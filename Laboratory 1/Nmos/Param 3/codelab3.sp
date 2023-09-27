ECE106 LABORATORY

vgs 1 0  -500mv
vds 2 0  -500mv
vbs 3 0 0v
m1 2 1 0 0 pch l=3.60u w=2.840u

.lib 'mm018.l' TT
.op
.options post probe
.dc vgs 0  -500mv  -0.1v
.probe i1(m1)
.dc vds 0  -500mv  -0.1v
.probe i1(m1)
.dc vds 0  -500mv  -0.1v vgs 0  -500mv  -0.45v
.probe i1(m1)
.end