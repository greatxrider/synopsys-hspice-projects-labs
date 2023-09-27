ECE106 LABORATORY

vgs 1 0 300mv
vds 2 0 300mv
vbs 3 0 0v
m1 2 1 0 0 nch l=2.450u w=2.840u

.lib 'mm018.l' TT
.op
.options post probe
.dc vgs 0 300mv 0.1v
.probe i1(m1)
.dc vds 0 300mv 0.1v
.probe i1(m1)
.dc vds 0 300mv 0.1v vgs 0 300mv 0.45v
.probe i1(m1)
.end