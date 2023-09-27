*Sample and Hold Ideal Op-Amp

.lib 'mm018.l' tt
.lib 'mm018.l' tt_bip

e1 x gnd vin x max=1.8v min=0 3236

e2 vout gnd y vout max=1.8v min=0 3236

mn1 y vg x x nch w=30u l=1u

Vclk vg gnd pulse(0v 2.5v 0 1p 1p 1u 4u)
vin vin gnd pulse(0 1.8v 0 100u 100u 100u 400u)

cHold y gnd 100p

.op
.option post probe
.tran 1u 700u
.probe tran v(vin) v(vout) v(x)

.end