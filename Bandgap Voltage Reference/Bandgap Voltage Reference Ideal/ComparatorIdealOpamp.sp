*Voltage Ref Ideal

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

* Ideal Two Stage Op.amp 

e vout gnd vinp vinm max=1.8v min=0 3236
vdd vdd gnd dc 1.8v

*Temp-Indep Vref

q1 gnd gnd vinm pnp10 area = 1
q2 gnd gnd ve2 pnp10 area = 5

mp17 vref vout vdd vdd pch w=20u l=1u

r1 vinm vref 7k
r2 vinp vref 7k
r3 vinp ve2 7k

.option post probe
.dc temp  -25 110 0.1
.dc vdd 0.75 1.8 0.1
.op
.probe v(vref), v(vinm), v(vinp,ve2)

.end
