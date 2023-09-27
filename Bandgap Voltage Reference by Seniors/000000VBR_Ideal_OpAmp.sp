VBR_Ideal_OpAmp.sp

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

e vout gnd vinp vinn max=1.8v min=0 13879

vdd vdd gnd 1.8v

r1 vinn vref 71.75k
r2 vinp vref 71.75k
r3 vinp c 7k

q1 gnd gnd vinn pnp10 m=1
q2 gnd gnd c pnp10 m=8

mp17 vref vout vdd vdd pch w=20u l=1u

.option post probe
.dc temp -40 120 0.1
.dc vdd 1.62 1.98 0.1
.op
.probe v(vref), v(vinn), v(vinp,c)

.alter
.lib 'mm018.l' ff
.alter
.lib 'mm018.l' ss

.end