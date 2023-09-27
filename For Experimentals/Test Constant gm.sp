*Constant gm Current Reference by Jeph Daligdig

vdd vdd gnd 1.8

*current reference

m31 c vb4 vdd vdd pch L=10u W=3u m=16
m32 e vb4 vdd vdd pch L=10u W=3u m=16
m33 vb4 vb3 c vdd pch L=10u W=3u m=16
m34 f vb3 e vdd pch L=10u W=3u m=16

m35 vb4 vb2 d gnd nch L=10u W=3u m=11

m36 vb1 vb2 h gnd nch L=10u W=3u m=16

m37 d vb1 gnd gnd nch L=9u W=3u m=26

m38 h f gnd gnd nch L=9u W=3u m=16

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

R f vb1 2.0251k

.dc vdd 0 1.8 0.1
.probe dc i(R)
.probe dc v(vb1)
.probe dc v(vb2)
.dc vdd 1.62 1.98 0.001

.OPTION post probe
.global vdd gnd
.lib mm018.l TT

.op
.end



