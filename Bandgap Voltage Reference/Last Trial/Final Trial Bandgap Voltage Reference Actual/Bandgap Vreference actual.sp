*Voltage Ref Non-Ideal

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip
.subckt opamp vinm vinp vout
vdd vdd gnd 1.8v

*CURRENT REFERENCE

m31 c vb4 vdd vdd pch L=10u W=3u m=16
m32 e vb4 vdd vdd pch L=10u W=3u m=16
m33 vb4 vb3 c vdd pch L=10u W=3u m=16
m34 f vb3 e vdd pch L=10u W=3u m=16

m35 vb4 vb2 d gnd nch L=10u W=3u m=11

m36 vb1 vb2 h gnd nch L=10u W=3u m=16

m37 d vb1 gnd gnd nch L=9u W=3u m=26

m38 h f gnd gnd nch L=12u W=4u m=16

*CACODE BIAS

m2 i vb4 vdd vdd pch L=9.375u W=3u m=26
m3 vb2 vb3 i vdd pch L=9.375u W=3u m=26

m8 vb3 vb2 l gnd nch L=9.375u W=3u m=21

m9 l vb1 gnd gnd nch L=9.375u W=3u m=36

m12 vb2 vb2 gnd gnd nch L=9.375u W=3u m=4
m46 vb3 vb3 vdd vdd pch L=9.375u W=3u m=4

*START-UP

m14 vb3 m gnd gnd nch L=9.375u W=3u m=16
m15 vb4 m gnd gnd nch L=9.375u W=3u m=16
m16 m vb2 gnd gnd nch L=9.375u W=3u m=16

*CONNECTORS

mc1 n1 vb4 vdd vdd pch L=10u W=3u m=16
mc2 vg2 vb3 n1 vdd pch L=10u W=3u m=16

m17 m gnd vdd vdd pch L=9.35u W=3u m=1

R f vb1 1.915k

*TWO STAGE OP-AMP

mp4 vx vg1 vdd vdd pch w=11.345u l=1.5u
mp3 vg1 vg1 vdd vdd pch w=11.345u l=1.5u
mn2 vg1 vinm vs1 gnd nch w=6.654u l=1.5u
mn1 vx vinp vs1 gnd nch w=6.654u l=1.5u
mn5 vs1 vg2 gnd gnd nch w=10.265u l=1.5u
mn8 vg2 vg2 gnd gnd nch w=10.265u l=1.5u
mp6 vout vx vdd vdd pch w=67u l=1.5u
mn7 vout vg2 gnd gnd nch w=32u l=1.5u

cload vout gnd 10p
cc vc vout 4p 
rc vx vc 10.423k

.ends

*TEMP-IND VREF

vdd vdd gnd 1.8v
xopamp vinm vinp vout opamp

q1 gnd gnd vinm pnp10 m=1
q2 gnd gnd ve2 pnp10 m=5

mp17 vref vout vdd vdd pch w=20u l=1u

r1 vref vinm 79.178k
r2 vref vinp 79.178k
r3 vinp ve2 6.10k

.option post probe
.dc temp  -40 120 0.1
.dc vdd 1.62 1.98 0.1
.op
.probe v(vref), v(vinm), v(vinp,ve2)

*.alter
*.lib 'mm018.l' ff
*.alter 
*.lib 'mm018.l' ss
*.alter 
*.lib 'mm018.l' fs
*.alter 
*.lib 'mm018.l' sf

.end
