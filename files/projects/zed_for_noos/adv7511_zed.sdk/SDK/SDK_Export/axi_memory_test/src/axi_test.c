/*
 * axi_test.c
 *
 *  Created on: Sep 18, 2014
 *      Author: Salmon
 */


#include "xparameters.h"
#include "sleep.h"
#include "xil_exception.h"
#include "xil_printf.h"
#include "xil_io.h"

#define AXI_SLAVE_ADDR  0x43C00000


int main(void){
	u32 address = AXI_SLAVE_ADDR ;
	u32 value_out  = 555 ;
	u32 value_in = 0 ;
	xil_printf("Going to Xil_Out32\r\n");
	Xil_Out32((u32) address, (u32) value_out) ;
	xil_printf("Xil_Out32 ok\r\n");/*
	value_in = Xil_In32(address) ;
	xil_printf("Xil_In32 ok");
	if (value_in == value_out){
		xil_printf("AXI peripheral test successfully passed");
	}
	else {
		xil_printf("AXI peripheral test failed");
		return 1;
	}
*/
	return 0;
}
