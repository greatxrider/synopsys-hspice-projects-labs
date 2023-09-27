*Sample&Hold Non-Ideal Op-Amp

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

.subckt opamp vinm1 vinp1 vout1

vdd vdd gnd 1.8v

*CURRENT REFERENCE 1

m31 c vb4 vdd vdd pch L=10u W=3u m=16
m32 e vb4 vdd vdd pch L=10u W=3u m=16
m33 vb4 vb3 c vdd pch L=10u W=3u m=16
m34 f vb3 e vdd pch L=10u W=3u m=16

m35 vb4 vb2 d gnd nch L=10u W=3u m=11

m36 vb1 vb2 h gnd nch L=10u W=3u m=16

m37 d vb1 gnd gnd nch L=9u W=3u m=26

m38 h f gnd gnd nch L=12u W=4u m=16

*CACODE BIAS 1

m2 i vb4 vdd vdd pch L=9.375u W=3u m=26
m3 vb2 vb3 i vdd pch L=9.375u W=3u m=26

m8 vb3 vb2 l gnd nch L=9.375u W=3u m=21

m9 l vb1 gnd gnd nch L=9.375u W=3u m=36

m12 vb2 vb2 gnd gnd nch L=9.375u W=3u m=4
m46 vb3 vb3 vdd vdd pch L=9.375u W=3u m=4

*START-UP 1

m14 vb3 m gnd gnd nch L=9.375u W=3u m=16
m15 vb4 m gnd gnd nch L=9.375u W=3u m=16
m16 m vb2 gnd gnd nch L=9.375u W=3u m=16

*CONNECTORS 1

mc1 n1 vb4 vdd vdd pch L=10u W=3u m=16
mc2 vg2 vb3 n1 vdd pch L=10u W=3u m=16

m17 m gnd vdd vdd pch L=9.35u W=3u m=1

R f vb1 1.915k

*TWO STAGE OP-AMP 1

mp4 vx vg1 vdd vdd pch w=11.345u l=1.5u
mp3 vg1 vg1 vdd vdd pch w=11.345u l=1.5u
mn2 vg1 vinm1 vs1 gnd nch w=6.654u l=1.5u
mn1 vx vinp1 vs1 gnd nch w=6.654u l=1.5u
mn5 vs1 vg2 gnd gnd nch w=10.265u l=1.5u
mn8 vg2 vg2 gnd gnd nch w=10.265u l=1.5u
mp6 vout1 vx vdd vdd pch w=67u l=1.5u
mn7 vout1 vg2 gnd gnd nch w=32u l=1.5u

cload vout1 gnd 10p
cc vc vout1 4p 
rc vx vc 10.423k

.ends

.subckt opamp2 vinm2 vinp2 vout2

vdd vdd gnd 1.8v

*CURRENT REFERENCE 2

m31 c vb4 vdd vdd pch L=10u W=3u m=16
m32 e vb4 vdd vdd pch L=10u W=3u m=16
m33 vb4 vb3 c vdd pch L=10u W=3u m=16
m34 f vb3 e vdd pch L=10u W=3u m=16

m35 vb4 vb2 d gnd nch L=10u W=3u m=11

m36 vb1 vb2 h gnd nch L=10u W=3u m=16

m37 d vb1 gnd gnd nch L=9u W=3u m=26

m38 h f gnd gnd nch L=12u W=4u m=16

*CACODE BIAS 2

m2 i vb4 vdd vdd pch L=9.375u W=3u m=26
m3 vb2 vb3 i vdd pch L=9.375u W=3u m=26

m8 vb3 vb2 l gnd nch L=9.375u W=3u m=21

m9 l vb1 gnd gnd nch L=9.375u W=3u m=36

m12 vb2 vb2 gnd gnd nch L=9.375u W=3u m=4
m46 vb3 vb3 vdd vdd pch L=9.375u W=3u m=4

*START-UP 2

m14 vb3 m gnd gnd nch L=9.375u W=3u m=16
m15 vb4 m gnd gnd nch L=9.375u W=3u m=16
m16 m vb2 gnd gnd nch L=9.375u W=3u m=16

*CONNECTORS 2

mc1 n1 vb4 vdd vdd pch L=10u W=3u m=16
mc2 vg2 vb3 n1 vdd pch L=10u W=3u m=16

m17 m gnd vdd vdd pch L=9.35u W=3u m=1

R f vb1 1.915k

*TWO STAGE OP-AMP 2
 
mp4 vx vg1 vdd vdd pch w=11.345u l=1.5u
mp3 vg1 vg1 vdd vdd pch w=11.345u l=1.5u
mn2 vg1 vinm2 vs1 gnd nch w=6.654u l=1.5u
mn1 vx vinp2 vs1 gnd nch w=6.654u l=1.5u
mn5 vs1 vg2 gnd gnd nch w=10.265u l=1.5u
mn8 vg2 vg2 gnd gnd nch w=10.265u l=1.5u
mp6 vout2 vx vdd vdd pch w=67u l=1.5u
mn7 vout2 vg2 gnd gnd nch w=32u l=1.5u

cload vout2 gnd 10p
cc vc vout2 4p 
rc vx vc 10.423k

.ends

*Sample and Hold 

xopamp1 vout1 vinm1 vout1 opamp

xopamp2 vout2 vinm2 vout2 opamp2

mn30 vinm2 vg vout1 vout1 nch w=10u l=2u

Vclk vg gnd pulse(0v 2.5v -1u 1p 1p 1u 4u)

VIN vinm1 gnd pulse(0 1.8v 0 100u 100u 100u 400u)

cHold vinm2 gnd 100p

.op
.option post probe
.tran 1u 400u
.probe tran v(vinm1) v(vout2) v(vout1)

.end




