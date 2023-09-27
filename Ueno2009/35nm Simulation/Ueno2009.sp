*ueno2009

.lib 'all_mos.l' tt
*.lib 'all_mos.l' tt_bip

vdd vdd gnd 1.4v

*startupckt

m15 wire3 wire3 vdd vdd pch w=3u l=3u
m16 wire4 wire4 wire3 wire3 pch w=3u l=3u
m17 wire2 vref wire4 wire4 pch w=3u l=3u
m18 wire2 vref gnd gnd nch w=3u l=3u
m19 wire1 wire2 gnd gnd nch w=3u l=3u

*diffamp

m10 wire5 wire5 vdd vdd pch w=23u l=3u
m11 wire1 wire5 vdd vdd pch w=23u l=3u
m12 wire5 wire6 wire7 wire7 nch w=80u l=3u
m13 wire1 wire9 wire7 wire7 nch w=200u l=8u
m14 wire7 wire8 gnd gnd nch w=80u l=3u

*currentmirrtop

m20 wire9 wire1 vdd vdd pch w=200u l=3u
m21 wire6 wire1 vdd vdd pch w=200u l=3u
m22 wire12 wire1 vdd vdd pch w=200u l=3u
m23 wire14 wire1 vdd vdd pch w=200u l=3u
m24 vref wire1 vdd vdd pch w=200u l=3u

*cascadecurrmirr

m8 wire9 wire9 wire8 wire8 nch w=200u l=3u
m9 wire6 wire9 wire10 wire10 nch w=200u l=3u

*LnsetforMr1
m1 wire8 wire8 gnd gnd nch w=150u l=3u
m2 wire10 wire8 wire11 wire11 nch w=100u l=3u
m25 wire11 vref gnd gnd nch w=10u l=3u

*Biasvoltagesubckt

*Numerator

m3 wire12 wire12 wire13 wire13 nch w=200u l=3u 
m5 wire14 wire14 wire15 wire15 nch w=200u l=3u

*Denominator
m4 wire13 wire12 gnd gnd nch w=8u l=3u
m6 wire15 wire14 wire13 wire13 nch w=8u l=3u
m7 vref vref wire15 wire15 nch w=8u l=3u

*passivecomp

c1 vdd wire1 1p
c2 wire9 gnd 1p
c3 wire1 wire6 1p

.option post probe
.op
.dc temp -20 80 0.1
.dc vdd 0v 2v 0.1

.probe v(vref)

.alter
.lib 'all_mos.l' ff
.alter 
.lib 'all_mos.l' ss
.alter 
.lib 'all_mos.l' fs
.alter 
.lib 'all_mos.l' sf

.end




