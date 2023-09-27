*mattia2015

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

vdd vdd gnd 0.5v

*currentmirrormfets

m9 wire2 wire1 vdd vdd pch w=12u l=2u 
m8 wire1 wire1 vdd vdd pch w=2u l=2u 
m10 wire5 wire1 vdd vdd pch w=2u l=2u 
m11 wire7 wire1 vdd vdd pch w=2u l=2u 
m12 vref wire1 vdd vdd pch w=4u l=2u 

*ve_div_bjt_biasckt

m1 wire3 wire3 gnd gnd nch w=8u l=2u 
m2 wire4 wire2 wire3 wire3 nch w=8u l=2u 
m3 wire1 wire2 wire4 wire4 nch w=80u l=2u 
q0 gnd gnd wire2 pnp10

*sc_ptatcells

m4 wire6 wire5 wire4 wire4 nch w=2u l=2u 
m5 wire5 wire5 wire6 wire6 nch w=16u l=2u 
m6 vref wire7 wire6 wire6 nch w=2u l=2u 
m7 wire7 wire7 vref vref nch w=16u l=2u 

.option post probe
.op
.dc temp 0 125 0.1
.dc vdd 0v 1.8v 0.1

.probe v(vref), v(wire3,gnd), v(wire2,gnd), v(vref,wire3), v(wire4,wire3), v(wire6,wire4), v(vref,wire6)

.alter
.lib 'mm018.l' ff
.alter 
.lib 'mm018.l' ss
.alter 
.lib 'mm018.l' fs
.alter 
.lib 'mm018.l' sf

.end




