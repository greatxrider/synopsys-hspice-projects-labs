*KunPeng2018

.lib 'toplevel.l' tt_lib
*.lib 'crn65lp_2d5_lk_v1d7.l' tt
*.lib 'crn65lp_2d5_lk_v1d7.l' tt_bip

vdd vdd gnd 1.2v
i1 vdd wire11 18u

*Current_mirrors

M0 wire1 wire2 vdd vdd pch W=60u L=3u  
M1 wire3 wire2 vdd vdd pch W=60u L=3u 
M2 wire4 wire2 vdd vdd pch W=60u L=3u  
M3 wire5 wire2 vdd vdd pch W=60u L=3u  

*Resistors

R1 wire1 wire6 25k

R2 wire1 gnd 10k
R6 wire7 gnd 10k

R3 wire1 wire4 25k
R7 wire7 wire4 25k

R4 vref gnd 500k
R5 wire5 vref 50k

*Capacitors
C1 vdd wire2 3p
C2 wire2 gnd 3p

*BJT

Q1 gnd gnd wire6 pnp10 
Q2 gnd gnd wire3 pnp10
Q3 gnd gnd wire4 pnp10 

*twostage_amp_miller_compensated

Mp1 wire8 wire8 vdd vdd pch W=20u L=3u
Mp2 wire9 wire8 vdd vdd pch W=20u L=3u

Mp3 wire2 wire9 vdd vdd pch W=16u L=3u

Md1 wire8 wire1 wire10 wire10 nch W=16u L=3u
Md2 wire9 wire7 wire10 wire10 nch W=16u L=3u

Mn1 wire11 wire11 gnd gnd nch W=6u L=3u
Mn2 wire10 wire11 gnd gnd nch W=6u L=3u
Mn3 wire2 wire11 gnd gnd nch W=6u L=3u

.op
.option post probe

*meas_tem_pvref
.dc temp -20 100 0.1
.dc vdd 0v 1.8v 0.1
.probe v(wire2), v(vref), v(wire1,wire6), v(wire1,gnd), v(wire7,wire4), v(wire1,wire4), v(wire5,vref), v(wire7,gnd)

*meas_two_stage
*.meas ac gb when vdb(wire2)=0
*.ac dec 100 10 10g
*.probe v(wire2)

*.alter
*.lib 'crn65lp_2d5_lk_v1d7.l' ff
*.alter 
*.lib 'crn65lp_2d5_lk_v1d7.l' ss
*.alter 
*.lib 'crn65lp_2d5_lk_v1d7.l' fs
*.alter 
*.lib 'crn65lp_2d5_lk_v1d7.l' sf

.end

