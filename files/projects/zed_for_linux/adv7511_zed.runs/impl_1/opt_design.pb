
Y
Command: %s
53*	vivadotcl21
opt_design -directive Explore2default:defaultZ4-113
[
$Directive used for opt_design is: %s67*	vivadotcl2
Explore2default:defaultZ4-136
š
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347
Š
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349
e
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22
I

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103
G
Running DRC with %s threads
24*drc2
22default:defaultZ23-27
L
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461
[
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462
‰

%s
*constraints2r
^Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.342 . Memory (MB): peak = 910.297 ; gain = 3.8792default:default
X

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103
/
Deriving generated clocks
2*timingZ38-2
`

Phase %s%s
101*constraints2
1 2default:default2
Retarget2default:defaultZ18-101
C
Pushed %s inverter(s).
98*opt2
02default:defaultZ31-138
B
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49
3
'Phase 1 Retarget | Checksum: 27a73403e
*common
‰

%s
*constraints2r
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.858 . Memory (MB): peak = 911.926 ; gain = 1.6292default:default
l

Phase %s%s
101*constraints2
2 2default:default2(
Constant Propagation2default:defaultZ18-101
C
Pushed %s inverter(s).
98*opt2
02default:defaultZ31-138
B
Eliminated %s cells.
10*opt2
3272default:defaultZ31-10
?
3Phase 2 Constant Propagation | Checksum: 26a952984
*common
…

%s
*constraints2n
ZTime (s): cpu = 00:00:02 ; elapsed = 00:00:02 . Memory (MB): peak = 911.926 ; gain = 1.6292default:default
]

Phase %s%s
101*constraints2
3 2default:default2
Sweep2default:defaultZ18-101
N
 Eliminated %s unconnected nets.
12*opt2
12072default:defaultZ31-12
N
!Eliminated %s unconnected cells.
11*opt2
3252default:defaultZ31-11
0
$Phase 3 Sweep | Checksum: 17cf6e35e
*common
…

%s
*constraints2n
ZTime (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 911.926 ; gain = 1.6292default:default
l

Phase %s%s
101*constraints2
4 2default:default2(
Constant Propagation2default:defaultZ18-101
C
Pushed %s inverter(s).
98*opt2
02default:defaultZ31-138
@
Eliminated %s cells.
10*opt2
02default:defaultZ31-10
?
3Phase 4 Constant Propagation | Checksum: 17cf6e35e
*common
…

%s
*constraints2n
ZTime (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 911.926 ; gain = 1.6292default:default
]

Phase %s%s
101*constraints2
5 2default:default2
Sweep2default:defaultZ18-101
K
 Eliminated %s unconnected nets.
12*opt2
12default:defaultZ31-12
L
!Eliminated %s unconnected cells.
11*opt2
02default:defaultZ31-11
0
$Phase 5 Sweep | Checksum: 2916b8caf
*common
…

%s
*constraints2n
ZTime (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 911.926 ; gain = 1.6292default:default
A
5Ending Logic Optimization Task | Checksum: 2916b8caf
*common
…

%s
*constraints2n
ZTime (s): cpu = 00:00:00 ; elapsed = 00:00:04 . Memory (MB): peak = 911.926 ; gain = 1.6292default:default
8
,Implement Debug Cores | Checksum: 296887403
*common
5
)Logic Optimization | Checksum: 296887403
*common
X

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103
[

Starting %s Task
103*constraints2)
PowerOpt TimerUpdates2default:defaultZ18-103
<
%Done setting XDC timing constraints.
35*timingZ38-35
D
8Ending PowerOpt TimerUpdates Task | Checksum: 2916b8caf
*common
‰

%s
*constraints2r
^Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.957 . Memory (MB): peak = 912.691 ; gain = 0.7662default:default
4
Applying IDT optimizations ...
9*pwroptZ34-9
6
Applying ODC optimizations ...
10*pwroptZ34-10


*pwropt
ñ
©WRITE_MODE attribute of %s BRAM(s) out of a total of %s was updated to NO_CHANGE to save power.
    Run report_power_opt to get a complete listing of the BRAMs updated.
129*pwropt2
02default:default2
22default:defaultZ34-162
[
+Structural ODC has moved %s WE to EN ports
155*pwropt2
02default:defaultZ34-201
Ÿ
CNumber of BRAM Ports augmented: %s newly gated: %s Total Ports: %s
65*pwropt2
02default:default2
12default:default2
42default:defaultZ34-65
A
5Ending Power Optimization Task | Checksum: 24bd26c53
*common
ˆ

%s
*constraints2q
]Time (s): cpu = 00:00:00 ; elapsed = 00:00:04 . Memory (MB): peak = 1015.348 ; gain = 103.4222default:default
Q
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83
½
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
322default:default2
02default:default2
02default:default2
02default:defaultZ4-41
S
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42
û
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
opt_design: 2default:default2
00:00:082default:default2
00:00:092default:default2
1015.3482default:default2
108.9492default:defaultZ17-268
<
%Done setting XDC timing constraints.
35*timingZ38-35
4
Writing XDEF routing.
211*designutilsZ20-211
A
#Writing XDEF routing logical nets.
209*designutilsZ20-209
A
#Writing XDEF routing special nets.
210*designutilsZ20-210
†
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:002default:default2 
00:00:00.2632default:default2
1015.3482default:default2
0.0002default:defaultZ17-268


End Record