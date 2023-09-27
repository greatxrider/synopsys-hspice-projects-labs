* Ideal Two-Stage Opamp as Comparator

.GLOBAL gnd vdd

e vout gnd vinp vinm max=1.8v min=0 3236

*vinp vinp gnd dc=0.9v
vinp vinp gnd dc=0 sin(0.9v 0.9v 5k 0 0 0)
vinm vinm nodeh dc=0 sin(0.9v 0.9v 5k 0 0 0)
vnoise nodeh gnd dc=0 sin(0 0mv 10000000 0 0 0)

.op
.option post probe
.dc vinm -1.8 1.8 0.01
.dc vinm 1.8 -1.8 -0.01
.tran 0.01u 400u start=0u
.probe tran v(vinm) v(vout) v(vinp)
.prot
.lib 'mm018.l' tt
.unprot

.end
