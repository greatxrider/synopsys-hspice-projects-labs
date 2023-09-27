*TwoStageOp-ApSubthresholdhighgain

.lib mm018.l TT

.MODEL pch pmos wmin=90u wmax=110u lmin=0.3u lmax=12u
.MODEL nch nmos wmin=4u wmax=1000u lmin=0.3u lmax=5u


vdd vdd gnd dc 0.5v
vinp vinp gnd dc 0.2v ac 0.2v
vinn vinn gnd dc 0.2v ac 0v
iref vdd id 0.15u

m1 two1 vinn two2 two2 nch L=2u W=155u 
m2 two3 vinp two2 two2 nch L=2u W=155u 

m3 two1 two1 vdd vdd pch L=0.4u W=105u 
m4 two3 two1 vdd vdd pch L=0.4u W=105u 

m7 vout two3 gnd gnd nch L=1u W=5u 

m5 two2 id gnd gnd nch L=1u W=60u 
m8 id id gnd gnd nch L=1u W=60u 

m6 vout id vdd vdd pch L=10.3u W=95u

rc two3 two4 0.9M
cc two4 vout 1p
cl vout gnd 10p

.op
.OPTION post probe
.meas ac gb when vdb(vout)=0
.ac dec 100 10 10g
.probe v(vout)
.pz v(vout) vinp

.alter 
vdd vdd gnd dc 0.8v
.meas ac gb when vdb(vout)=0
.ac dec 100 10 10g
.probe v(vout)
.pz v(vout) vinp


.end