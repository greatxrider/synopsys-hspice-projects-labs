*Sub1_VNanowattCurrefFakhar

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

*bandgapvoltreffakh

vdd vdd gnd 0.9v

*BVR

*currentref

m11 wire2 wire1 vdd vdd pch w=0.5u l=20u 
m10 wire1 wire1 vdd vdd pch w=0.5u l=20u

m8 wire1 wire2 wire3 wire3 nch w=9.75u l=1u
m9 wire3 wire3 gnd gnd nch w=9.75u l=1u

m16 wire2 wire2 wire2 gnd pch w=1u l=1u


.option post probe
.op
.dc temp -25 110 0.1
.dc vdd 0v 1.8v 0.1

.probe i(m10), i(m11), i(m8), i(m16), i(m9), v(wire3), v(wire2,gnd), v(wire1)

*.alter
*.lib 'mm018.l' ff
*.alter 
*.lib 'mm018.l' ss
*.alter 
*.lib 'mm018.l' fs
*.alter 
*.lib 'mm018.l' sf

.end