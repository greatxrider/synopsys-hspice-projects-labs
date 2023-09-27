Mattia2014.sp

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

vdd vdd gnd 0.5v

*Currentmirrormfets

M9 net1 net2 vdd vdd pch w=28u l=2u
M8 net2 net2 vdd  vdd  pch w=2u l=2u
M12 net5 net2 vdd  vdd  pch w=4u l=2u
M13 vref net2 vdd  vdd  pch w=4u l=2u

*PTATcells

M3 net2 net1 net3 net3 nch w=95u l=1u
M2 net3 net1 net4 net4 nch w=10u l=2u

M5  net3 net6 net5 net5 pch w=16u l=2u
M4  net6 net6 net3 net3 pch w=2u l=2u

M7  net5 net8 vref vref pch w=16u l=2u
M6  net8 net8 net5 net5 pch w=2u l=2u

*Lowerpartmfets

M1 net4 net4 gnd  gnd  nch w=16u l=2u
M10 net6 net4 gnd  gnd  nch w=2u l=2u
M11 net8 net4 gnd  gnd  nch w=2u l=2u

*BJT

Q0 gnd gnd net1 pnp10

.option post probe
.op
.dc temp 0 125 0.1
.dc vdd 0 0.5 0.1
.probe v(vref),v(net8),v(net5, net6), v(net3, net4), v(vref, net8), v(net3,net6),v(net2,net5) ,v(net4), i(M3), i(M2), i(M1), i(M8)

.alter
.lib 'mm018.l' ff
.alter 
.lib 'mm018.l' ss
.alter 
.lib 'mm018.l' fs
.alter 
.lib 'mm018.l' sf

.end