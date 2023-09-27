Voltage_Bandgap_thesis.sp

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

.subckt opamp vin- vin+ vout

vdd vdd gnd 1.8v

mn1 vx vin+ vs1 gnd nch w=5u l=1u
mn2 vg1 vin- vs1 gnd nch w=5u l=1u
mp3 vg1 vg1 vdd vdd pch w=11u l=1u
mp4 vx vg1 vdd vdd pch w=11u l=1u
mn5 vs1 vg2 gnd gnd nch w=10u l=1u
mp6 vout vx vdd vdd pch w=30u l=1u
mn7 vout vg2 gnd gnd nch w=30u l=1u
mn8 vg2 vg2 gnd gnd nch w=10u l=1u

m12 c vb1 vdd vdd pch l=1u w=16u 
m13 e vb1 vdd vdd pch l=1u w=16u 
m11 vb1 vb2 c vdd pch l=1u w=16u 
m10 x vb2 e vdd pch l=1u w=16u 
m4 vb1 vb3 d gnd nch l=1u w=7u 
m5 vb4 vb3 h gnd nch l=1u w=6u 
m3 d vb4 gnd gnd nch l=1u w=24u 
m2 h x gnd gnd nch l=1u w=12u 
R x vb4 2.241k

m14 i vb1 vdd vdd pch l=1u w=17u 
m8 vb3 vb2 i vdd pch l=1u w=17u 
m6 vb2 vb3 l gnd nch l=1u w=6u 
m1 l vb4 gnd gnd nch l=1u w=8.5u
m7 vb3 vb3 gnd gnd nch l=1u w=0.8u
m9 vb2 vb2 vdd vdd pch l=1u w=0.8u

m15 vb2 n gnd gnd nch l=1u w=5u 
m16 vb1 n gnd gnd nch l=1u w=5u
m17 m vb3 gnd gnd nch l=1u w=5u
m18 m gnd vdd vdd pch l=1u w=0.5u

m20 y vb1 vdd vdd pch l=1u w=16u
m21 vg2 vb2 y vdd pch l=1u w=16u

cc vx vout 4p
cload vout gnd 10p

.ends

vdd vdd gnd 1.8v
xopamp vin- vin+ vout opamp
q1 gnd gnd vin- pnp10 m=1
q2 gnd gnd ve2 pnp10 m=8
Mp1 x vout vdd vdd pch l=1u w=20u
Mp2 vref vout vdd vdd pch l=1u w=20u
R1 vin+ ve2 6.4k
R2 vref vin+ 63.552k
R3 x vin- 63.552k
.option post probe
.dc temp -40 120 0.1
.dc vdd 1.62 1.98 0.1
.op
.probe v(vref), v(vin-), v(vin+,ve2)


.end





