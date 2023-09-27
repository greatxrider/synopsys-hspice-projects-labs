*4 BIT FLASH ADC — RENEW

.protect
.inc 'v01c_mm_non_epi-params.txt'
.unprotect

.GLOBAL vdd! gnd!

*INVERTER EQ. MOS CKT

.SUBCKT dynamic_comp_inv vi vo
*.PININFO vi:I vo:O
MM4 vo vi vdd! vdd! CMOSP W=4u L=350.00n m=1
MM3 vo vi gnd! gnd! CMOSN W=1u L=350.00n m=1

.ENDS


*XOR GATE EQ. MOS CKT

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

*NAND GATE EQ. MOS CKT

.SUBCKT dynamic_comp_nand2 va vab vb
*.PININFO va:I vb:I vab:O
MMA vab va vdd! vdd! CMOSP W=3u L=350n m=15
MMB vab vb vdd! vdd! CMOSP W=3u L=350n m=15
MMC vab va net16 gnd! CMOSN W=1u L=350n m=15
MMD net16 vb gnd! gnd! CMOSN W=1u L=350n m=15

.ENDS

*AND GATE EQ. MOS CKT

.SUBCKT dynamic_comp_and1 va vo1 vb
MME vab va vdd! vdd! CMOSP W=3u L=350n m=15
MMF vab vb vdd! vdd! CMOSP W=3u L=350n m=15
MMG vab va neta3 gnd! CMOSN W=1u L=350n m=15
MMH neta3 vb gnd! gnd! CMOSN W=1u L=350n m=15

MMI vo1 vab vdd! vdd! CMOSP W=4u L=350.00n m=1
MMJ vo1 vab gnd! gnd! CMOSN W=1u L=350.00n m=1

.ENDS

*LATCH CIRCUIT 

.SUBCKT dynamic_comp_latch Q Qb R S
*.PININFO R:I S:I Q:O Qb:O
XI5 Qb Q net14 / dynamic_comp_nand2
XI1 net16 Qb Q / dynamic_comp_nand2
XI4 R net12 / dynamic_comp_inv
XI3 net12 net14 / dynamic_comp_inv
XI2 net18 net16 / dynamic_comp_inv
XI0 S net18 / dynamic_comp_inv

.ENDS

*COMPARATOR EQ. MOS CKT

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

*4 BIT FLASH ADC

.SUBCKT flash_ADC_4b G0 G1 G2 G3 B0 B1 B2 B3 T1 T1b T2 T2b T3 T3b T4 T4b T5 T5b T6 T6b T7 T7b 
+ T8 T8b T9 T9b T10 T10b T11 T11b T12 T12b T13 T13b T14 T14b T15 T15b vcm vin vip vlatch

*.PININFO vcm:I vin:I vip:I vlatch:I B1:O B2:O B3:O T1:O T1b:O T2:O T2b:O T3:O 
*.PININFO T3b:O T4:O T4b:O T5:O T5b:O T6:O T6b:O T7:O T7b:O

*32 RESISTOR LADDERS

*Vrefn

R1 vdd! vref1n 190K $[RP]
R2 vref1n vref2n 10K $[RP]
R3 vref2n vref3n 10K $[RP]
R4 vref3n vref4n 10K $[RP]
R5 vref4n vref5n 10K $[RP]
R6 vref5n vref6n 10K $[RP]
R7 vref6n vref7n 10K $[RP]
R8 vref7n net13 10K $[RP]
R9 net13 vref9n 10K $[RP]
R10 vref9n vref10n 10K $[RP]
R11 vref10n vref11n 10K $[RP]
R12 vref11n vref12n 10K $[RP]
R13 vref12n vref13n 10K $[RP]
R14 vref13n vref14n 10K $[RP]
R15 vref14n vref15n 10K $[RP]
R16 vref15n gnd! 190K $[RP]
R16b vdd! vref15p 190K $[RP]
R15b vref15p vref14p 10K $[RP]
R14b vref14p vref13p 10K $[RP]
R13b vref13p vref12p 10K $[RP]
R12b vref12p vref11p 10K $[RP]
R11b vref11p vref10p 10K $[RP]
R10b vref10p vref9p 10K $[RP]
R9b vref9p net11 10K $[RP]
R8b net11 vref7p 10K $[RP]
R7b vref7p vref6p 10K $[RP]
R6b vref6p vref5p 10K $[RP]
R5b vref5p vref4p 10K $[RP]
R4b vref4p vref3p 10K $[RP]
R3b vref3p vref2p 10K $[RP]
R2b vref2p vref1p 10K $[RP]
R1b vref1p gnd! 190K $[RP]

*15 COMPARATORS (2^N-1)

XI6 vin vip vlatch neta netb vref1n vref1p / dynamic_comp
XI5 vin vip vlatch netc netd vref2n vref2p / dynamic_comp
XI4 vin vip vlatch nete netf vref3n vref3p / dynamic_comp
XI3 vin vip vlatch netg neth vref4n vref4p / dynamic_comp
XI2 vin vip vlatch neti netj vref5n vref5p / dynamic_comp
XI1 vin vip vlatch netk netl vref6n vref6p / dynamic_comp
XI0 vin vip vlatch netm netn vref7n vref7p / dynamic_comp
XI7 vin vip vlatch neto netp vcm vcm / dynamic_comp  
XI8 vin vip vlatch netq netr vref9n vref9p / dynamic_comp
XI9 vin vip vlatch nets nett vref10n vref10p / dynamic_comp 
XI10 vin vip vlatch netu netv vref11n vref11p / dynamic_comp
XI11 vin vip vlatch netw netx vref12n vref12p / dynamic_comp
XI12 vin vip vlatch nety netz vref13n vref13p / dynamic_comp
XI13 vin vip vlatch neta2 netb2 vref14n vref14p / dynamic_comp
XI14 vin vip vlatch netc2 netd2 vref15n vref15p / dynamic_comp

*BINARY CODES TO THERMOMETER CODES (LATCH)

XI15 T1 T1b neta netb / dynamic_comp_latch
XI16 T2 T2b netc netd / dynamic_comp_latch
XI17 T3 T3b nete netf / dynamic_comp_latch
XI18 T4 T4b netg neth / dynamic_comp_latch
XI19 T5 T5b neti netj / dynamic_comp_latch
XI20 T6 T6b netk netl / dynamic_comp_latch
XI21 T7 T7b netm netn / dynamic_comp_latch
XI22 T8 T8b neto netp / dynamic_comp_latch
XI23 T9 T9b netq netr / dynamic_comp_latch
XI24 T10 T10b nets nett / dynamic_comp_latch
XI25 T11 T11b netu netv / dynamic_comp_latch
XI26 T12 T12b netw netx / dynamic_comp_latch
XI27 T13 T13b nety netz / dynamic_comp_latch
XI28 T14 T14b neta2 netb2 / dynamic_comp_latch
XI29 T15 T15b netc2 netd2 / dynamic_comp_latch

*Thermometer -> Gray -> Binary Code (ENCODER)

XI30 T1 wire1 T3b / dynamic_comp_nand2

*XI32 wire2 invwire2 / dynamic_comp_inv

XI31 T5 wire3 T7b / dynamic_comp_nand2 

XI33 wire1 wire2 wire3 / dynamic_comp_and1

XI35 T9 wire4 T11b / dynamic_comp_nand2

XI38 T13 wire6 T15b / dynamic_comp_nand2

XI36 wire4 wire5 wire6 / dynamic_comp_and1

XI34 wire2 G0 wire5 / dynamic_comp_nand2

*XI37 wire5 invwire5 / dynamic_comp_inv

XI39 T2 wire7 T6b / dynamic_comp_nand2
XI40 T10 wire8 T14b / dynamic_comp_nand2
XI41 T4 wire9 T12b / dynamic_comp_nand2
XI42 T8 wire10 T8 / dynamic_comp_nand2

XI43 wire7 G1 wire8 / dynamic_comp_nand2
XI44 wire9 G2 wire9 / dynamic_comp_nand2
XI45 wire10 G3 wire10 / dynamic_comp_nand2

XI47 G1 B2 B1 / dynamic_comp_xor2
XI46 G0 B1 B0 / dynamic_comp_xor2
XI49 G2 B3 B2 / dynamic_comp_xor2

XI51 T8 net074 / dynamic_comp_inv
XI50 net074 G3 / dynamic_comp_inv
XI52 G3 neta4 / dynamic_comp_inv
XI53 neta4 B3 / dynamic_comp_inv

.ENDS

XfADC G0 G1 G2 G3 B0 B1 B2 B3 T1 T1b T2 T2b T3 T3b T4 T4b T5 T5b T6 T6b T7 T7b 
+T8 T8b T9 T9b T10 T10b T11 T11b T12 T12b T13 T13b T14 T14b T15 T15b vcm vin vip clk / flash_ADC_4b

v1 vdd! 0 DC 3v
v2 gnd! 0 DC 0v 

Vcm vcm 0 1.5V

vinp vin 0 dc  1.5V   
vinn vip 0 PWL (0ns 0v 20us 3v)

Vreset clk 0 pulse (0v 3v 0.1u 0.1n 0.1n 0.2499u 0.5u) 

.TRAN 0.01u  20u  *0.001u   800u          
.meas tran tot_power avg power  from=0  to=10u

.op
.option post = 2
.option acout = 0


.END

