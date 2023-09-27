.protect
.inc 'v01c_mm_non_epi-params.txt'
.unprotect

.GLOBAL vdd! gnd!

.SUBCKT dynamic_comp_inv vi vo
*.PININFO vi:I vo:O
MM4 vo vi vdd! vdd! CMOSP W=4u L=350.00n m=1
MM3 vo vi gnd! gnd! CMOSN W=1u L=350.00n m=1
.ENDS


.SUBCKT dynamic_comp_xor2 A B xor2
*.PININFO A:I B:I xor2:O
XI0 A Ab / dynamic_comp_inv
XI1 B Bb / dynamic_comp_inv
MM0 xor2 B net20 gnd! CMOSN W=1u L=350n m=5
MM6 net12 Ab gnd! gnd! CMOSN W=1u L=350n m=5
MM5 xor2 Bb net12 gnd! CMOSN W=1u L=350n m=5
MM11 net20 A gnd! gnd! CMOSN W=1u L=350n m=5
MM8 xor2 B net27 vdd! CMOSP W=3u L=350n m=5
MM9 net35 A vdd! vdd! CMOSP W=3u L=350n m=5
MM10 xor2 Bb net35 vdd! CMOSP W=3u L=350n m=5
MM7 net27 Ab vdd! vdd! CMOSP W=3u L=350n m=5
.ENDS


.SUBCKT dynamic_comp_nand2 va vab vb
*.PININFO va:I vb:I vab:O
MM0 vab va vdd! vdd! CMOSP W=3u L=350n m=15
MM1 vab vb vdd! vdd! CMOSP W=3u L=350n m=15
MM2 vab va net16 gnd! CMOSN W=1u L=350n m=15
MM3 net16 vb gnd! gnd! CMOSN W=1u L=350n m=15
.ENDS


.SUBCKT dynamic_comp_latch Q Qb R S
*.PININFO R:I S:I Q:O Qb:O
XI5 Qb Q net14 / dynamic_comp_nand2
XI1 net16 Qb Q / dynamic_comp_nand2
XI4 R net12 / dynamic_comp_inv
XI3 net12 net14 / dynamic_comp_inv
XI2 net18 net16 / dynamic_comp_inv
XI0 S net18 / dynamic_comp_inv
.ENDS


.SUBCKT dynamic_comp vin vip vlatch von vop vrefn vrefp
*.PININFO vin:I vip:I vlatch:I vrefn:I vrefp:I von:O vop:O
MMP9 von vlatch vdd! vdd! CMOSP W=1u L=350n m=5
MMP11 vop von vdd! vdd! CMOSP W=1u L=350n m=5
MMP10 von vop vdd! vdd! CMOSP W=1u L=350n m=5
MMP12 vop vlatch vdd! vdd! CMOSP W=1u L=350n m=5
MMN7 von vlatch net48 gnd! CMOSN W=1u L=350n m=5
MMN6 net28 von net36 gnd! CMOSN W=1u L=350n m=5
MMN1 net32 vrefn gnd! gnd! CMOSN W=3u L=350n m=20
MMN3 net36 vin gnd! gnd! CMOSN W=3u L=350n m=20
MMN2 net32 vip gnd! gnd! CMOSN W=3u L=350n m=20
MMN4 net36 vrefp gnd! gnd! CMOSN W=3u L=350n m=20
MMN5 net48 vop net32 gnd! CMOSN W=1u L=350n m=5
MMN8 vop vlatch net28 gnd! CMOSN W=1u L=350n m=5
.ENDS


.SUBCKT flash_ADC_3b B1 B2 B3 T1 T1b T2 T2b T3 T3b T4 T4b T5 T5b T6 T6b T7 T7b 
+ vcm vin vip vlatch
*.PININFO vcm:I vin:I vip:I vlatch:I B1:O B2:O B3:O T1:O T1b:O T2:O T2b:O T3:O 
*.PININFO T3b:O T4:O T4b:O T5:O T5b:O T6:O T6b:O T7:O T7b:O
RR4 net11 vref3p 10K $[RP]
RR2 vref7p vref6p 10K $[RP]
RR1 vref2n vref3n 10K $[RP]
RR8 vref6n vref7n 10K $[RP]
RR7 net13 vref5n 10K $[RP]
RR15 vdd! vref1n 120K $[RP]
RR14 vdd! vref7p 120K $[RP]
RR0 vref1n vref2n 10K $[RP]
RR12 vref1p gnd! 120K $[RP]
RR9 vref5n vref6n 10K $[RP]
RR5 vref5p net11 10K $[RP]
RR11 vref2p vref1p 10K $[RP]
RR3 vref6p vref5p 10K $[RP]
RR6 vref3n net13 10K $[RP]
RR10 vref3p vref2p 10K $[RP]
RR13 vref7n gnd! 120K $[RP]


XI58 net074 B3 / dynamic_comp_inv
XI57 G3 net074 / dynamic_comp_inv
XI56 G2 B3 B2 / dynamic_comp_xor2
XI55 G1 B2 B1 / dynamic_comp_xor2
XI20 net46 G3 net46 / dynamic_comp_nand2
XI19 net49 G2 net49 / dynamic_comp_nand2
XI18 net55 G1 net52 / dynamic_comp_nand2
XI17 T4 net46 T4 / dynamic_comp_nand2
XI16 T2 net49 T6b / dynamic_comp_nand2
XI15 T5 net52 T7b / dynamic_comp_nand2
XI14 T1 net55 T3b / dynamic_comp_nand2

XI13 T1 T1b net104 net103 / dynamic_comp_latch
XI12 T2 T2b net111 net110 / dynamic_comp_latch
XI11 T3 T3b net118 net117 / dynamic_comp_latch
XI10 T4 T4b net125 net124 / dynamic_comp_latch
XI9 T5 T5b net132 net131 / dynamic_comp_latch
XI8 T6 T6b net97 net96 / dynamic_comp_latch
XI7 T7 T7b net90 net89 / dynamic_comp_latch

XI6 vin vip vlatch net104 net103 vref1n vref1p / dynamic_comp
XI5 vin vip vlatch net111 net110 vref2n vref2p / dynamic_comp
XI4 vin vip vlatch net118 net117 vref3n vref3p / dynamic_comp
XI3 vin vip vlatch net125 net124 vcm vcm / dynamic_comp
XI2 vin vip vlatch net132 net131 vref5n vref5p / dynamic_comp
XI1 vin vip vlatch net97 net96 vref6n vref6p / dynamic_comp
XI0 vin vip vlatch net90 net89 vref7n vref7p / dynamic_comp
.ENDS


XfADC B1 B2 B3 T1 T1b T2 T2b T3 T3b T4 T4b T5 T5b T6 T6b T7 T7b 
+ vcm vin vip clk / flash_ADC_3b

v1 vdd! 0 DC 3v
v2 gnd! 0 0v 

Vcm vcm 0 1.5V

vinp vin 0 dc  1.5v   
vinn vip 0 PWL (0ns 0v 10us 3v)

Vreset clk 0 pulse (0v 3v 0.1u 0.1n 0.1n 0.2499u 0.5u) 


.TRAN 0.01u  10u  *0.001u   800u          
.meas tran tot_power avg power  from=0  to=10u

.op 
.option post = 2
.option acout=0

.END
