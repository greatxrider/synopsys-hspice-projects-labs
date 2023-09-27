ECE106 LABORATORY

vgs 1 0  -100mv
vds 2 0  -200mv
vbs 3 0 0v
m1 2 1 0 0 pch l=2.450u w=2.840u

.lib 'mm018.l' TT
.op
.options post probe
.dc vgs 0  -100mv  -0.1v
.probe i1(m1)
.dc vds 0  -200mv  -0.1v
.probe i1(m1)
.dc vds 0  -200mv  -0.1v vgs 0  -100mv  -0.45v
.probe i1(m1)
.end