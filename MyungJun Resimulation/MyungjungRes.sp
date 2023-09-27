*myungjungres_2

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

vdd vdd gnd 1.1v

*biasgen

mb4 wire1 wire1 vdd vdd pch w=1u l=3u
mb3 wire1 vo wire2 wire2 nch w=5u l=2u
mb2 wire2 vbe vbias vbias nch w=1u l=3u m=5 
mb1 vbias vbias gnd gnd nch w=1u l=3u

*currentmirr

m8 vo wire3 vdd vdd pch w=1u l=3u m=10

*opamp_ptatembedd

m7 wire5 wire1 vdd vdd pch w=1u l=3u m=2

m1L vo1 wire4 wire5 wire5 pch w=0.5u l=0.5u m=66
m2L vo1 wire6 wire7 wire7 nch w=1u l=1u 
m3L wire7 wire8 gnd gnd nch w=5u l=1u

m1R wire6 vbe wire5 wire5 pch w=0.5u l=0.5u 
m2R wire6 wire6 wire8 wire8 nch w=1u l=1u m=4
m3R wire8 wire8 gnd gnd nch w=5u l=1u m=4

m4 wire9 vo1 gnd gnd nch w=5u l=1u 
m5 wire3 wire5 wire9 wire9 nch w=0.5u l=5u 
m6 wire3 wire3 vdd vdd pch w=1u l=3u

Co vo gnd 5.4p
Cc vo wire8 1p

*bjt_branch

R2 vo wire4 3.5Meg
R1 wire4 vbe 1.6Meg
Q1 gnd gnd vbe pnp10 n=10

*comms

.option post probe
.op
.dc temp -40 140 0.1
.dc vdd 0v 1.8v 0.1
.probe v(wire4,vbe) , v(vbe,gnd) , v(vo) , v(wire1), v(wire5), i(R1), i(Q1)

.alter
.lib 'mm018.l' ff
.alter 
.lib 'mm018.l' ss
.alter 
.lib 'mm018.l' fs
.alter 
.lib 'mm018.l' sf

.end





