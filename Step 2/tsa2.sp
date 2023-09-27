TwoStageAmplifier_Step2.1

mp4 vx vg1 vdd vdd pch w=11.345u l=1.5u
mp3 vg1 vg1 vdd vdd pch w=11.345u l=1.5u
mn2 vg1 vinp vs1 gnd nch w=6.654u l=1.5u
mn1 vx vinn vs1 gnd nch w=6.654u l=1.5u
mn5 vs1 vg2 gnd gnd nch w=10.265u l=1.5u
mn8 vg2 vg2 gnd gnd nch w=10.265u l=1.5u
mp6 vout vx vdd vdd pch w=67u l=1.5u
mn7 vout vg2 gnd gnd nch w=32u l=1.5u

Iref vdd vg2 18.33u
vdd vdd gnd dc 1.84v
vinp vinp gnd dc 1.1v ac 0v
vinn vinn gnd dc 1.1v ac 1v
cload vout gnd 10p

.op
.option post probe
.meas ac gb when vdb(vout)=0
.ac dec 100 10 10g
.probe v(vx), v(vout)
.tf v(vout) vinp
.pz v(vout) vinp
.lib 'mm018.l' tt

.end 