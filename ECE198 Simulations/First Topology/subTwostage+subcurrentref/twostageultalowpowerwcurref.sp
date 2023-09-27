*twostageultalowpowerwcurref

.MODEL pch pmos wmin=90u wmax=110u lmin=0.3u lmax=12u
.MODEL nch nmos wmin=4u wmax=1000u lmin=0.3u lmax=5u
.lib mm018.l TT

vdd vdd gnd dc 0.5v

*subthreshcurrentref

MP1 net1 net1 vdd vdd pch w=0.5u l=3u
MP2 net2 net1 vdd vdd pch w=5u l=22u
MP3 net3 net3 vdd vdd pch w=6u l=0.5u
MP4 ibias net3 vdd vdd pch w=10u l=1u
MN1 net1 net1 gnd gnd nch w=50u l=50u
MN2 net2 net2 gnd gnd nch w=20u l=1u
MN3 net3 net2 gnd gnd nch w=26u l=1u

R1 vr gnd 2k

*twostageultralowpower

vinp vinp gnd dc 0.321v ac 0v
vinn vinn gnd dc 0.321v ac 0v
*iref vdd id 0.15u

m1 two1 vinn two2 two2 nch L=2u W=155u 
m2 two3 vinp two2 two2 nch L=2u W=155u 

m3 two1 two1 vdd vdd pch L=0.4u W=105u 
m4 two3 two1 vdd vdd pch L=0.4u W=105u 

m7 vout ibias gnd gnd nch L=1u W=5u 

m5 two2 ibias gnd gnd nch L=1u W=60u 
m8 ibias ibias gnd gnd nch L=1u W=60u 

m6 vout vout vdd vdd pch L=10.3u W=95u

rc two3 two4 0.9M
cc two4 vout 1p
cl vout gnd 10p

.op
.OPTION post probe
.meas ac gb when vdb(vout)=0
.ac dec 100 10 10g
.probe v(two3), v(vout)
*.pz v(vout) vinp
*.tf v(vout) vinp

.alter 
vdd vdd gnd dc 0.8v
.meas ac gb when vdb(vout)=0
.ac dec 100 10 10g
.probe v(two3), v(vout)
*.pz v(vout) vinp
*.tf v(vout) vinp

.end