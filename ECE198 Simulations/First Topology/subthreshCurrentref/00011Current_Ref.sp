Current_Ref.sp

vdd vdd gnd dc 0.8V

.MODEL pch pmos wmin=90u wmax=110u lmin=0.3u lmax=12u
.MODEL nch nmos wmin=4u wmax=160u lmin=0.3u lmax=5u

MP1 net1 net1 vdd vdd pch w=0.5u l=3u 
MP2 net2 net1 vdd vdd pch w=5u l=22u
MP3 net3 net3 vdd vdd pch w=6u l=0.5u
MP4 vr net3 vdd vdd pch w=10u l=1u
MN1 net1 net1 gnd gnd nch w=50u l=50u
MN2 net2 net2 gnd gnd nch w=20u l=1u
MN3 net3 net2 gnd gnd nch w=26u l=1u

R1 vr gnd 2k

.lib 'mm018.l' tt

.op
.option post probe
.probe v(vr)
.dc vdd 0 1.8 .001
.probe i(vr)

.end

