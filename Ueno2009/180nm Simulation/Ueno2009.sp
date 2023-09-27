*ueno2009

.lib 'mm018.l' tt
*.lib 'mm018.l' tt_bip

vdd vdd gnd 0.5v

*startupckt

m15 vdd wire3 wire3 wire3 pch w=60u l=3u
m16 wire3 wire4 wire4 wire4 pch w=60u l=3u
m17 wire4 vref wire2 wire2 pch w=60u l=3u
m18 wire2 vref gnd gnd nch w=60u l=3u
m19 wire1 wire2 gnd gnd nch w=60u l=3u

*diffamp

m10 vdd wire5 wire5 wire5 pch w=60u l=3u
m11 vdd wire5 wire1 wire1 pch w=60u l=3u
m12 wire5 wire6 wire7 wire7 nch w=20u l=3u
m13 wire1 wire9 wire7 wire7 nch w=20u l=3u
m14 wire7 wire8 gnd gnd nch w=60u l=3u

*currentmirrtop
m20 vdd wire1 wire9 wire9 pch w=60u l=3u
m21 vdd wire1 wire6 wire6 pch w=60u l=3u
m22 vdd wire1 wire12 wire12 pch w=60u l=3u
m23 vdd wire1 wire14 wire14 pch w=60u l=3u
m24 vdd wire1 vref vref pch w=60u l=3u

*cascadecurrmirr

m8 wire9 wire9 wire8 wire8 nch w=60u l=3u
m9 wire6 wire9 wire10 wire10 nch w=60u l=3u
m1 wire8 wire8 gnd gnd nch w=60u l=3u
m2 wire10 wire8 wire11 wire11 nch w=60u l=3u
m25 wire11 vref gnd gnd nch w=60u l=3u

*Biasvoltagesubckt

m3 wire12 wire12 wire13 wire13 nch w=60u l=3u 
m4 wire13 wire12 gnd gnd nch w=6u l=3u
m5 wire14 wire14 wire15 wire15 nch w=60u l=3u
m6 wire15 wire14 wire13 wire13 nch w=6u l=3u
m7 vref vref wire15 wire15 nch w=6u l=3u

*passivecomp

c1 vdd wire1 1p
c2 wire9 gnd 1p
c3 wire1 wire6 1p

.option post probe
.op
.dc temp -20 80 0.1
.dc vdd 0v 1.4v 0.1

.probe v(vref)

.end




