lab2_Step3.b

m1 vout+ 1 2 0 nch l=0.79u w=0.95u
m2 2 2 0 nch l=0.79u w=0.95u
vgs 1 v1 dc 1.53v
v1 v1 0 sin(0 0.05 100k 0 0)
vds vds 0 dc 2v
r1 vds vout+ 10k
c1 vout+ 0 10p ic=0

.lib 'mm018.l' TT
.op
.option post probe
.tran 625ns 10.24ms
.fft v(vout+) start=0 stop=10.24ms np=16384
.end