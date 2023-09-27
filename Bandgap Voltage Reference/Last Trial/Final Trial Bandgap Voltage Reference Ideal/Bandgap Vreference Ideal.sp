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

r1 vinm vref 93.94k
r2 vinp vref 93.94k
r3 vinp ve2 7k

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
