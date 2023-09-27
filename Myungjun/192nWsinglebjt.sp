*192nWsinglebjt

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

vdd vdd gnd 1.3v

*BVR

mb4 wire2 wire1 vdd vdd pch w=1u l=3u
mb3 wire2 vo wire4 wire4 nch w=5u l=2u
mb2 wire4 wire5 vbias vbias nch w=1u l=3u m=5
mb1 vbias vbias gnd gnd nch w=1u l=3u

m8 vo wire6 vdd vdd pch w=1u l=3u m=10
m7 wire8 wire1 vdd vdd pch w=1u l=3u m=2

m1L vo1 wire7 wire8 wire8 pch w=2u l=2u m=68
m2L vo1 wire10 wire11 wire11 nch w=1u l=1u
m3L wire11 wire12 gnd gnd nch w=5u l=1u

m1R wire10 wire5 wire8 wire8 pch w=2u l=2u m=2
m2R wire10 wire10 wire12 wire12 nch w=1u l=1u m=4
m3R wire12 wire12 gnd gnd nch w=5u l=1u m=4

m6 wire6 wire6 vdd vdd pch w=1u l=3u
m5 wire6 wire8 wire13 wire13 nch w=0.5u l=5u
m4 wire13 vo1 gnd gnd nch w=2u l=1u

q1 gnd gnd wire5 pnp10 n=5

R1 wire7 wire5 1.6M
R2 vo wire7 3.5M

Co vo gnd 5.4p
Cc vo wire12 1p

.option post probe
.op
.dc temp -40 140 0.1
.dc vdd 0v 1.8v 0.1
.probe v(vo), v(wire7,wire5), v(vo,wire7), v(vbe)

.end