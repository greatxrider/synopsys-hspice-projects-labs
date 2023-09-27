*Hysteresis Comparator

vdd          vdd          gnd          1.8v
Iref          vbias       gnd           18u
*Hysteresis

mp1	c	in-	a	vdd	pch	l=1u	w=3u	m=1
mp2	d	in+	a	vdd	pch	l=1u	w=3u	m=1
mn3	c	c	gnd	gnd	nch	l=1u	w=1u	m=1
mn4	d	d	gnd	gnd	nch	l=1u	w=1u	m=1
mn5	d	c	gnd	gnd	nch	l=1u	w=1u	m=2
mn6	c	d	gnd	gnd	nch	l=1u	w=1u	m=2
mn7	out	d	gnd 	gnd	nch	l=1u	w=1u	m=1
mp8	b	b	vdd	vdd	pch	l=1u	w=3u	m=1
mn9	b	c	gnd	gnd	nch	l=1u	w=1u	m=1
mp10	out	b	vdd	vdd	pch	l=1u	w=3u	m=1
mp11	a	vbias	vdd	vdd	pch	l=1u	w=3u	m=2

mp12	out1	out	vdd	vdd	pch	l=1u	w=3u	m=1
mn13	out1	out	gnd	gnd	nch	l=1u	w=1u	m=1
mp14	out2	out1	vdd	vdd	pch	l=1u	w=3u	m=1
mn15	out2	out1	gnd	gnd	nch	l=1u	w=1u	m=1

mpbias	vbias	vbias	vdd	vdd	pch	l=1u	w=3u	m=2

vinput-	in-	gnd	dc=0.9v 
vinput+	in+	nodeh	dc=0 sin(0.9v 0.9v 5k 0 0 0)
vnoise      nodeh      gnd          dc=0 sin(0 140mV 10000000 0 0 0)

*vinput+	in+	nodeh	dc=0 pwl(0s 0, 100u 1.8v, 200u 0, R)

vdiff	vinput+    vinput-     0v

.op
.option post probe
.dc in+  -1.8v 1.8v 0.01v
.dc in+ 1.8v 1.8v  -0.01v
.tran 0.01u 211u start=194u
.probe tran v(in-) v(in+) v(out)
.prot
.lib 'mm018.l' tt
.unprot

.end