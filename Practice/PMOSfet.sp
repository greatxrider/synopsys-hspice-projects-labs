*practice

.lib 'mm018.l' tt

vdd vdd gnd 1.8v
i1 vdd a1 18u

m1 a1 a1 gnd gnd nch w=8u l=8u
m2 a2 a1 gnd gnd nch w=8u l=8u
m3 a2 a1 gnd gnd nch w=8u l=8u

r1 vdd a2 1

.option post probe
.op
.probe dc i(m1), i(m2)
.end

