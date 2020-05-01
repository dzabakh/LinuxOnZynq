/* This program is hereby placed into the public domain. Of course the program is 
provided without warranty of any kind. */
#include <sys/ioctl.h> 
#include <errno.h> 
#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include <fcntl.h> 
#include <string.h> 
#include <time.h> 
#include <linux/i2c.h> 
#include <linux/i2c-dev.h>
/*
  this program can read 24C16 (and probably smaller ones, too)
  I wrote it as a quick and dirty hack because my satellite receiver
  hung again... so I had to reprogram the eeprom where is stores it's
  settings.
 */
#define DEFAULT_I2C_BUS "/dev/i2c-0" 
#define DEFAULT_EEPROM_ADDR 0x50 /* the 24C16 sits on i2c address 0x50 */ 
#define DEFAULT_NUM_PAGES 8 /* we default to a 24C16 eeprom which has 8 pages */ 
#define BYTES_PER_PAGE 512 /* one eeprom page is 256 byte */ 
#define MAX_BYTES 16 /* max number of bytes to write in one chunk */
       /* ... note: 24C02 and 24C01 only allow 8 bytes to be written in one chunk.  *
        * if you are going to write 24C04,8,16 you can change this to 16 */ /* write len 
bytes (stored in buf) to eeprom at address addr, page-offset offset */ /* if len=0 (buf 
may be NULL in this case) you can reposition the eeprom's read-pointer */ /* return 0 on 
success, -1 on failure */ 
int eeprom_write(int fd,
		 unsigned int addr,
		 unsigned int offset,
		 unsigned char *buf,
		 unsigned char len ){
	struct i2c_rdwr_ioctl_data msg_rdwr;
	struct i2c_msg i2cmsg;
	int i;
	char _buf[MAX_BYTES + 1];
	if(len>MAX_BYTES){
	    fprintf(stderr,"I can only write MAX_BYTES bytes at a time!\n");
	    return -1;
	}
	if(len+offset >512){
	    fprintf(stderr,"Sorry, len(%d)+offset(%d) > 512 (page boundary)\n",len,offset);
	    return -1;
	}
	_buf[0]= (offset>>8) && 0xFF; /* _buf[0] is the offset into the eeprom page! */
	_buf[1]= (offset & 0xFF);
	for(i=0;i<len;i++) /* copy buf[0..n] -> _buf[2..n+2] */
	    _buf[2+i]=buf[i];
	msg_rdwr.msgs = &i2cmsg;
	msg_rdwr.nmsgs = 1;
	i2cmsg.addr = addr;
	i2cmsg.flags = 0;
	i2cmsg.len = 1+len;
	i2cmsg.buf = _buf;
	fprintf(stderr,"I'm inside eeprom_write()\n");
	if((i=ioctl(fd,I2C_RDWR,&msg_rdwr))<0){
	    perror("ioctl()");
	    fprintf(stderr,"ioctl returned %d\n",i);
	    return -1;
	}
	if(len>0)
	    fprintf(stderr,"Wrote %d bytes to eeprom at 0x%02x, offset %08x\n",len,addr,offset);
	else
	    fprintf(stderr,"Positioned pointer in eeprom at 0x%02x to offset %08x\n",addr,offset);
	return 0;
}
/* read len bytes stored in eeprom at address addr, offset offset in array buf */ /* 
return -1 on error, 0 on success */ 
int eeprom_read(int fd,
		 unsigned int addr,
		 unsigned int offset,
		 unsigned char *buf,
		 unsigned char len ){
	struct i2c_rdwr_ioctl_data msg_rdwr;
	struct i2c_msg i2cmsg;
	int i;
	if(len>MAX_BYTES){
	    fprintf(stderr,"I can only write MAX_BYTES bytes at a time!\n");
	    return -1;
	}
	if(eeprom_write(fd,addr,offset,NULL,0)<0)
	    return -1;
	msg_rdwr.msgs = &i2cmsg;
	msg_rdwr.nmsgs = 1;
	i2cmsg.addr = addr;
	i2cmsg.flags = I2C_M_RD;
	i2cmsg.len = len;
	i2cmsg.buf = buf;
	fprintf(stderr, "I'm inside eeprom_read()\n");
	if((i=ioctl(fd,I2C_RDWR,&msg_rdwr))<0){
	    perror("ioctl()");
	    fprintf(stderr,"ioctl returned %d\n",i);
	    return -1;
	}
	fprintf(stderr,"Read %d bytes from eeprom at 0x%02x, offset %08x, contents is %d\n",len,addr,offset,buf[1]);
	return 0;
}
int main(int argc, char **argv){
    char *dn=DEFAULT_I2C_BUS;
    int d;
    int i,j;
    int f=-1;
    char *fn=NULL;
    unsigned int addr=DEFAULT_EEPROM_ADDR;
    int rwmode=0;
    int pages=DEFAULT_NUM_PAGES;
	unsigned char buf[BYTES_PER_PAGE];
	  if((d=open(dn,O_RDWR))<0){
		fprintf(stderr,"Could not open i2c at %s\n",dn);
		perror(dn);
		exit(1);
    }
	
	
	/*if(eeprom_write(d,addr,5*MAX_BYTES,buf,MAX_BYTES)<0)
	   exit(1);*/
	  
/*fprintf(stderr, "I'm between eeprom_write() and eeprom_read() calls\n");*/
 	if( eeprom_read(d,addr,5*MAX_BYTES,buf,MAX_BYTES)<0)
	   exit(1);
 
close(d);
exit(0);
}
