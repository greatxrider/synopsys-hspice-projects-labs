Voltage_Bandgap_thesis_Subthreshold.sp

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

.MODEL pch pmos wmin=90u wmax=210u lmin=0.3u lmax=100u
.MODEL nch nmos wmin=4u wmax=1000u lmin=0.3u lmax=5u

.subckt opamp vinn vinp vout

vdd vdd gnd dc 0.8v

*Subthresholdcurrentref

MP1 net1 net1 vdd vdd pch w=0.5u l=3u
MP2 net2 net1 vdd vdd pch w=5u l=22u
MP3 net3 net3 vdd vdd pch w=6u l=0.5u
MP4 ibias net3 vdd vdd pch w=10u l=1u
MN1 net1 net1 gnd gnd nch w=50u l=50u
MN2 net2 net2 gnd gnd nch w=20u l=1u
MN3 net3 net2 gnd gnd nch w=26u l=1u

R1 vr gnd 2k

*SubthresholdOpamp

*vinp vinp gnd dc 0.2v ac 0.2v
*vinn vinn gnd dc 0.2v ac 0v
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

.ends

vdd vdd gnd 0.8v

xompamp vinn vinp vout opamp


*Subthresholdbandgapvoltagereference

Mb1 net1 vout vdd vdd pch L=50u W=210u
Mb2 vref vout vdd vdd pch L=58u W=210u 

R_1 vref vinp 4300K
R_3 vinp net3 4300K

R_2 net1 vinn 100000K


q1 gnd gnd vinn pnp10 m=1
q2 gnd gnd net3 pnp10 m=8

cl2 vref gnd 10p

.option post probe
.dc temp -40 120 0.1
.dc vdd 1.62 1.98 0.1
.op
.probe v(vref), v(vinn), v(vinp,net3)

.end





