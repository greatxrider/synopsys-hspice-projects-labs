*Subthreshold Bandgap Voltage Reference At 0.5V supply.

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip
vdd vdd gnd 0.5v

*Start-up&Body bias circuit

mp1 wire1 wire5 vdd vdd pch L=0.5u W=4u M=1 
mp2 wire4 wire1 vdd vdd pch L=2u W=2u M=1
mn1 wire 1 wire5 gnd gnd nch L=10u W=0.5u M=1
R4 vdd vbb 900k
R5 vbb gnd 300k

*TwoStageOp-ApSubthresholdhighgain

m1 two1 vtwo two2 two2 nch L=2u W=155u M=2
m2 two3 vbb two2 two2 nch L=2u W=105u M=2
m3 two1 two1 vdd vdd pch L=0.4u W=105u M=2
m4 two3 two1 vdd vdd pch L=0.4u W=105u M=2
m5 two2 gnd gnd gnd nch L=1u W=60u M=1
m6 vtwo vdd vdd vdd pch L=10.3u W=95u M=1
m7 vtwo two3 gnd gnd nch L=1u W=5u M=1
rc two3 two4 0.9M 
cc two4 vtwo 1p
c3 vtwo gnd 10p

*IPTAT Generator
mp3 wire6 wire5 vdd vdd pch L=2u W=4 M=5
mp4 wire5 wire5 vdd vdd pch L=2u W=4 M=5
mn2 wire7 wire6 gnd gnd nch L=1 W=150 M=3
mn3 wire5 wire7 gnd gnd nch L=1 W=720 M=1
R1 wire6 wire7 100k

*ICTAT Generator
mp5 wire8 wire5 vdd vdd pch L=2u W=4 M=5 
mp6 wire9 wire10 vdd vdd pch L=2u W=4 M=5
mp7 wire10 wire10 vdd vdd pch L=2u W=4 M=5
mn4 wire8 wire9 gnd vtwo nch L=1 W=150 M=3
mn5 wire10 wire8 gnd gnd nch L=1 W=150 M=3
R2 wire9 gnd 780k
c1 wire8 gnd 10p

*Output Stage
mp8 vref wire10 vdd vdd pch L=2u W=6u M=1
mp9 vref wire5 vdd vdd pch L=2u W=5.5u M=1
R3 vref gnd 500k
c2 vref gnd 2pf
