*Two-Stage Opamp as Comparator

.GLOBAL gnd vdd

*mirrors
mc1 n1 vb4 vdd vdd pch L=10u W=3u m=16
mc2 vg2 vb3 n1 vdd pch L=10u W=3u m=16

*current reference
m31 c vb4 vdd vdd pch L=10u W=3u m=16
m32 e vb4 vdd vdd pch L=10u W=3u m=16
m33 vb4 vb3 c vdd pch L=10u W=3u m=16
m34 f vb3 e vdd pch L=10u W=3u m=16

m35 vb4 vb2 d gnd nch L=10u W=3u m=11

m36 vb1 vb2 h gnd nch L=10u W=3u m=16

m37 d vb1 gnd gnd nch L=9u W=3u m=26

m38 h f gnd gnd nch L=12u W=4u m=16

*cascode bias
m2 i vb4 vdd vdd pch L=9.375u W=3u m=26
m3 vb2 vb3 i vdd pch L=9.375u W=3u m=26

m8 vb3 vb2 l gnd nch L=9.375u W=3u m=21

m9 l vb1 gnd gnd nch L=9.375u W=3u m=36

m12 vb2 vb2 gnd gnd nch L=9.375u W=3u m=4
m46 vb3 vb3 vdd vdd pch L=9.375u W=3u m=4

*start-up
m14 vb3 m gnd gnd nch L=9.375u W=3u m=16
m15 vb4 m gnd gnd nch L=9.375u W=3u m=16
m16 m vb2 gnd gnd nch L=9.375u W=3u m=16

m17 m gnd vdd vdd pch L=9.35u W=3u m=1

R f vb1 1.915k

*TWO-STAGE OP-AMP

mn1 vx vinp vs1 gnd nch w=6.654u l=1.5u
mn2 vg1 vinm vs1 gnd nch w=6.654u l=1.5u
mp3 vg1 vg1 vdd vdd pch w=11.345u l=1.5u
mp4 vx vg1 vdd vdd pch w=11.345u l=1.5u
mn5 vs1 vg2 gnd gnd nch w=10.265u l=1.5u
mp6 vout vx vdd vdd pch w=67u l=1.5u
mn7 vout vg2 gnd gnd nch w=32u l=1.5u
mn8 vg2 vg2 gnd gnd nch w=10.265u l=1.5u

vdd vdd gnd dc 1.8v

vinp vinp gnd dc=0.9v
*vinp vinp gnd dc=0 sin(0.9v 0.9v 5k 0 0 0)
vinm vinm nodeh dc=0 sin(0.9v 0.9v 5k 0 0 0)
vnoise nodeh gnd dc=0 sin(0 16mv 10000000 0 0 0)

.op
.option post probe
.dc vinp -1.8 1.8 0.01
.dc vinp 1.8 -1.8 -0.01
.tran 0.01u 206u start=194u
.probe tran v(vinm) v(vout) v(vinp)
.prot
.lib 'mm018.l' tt
.unprot

.end
