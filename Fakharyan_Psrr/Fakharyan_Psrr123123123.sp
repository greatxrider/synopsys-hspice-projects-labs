*Fakharyan_Psrr

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

*bandgapvoltreffakh

vdd vdd ac 0.9v
vin ac gnd dc 0v ac 1v

*BVR

*currentref

m11 wire2 wire1 vdd vdd pch w=0.5u l=20u 
m10 wire1 wire1 vdd vdd pch w=0.5u l=20u

m8 wire1 wire2 wire3 wire3 nch w=9.5u l=1u
m9 wire3 wire3 gnd gnd nch w=9.5u l=1u

m16 wire2 wire2 wire2 gnd pch w=1u l=1u

*BandgapVref

*1ptatcell

m12 wire4 wire1 vdd vdd pch w=0.5u l=20u
m6 wire4 wire4 wire5 wire5 nch w=1u l=1u
m7 wire5 wire4 gnd gnd nch w=0.5u l=1u    

*2ptatcell

m13 wire6 wire1 vdd vdd pch w=0.5u l=20u
m4 wire6 wire6 wire7 wire7 nch w=1u l=1u
m5 wire7 wire6 wire5 wire5 nch w=0.5u l=1u     

*3ptatcell

m14 wire8 wire1 vdd vdd pch w=0.5u l=20u
m2 wire8 wire8 wire9 wire9 nch w=1u l=1u
m3 wire9 wire8 wire7 wire7 nch w=0.5u l=1u   

*Ctat

m15 vref wire1 vdd vdd pch w=100u l=1u
m1 vref vref wire9 wire9 nch w=0.5u l=1u 

*Diff Amp

m17 net3 net3 vdd vdd pch w=0.5u l=20u
m18 net2 net3 vdd vdd pch w=0.5u l=20u
m19 net2 wire2 net1 net1 nch w=9.5u l=1u
m20 net3 wire1 net1 net1 nch w=9.5u l=1u
m21 net1 wire4 gnd gnd nch w=9.5u l=1u

.op
.option post probe
.dc temp -25 110 0.1
.meas ac gb when vdb(vref)=0
.dc vdd 0v 1.8v 0.1
.ac dec 100 100 10g
.probe v(vref, wire9) , v(ac, gnd), v(wire9, wire7), v(vref), v(vdd, gnd)

*.alter
*.lib 'mm018.l' ff
*.alter 
*.lib 'mm018.l' ss
*.alter 
*.lib 'mm018.l' fs
*.alter 
*.lib 'mm018.l' sf

.end