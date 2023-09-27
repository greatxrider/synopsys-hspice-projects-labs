*
*  **********************************************
*  *              SPICE MODEL               *
*  **********************************************
*  
*    PROCESS :  0.35um MIXED MODE (2P3M,3.3V/5V) POLYCIDE
*    MODEL   :  BSIM3 ( V3.1 )
*    DOC. NO.:  TA-1098-6001
*    VERSION :  2.0 
*    DATE    :  July 12 , 1999
*    HSPICE VERSION : H98.2 & H98.4
*
********************************************************************************
*                                                                             
*       SPICE model release notes for H97.2, H97.4 and H98.2 and H98.4:         
*                                                                         
*                                                                             
* (1) New parameter "CALCACM" is added in the H98.2 & H98.4                    
*                                                                             
*
*     In H97.2 & H97.4, the default values of AS/AD and PS/PD are zero when
* Bsim3v3.1 model with ACM=12 is used. This results in zero junction capacitance
* and incorrect junction leakage current, if AS/AD and PS/PD are not specified
* in the netlist. In H98.2 & H98.4, with CALCACM >0, the default calculation of 
* AS/AD and PS/PD will be calculated using HDIF. When CALCACM=0, the default is 
* zero for AS/AD and PS/PD.
*
* (2) New parameter "VFBFLAG" is added in H98.2 & H98.4
*
*     In H97.2 & H97.4, The capacitance model CAPMOD=0 normally uses a
* threshold voltage defined as Vth = vfbc + phi+ k1 * sqrt(phi - vbs), where
* vfbc is derived from the model parameter VFBCV. In this way, the CV will not
* track with VTH0 for corner simulation. In H98.2 and H98.4, VFBFLAG=1 uses
* Vth=vfb + phi + k1 * sqrt(phi - vbs), where vfb is identical to the  
* flatband voltage used in the drain current calculations. The resultant CV
* simulation will track with change in VTH0, which is more physical for corner
* case simulation. The VFBFLAG default value is zero.
*
* (3) Difference in simulation results for H97.2, H97.4 and H98.2 & H98.4
*
*     With VFBFLAG=1 and CALCACM=1 in H98.2/H98.4, the simulation results based
* on ring oscillator delay indicates that the difference is less than 6% 
* between the ring oscillator speed by using H98.2/H98.4 and that by using 
* H97.2 & H97.4. The discrepancy is mainly due to the effect of VFBFLAG=1. 
* By setting VFBFLAG=0, users would obtain the same results from H97.2, H97.4
* , H98.2 and H98.4.
*
******************************************************************************
******************************************************************************
*                                                                            * 
*       IN THIS MODEL LIB CONTAINS :                                         *  
*                                                                            *
*       1.LIB TT                                                             *
*             SS                                                             *
*             FF                                                             *
*             SF                                                             *
*             FS                                                             *
*        ( 3.3V Normal devices with different geometric and corner models)   *
*                                                                            *
*                                                                            *
*       2.LIB TT_5V                                                          *
*             SS_5V                                                          *
*             FF_5V                                                          *
*             SF_5V                                                          *
*             FS_5V                                                          *
*        ( 5V normal devices with different geometric and corner models)     *
*                                                                            *
*       3.LIB BIP                                                            *
*        ( P+/NW/PSUB 10x10, 5x5 vertical PNP bipolar )                      *
*                                                                            *
*       4.LIB DIO                                                            *
*        ( P+/NW , N+/PW & NW/PSUB diode )                                   *
*                                                                            *
******************************************************************************
******************************************************************************
*                                                                            *
* 1)To use these models directly by programming in this style:               *
*                                                                            *
*     .lib 'lib_path/lib_name' model_name                                    *
*                                                                            *
*                                                                            *
*    EX: .lib '/home/user/tsmc/MIXED035/mm0355v.l' TT                          *
*        for typical 3.3V N,PMOS                                             *
*        .lib '/home/user/tsmc/MIXED035/mm0355v.l' TT_5V                       *
*        for typical 5V N,PMOS                                               *
*  note:                                                                     *
*      corner_name                                                           *
*       TT : typical model for 3.3V devices                                  *
*       SS : Slow NMOS Slow PMOS model for 3.3V devices                      *
*       FF : Fast NMOS Fast PMOS model for 3.3V devices                      *
*       SF : Slow NMOS Fast PMOS model for 3.3V devices                      *
*       FS : Fast NMOS Slow PMOS model for 3.3V devices                      *
*                                                                            *
*       TT_5V : typical model for 5V devices                                 *
*       SS_5V : Slow NMOS Slow PMOS model for 5V devices                     *
*       FF_5V : Fast NMOS Fast PMOS model for 5V devices                     *
*       SF_5V : Slow NMOS Fast PMOS model for 5V devices                     *
*       FS_5V : Fast NMOS Slow PMOS model for 5V devices                     *
*                                                                            *
* 2)HDIF depends on your layout poly spacer to contact center distance.      *
*   The value listed here is TSMC minimum-rule value. You can change it      *
*   according to your layout.                                                *
*                                                                            *
******************************************************************************
***************************************************************
*                                                             *
*                3.3V NORMAL DEVICES LIB                      *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT
.param toxn  = 7.5e-9 toxp  = 7.7e-9 
+dxl  = 0 dxw  = 0
+dvtn  = 0 dvtp  = 0  
+cjn  = 9.50957e-4 cjp  =  1.38871E-3
+cjswn  = 2.84489e-10 cjswp  = 3.86159e-10
+cgon  = 2.063e-10 cgop  = 1.83e-10
+cjswgn  = 1.816514e-10 cjswgp  = 4.415421e-11 
+hdifn  = 3.65E-07 hdifp  = 3.65E-07  
.lib 'all_mos.l' MOS
.ENDL TT
**************** CORNER_LIB OF  SNSP   MODEL ****************************
.LIB SS
.param toxn  = 8.0e-9 toxp  = 8.2e-9   
+dxl  = 4e-8 dxw  = -6e-8
+dvtn  = 0.1 dvtp  = -0.1  
+cjn  = 1.0460527e-3 cjp  = 1.527581e-3 
+cjswn  = 3.129379e-10 cjswp  = 4.247749e-10
+cgon  = 2.2693e-10 cgop  = 2.013e-10
+cjswgn  = 1.9981654e-10 cjswgp  = 4.8569631e-11 
+hdifn  = 3.65E-07 hdifp  = 3.65E-07  
.lib 'all_mos.l'  MOS
.ENDL SS
**************** CORNER_LIB OF  FNFP   MODEL ****************************
.LIB FF
.param toxn  = 7.0e-9 toxp  = 7.2e-9  
+dxl  = -4e-8 dxw  = 6e-8  
+dvtn  = -0.1 dvtp  = 0.1  
+cjn  = 8.558613e-4 cjp  = 1.249839e-3  
+cjswn  = 2.560401e-10 cjswp  = 3.475431e-10  
+cgon  = 1.8567e-10 cgop  = 1.647e-10  
+cjswgn  = 1.6348626e-10 cjswgp  = 3.9738739e-11  
+hdifn  = 3.65E-07 hdifp  = 3.65E-07  
.lib 'all_mos.l'  MOS
.ENDL FF
**************** CORNER_LIB OF  SNFP   MODEL ****************************
.LIB SF
.param toxn  = 7.5e-9 toxp  = 7.7e-9  
+dxl  = 0 dxw  = 0  
+dvtn  = 0.1 dvtp  = 0.1  
+cjn  = 1.0460527e-3 cjp  = 1.249839e-3   
+cjswn  = 3.129379e-10 cjswp  = 3.475431e-10    
+cgon  = 2.063e-10 cgop  = 1.83e-10  
+cjswgn  = 1.9981654e-10 cjswgp  = 3.9738739e-11  
+hdifn  = 3.65E-07 hdifp  = 3.65E-07  
.lib 'all_mos.l'  MOS
.ENDL SF
**************** CORNER_LIB OF  FNSP   MODEL ****************************
.LIB FS
.param toxn  = 7.5e-9 toxp  = 7.7e-9  
+dxl  = 0 dxw  = 0
+dvtn  = -0.1 dvtp  = -0.1  
+cjn  = 8.558613e-4 cjp  = 1.527581e-3  
+cjswn  = 2.560401e-10 cjswp  = 4.247749e-10  
+cgon  = 2.063e-10 cgop  = 1.83e-10  
+cjswgn  = 1.6348626e-10 cjswgp  = 4.8569631e-11
+hdifn  = 3.65E-07 hdifp  = 3.65E-07  
.lib 'all_mos.l'  MOS
.ENDL FS
*
***************************************************************
*                                                             *
*                  5V NORMAL DEVICES LIB                      *
*                                                             *
***************************************************************
***************** CORNER_LIB OF TYPICAL MODEL ****************************
.LIB TT_5V 
.param toxn5 = 1.46e-8 toxp5 = 1.48e-8 
+dxl5 = 0 dxw5 = 0 
+dvtn5 = 0 dvtp5 = 0 
+cjn5 = 9.97124e-4   cjp5 = 1.385012e-3
+cjswn5 = 2.68215e-10  cjswp5 = 3.68278e-10
+cgon5 = 1.6463e-10   cgop5 = 1.714154e-10
+cjswgn5 = 1.844056e-10  cjswgp5 = 6.89655e-11
+hdifn5 = 3.65E-07    hdifp5 = 3.65E-07  
.lib 'all_mos.l' MOS_5V
.ENDL TT_5V 
**************** CORNER_LIB OF  SNSP   MODEL **************************** 
.LIB SS_5V 
.param toxn5 = 1.56e-8 toxp5 = 1.58e-8 
+dxl5 = 4e-8 dxw5 = -6e-8 
+dvtn5 = 0.1 dvtp5 = -0.15 
+cjn5 = 1.0968e-3   cjp5 = 1.5235132e-3
+cjswn5 = 2.950365E-10   cjswp5 = 4.051058e-10
+cgon5 = 1.811e-10    cgop5 = 1.8855694e-10
+cjswgn5 = 2.0284616e-10  cjswgp5 = 7.586205e-11
+hdifn5 = 3.65E-07    hdifp5 = 3.65E-07  
.lib 'all_mos.l'  MOS_5V 
.ENDL SS_5V                               
**************** CORNER_LIB OF  FNFP   MODEL **************************** 
.LIB FF_5V 
.param toxn5 = 1.36e-8 toxp5 = 1.38e-8 
+dxl5 = -4e-8 dxw5 = 6e-8 
+dvtn5 = -0.1 dvtp5 = 0.15 
+cjn5 = 8.974116e-4   cjp5 = 1.2465108e-3
+cjswn5 = 2.413539e-10   cjswp5 = 3.314502e-10
+cgon5 = 1.48167e-10   cgop5 = 1.5427386e-10
+cjswgn5 = 1.65965e-10  cjswgp5 = 6.206895e-11
+hdifn5 = 3.65E-07    hdifp5 = 3.65E-07  
.lib 'all_mos.l'  MOS_5V 
.ENDL FF_5V 
**************** CORNER_LIB OF  SNFP   MODEL **************************** 
.LIB SF_5V 
.param toxn5 = 1.46e-8 toxp5 = 1.48e-8 
+dxl5 = 0 dxw5 = 0 
+dvtn5 = 0.1 dvtp5 = 0.15 
+cjn5 = 1.0968e-3   cjp5 = 1.2465108e-3
+cjswn5 = 2.950365E-10   cjswp5 = 3.314502e-10
+cgon5 = 1.6463e-10    cgop5 = 1.714154e-10
+cjswgn5 = 2.0284616e-10  cjswgp5 = 6.206895e-11
+hdifn5 = 3.65E-07    hdifp5 = 3.65E-07  
.lib 'all_mos.l'  MOS_5V 
.ENDL SF_5V 
**************** CORNER_LIB OF  FNSP   MODEL **************************** 
.LIB FS_5V 
.param toxn5 = 1.46e-8 toxp5 = 1.48e-8 
+dxl5 = 0 dxw5 = 0 
+dvtn5 = -0.1 dvtp5 = -0.15 
+cjn5 = 8.974116e-4   cjp5 = 1.5235132e-3
+cjswn5 = 2.413539e-10   cjswp5 = 4.051058e-10
+cgon5 = 1.6463e-10    cgop5 = 1.714154e-10
+cjswgn5 = 1.65965e-10  cjswgp5 = 7.586205e-11
+hdifn5 = 3.65E-07    hdifp5 = 3.65E-07  
.lib 'all_mos.l'  MOS_5V 
.ENDL FS_5V 
*
**************************************************************************
*
***************************************************************
*                                                             *
*                                                             *
*               3.3V NORMAL DEVICES MODEL                     *
*                                                             *
*                                                             *
*                                                             *
***************************************************************
*   
.LIB MOS
*
***************************************************************
*                                                             *
*               3.3V NMOS DEVICES MODEL                       *
*                                                             *
***************************************************************
.MODEL nch.1             NMOS   (                    LMIN    = '1.207E-06-dxl' 
+LMAX    = 2.01E-05        WMIN    = '1.183E-06-dxw' WMAX    = '1.9983E-5-dxw' 
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.536027' LVTH0   = 3.726466E-08    WVTH0   = -2.1316E-08     
+PVTH0   = -2.460013E-14   K1      = 0.5246611       LK1     = -1.639613E-08   
+WK1     = -5.031044E-08   PK1     = 2.211867E-14    K2      = 0.02709882      
+LK2     = -6.586022E-09   WK2     = 5.785586E-09    PK2     = 3.435911E-15    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 95850.88        LVSAT   = 0.01310061      
+WVSAT   = 0.0008223997    PVSAT   = -1.641506E-08   UA      = 3.196265E-11    
+LUA     = -3.698079E-17   WUA     = -6.408507E-16   PUA     = 7.414642E-22    
+UB      = 2.045354E-18    LUB     = 6.227287E-25    WUB     = 5.533028E-26    
+PUB     = -1.805726E-30   UC      = 6.725734E-11    LUC     = 1.901776E-17    
+WUC     = -3.996494E-17   PUC     = -3.876839E-23   RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.04660162      LU0     = 5.515446E-09    WU0     = -1.626703E-08   
+PU0     = -4.134264E-15   A0      = 0.5017616       LA0     = 5.552729E-07    
+WA0     = 6.615518E-07    PA0     = -5.219843E-13   KETA    = -0.008348037    
+LKETA   = 2.403177E-08    WKETA   = 2.44925E-08     PKETA   = -3.102829E-14   
+A1      = 0               A2      = 0.99            AGS     = 0.09736285      
+LAGS    = 1.223815E-07    WAGS    = 1.607973E-07    PAGS    = -4.561918E-14   
+B0      = 0               B1      = 0               VOFF    = -0.1432202      
+LVOFF   = 3.766451E-08    WVOFF   = 2.755289E-08    PVOFF   = -1.641511E-14   
+NFACTOR = 1.071551        LNFACTOR= -3.18949E-07    WNFACTOR= -3.166332E-07   
+PNFACTOR= 4.241266E-13    CIT     = -7.628655E-05   LCIT    = 2.723331E-10    
+WCIT    = 4.660042E-10    PCIT    = -4.03804E-16    CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = 0.0002181413    
+LETA0   = 4.893156E-10    WETA0   = -2.201543E-10   PETA0   = 3.379313E-16    
+ETAB    = 1.65427E-05     LETAB   = -1.913991E-11   WETAB   = -2.072801E-11   
+PETAB   = 2.39823E-17     DSUB    = 0               PCLM    = 0.1632291       
+LPCLM   = 7.33948E-07     WPCLM   = 7.523777E-09    PPCLM   = -1.501737E-13   
+PDIBLC1 = 1E-05           PDIBLC2 = -0.0001189527   LPDIBLC2= 3.04769E-09     
+WPDIBLC2= 7.281391E-12    PPDIBLC2= -5.988417E-16   PDIBLCB = 0.138753        
+DROUT   = 0               PSCBE1  = 4.710076E+08    LPSCBE1 = -47.68667       
+WPSCBE1 = -72.788         PPSCBE1 = -1.725277E-05   PSCBE2  = 0.0001510638    
+LPSCBE2 = -1.69574E-10    WPSCBE2 = -1.390941E-10   PPSCBE2 = 1.578688E-16    
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06        
+BETA0   = 20.7            KT1     = -0.2700492      LKT1    = -3.095004E-08   
+WKT1    = 2.812907E-08    PKT1    = 7.879249E-14    KT2     = -0.04153765     
+LKT2    = 2.524311E-08    WKT2    = 2.833375E-08    PKT2    = -1.608147E-14   
+AT      = 2219.528        LAT     = -0.02686487     WAT     = -0.002395568    
+PAT     = 2.596705E-08    UTE     = -2.065168       LUTE    = -4.132515E-07   
+WUTE    = 4.668071E-07    PUTE    = 3.33133E-13     UA1     = 1.422613E-10    
+LUA1    = -1.44336E-15    WUA1    = 9.693937E-16    PUA1    = 1.598886E-22    
+UB1     = -2.172033E-18   LUB1    = 1.404262E-24    WUB1    = 5.546184E-26    
+PUB1    = 6.856764E-31    UC1     = -5.716306E-11   LUC1    = 5.31648E-17     
+WUC1    = -2.396283E-17   PUC1    = -2.142338E-24   KT1L    = 0               
+PRT     = 24.11496        LPRT    = -1.086812E-05   WPRT    = -0.000500091    
+PPRT    = 1.361775E-11    
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )
*
*
.MODEL nch.2             NMOS   (                    LMIN    = '8.07E-07-dxl'  
+LMAX    = '1.207E-06-dxl' WMIN    = '1.183E-06-dxw' WMAX    = '1.9983E-5-dxw' 
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.546655' LVTH0   = 2.496758E-08    WVTH0   = -4.998887E-08   
+PVTH0   = 8.574382E-15    K1      = 0.4989724       LK1     = 1.332564E-08    
+WK1     = -1.063668E-07   PK1     = 8.697584E-14    K2      = 0.02537151      
+LK2     = -4.587532E-09   WK2     = 1.546677E-08    PK2     = -7.765214E-15   
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 129157.8        LVSAT   = -0.02543551     
+WVSAT   = -0.07469934     PVSAT   = 7.096359E-08    UA      = 0               
+UB      = 3.817944E-18    LUB     = -1.428159E-24   WUB     = -3.001886E-24   
+PUB     = 1.731473E-30    UC      = 1.288592E-10    LUC     = -5.225554E-17   
+WUC     = -1.385508E-16   PUC     = 7.529545E-23    RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.05813805      LU0     = -7.83221E-09    WU0     = -2.807534E-08   
+PU0     = 9.527953E-15    A0      = 1.417374        LA0     = -5.040912E-07   
+WA0     = 4.499891E-07    PA0     = -2.772062E-13   KETA    = 0.02457614      
+LKETA   = -1.40615E-08    WKETA   = -1.016334E-08   PKETA   = 9.068513E-15    
+A1      = 0               A2      = 0.99            AGS     = 0.5850528       
+LAGS    = -4.418758E-07   WAGS    = 4.016458E-07    PAGS    = -3.242809E-13   
+B0      = 0               B1      = 0               VOFF    = -0.1838075      
+LVOFF   = 8.462402E-08    WVOFF   = 1.050108E-07    PVOFF   = -1.060339E-13   
+NFACTOR = -0.0335216      LNFACTOR= 9.596193E-07    WNFACTOR= 1.057246E-06    
+PNFACTOR= -1.165451E-12   CIT     = 0.0004911736    LCIT    = -3.842184E-10   
+WCIT    = -3.289006E-10   PCIT    = 5.159007E-16    CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = 0.0001221602    
+LETA0   = 6.003658E-10    WETA0   = 9.98899E-10     PETA0   = -1.072513E-15   
+ETAB    = -6.307671E-06   LETAB   = 7.29797E-12     WETAB   = 1.264687E-10    
+PETAB   = -1.463242E-16   DSUB    = 0               PCLM    = 0.7657633       
+LPCLM   = 3.681587E-08    WPCLM   = -3.195318E-07   PPCLM   = 2.282295E-13    
+PDIBLC1 = 1E-05           PDIBLC2 = -0.001092725    LPDIBLC2= 4.174345E-09    
+WPDIBLC2= -5.786619E-10   PPDIBLC2= 7.909472E-17    PDIBLCB = -0.1138522      
+LPDIBLCB= 2.922645E-07    WPDIBLCB= 3.165146E-07    PPDIBLCB= -3.662074E-13   
+DROUT   = 0               PSCBE1  = 4.682528E+08    LPSCBE1 = -44.49948       
+WPSCBE1 = -209.8855       PPSCBE1 = 0.0001413691    PSCBE2  = 3.714287E-06    
+LPSCBE2 = 9.093489E-13    WPSCBE2 = -8.065528E-13   PPSCBE2 = -2.129907E-18   
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06      
+BETA0   = 20.7            KT1     = -0.2160808      LKT1    = -9.339147E-08   
+WKT1    = 3.355112E-08    PKT1    = 7.251917E-14    KT2     = -0.01143072     
+LKT2    = -9.590603E-09   WKT2    = 2.278139E-08    PKT2    = -9.657396E-15   
+AT      = -66481.34       LAT     = 0.05262202      WAT     = 0.09716874      
+PAT     = -8.922884E-08   UTE     = -2.188333       LUTE    = -2.707498E-07   
+WUTE    = 5.839889E-08    PUTE    = 8.056612E-13    UA1     = 4.797778E-10    
+LUA1    = -1.833867E-15   WUA1    = -9.438131E-16   PUA1    = 2.373469E-21    
+UB1     = -3.79573E-18    LUB1    = 3.282878E-24    WUB1    = 4.301764E-24    
+PUB1    = -4.227295E-30   UC1     = -3.774725E-11   LUC1    = 3.07007E-17     
+WUC1    = 3.189914E-17    PUC1    = -6.677463E-23   KT1L    = 0               
+PRT     = 46.58106        LPRT    = -3.686147E-05   WPRT    = -0.001359025    
+PPRT    = 1.007405E-09 
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )    
*
*
.MODEL nch.3             NMOS   (                    LMIN    = 3.5E-07         
+LMAX    = '8.07E-07-dxl'  WMIN    = '1.183E-06-dxw' WMAX    = '1.9983E-5-dxw' 
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.582913' LVTH0   = -2.479376E-09   WVTH0   = -6.03258E-08    
+PVTH0   = 1.639944E-14    K1      = 0.4858325       LK1     = 2.327254E-08    
+WK1     = 6.104411E-08    PK1     = -3.97542E-14    K2      = 0.04534535      
+LK2     = -1.970772E-08   WK2     = -1.945053E-09   PK2     = 5.415533E-15    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 95126.3         LVSAT   = 0.0003263514    
+WVSAT   = 0.0276876       PVSAT   = -6.543329E-09   UA      = 0               
+UB      = 2.104607E-18    LUB     = -1.31162E-25    WUB     = -5.904336E-25   
+PUB     = -9.399655E-32   UC      = 6.617273E-11    LUC     = -4.801916E-18   
+WUC     = -4.640422E-17   PUC     = 5.540488E-24    RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.04861747      LU0     = -6.251291E-10   WU0     = -1.520027E-08   
+PU0     = -2.184713E-16   A0      = 0.7344329       LA0     = 1.289558E-08    
+WA0     = -2.513495E-07   PA0     = 2.537071E-13    KETA    = 0.01065971      
+LKETA   = -3.526753E-09   WKETA   = -3.419267E-08   PKETA   = 2.725872E-14    
+A1      = 0               A2      = 0.99            AGS     = 0.2223535       
+LAGS    = -1.673124E-07   WAGS    = -3.122171E-07   PAGS    = 2.161134E-13    
+B0      = 0               B1      = 0               VOFF    = -0.0716667      
+LVOFF   = -2.66569E-10    WVOFF   = -6.081282E-08   PVOFF   = 1.949458E-14    
+NFACTOR = 1.373063        LNFACTOR= -1.051655E-07   WNFACTOR= -4.708978E-07   
+PNFACTOR= -8.646475E-15   CIT     = -9.014477E-05   LCIT    = 5.583969E-11    
+WCIT    = 2.859396E-10    PCIT    = 5.046674E-17    CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = -0.0003508224   
+LETA0   = 9.584137E-10    WETA0   = -1.229799E-09   PETA0   = 6.146112E-16    
+ETAB    = 0.001435363     LETAB   = -1.084047E-09   WETAB   = -1.334921E-09   
+PETAB   = 9.599482E-16    DSUB    = 0               PCLM    = 0.7913016       
+LPCLM   = 1.748337E-08    WPCLM   = -2.414444E-08   PPCLM   = 4.621286E-15    
+PDIBLC1 = 1E-05           PDIBLC2 = 0.0001653532    LPDIBLC2= 3.22198E-09     
+WPDIBLC2= -3.987821E-11   PPDIBLC2= -3.287649E-16   PDIBLCB = 0.3624882       
+LPDIBLCB= -6.83252E-08    WPDIBLCB= -1.827158E-07   PPDIBLCB= 1.171009E-14    
+DROUT   = 0               PSCBE1  = 3.496792E+08    LPSCBE1 = 45.26074        
+WPSCBE1 = -43.00555       PPSCBE1 = 1.504091E-05    PSCBE2  = 4.060865E-06    
+LPSCBE2 = 6.469898E-13    WPSCBE2 = -5.382114E-12   PPSCBE2 = 1.333792E-18    
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06  
+BETA0   = 20.7            KT1     = -0.4001584      LKT1    = 4.595524E-08    
+WKT1    = 2.659199E-07    PKT1    = -1.03384E-13    KT2     = -0.03018077     
+LKT2    = 4.603183E-09    WKT2    = 1.978027E-08    PKT2    = -7.385543E-15   
+AT      = -1454.14        LAT     = 0.003396435     WAT     = -0.01336298     
+PAT     = -5.556333E-09   UTE     = -2.743312       LUTE    = 1.493698E-07    
+WUTE    = 1.759122E-06    PUTE    = -4.817859E-13   UA1     = -2.551773E-09   
+LUA1    = 4.610171E-16    WUA1    = 5.268021E-15    PUA1    = -2.32889E-21    
+UB1     = 1.096567E-18    LUB1    = -4.205904E-25   WUB1    = -6.127881E-24   
+PUB1    = 3.667946E-30    UC1     = 1.205581E-11    LUC1    = -7.000217E-18   
+WUC1    = -1.569118E-16   PUC1    = 7.615527E-23    KT1L    = 0               
+PRT     = 0.2675717       LPRT    = -1.802119E-06   WPRT    = 8.331496E-06    
+PPRT    = -2.768447E-11  
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          ) 
*
*
.MODEL nch.4             NMOS   (                    LMIN    = '1.207E-06-dxl' 
+LMAX    = 2.01E-05        WMIN    = '7.83E-07-dxw'  WMAX    = '1.183E-06-dxw' 
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.528243' LVTH0   = 1.080427E-08    WVTH0   = -1.156297E-08   
+PVTH0   = 8.55473E-15     K1      = 0.4545522       LK1     = 3.322464E-08    
+WK1     = 3.753591E-08    PK1     = -4.005616E-14   K2      = 0.02647978      
+LK2     = 7.992918E-09    WK2     = 6.561244E-09    PK2     = -1.48315E-14    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 96507.23        UA      = -7.217974E-10   
+LUA     = 8.351195E-16    WUA     = 3.036106E-16    PUA     = -3.512775E-22   
+UB      = 2.902607E-18    LUB     = -1.401372E-24   WUB     = -1.018808E-24   
+PUB     = 7.304723E-31    UC      = 7.178552E-11    LUC     = -2.088186E-17   
+WUC     = -4.563875E-17   PUC     = 1.122583E-23    RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.03723282      LU0     = -2.798723E-09   WU0     = -4.527918E-09   
+PU0     = 6.28339E-15     A0      = 1.848904        LA0     = -5.194055E-07   
+WA0     = -1.026417E-06   PA0     = 8.245877E-13    KETA    = 0.01166675      
+LKETA   = -2.805299E-09   WKETA   = -5.86025E-10    PKETA   = 2.598561E-15    
+A1      = 0               A2      = 0.99            AGS     = 0.7010739       
+LAGS    = -4.640424E-07   WAGS    = -5.956526E-07   PAGS    = 6.8917E-13      
+B0      = 0               B1      = 0               VOFF    = -0.1212307      
+LVOFF   = 2.456386E-08    NFACTOR = 0.8705778       LNFACTOR= -1.828959E-08   
+WNFACTOR= -6.481431E-08   PNFACTOR= 4.740038E-14    CIT     = 0.0002549786    
+LCIT    = -4.391399E-11   WCIT    = 5.092893E-11    PCIT    = -7.546486E-18   
+CDSC    = 0               CDSCB   = 0               CDSCD   = 0               
+ETA0    = -8.412339E-05   LETA0   = 1.002234E-09    WETA0   = 1.585833E-10    
+PETA0   = -3.047557E-16   ETAB    = -3.010733E-05   LETAB   = 1.752946E-10    
+WETAB   = 3.772446E-11    PETAB   = -2.19644E-16    DSUB    = 0               
+PCLM    = 0.1692336       LPCLM   = 6.140966E-07    PDIBLC1 = 1E-05           
+PDIBLC2 = -0.000347682    LPDIBLC2= 1.437708E-09    WPDIBLC2= 2.938791E-10    
+PPDIBLC2= 1.418466E-15    PDIBLCB = 0.1387533       DROUT   = 0               
+PSCBE1  = 3.519534E+08    LPSCBE1 = -125.1231       WPSCBE1 = 76.38679        
+PPSCBE1 = 7.977505E-05    PSCBE2  = -8.737216E-05   LPSCBE2 = 9.863835E-11    
+WPSCBE2 = 1.596661E-10    PPSCBE2 = -1.782013E-16   PVAG    = 0               
+DELTA   = 0.01            ALPHA0  = 2.5E-06         BETA0   = 20.7            
+KT1     = -0.1499315      LKT1    = -2.115566E-09   WKT1    = -1.223785E-07   
+PKT1    = 4.266289E-14    KT2     = -0.02087417     LKT2    = 5.041189E-08    
+WKT2    = 2.442399E-09    PKT2    = -4.761794E-14   AT      = -21673.44       
+LAT     = 0.006954652     WAT     = 0.02754232      PAT     = -1.640881E-08   
+UTE     = -2.565965       LUTE    = 5.17659E-07     WUTE    = 1.094306E-06    
+PUTE    = -8.332978E-13   UA1     = -1.6811E-09     LUA1    = 1.19284E-15     
+WUA1    = 3.254065E-15    PUA1    = -3.143271E-21   UB1     = -1.065109E-18   
+LUB1    = -2.464934E-25   WUB1    = -1.331515E-24   PUB1    = 2.754072E-30    
+UC1     = -8.220291E-11   LUC1    = -3.608129E-17   WUC1    = 7.412109E-18    
+PUC1    = 1.09683E-22     KT1L    = 0               PRT     = -1223.895       
+LPRT    = 0.0009821714    WPRT    = 0.001063665     PPRT    = -1.230661E-09
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )   
*
*
.MODEL nch.5             NMOS   (                    LMIN    = '8.07E-07-dxl'  
+LMAX    = '1.207E-06-dxl' WMIN    = '7.83E-07-dxw'  WMAX    = '1.183E-06-dxw' 
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.467619' LVTH0   = 8.094657E-08    WVTH0   = 4.90438E-08     
+PVTH0   = -6.156729E-14   K1      = 0.358099        LK1     = 1.44821E-07     
+WK1     = 7.01475E-08     PK1     = -7.778778E-14   K2      = 0.07054502      
+LK2     = -4.299056E-08   WK2     = -4.113562E-08   PK2     = 4.035377E-14    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 78576.45        LVSAT   = 0.02074592      
+WVSAT   = -0.01132088     PVSAT   = 1.309826E-08    UA      = 0               
+UB      = 5.741077E-19    LUB     = 1.292701E-24    WUB     = 1.062641E-24    
+PUB     = -1.677764E-30   UC      = 3.660264E-11    LUC     = 1.982473E-17    
+WUC     = -2.295341E-17   PUC     = -1.502111E-23   RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.03874022      LU0     = -4.542793E-09   WU0     = -3.769856E-09   
+PU0     = 5.406313E-15    A0      = 2.791505        LA0     = -1.609995E-06   
+WA0     = -1.271796E-06   PA0     = 1.108491E-12    KETA    = 0.0321512       
+LKETA   = -2.65058E-08    WKETA   = -1.965488E-08   PKETA   = 2.466123E-14    
+A1      = 0               A2      = 0.99            AGS     = 0.9056002       
+LAGS    = -7.006794E-07   B0      = 0               B1      = 0               
+VOFF    = -0.1            NFACTOR = 0.7543952       LNFACTOR= 1.161336E-07    
+WNFACTOR= 6.998602E-08    PNFACTOR= -1.085636E-13   CIT     = 0.000285048     
+LCIT    = -7.870424E-11   WCIT    = -7.062511E-11   PCIT    = 1.330915E-16    
+CDSC    = 0               CDSCB   = 0               CDSCD   = 0               
+ETA0    = 0.003352228     LETA0   = -2.973624E-09   WETA0   = -3.048375E-09   
+PETA0   = 3.405695E-15    ETAB    = 0.0006475641    LETAB   = -6.087711E-10   
+WETAB   = -6.928325E-10   PETAB   = 6.256102E-16    DSUB    = 0               
+PCLM    = 1.032518        LPCLM   = -3.847236E-07   WPCLM   = -6.537757E-07   
+PPCLM   = 7.564184E-13    PDIBLC1 = 1E-05           PDIBLC2 = -0.00416775     
+LPDIBLC2= 5.857526E-09    WPDIBLC2= 3.274343E-09    PPDIBLC2= -2.029931E-15   
+PDIBLCB = 0.1387533       DROUT   = 0               PSCBE1  = 1.089719E+08    
+LPSCBE1 = 156.0066        WPSCBE1 = 240.2935        PPSCBE1 = -0.000109865    
+PSCBE2  = -5.255092E-06   LPSCBE2 = 3.628897E-12    WPSCBE2 = 1.043208E-11    
+PPSCBE2 = -5.537501E-18   PVAG    = 0               DELTA   = 0.01            
+ALPHA0  = 2.5E-06         BETA0   = 20.7            KT1     = -0.09596287     
+LKT1    = -6.455721E-08   WKT1    = -1.169567E-07   PKT1    = 3.638983E-14    
+KT2     = 0.07813779      LKT2    = -6.414494E-08   WKT2    = -8.944794E-08   
+PKT2    = 5.869918E-14    AT      = -110972.9       LAT     = 0.1102741       
+WAT     = 0.1529166       PAT     = -1.614668E-07   UTE     = -3.559982       
+LUTE    = 1.667736E-06    WUTE    = 1.777075E-06    PUTE    = -1.623261E-12   
+UA1     = -5.651362E-10   LUA1    = -9.832879E-17   WUA1    = 3.654639E-16    
+PUA1    = 1.9884E-22      UB1     = -6.47051E-19    LUB1    = -7.301864E-25   
+WUB1    = 3.564699E-25    PUB1    = 8.010748E-31    UC1     = -8.009362E-12   
+LUC1    = -1.219232E-16   WUC1    = -5.362414E-18   PUC1    = 1.244631E-22    
+KT1L    = 0               PRT     = -2390.559       LPRT    = 0.002332001     
+WPRT    = 0.00169471      PPRT    = -1.960779E-09   
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )
*
*
.MODEL nch.6             NMOS   (                    LMIN    = 3.5E-07         
+LMAX    = '8.07E-07-dxl'  WMIN    = '7.83E-07-dxw'  WMAX    = '1.183E-06-dxw' 
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.574607' LVTH0   = -4.339362E-11   WVTH0   = -4.991848E-08   
+PVTH0   = 1.334716E-14    K1      = 0.5850455       LK1     = -2.697753E-08   
+WK1     = -6.326979E-08   PK1     = 2.320913E-14    K2      = 0.03486114      
+LK2     = -1.597786E-08   WK2     = 1.119166E-08    PK2     = 7.420165E-16    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 119212.2        LVSAT   = -0.01001536     
+WVSAT   = -0.002492058    PVSAT   = 6.414841E-09    UA      = -1.425246E-09   
+LUA     = 1.078912E-15    WUA     = 1.785833E-15    PUA     = -1.351876E-21   
+UB      = 4.112102E-18    LUB     = -1.385562E-24   WUB     = -3.105826E-24   
+PUB     = 1.477766E-30    UC      = 4.050535E-11    LUC     = 1.687038E-17    
+WUC     = -1.424299E-17   PUC     = -2.161491E-23   RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.02507698      LU0     = 5.800281E-09    WU0     = 1.429596E-08    
+PU0     = -8.26951E-15    A0      = 0.3001916       LA0     = 2.759296E-07    
+WA0     = 2.92755E-07     PA0     = -7.587451E-14   KETA    = -0.05698659     
+LKETA   = 4.097151E-08    WKETA   = 5.056813E-08    PKETA   = -2.84976E-14    
+A1      = 0               A2      = 0.99            AGS     = -0.0458255      
+LAGS    = 1.954991E-08    WAGS    = 2.381111E-08    PAGS    = -1.802502E-14   
+B0      = 0               B1      = 0               VOFF    = -0.141804       
+LVOFF   = 3.164562E-08    WVOFF   = 2.706921E-08    PVOFF   = -2.049139E-14   
+NFACTOR = 1.157475        LNFACTOR= -1.889977E-07   WNFACTOR= -2.007654E-07   
+PNFACTOR= 9.63953E-14     CIT     = 0.0001456854    LCIT    = 2.679317E-11    
+WCIT    = -9.555716E-12   PCIT    = 8.686202E-17    CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = -0.006824942    
+LETA0   = 4.730496E-09    WETA0   = 6.882274E-09    PETA0   = -4.111808E-15   
+ETAB    = 0.0002038415    LETAB   = -2.728731E-10   WETAB   = 2.081748E-10    
+PETAB   = -5.645233E-17   DSUB    = 0               PCLM    = 0.8004329       
+LPCLM   = -2.090351E-07   WPCLM   = -3.558609E-08   PPCLM   = 2.884489E-13    
+PDIBLC1 = 1E-05           PDIBLC2 = 0.005613619     LPDIBLC2= -1.546974E-09   
+WPDIBLC2= -6.866557E-09   PPDIBLC2= 5.646734E-15    PDIBLCB = 0.1320065       
+LPDIBLCB= 5.107366E-09    WPDIBLCB= 1.060778E-07    PPDIBLCB= -8.030091E-14   
+DROUT   = 0               PSCBE1  = 6.561562E+07    LPSCBE1 = 188.8273        
+WPSCBE1 = 312.9262        PPSCBE1 = -0.000164848    PSCBE2  = -1.060816E-05   
+LPSCBE2 = 7.681177E-12    WPSCBE2 = 1.299818E-11    PPSCBE2 = -7.480043E-18   
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06   
+BETA0   = 20.7            KT1     = -0.2037678      LKT1    = 1.705115E-08    
+WKT1    = 1.984253E-08    PKT1    = -6.716717E-14   KT2     = -0.01380252     
+LKT2    = 5.453875E-09    WKT2    = -7.416772E-10   PKT2    = -8.45146E-15    
+AT      = 92820.91        LAT     = -0.04399785     WAT     = -0.1314896      
+PAT     = 5.382871E-08    UTE     = 0.1429917       LUTE    = -1.135416E-06   
+WUTE    = -1.857417E-06   PUTE    = 1.12805E-12     UA1     = 7.997219E-09    
+LUA1    = -6.580034E-15   WUA1    = -7.949868E-15   PUA1    = 6.493548E-21    
+UB1     = -1.595098E-17   LUB1    = 1.08549E-23     WUB1    = 1.52327E-23     
+PUB1    = -1.046024E-29   UC1     = -4.433896E-10   LUC1    = 2.076597E-16    
+WUC1    = 4.137613E-16    PUC1    = -1.928136E-22   KT1L    = 0               
+PRT     = 1397.411        LPRT    = -0.0005354923   WPRT    = -0.001742289    
+PPRT    = 6.410293E-10
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )    
*
*
.MODEL nch.7             NMOS   (                    LMIN    = '1.207E-06-dxl' 
+LMAX    = 2.01E-05        WMIN    = 4E-07           WMAX    = '7.83E-07-dxw'  
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.544538' LVTH0   = 1.720274E-08    WVTH0   = -2.546298E-08   
+PVTH0   = 3.096841E-15    K1      = 0.5502741       LK1     = -3.125255E-08   
+WK1     = -4.411482E-08   PK1     = 1.494289E-14    K2      = 0.01727784      
+LK2     = -1.487584E-08   WK2     = 1.441049E-08    PK2     = 4.675549E-15    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 96507.23        UA      = -7.802065E-10   
+LUA     = 9.026988E-16    WUA     = 3.534335E-16    PUA     = -4.089226E-22   
+UB      = 1.893473E-18    LUB     = -5.306664E-25   WUB     = -1.580168E-25   
+PUB     = -1.223976E-32   UC      = 2.085218E-11    LUC     = 1.298873E-17    
+WUC     = -2.192611E-18   PUC     = -1.766579E-23   RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.03104484      LU0     = 4.876105E-09    WU0     = 7.504263E-10    
+PU0     = -2.632391E-16   A0      = 0.5611327       LA0     = 5.492548E-07    
+WA0     = 7.205156E-08    PA0     = -8.697965E-14   KETA    = 0.01632805      
+LKETA   = 1.817118E-09    WKETA   = -4.562111E-09   PKETA   = -1.344362E-15   
+A1      = 0               A2      = 0.99            AGS     = 0.001377129     
+LAGS    = 3.717127E-07    WAGS    = 1.188842E-09    PAGS    = -2.372926E-14   
+B0      = 0               B1      = 0               VOFF    = -0.1332525      
+LVOFF   = 3.847315E-08    WVOFF   = 1.025464E-08    PVOFF   = -1.186462E-14   
+NFACTOR = 1.473942        LNFACTOR= -7.516272E-07   WNFACTOR= -5.794843E-07   
+PNFACTOR= 6.729374E-13    CIT     = -0.0006621464   LCIT    = 1.027861E-09    
+WCIT    = 8.332366E-10    PCIT    = -9.217706E-16   CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = 7.131314E-05    
+LETA0   = 5.99268E-10     WETA0   = 2.599593E-11    PETA0   = 3.897462E-17    
+ETAB    = 2.000076E-05    LETAB   = -4.256616E-10   WETAB   = -5.017732E-12   
+PETAB   = 2.929716E-16    DSUB    = 0               PCLM    = 0.1762022       
+LPCLM   = 4.750038E-07    WPCLM   = -5.944212E-09   PPCLM   = 1.186463E-13    
+PDIBLC1 = 1E-05           PDIBLC2 = 0.0002290868    LPDIBLC2= 8.598363E-10    
+WPDIBLC2= -1.981044E-10   PPDIBLC2= 1.91139E-15     PDIBLCB = 0.1304779       
+LPDIBLCB= 1.651774E-07    WPDIBLCB= 7.058936E-09    PPDIBLCB= -1.408963E-13   
+DROUT   = 0               PSCBE1  = 4.235152E+08    LPSCBE1 = -58.8318        
+WPSCBE1 = 15.34459        PPSCBE1 = 2.322858E-05    PSCBE2  = 7.703648E-05    
+LPSCBE2 = -8.780832E-11   WPSCBE2 = 1.942555E-11    PPSCBE2 = -1.916228E-17   
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06 
+BETA0   = 20.7            KT1     = -0.3097948      LKT1    = 8.128185E-08    
+WKT1    = 1.398491E-08    PKT1    = -2.847512E-14   KT2     = -0.005076239    
+LKT2    = -4.617562E-08   WKT2    = -1.103323E-08   PKT2    = 3.477121E-14    
+AT      = 82328.36        LAT     = -0.08739209     WAT     = -0.06117122     
+PAT     = 6.406897E-08    UTE     = -1.349974       LUTE    = -6.17695E-07    
+WUTE    = 5.706533E-08    PUTE    = 1.351592E-13    UA1     = 3.045211E-09    
+LUA1    = -4.130031E-15   WUA1    = -7.774787E-16   PUA1    = 1.397139E-21    
+UB1     = -3.662418E-18   LUB1    = 4.251251E-24    WUB1    = 8.839907E-25    
+PUB1    = -1.082504E-30   UC1     = -1.046373E-10   LUC1    = 1.031438E-16    
+WUC1    = 2.654866E-17    PUC1    = -9.075983E-24   KT1L    = 0               
+PRT     = 473.8944        LPRT    = -0.0009821708   WPRT    = -0.0003845492   
+PPRT    = 4.449234E-10    
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )
*
*
.MODEL nch.8             NMOS   (                    LMIN    = '8.07E-07-dxl'  
+LMAX    = '1.207E-06-dxl' WMIN    = 4E-07           WMAX    = '7.83E-07-dxw'  
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.611238' LVTH0   = -5.996844E-08   WVTH0   = -7.346332E-08   
+PVTH0   = 5.863323E-14    K1      = 0.4463096       LK1     = 8.903435E-08    
+WK1     = -5.096067E-09   PK1     = -3.02018E-14    K2      = -0.009934468    
+LK2     = 1.660881E-08    WK2     = 2.751338E-08    PK2     = -1.048449E-14   
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 51524.56        LVSAT   = 0.05204498      
+WVSAT   = 0.01175437      PVSAT   = -1.359984E-08   UA      = 0               
+UB      = 1.684949E-18    LUB     = -2.894038E-25   WUB     = 1.150939E-25    
+PUB     = -3.282287E-31   UC      = -5.621833E-11   LUC     = 1.021593E-16    
+WUC     = 5.62229E-17     PUC     = -8.525252E-23   RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.03584241      LU0     = -6.746811E-10   WU0     = -1.298021E-09   
+PU0     = 2.106814E-15    A0      = 1.069539        LA0     = -3.897101E-08   
+WA0     = 1.970411E-07    PA0     = -2.315925E-13   KETA    = 0.01530131      
+LKETA   = 3.005051E-09    WKETA   = -5.28193E-09    PKETA   = -5.115318E-16   
+A1      = 0               A2      = 0.99            AGS     = 0.5853289       
+LAGS    = -3.039196E-07   WAGS    = 2.731914E-07    PAGS    = -3.384361E-13   
+B0      = 0               B1      = 0               VOFF    = -0.1            
+NFACTOR = 0.6173926       LNFACTOR= 2.394008E-07    WNFACTOR= 1.868493E-07    
+PNFACTOR= -2.137105E-13   CIT     = 0.0003063107    LCIT    = -9.264402E-11   
+WCIT    = -8.876222E-11   PCIT    = 1.449822E-16    CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = -0.0001093099   
+LETA0   = 8.082487E-10    WETA0   = -9.568357E-11   PETA0   = 1.797578E-16    
+ETAB    = -0.001177763    LETAB   = 9.601505E-10    WETAB   = 8.641713E-10    
+PETAB   = -7.1268E-16     DSUB    = 0               PCLM    = 0.0900574       
+LPCLM   = 5.746733E-07    WPCLM   = 1.501435E-07    PPCLM   = -6.194717E-14   
+PDIBLC1 = 1E-05           PDIBLC2 = -0.009213444    LPDIBLC2= 1.178484E-08    
+WPDIBLC2= 7.578321E-09    PPDIBLC2= -7.085934E-15   PDIBLCB = 0.2732414       
+WPDIBLCB= -1.147183E-07   DROUT   = 0               PSCBE1  = 2.142517E+08    
+LPSCBE1 = 183.286         WPSCBE1 = 150.4898        PPSCBE1 = -0.0001331344   
+PSCBE2  = -3.838787E-06   LPSCBE2 = 5.764359E-12    WPSCBE2 = 9.223971E-12    
+PPSCBE2 = -7.359051E-18   PVAG    = 0               DELTA   = 0.01            
+ALPHA0  = 2.5E-06         BETA0   = 20.7            KT1     = -0.1747238      
+LKT1    = -7.499526E-08   WKT1    = -4.977362E-08   PKT1    = 4.52935E-14     
+KT2     = -0.09084979     LKT2    = 5.306439E-08    WKT2    = 5.469848E-08    
+PKT2    = -4.128039E-14   AT      = 156661.5        LAT     = -0.1733955      
+WAT     = -0.07537551     PAT     = 8.050333E-08    UTE     = -1.664549       
+LUTE    = -2.537307E-07   WUTE    = 1.602711E-07    PUTE    = 1.575007E-14    
+UA1     = -1.327711E-09   LUA1    = 9.29439E-16     WUA1    = 1.01594E-15     
+PUA1    = -6.778459E-22   UB1     = -4.245534E-19   LUB1    = 5.05042E-25     
+WUB1    = 1.666793E-25    PUB1    = -2.525749E-31   UC1     = -1.090144E-10   
+LUC1    = 1.082081E-16    WUC1    = 8.079491E-17    PUC1    = -7.183889E-23   
+KT1L    = 0               PRT     = 404.2872        LPRT    = -0.0009016352   
+WPRT    = -0.0006892931   PPRT    = 7.97512E-10     
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )
*
*
.MODEL nch.9             NMOS   (                    LMIN    = 3.5E-07         
+LMAX    = '8.07E-07-dxl'  WMIN    = 4E-07           WMAX    = '7.83E-07-dxw'  
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.525422' LVTH0   = 4.993819E-09    WVTH0   = -9.507126E-09   
+PVTH0   = 1.021839E-14    K1      = 0.5813381       LK1     = -1.318226E-08   
+WK1     = -5.816663E-08   PK1     = 9.972617E-15    K2      = 0.02935361      
+LK2     = -1.313227E-08   WK2     = 1.606665E-08    PK2     = -1.819316E-15   
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 124715.3        LVSAT   = -0.003360439    
+WVSAT   = -0.005906745    PVSAT   = -2.303697E-10   UA      = 1.237881E-09    
+LUA     = -9.370761E-16   WUA     = -6.6957E-16     PUA     = 5.068646E-22    
+UB      = 2.303303E-20    LUB     = 9.686662E-25    WUB     = 5.506454E-25    
+PUB     = -6.579411E-31   UC      = 9.352798E-11    LUC     = -1.119865E-17   
+WUC     = -6.127926E-17   PUC     = 3.696612E-24    RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.04878879      LU0     = -1.047509E-08   WU0     = -7.309575E-09   
+PU0     = 6.65756E-15     A0      = 0.2731722       LA0     = 5.638784E-07    
+WA0     = 3.586827E-07    PA0     = -3.539552E-13   KETA    = 0.01651734      
+LKETA   = 2.084521E-09    WKETA   = -1.463331E-08   PKETA   = 6.567465E-15    
+A1      = 0               A2      = 0.99            AGS     = -0.09344225     
+LAGS    = 2.099102E-07    WAGS    = 9.137526E-08    PAGS    = -2.008013E-13   
+B0      = 0               B1      = 0               VOFF    = -0.1301078      
+LVOFF   = 2.279158E-08    WVOFF   = 1.628529E-08    PVOFF   = -1.232797E-14   
+NFACTOR = 1.136485        LNFACTOR= -1.535521E-07   WNFACTOR= -1.784141E-07   
+PNFACTOR= 6.279391E-14    CIT     = -9.737274E-05   LCIT    = 2.129444E-10    
+WCIT    = 2.148746E-10    PCIT    = -8.487093E-17   CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = 0.0001017259    
+LETA0   = 6.484946E-10    WETA0   = 6.739802E-10    PETA0   = -4.028777E-16   
+ETAB    = 0.0005133018    LETAB   = -3.199854E-10   WETAB   = -4.845151E-11   
+PETAB   = -2.18245E-17    DSUB    = 0               PCLM    = 1.355904        
+LPCLM   = -3.835729E-07   WPCLM   = -5.100177E-07   PPCLM   = 4.377949E-13    
+PDIBLC1 = 1E-05           PDIBLC2 = 0.002662655     LPDIBLC2= 2.794636E-09    
+WPDIBLC2= -3.822584E-09   PPDIBLC2= 1.544552E-15    PDIBLCB = 0.5120286       
+LPDIBLCB= -1.807619E-07   WPDIBLCB= -2.286922E-07   PPDIBLCB= 8.627818E-14    
+DROUT   = 0               PSCBE1  = 4.613509E+08    LPSCBE1 = -3.768093       
+WPSCBE1 = -35.53878       PPSCBE1 = 7.689244E-06    PSCBE2  = 4.618633E-06    
+LPSCBE2 = -6.379074E-13   WPSCBE2 = -5.490942E-13   PPSCBE2 = 3.915955E-20    
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06 
+BETA0   = 20.7            KT1     = -0.1251057      LKT1    = -1.125561E-07   
+WKT1    = -6.342647E-08   PKT1    = 5.562872E-14    KT2     = -0.01401484     
+LKT2    = -5.099672E-09   WKT2    = -2.188774E-09   PKT2    = 1.783267E-15    
+AT      = -99596.23       LAT     = 0.02059158      WAT     = 0.0334882       
+PAT     = -1.906498E-09   UTE     = -2.786766       LUTE    = 5.957877E-07    
+WUTE    = 7.692041E-07    PUTE    = -4.452122E-13   UA1     = -2.983657E-09   
+LUA1    = 2.182991E-15    WUA1    = 2.243578E-15    PUA1    = -1.607168E-21   
+UB1     = 3.855079E-18    LUB1    = -2.73464E-24    WUB1    = -2.81326E-24    
+PUB1    = 2.003239E-30    UC1     = 1.684049E-10    LUC1    = -1.017984E-16   
+WUC1    = -1.267505E-16   PUC1    = 8.527297E-23    KT1L    = 0               
+PRT     = -1377.407       LPRT    = 0.0004471074    WPRT    = 0.0006446759    
+PPRT    = -2.123025E-10   
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )
*
*
.MODEL nch.10            NMOS   (                    LMIN    = '1.207E-06-dxl' 
+LMAX    = 2.01E-05        WMIN    = '1.9983E-5-dxw' WMAX    = 0.0002001       
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.523596' LVTH0   = 4.430968E-08    WVTH0   = 2.279147E-07    
+PVTH0   = -1.658529E-13   K1      = 0.5035352       LK1     = -1.691519E-08   
+WK1     = 3.732626E-07    PK1     = 3.252572E-14    K2      = 0.02639952      
+LK2     = 3.398003E-09    WK2     = 1.980659E-08    PK2     = -1.967438E-13   
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 96575.78        LVSAT   = -0.001368327    
+WVSAT   = -0.01371178     PVSAT   = 2.736871E-07    UA      = -7.243246E-10   
+LUA     = 8.380434E-16    WUA     = 1.452271E-14    PUA     = -1.680277E-20   
+UB      = 2.507682E-18    LUB     = -9.292725E-25   WUB     = -9.214355E-24   
+PUB     = 2.931189E-29    UC      = 4.653199E-11    LUC     = -2.983065E-18   
+WUC     = 3.755784E-16    PUC     = 4.023481E-22    RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.03921134      LU0     = 6.986588E-09    WU0     = 1.319081E-07    
+PU0     = -3.363066E-14   A0      = 0.5149775       LA0     = 5.62179E-07     
+WA0     = 3.965712E-07    PA0     = -6.604507E-13   KETA    = 0.002816328     
+LKETA   = 1.495658E-09    WKETA   = -1.99353E-07    PKETA   = 4.208207E-13    
+A1      = 0               A2      = 0.99            AGS     = -0.0002663955   
+LAGS    = 1.790876E-07    WAGS    = 2.118263E-06    PAGS    = -1.182575E-12   
+B0      = 0               B1      = 0               VOFF    = -0.118934       
+LVOFF   = 2.319556E-08    WVOFF   = -4.593862E-07   PVOFF   = 2.736873E-13    
+NFACTOR = 1.089919        LNFACTOR= 9.594396E-08    WNFACTOR= -6.849148E-07   
+PNFACTOR= -7.894476E-12   CIT     = -0.0001081982   LCIT    = -1.689249E-10   
+WCIT    = 1.105833E-09    PCIT    = 8.443418E-15    CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = 7.25065E-05     
+LETA0   = 9.311983E-10    WETA0   = 2.699823E-09    PETA0   = -8.521816E-15   
+ETAB    = 1.007015E-05    LETAB   = -1.165116E-11   WETAB   = 1.090467E-10    
+PETAB   = -1.26167E-16    DSUB    = 0               PCLM    = 0.1835384       
+LPCLM   = 3.285741E-07    WPCLM   = -3.996779E-07   PPCLM   = 7.977571E-12    
+PDIBLC1 = 1E-05           PDIBLC2 = 0.0001413927    LPDIBLC2= 2.353788E-09    
+WPDIBLC2= -5.212645E-09   PPDIBLC2= 1.331389E-14    PDIBLCB = 0.1387533       
+WPDIBLCB= -7.049708E-12   PPDIBLCB= 8.156512E-18    DROUT   = 0               
+PSCBE1  = 4.16586E+08     LPSCBE1 = 95.76174        WPSCBE1 = 1018.363        
+PPSCBE1 = -0.002893393    PSCBE2  = 4.54933E-05     LPSCBE2 = -3.308092E-11   
+WPSCBE2 = 1.977595E-09    PPSCBE2 = -2.578818E-15   PVAG    = 0               
+DELTA   = 0.01            ALPHA0  = 2.5E-06         BETA0   = 20.7            
+KT1     = -0.2964827      LKT1    = -3.814854E-09   WKT1    = 5.58119E-07     
+PKT1    = -4.652679E-13   KT2     = -0.02842824     LKT2    = 8.383796E-09    
+WKT2    = -2.3451E-07     PKT2    = 3.219478E-13    AT      = 58413.87        
+LAT     = -0.05857738     WAT     = -1.129092       PAT     = 6.618029E-07    
+UTE     = -1.535532       LUTE    = -2.949172E-07   WUTE    = -1.015238E-05   
+PUTE    = -2.039471E-12   UA1     = 2.097278E-09    LUA1    = -2.304323E-15   
+WUA1    = -3.822868E-14   PUA1    = 1.742218E-20    UB1     = -3.46834E-18    
+LUB1    = 3.99078E-24     WUB1    = 2.604641E-23    PUB1    = -5.117401E-29   
+UC1     = -6.400205E-11   LUC1    = 1.303836E-17    WUC1    = 1.13159E-16     
+PUC1    = 8.023928E-22    KT1L    = 0               PRT     = -0.7466621      
+LPRT    = -6.926093E-06   WPRT    = -1.615575E-06   PPRT    = -6.542008E-11 
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )  
*
*
.MODEL nch.11            NMOS   (                    LMIN    = '8.07E-07-dxl'  
+LMAX    = '1.207E-06-dxl' WMIN    = '1.9983E-5-dxw' WMAX    = 0.0002001       
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.552335' LVTH0   = 1.105919E-08    WVTH0   = -1.638662E-07   
+PVTH0   = 2.874375E-13    K1      = 0.5140873       LK1     = -2.9124E-08     
+WK1     = -4.094213E-07   PK1     = 9.38091E-13     K2      = 0.03640923      
+LK2     = -8.183232E-09   WK2     = -2.058394E-07   PK2     = 6.432856E-14    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 93284.7         LVSAT   = 0.002439456     
+WVSAT   = 0.6445567       PVSAT   = -4.879294E-07   UA      = 0               
+UB      = 2.107241E-18    LUB     = -4.659615E-25   WUB     = 3.129772E-23    
+PUB     = -1.756058E-29   UC      = 1.015095E-10    LUC     = -6.65921E-17    
+WUC     = 4.098089E-16    PUC     = 3.627434E-22    RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.04695012      LU0     = -1.967186E-09   WU0     = 1.962427E-07    
+PU0     = -1.080658E-13   A0      = 1.123475        LA0     = -1.418531E-07   
+WA0     = 6.342665E-06    PA0     = -7.540081E-12   KETA    = 0.0194797       
+LKETA   = -1.778386E-08   WKETA   = 9.20202E-08     PKETA   = 8.370197E-14    
+A1      = 0               A2      = 0.99            AGS     = 0.2366145       
+LAGS    = -9.498365E-08   WAGS    = 7.387834E-06    PAGS    = -7.279468E-12   
+B0      = 0               B1      = 0               VOFF    = -0.0912467      
+LVOFF   = -8.83858E-09    WVOFF   = -1.750833E-06   PVOFF   = 1.767891E-12    
+NFACTOR = 1.222168        LNFACTOR= -5.706807E-08   WNFACTOR= -2.411932E-05   
+PNFACTOR= 1.921913E-11    CIT     = -0.0004653787   LCIT    = 2.443328E-10    
+WCIT    = 1.884997E-08    PCIT    = -1.208655E-14   CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = 0.001006312     
+LETA0   = -1.492144E-10   WETA0   = -1.672834E-08   PETA0   = 1.395657E-14    
+ETAB    = 0.0004206679    LETAB   = -4.867127E-10   WETAB   = -8.434391E-09   
+PETAB   = 9.758589E-15    DSUB    = 0               PCLM    = 1.103169        
+LPCLM   = -7.354388E-07   WPCLM   = -7.084521E-06   PPCLM   = 1.571193E-11    
+PDIBLC1 = 1E-05           PDIBLC2 = -0.0006830479   LPDIBLC2= 3.307666E-09    
+WPDIBLC2= -8.79269E-09    PPDIBLC2= 1.7456E-14      PDIBLCB = 0.1651368       
+LPDIBLCB= -3.052564E-08   WPDIBLCB= -5.277212E-06   PPDIBLCB= 6.105734E-12    
+DROUT   = 0               PSCBE1  = 5.782154E+08    LPSCBE1 = -91.24341       
+WPSCBE1 = -2414.635       PPSCBE1 = 0.001078585     PSCBE2  = 2.779844E-05    
+LPSCBE2 = -1.260797E-11   WPSCBE2 = -4.836938E-10   PPSCBE2 = 2.688923E-16    
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06  
+BETA0   = 20.7            KT1     = -0.356801       LKT1    = 6.597352E-08    
+WKT1    = 2.854991E-06    PKT1    = -3.122749E-12   KT2     = -0.01945076     
+LKT2    = -2.003143E-09   WKT2    = 1.835831E-07    PKT2    = -1.61786E-13    
+AT      = 1906.944        LAT     = 0.006801126     WAT     = -1.274016       
+PAT     = 8.294801E-07    UTE     = -1.979571       LUTE    = 2.188354E-07    
+WUTE    = -4.127272E-06   PUTE    = -9.010521E-12   UA1     = -2.167498E-10   
+LUA1    = 3.730067E-16    WUA1    = 1.302156E-14    PUA1    = -4.187434E-20   
+UB1     = -1.302893E-18   LUB1    = 1.485358E-24    WUB1    = -4.567962E-23   
+PUB1    = 3.1813E-29      UC1     = -3.468722E-10   LUC1    = 3.403191E-16    
+WUC1    = 6.229855E-15    PUC1    = -6.274624E-21   KT1L    = 0               
+PRT     = -10.67252       LPRT    = 4.558123E-06    WPRT    = -0.0002110901   
+PPRT    = 1.769419E-10   
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )
*
*
.MODEL nch.12            NMOS   (                    LMIN    = 3.5E-07         
+LMAX    = '8.07E-07-dxl'  WMIN    = '1.9983E-5-dxw' WMAX    = 0.0002001       
+LEVEL   = 49              TNOM    = 25              VERSION = 3.1             
+ACM     = 12              LDIF    = 1.2E-07         HDIF    = hdifn           
+RSH     = 82.2            RD      = 0               RS      = 0               
+TOX     = toxn            XJ      = 1E-07           NCH     = 2.3579E+17      
+LLN     = 1               LWN     = 1               WLN     = 1               
+WWN     = 1               LINT    = 4E-08           LL      = 0               
+LW      = 0               LWL     = 0               WINT    = 4E-08           
+WL      = 0               WW      = 0               WWL     = 0               
+MOBMOD  = 1               BINUNIT = 2               XL      = '3E-08+dxl'     
+XW      = '1.5E-07+dxw'   DWG     = 0               DWB     = 0               
+VTH0    = 'dvtn+0.558288' LVTH0   = 6.552551E-09    WVTH0   = 4.333969E-07    
+PVTH0   = -1.646906E-13   K1      = 0.4243538       LK1     = 3.880428E-08    
+WK1     = 1.293692E-06    PK1     = -3.511657E-13   K2      = 0.05531685      
+LK2     = -2.24963E-08    WK2     = -2.018737E-07   PK2     = 6.132655E-14    
+K3      = 0               DVT0    = 0               DVT1    = 0               
+DVT2    = 0               DVT0W   = 0               DVT1W   = 0               
+DVT2W   = 0               NLX     = 0               W0      = 0               
+K3B     = 0               VSAT    = 96507.23        UA      = 5.780811E-10    
+LUA     = -4.376074E-16   WUA     = -1.159052E-14   PUA     = 8.774028E-21    
+UB      = 9.327076E-19    LUB     = 4.231599E-25    WUB     = 2.290615E-23    
+PUB     = -1.120815E-29   UC      = -4.252817E-11   LUC     = 4.244447E-17    
+WUC     = 2.133049E-15    PUC     = -9.417496E-22   RDSW    = 750             
+PRWB    = 0               PRWG    = 0               WR      = 1               
+U0      = 0.0493599       LU0     = -3.791383E-09   WU0     = -3.008583E-08   
+PU0     = 6.326492E-14    A0      = 1.108632        LA0     = -1.306164E-07   
+WA0     = -7.754034E-06   PA0     = 3.131122E-12    KETA    = -0.002019476    
+LKETA   = -1.508986E-09   WKETA   = 2.200248E-07    PKETA   = -1.319746E-14   
+A1      = 0               A2      = 0.99            AGS     = 0.1805967       
+LAGS    = -5.257816E-08   WAGS    = 5.250056E-07    PAGS    = -2.084307E-12   
+B0      = 0               B1      = 0               VOFF    = -0.1028186      
+LVOFF   = -7.862375E-11   WVOFF   = 5.637835E-07    PVOFF   = 1.572632E-14    
+NFACTOR = 1.279284        LNFACTOR= -1.003055E-07   WNFACTOR= 1.409367E-06    
+PNFACTOR= -1.060879E-13   CIT     = -0.0003548934   LCIT    = 1.606955E-10    
+WCIT    = 5.594149E-09    PCIT    = -2.051892E-15   CDSC    = 0               
+CDSCB   = 0               CDSCD   = 0               ETA0    = -0.0004200171   
+LETA0   = 9.305167E-10    WETA0   = 1.575515E-10    PETA0   = 1.173948E-15    
+ETAB    = 0.0006617482    LETAB   = -6.692105E-10   WETAB   = 1.417605E-08    
+PETAB   = -7.357516E-15   DSUB    = 0               PCLM    = -0.09697377     
+LPCLM   = 1.730695E-07    WPCLM   = 1.778578E-05    PPCLM   = -3.114881E-12   
+PDIBLC1 = 1E-05           PDIBLC2 = -0.0001322146   LPDIBLC2= 2.890686E-09    
+WPDIBLC2= 5.926362E-09    PPDIBLC2= 6.313672E-15    PDIBLCB = 0.09958895      
+LPDIBLCB= 1.909405E-08    WPDIBLCB= 5.088415E-06    PPDIBLCB= -1.741046E-12   
+DROUT   = 0               PSCBE1  = 4.648172E+08    LPSCBE1 = -5.401008       
+WPSCBE1 = -2351.523       PPSCBE1 = 0.001030809     PSCBE2  = 1.387722E-05    
+LPSCBE2 = -2.069607E-12   WPSCBE2 = -2.022001E-10   PPSCBE2 = 5.580156E-17    
+PVAG    = 0               DELTA   = 0.01            ALPHA0  = 2.5E-06 
+BETA0   = 20.7            KT1     = -0.1420202      LKT1    = -9.661557E-08   
+WKT1    = -4.90975E-06    PKT1    = 2.755161E-12    KT2     = -0.01610689     
+LKT2    = -4.534451E-09   WKT2    = -2.62401E-07    PKT2    = 1.75824E-13     
+AT      = 4458.583        LAT     = 0.004869536     WAT     = -0.131913       
+PAT     = -3.509204E-08   UTE     = -1.801945       LUTE    = 8.437233E-08    
+WUTE    = -1.71153E-05    PUTE    = 8.21413E-13     UA1     = -6.043561E-10   
+LUA1    = 6.664246E-16    WUA1    = -3.377768E-14   PUA1    = -6.447314E-21   
+UB1     = 1.551122E-18    LUB1    = -6.751311E-25   WUB1    = -1.52417E-23    
+PUB1    = 8.77149E-30     UC1     = 2.179031E-10    LUC1    = -8.721581E-17   
+WUC1    = -4.28415E-15    PUC1    = 1.684478E-21    KT1L    = 0               
+PRT     = 4.542504        LPRT    = -6.95965E-06    WPRT    = -7.738082E-05   
+PPRT    = 7.5724E-11
+CJ      = cjn            CJSW     = cjswn          CJSWG    = cjswgn 
+MJ      = 0.3297355      MJSW     = 0.1303453      MJSWG    = 0.1303453
+PB      = 0.6944804      PBSW     = 0.6944804      PBSWG    = 0.6944804
+CTA     = 9.42521E-4     CTP      = 4.91382E-04    PTA      = 1.485657E-03
+PTP     = 1.485657E-03   CGDO     = cgon           CGSO     = cgon
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1       
+JS      = 6.27496E-05    JSW      = 5.79847E-10          )
*
***************************************************************
*                                                             *
*               3.3V PMOS DEVICES MODEL                       *
*                                                             *
***************************************************************
*
.MODEL pch.1            PMOS   (                    LMIN     = '1.2228E-06-dxl'
+LMAX    = 2.01E-05       WMIN     = '1.1823E-06-dxw' WMAX   = '19.9823E-06-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7355598'
+LVTH0   = -2.602729E-08  WVTH0    = -6.917693E-08  PVTH0    = 4.363606E-14   
+K1      = 0.4301047      LK1      = -4.284528E-08  WK1      = -6.316756E-08  
+PK1     = 5.673784E-14   K2       = -0.0003689397  LK2      = -5.71726E-09   
+WK2     = 1.353252E-08   PK2      = -8.016593E-15  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 1.0078E-09     LUA      = -4.527726E-16  
+WUA     = 8.184941E-17   PUA      = -3.757546E-23  UB       = 1.534481E-18   
+LUB     = 2.820746E-25   WUB      = -1.068201E-24  PUB      = 3.569499E-31   
+UC      = 4.555716E-12   LUC      = -1.513726E-18  WUC      = -9.126132E-17  
+PUC     = 3.032344E-23   RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.0196312      
+LU0     = -4.857933E-09  WU0      = -4.780753E-09  PU0      = 3.105424E-16   
+A0      = 0.4467904      LA0      = -2.616579E-07  WA0      = 3.821818E-07   
+PA0     = -7.26674E-14   KETA     = -0.005948482   LKETA    = -1.733205E-08  
+WKETA   = 1.878229E-08   PKETA    = 1.053462E-15   A1       = 0              
+A2      = 0.4            AGS      = 0.01930433     LAGS     = 8.019689E-10   
+WAGS    = 1.393591E-08   PAGS     = -1.606531E-14  B0       = 0              
+B1      = 0              VOFF     = -0.1991839     LVOFF    = 2.295196E-08   
+WVOFF   = -4.09161E-08   PVOFF    = 3.040523E-14   NFACTOR  = 3.110217       
+LNFACTOR= -2.124369E-06  WNFACTOR = -6.45487E-07   PNFACTOR = 1.496336E-12   
+CIT     = -0.0009357498  LCIT     = 1.367298E-09   WCIT     = 7.730287E-10   
+PCIT    = -1.122406E-15  CDSC     = 0              CDSCB    = -9.316545E-06  
+LCDSCB  = 1.335765E-10   WCDSCB   = 6.37953E-11    PCDSCB   = -2.249144E-16  
+CDSCD   = 0              ETA0     = 8.045419E-05   LETA0    = 2.024863E-09   
+WETA0   = 1.722021E-11   PETA0    = 1.87748E-15    ETAB     = -1.001222E-05  
+LETAB   = 1.343784E-10   WETAB    = 7.773121E-11   PETAB    = -2.409797E-16  
+DSUB    = 0              PCLM     = 2.432071       LPCLM    = -1.352396E-07  
+WPCLM   = 1.629385E-06   PPCLM    = -2.650532E-12  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 0.2976793      LPDIBLCB = -3.29082E-07   
+WPDIBLCB= -3.773149E-07  PPDIBLCB = 6.147268E-13   DROUT    = 0              
+PSCBE1  = 6.241878E+08   PSCBE2   = 1E-20          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 8E-09          BETA0    = 18             
+KT1     = -0.5176825     LKT1     = -7.966352E-09  WKT1     = 1.360315E-08   
+PKT1    = 1.053899E-15   KT2      = -0.03958106    LKT2     = -2.860989E-09  
+WKT2    = -2.070945E-08  PKT2     = 2.532487E-14   AT       = -50000         
+UTE     = -1.742463      LUTE     = -5.778249E-07  WUTE     = 2.131611E-07   
+PUTE    = 5.872746E-13   UA1      = -3.20746E-10   LUA1     = -2.415259E-15  
+WUA1    = 5.988957E-17   PUA1     = 2.375843E-21   UB1      = -2.244901E-18  
+LUB1    = 2.395018E-24   WUB1     = 8.788389E-25   PUB1     = -2.61793E-30   
+UC1     = -9.696401E-11  LUC1     = 6.653525E-17   WUC1     = 7.734976E-17   
+PUC1    = -9.268197E-23  KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 8.5E-12      
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1      )
*
*
.MODEL pch.2            PMOS   (                    LMIN     = '8.228E-07-dxl'
+LMAX    = '1.2228E-06-dxl' WMIN   = '1.1823E-06-dxw' WMAX   = '19.9823E-06-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.766296'
+LVTH0   = 9.405285E-09   WVTH0    = -2.838143E-08  PVTH0    = -3.392986E-15  
+K1      = 0.4032516      LK1      = -1.188909E-08  WK1      = -6.26186E-08   
+PK1     = 5.6105E-14     K2       = -0.01627576    LK2      = 1.262012E-08   
+WK2     = 3.699832E-08   PK2      = -3.506796E-14  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 8.502457E-10   LUA      = -2.711436E-16  
+WUA     = 2.974891E-16   PUA      = -2.861649E-22  UB       = 7.956685E-19   
+LUB     = 1.133777E-24   WUB      = -6.748139E-25  PUB      = -9.654638E-32  
+UC      = 4.457796E-12   LUC      = -1.40085E-18   WUC      = -8.929978E-17  
+PUC     = 2.806218E-23   RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01819144     
+LU0     = -3.198179E-09  WU0      = -5.180247E-09  PU0      = 7.710789E-16   
+A0      = 0.04032973     LA0      = 2.069099E-07   WA0      = 8.760829E-07   
+PA0     = -6.420366E-13  KETA     = -0.02118766    LKETA    = 2.356817E-10   
+WKETA   = 2.379156E-08   PKETA    = -4.721232E-15  A1       = 0              
+A2      = 0.4            AGS      = 0.02           B0       = 0              
+B1      = 0              VOFF     = -0.2186518     LVOFF    = 4.53946E-08    
+WVOFF   = 2.026846E-08   PVOFF    = -4.012832E-14  NFACTOR  = -0.2299324     
+LNFACTOR= 1.726156E-06   WNFACTOR = 1.601439E-06   PNFACTOR = -1.09392E-12   
+CIT     = 0.001390931    LCIT     = -1.314899E-09  WCIT     = -8.138641E-10  
+PCIT    = 7.069634E-16   CDSC     = 0              CDSCB    = 0.0002907382   
+LCDSCB  = -2.123266E-10  WCDSCB   = -4.278522E-10  PCDSCB   = 3.418568E-16   
+CDSCD   = 0              ETA0     = 0.0001606131   LETA0    = 1.932455E-09   
+WETA0   = 8.750046E-09   PETA0    = -8.18972E-15   ETAB     = 9.491315E-05   
+LETAB   = 1.342048E-11   WETAB    = 1.019006E-10   PETAB    = -2.688422E-16  
+DSUB    = 0              PCLM     = 2.968812       LPCLM    = -7.539939E-07  
+WPCLM   = -3.166047E-06  PPCLM    = 2.877641E-12   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.002433605   LPDIBLCB = 1.688803E-08   
+WPDIBLCB= 4.493959E-07   PPDIBLCB = -3.383052E-13  DROUT    = 0              
+PSCBE1  = 6.241878E+08   PSCBE2   = 1E-20          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 8E-09          BETA0    = 18             
+KT1     = -0.4758361     LKT1     = -5.62068E-08   WKT1     = -2.242433E-08  
+PKT1    = 4.258637E-14   KT2      = -0.04881256    LKT2     = 7.781083E-09   
+WKT2    = 1.664485E-08   PKT2     = -1.773716E-14  AT       = -50000         
+UTE     = -2.643144      LUTE     = 4.604808E-07   WUTE     = 1.144958E-06   
+PUTE    = -4.869005E-13  UA1      = -2.449491E-09  LUA1     = 3.875782E-17   
+WUA1    = 2.794319E-15   PUA1     = -7.764063E-22  UB1      = -3.7071E-19    
+LUB1    = 2.344503E-25   WUB1     = -1.994584E-24  PUB1     = 6.945517E-31   
+UC1     = -4.638075E-11  LUC1     = 8.222869E-18   WUC1     = -1.142079E-16  
+PUC1    = 1.281457E-22   KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 8.5E-12     
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )
*
*
.MODEL pch.3            PMOS   (                    LMIN     = 3.5E-07      
+LMAX    = '8.228E-07-dxl' WMIN    = '1.1823E-06-dxw' WMAX   = '19.9823E-06-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7757999'
+LVTH0   = 1.655988E-08   WVTH0    = -1.74211E-08   PVTH0    = -1.164392E-14  
+K1      = 0.3485778      LK1      = 2.926939E-08   WK1      = 6.819686E-08   
+PK1     = -4.237287E-14  K2       = 0.0150499      LK2      = -1.096183E-08  
+WK2     = -2.311111E-08  PK2      = 1.018241E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 234649.4       LVSAT    = 0.01155597     WVSAT    = 0.00233258     
+PVSAT   = -1.755967E-09  UA       = 4.846211E-10   LUA      = 4.09865E-18    
+WUA     = -1.273793E-16  PUA      = 3.3676E-23     UB       = 2.236267E-18   
+LUB     = 4.929461E-26   WUB      = -1.019081E-24  PUB      = 1.626178E-31   
+UC      = 3.662316E-12   LUC      = -8.020134E-19  WUC      = -5.654456E-17  
+PUC     = 3.404061E-24   RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.0160962      
+LU0     = -1.620878E-09  WU0      = -5.021799E-09  PU0      = 6.517988E-16   
+A0      = -0.1255965     LA0      = 3.318191E-07   WA0      = -9.272605E-08  
+PA0     = 8.728277E-14   KETA     = -0.02604099    LKETA    = 3.889268E-09   
+WKETA   = 2.665836E-08   PKETA    = -6.879354E-15  A1       = 0              
+A2      = 0.4            AGS      = 0.02507669     LAGS     = -3.821729E-09  
+WAGS    = -6.256E-09     PAGS     = 4.709516E-15   B0       = 0              
+B1      = 0              VOFF     = -0.1943438     LVOFF    = 2.709555E-08   
+WVOFF   = 1.40105E-08    PVOFF    = -3.541732E-14  NFACTOR  = 1.717909       
+LNFACTOR= 2.598207E-07   WNFACTOR = 8.39973E-07    PNFACTOR = -5.206886E-13  
+CIT     = -0.0004053609  LCIT     = 3.734908E-11   WCIT     = -1.720536E-10  
+PCIT    = 2.238085E-16   CDSC     = 0              CDSCB    = 1.585899E-05   
+LCDSCB  = -5.397541E-12  WCDSCB   = 1.742596E-11   PCDSCB   = 6.651389E-18   
+CDSCD   = 0              ETA0     = -0.002082149   LETA0    = 3.620807E-09   
+WETA0   = -4.331757E-09  PETA0    = 1.65826E-15    ETAB     = 0.0001974238   
+LETAB   = -6.37495E-11   WETAB    = -6.036696E-10  PETAB    = 2.623109E-16   
+DSUB    = 0              PCLM     = 2.539458       LPCLM    = -4.307759E-07  
+WPCLM   = 1.260685E-06   PPCLM    = -4.548027E-13  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.05990779    LPDIBLCB = 6.015458E-08   
+DROUT   = 0              PSCBE1   = 6.241878E+08   PSCBE2   = 1E-20          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 8E-09          
+BETA0   = 18             KT1      = -0.5336035     LKT1     = -1.27195E-08   
+WKT1    = 1.655252E-08   PKT1     = 1.324461E-14   KT2      = -0.03884892    
+LKT2    = 2.804567E-10   WKT2     = -1.052912E-08  PKT2     = 2.7194E-15     
+AT      = -95225.05      LAT      = 0.03404541     WAT      = 0.09719087     
+PAT     = -7.316528E-08  UTE      = -2.184161      LUTE     = 1.149584E-07   
+WUTE    = 4.57182E-07    PUTE     = 3.08571E-14    UA1      = -3.235799E-09  
+LUA1    = 6.306902E-16   WUA1     = 2.370457E-15   PUA1     = -4.573231E-22  
+UB1     = 1.127105E-18   LUB1     = -8.931043E-25  WUB1     = -2.229754E-24  
+PUB1    = 8.715877E-31   UC1      = -3.854352E-11  LUC1     = 2.322999E-18   
+WUC1    = 8.195983E-17   PUC1     = -1.952937E-23  KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 8.5E-12 
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )      
*
*
.MODEL pch.4            PMOS   (                    LMIN     = '1.2228E-06-dxl'
+LMAX    = 2.01E-05       WMIN     = '7.823E-07-dxw' WMAX    = '1.1823E-06-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7866083'
+LVTH0   = 1.057459E-08   WVTH0    = -6.269882E-09  PVTH0    = -1.468425E-15  
+K1      = 0.4168567      LK1      = -5.362176E-08  WK1      = -4.684214E-08  
+PK1     = 7.001769E-14   K2       = -0.01016741    LK2      = 1.17565E-08    
+WK2     = 2.560718E-08   PK2      = -2.954951E-14  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 1.073501E-09   LUA      = -5.706369E-16  
+WUA     = 8.85903E-19    PUA      = 1.076688E-22   UB       = 7.214213E-19   
+LUB     = 7.715838E-25   WUB      = -6.626779E-26  PUB      = -2.462722E-31  
+UC      = -8.183195E-11  LUC      = 4.574169E-17   WUC      = 1.519419E-17   
+PUC     = -2.79094E-23   RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01589529     
+LU0     = -5.685544E-09  WU0      = -1.769906E-10  PU0      = 1.330407E-15   
+A0      = 0.3231201      LA0      = 2.88096E-07    WA0      = 5.345807E-07   
+PA0     = -7.501292E-13  KETA     = -0.01755726    LKETA    = 1.927339E-08   
+WKETA   = 3.308779E-08   PKETA    = -4.405541E-14  A1       = 0              
+A2      = 0.4            AGS      = 0.05269657     LAGS     = -3.769262E-08  
+WAGS    = -2.721336E-08  PAGS     = 3.137156E-14   B0       = 0              
+B1      = 0              VOFF     = -0.1879437     LVOFF    = -8.806627E-09  
+WVOFF   = -5.476744E-08  PVOFF    = 6.954134E-14   NFACTOR  = 2.680395       
+LNFACTOR= -1.280679E-06  WNFACTOR = -1.15817E-07   PNFACTOR = 4.56657E-13    
+CIT     = -0.0005696733  LCIT     = 1.123578E-09   WCIT     = 3.219128E-10   
+PCIT    = -8.220703E-16  CDSC     = 0              CDSCB    = 2.419705E-05   
+LCDSCB  = -9.985501E-11  WCDSCB   = 2.249651E-11   PCDSCB   = 6.274313E-17   
+CDSCD   = 0              ETA0     = 0.0001178861   LETA0    = 7.34801E-09    
+WETA0   = -2.890688E-11  PETA0    = -4.682234E-15  ETAB     = 0.002119739    
+LETAB   = -2.923373E-09  WETAB    = -2.546761E-09  PETAB    = 3.527087E-15   
+DSUB    = 0              PCLM     = 4.492218       LPCLM    = -4.954977E-06  
+WPCLM   = -9.093341E-07  PPCLM    = 3.28883E-12    PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.3149227     LPDIBLCB = 5.229975E-07   
+WPDIBLCB= 3.775945E-07   PPDIBLCB = -4.352909E-13  DROUT    = 0              
+PSCBE1  = 6.241878E+08   PSCBE2   = 1E-20          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 8E-09          BETA0    = 18             
+KT1     = -0.5579297     LKT1     = 6.130227E-08   WKT1     = 6.319981E-08   
+PKT1    = -8.430581E-14  KT2      = -0.07751723    LKT2     = 5.684131E-08   
+WKT2    = 2.60393E-08    PKT2     = -4.824628E-14  AT       = -49999.96      
+UTE     = -1.851253      LUTE     = 6.268078E-08   WUTE     = 3.472238E-07   
+PUTE    = -2.020204E-13  UA1      = -1.409633E-09  LUA1     = 1.185729E-15   
+WUA1    = 1.401725E-15   PUA1     = -2.061654E-21  UB1      = -1.114705E-18  
+LUB1    = -1.262137E-24  WUB1     = -5.139017E-25  PUB1     = 1.888781E-30   
+UC1     = -1.5418E-10    LUC1     = 2.956761E-17   WUC1     = 1.47857E-16    
+PUC1    = -4.712678E-23  KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 8.5E-12        
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )
*
*
.MODEL pch.5            PMOS   (                    LMIN     = '8.228E-07-dxl'
+LMAX    = '1.2228E-06-dxl' WMIN   = '7.823E-07-dxw' WMAX    = '1.1823E-06-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.779176'
+LVTH0   = 2.006595E-09   WVTH0    = -1.250934E-08  PVTH0    = 5.724419E-15   
+K1      = 0.2097173      LK1      = 1.851686E-07   WK1      = 1.758737E-07   
+PK1     = -1.867292E-13  K2       = 0.04239342     LK2      = -4.883562E-08  
+WK2     = -3.52997E-08   PK2      = 4.066394E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 8.325413E-10   LUA      = -2.928581E-16  
+WUA     = 3.193063E-16   PUA      = -2.594061E-22  UB       = -5.959466E-19  
+LUB     = 2.290246E-24   WUB      = 1.040073E-24   PUB      = -1.521662E-30  
+UC      = -8.300034E-11  LUC      = 4.708861E-17   WUC      = 1.847488E-17   
+PUC     = -3.169138E-23  RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01158579     
+LU0     = -7.17551E-10   WU0      = 2.959899E-09   PU0      = -2.285799E-15  
+A0      = 1.164632       LA0      = -6.819982E-07  WA0      = -5.093941E-07  
+PA0     = 4.533647E-13   KETA     = 0.01289531     LKETA    = -1.583234E-08  
+WKETA   = -1.820888E-08  PKETA    = 1.507939E-14   A1       = 0              
+A2      = 0.4            AGS      = 0.02           B0       = 0              
+B1      = 0              VOFF     = -0.2218014     LVOFF    = 3.022459E-08   
+WVOFF   = 2.41497E-08    PVOFF    = -2.143433E-14  NFACTOR  = -1.319543      
+LNFACTOR= 3.330449E-06   WNFACTOR = 2.944166E-06   PNFACTOR = -3.070891E-12  
+CIT     = 0.003063496    LCIT     = -3.064739E-09  WCIT     = -2.874966E-09  
+PCIT    = 2.863291E-15   CDSC     = 0              CDSCB    = -0.0002363616  
+LCDSCB  = 2.00517E-10    WCDSCB   = 2.216928E-10   PCDSCB   = -1.668903E-16  
+CDSCD   = 0              ETA0     = 0.01878576     LETA0    = -1.417231E-08  
+WETA0   = -1.420172E-08  PETA0    = 1.165619E-14   ETAB     = 0.0001815055   
+LETAB   = -6.889773E-10  WETAB    = -4.807217E-12  PETAB    = 5.967225E-16   
+DSUB    = 0              PCLM     = -5.086017      LPCLM    = 6.086812E-06   
+WPCLM   = 6.759918E-06   PPCLM    = -5.552283E-12  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 0.362247       LPDIBLCB = -2.576436E-07  
+DROUT   = 0              PSCBE1   = 6.241878E+08   PSCBE2   = 1E-20          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 8E-09          
+BETA0   = 18             KT1      = -0.5147027     LKT1     = 1.147023E-08   
+WKT1    = 2.547098E-08   PKT1     = -4.081202E-14  KT2      = -0.001345327   
+LKT2    = -3.096966E-08  WKT2     = -4.184902E-08  PKT2     = 3.001538E-14   
+AT      = -50000         UTE      = -2.214676      LUTE     = 4.81635E-07    
+WUTE    = 6.169569E-07   PUTE     = -5.129688E-13  UA1      = -6.098145E-11  
+LUA1    = -3.689957E-16  WUA1     = -1.490411E-16  PUA1     = -2.739316E-22  
+UB1     = -2.362473E-18  LUB1     = 1.762899E-25   WUB1     = 4.59865E-25    
+PUB1    = 7.662229E-31   UC1      = -3.500879E-10  LUC1     = 2.554103E-16   
+WUC1    = 2.600504E-16   PUC1     = -1.764633E-22  KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 8.5E-12 
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )     
*
*
.MODEL pch.6            PMOS   (                    LMIN     = 3.5E-07      
+LMAX    = '8.228E-07-dxl' WMIN    = '7.823E-07-dxw' WMAX    = '1.1823E-06-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7641595'
+LVTH0   = -9.297831E-09  WVTH0    = -3.176559E-08  PVTH0    = 2.022053E-14   
+K1      = 0.5075374      LK1      = -3.903041E-08  WK1      = -1.276891E-07  
+PK1     = 4.179296E-14   K2       = -0.02724116    LK2      = 3.585289E-09   
+WK2     = 2.900416E-08   PK2      = -7.744009E-15  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 208540         LVSAT    = 0.03121112     WVSAT    = 0.0345072      
+PVSAT   = -2.597702E-08  UA       = 4.029183E-10   LUA      = 3.056212E-17   
+WUA     = -2.669692E-17  PUA      = 1.065072E-24   UB       = 2.37556E-18    
+LUB     = 5.329574E-26   WUB      = -1.190731E-24  PUB      = 1.576872E-31   
+UC      = -9.487141E-12  LUC      = -8.252123E-18  WUC      = -4.034049E-17  
+PUC     = 1.258483E-23   RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01219331     
+LU0     = -1.174895E-09  WU0      = -2.122757E-10  PU0      = 1.022139E-16   
+A0      = -1.103584      LA0      = 1.025515E-06   WA0      = 1.112448E-06   
+PA0     = -7.675582E-13  KETA     = -0.01097397    LKETA    = 2.136461E-09   
+WKETA   = 8.091276E-09   PKETA    = -4.719369E-15  A1       = 0              
+A2      = 0.4            AGS      = 0.02           B0       = 0              
+B1      = 0              VOFF     = -0.1698755     LVOFF    = -8.865221E-09  
+WVOFF   = -1.614182E-08  PVOFF    = 8.897133E-15   NFACTOR  = 3.666665       
+LNFACTOR= -4.231673E-07  WNFACTOR = -1.561478E-06  PNFACTOR = 3.209575E-13   
+CIT     = -0.00176165    LCIT     = 5.676309E-10   WCIT     = 1.499302E-09   
+PCIT    = -4.296576E-16  CDSC     = 0              CDSCB    = 3E-05          
+CDSCD   = 0              ETA0     = -0.01347405    LETA0    = 1.011287E-08   
+WETA0   = 9.70648E-09    PETA0    = -6.341908E-15  ETAB     = -0.001790114   
+LETAB   = 7.952579E-10   WETAB    = 1.845573E-09   PETAB    = -7.962437E-16  
+DSUB    = 0              PCLM     = 5.310853       LPCLM    = -1.739951E-06  
+WPCLM   = -2.154504E-06  PPCLM    = 1.158494E-12   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.05990779    LPDIBLCB = 6.015458E-08   
+DROUT   = 0              PSCBE1   = 6.241878E+08   PSCBE2   = 1E-20          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 8E-09          
+BETA0   = 18             KT1      = -0.463275      LKT1     = -2.724455E-08  
+WKT1    = -7.011332E-08  PKT1     = 3.114384E-14   KT2      = -0.04331045    
+LKT2    = 6.21685E-10    WKT2     = -5.031174E-09  PKT2     = 2.298904E-15   
+AT      = -16355.55      LAT      = -0.02532754    UTE      = -1.682923      
+LUTE    = 8.133089E-08   WUTE     = -1.604939E-07  PUTE     = 7.229621E-14   
+UA1     = -3.270858E-10  LUA1     = -1.686723E-16  WUA1     = -1.213949E-15  
+PUA1    = 5.277313E-22   UB1      = -3.007486E-18  LUB1     = 6.618557E-25   
+WUB1    = 2.865301E-24   PUB1     = -1.044589E-30  UC1      = 3.054052E-11   
+LUC1    = -3.11268E-17   WUC1     = -3.172416E-18  PUC1     = 2.169081E-23   
+KT1L    = 0              PRT      = 0              JS       = 0.0001         
+JSW     = 8.5E-12        
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )
*
*
.MODEL pch.7            PMOS   (                    LMIN     = '1.2228E-06-dxl'
+LMAX    = 2.01E-05       WMIN     = 4E-07          WMAX     = '7.823E-07-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7029392'
+LVTH0   = -4.451755E-08  WVTH0    = -7.590772E-08  PVTH0    = 4.438476E-14   
+K1      = 0.3443789      LK1      = 8.180757E-08   WK1      = 1.348116E-08   
+PK1     = -4.270013E-14  K2       = 0.01761105     LK2      = -4.877357E-08  
+WK2     = 2.487164E-09   PK2      = 2.082967E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 1.066756E-09   LUA      = -2.483758E-16  
+WUA     = 6.500119E-18   PUA      = -1.605491E-22  UB       = 9.346848E-19   
+LUB     = 5.150803E-25   WUB      = -2.43767E-25   PUB      = -3.278438E-32  
+UC      = -4.907086E-11  LUC      = 1.301524E-17   WUC      = -1.207287E-17  
+PUC     = -6.711811E-25  RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01576646     
+LU0     = -4.720393E-09  WU0      = -6.976555E-11  PU0      = 5.271125E-16   
+A0      = 1.06084        LA0      = -1.011976E-06  WA0      = -7.942362E-08  
+PA0     = 3.319203E-13   KETA     = 0.04255971     LKETA    = -6.234864E-08  
+WKETA   = -1.694756E-08  PKETA    = 2.38786E-14    A1       = 0              
+A2      = 0.4            AGS      = 0.02           B0       = 0              
+B1      = 0              VOFF     = -0.237276      LVOFF    = 6.958046E-08   
+WVOFF   = -1.370811E-08  PVOFF    = 4.29978E-15    NFACTOR  = 3.356886       
+LNFACTOR= -2.514415E-06  WNFACTOR = -6.788601E-07  PNFACTOR = 1.483495E-12   
+CIT     = -0.001227871   LCIT     = 1.821105E-09   WCIT     = 8.697309E-10   
+PCIT    = -1.402622E-15  CDSC     = 0              CDSCB    = 7.549221E-05   
+LCDSCB  = -7.736119E-11  WCDSCB   = -2.019645E-11  PCDSCB   = 4.402152E-17   
+CDSCD   = 0              ETA0     = -0.0001047156  LETA0    = 2.308267E-09   
+WETA0   = 1.563642E-10   PETA0    = -4.876564E-16  ETAB     = -0.00198557    
+LETAB   = 2.45723E-09    WETAB    = 8.70087E-10    PETAB    = -9.511886E-16  
+DSUB    = 0              PCLM     = 3.781351       LPCLM    = -1.085423E-06  
+WPCLM   = -3.176793E-07  PPCLM    = 6.820034E-14   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 0.2670959      WPDIBLCB = -1.068196E-07  
+DROUT   = 0              PSCBE1   = 6.241878E+08   PSCBE2   = 1E-20          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 8E-09          
+BETA0   = 18             KT1      = -0.4769646     LKT1     = -5.411961E-08  
+WKT1    = -4.187418E-09  PKT1     = 1.17598E-14    KT2      = -0.02597249    
+LKT2    = -1.477262E-08  WKT2     = -1.686139E-08  PKT2     = 1.1358E-14     
+AT      = -50000         UTE      = -1.196817      LUTE     = -7.116914E-07  
+WUTE    = -1.974633E-07  PUTE     = 4.424896E-13   UA1      = 3.5086E-10     
+LUA1    = -2.020732E-15  WUA1     = -6.353342E-17  PUA1     = 6.070835E-22   
+UB1     = -6.322137E-19  LUB1     = -5.977636E-25  WUB1     = -9.154795E-25  
+PUB1    = 1.335823E-30   UC1      = 5.761773E-11   LUC1     = -1.162573E-16  
+WUC1    = -2.842223E-17  PUC1     = 7.424327E-23   KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 8.5E-12 
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )      
*
*
.MODEL pch.8            PMOS   (                    LMIN     = '8.228E-07-dxl'
+LMAX    = '1.2228E-06-dxl' WMIN   = 4E-07          WMAX     = '7.823E-07-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7488175'
+LVTH0   = 8.370963E-09   WVTH0    = -3.777674E-08  PVTH0    = 4.273592E-16   
+K1      = 0.523604       LK1      = -1.248031E-07  WK1      = -8.537419E-08  
+PK1     = 7.126033E-14   K2       = -0.05107869    LK2      = 3.041198E-08   
+WK2     = 4.249714E-08   PK2      = -2.529384E-14  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 1.920242E-09   LUA      = -1.232275E-15  
+WUA     = -5.859873E-16  PUA      = 5.224705E-22   UB       = 8.263419E-19   
+LUB     = 6.399782E-25   WUB      = -1.43697E-25   PUB      = -1.481451E-31  
+UC      = -2.361161E-11  LUC      = -1.633418E-17  WUC      = -3.095436E-17  
+PUC     = 2.109541E-23   RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01692046     
+LU0     = -6.05072E-09   WU0      = -1.480145E-09  PU0      = 2.152998E-15   
+A0      = 0.4326881      LA0      = -2.87842E-07   WA0      = 9.980239E-08   
+PA0     = 1.253086E-13   KETA     = -0.02037767    LKETA    = 1.020558E-08   
+WKETA   = 9.484226E-09   PKETA    = -6.591972E-15  A1       = 0              
+A2      = 0.4            AGS      = 0.02           B0       = 0              
+B1      = 0              VOFF     = -0.1646493     LVOFF    = -1.414362E-08  
+WVOFF   = -2.3418E-08    PVOFF    = 1.549334E-14   NFACTOR  = 0.8098734      
+LNFACTOR= 4.217814E-07   WNFACTOR = 1.171853E-06   PNFACTOR = -6.500073E-13  
+CIT     = 0.0004857531   LCIT     = -1.543615E-10  WCIT     = -7.29511E-10   
+PCIT    = 4.409841E-16   CDSC     = 0              CDSCB    = -1.19547E-05   
+LCDSCB  = 2.344761E-11   WCDSCB   = 3.49189E-11    PCDSCB   = -1.951545E-17  
+CDSCD   = 0              ETA0     = 0.003195406    LETA0    = -1.496113E-09  
+WETA0   = -1.225872E-09  PETA0    = 1.105785E-15   ETAB     = -0.0001486143  
+LETAB   = 3.395882E-10   WETAB    = 2.699516E-10   PETAB    = -2.593526E-16  
+DSUB    = 0              PCLM     = 3.857132       LPCLM    = -1.172783E-06  
+WPCLM   = -6.834642E-07  PPCLM    = 4.898773E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 0.973671       LPDIBLCB = -8.145399E-07  
+WPDIBLCB= -5.088884E-07  PPDIBLCB = 4.635049E-13   DROUT    = 0              
+PSCBE1  = 6.241878E+08   PSCBE2   = 1E-20          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 8E-09          BETA0    = 18             
+KT1     = -0.5435685     LKT1     = 2.266135E-08   WKT1     = 4.949596E-08   
+PKT1    = -5.01264E-14   KT2      = -0.04533644    LKT2     = 7.550143E-09   
+WKT2    = -5.235222E-09  PKT2     = -2.044651E-15  AT       = -50000         
+UTE     = -1.910263      LUTE     = 1.107694E-07   WUTE     = 3.635942E-07   
+PUTE    = -2.042974E-13  UA1      = -1.618861E-09  LUA1     = 2.49963E-16    
+WUA1    = 1.147583E-15   PUA1     = -7.890911E-22  UB1      = -1.710158E-18  
+LUB1    = 6.4489E-25     WUB1     = -8.305712E-26  PUB1     = 3.76207E-31    
+UC1     = -1.616186E-10  LUC1     = 1.364784E-16   WUC1     = 1.031874E-16   
+PUC1    = -7.747635E-23  KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 8.5E-12        
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )
*
*
.MODEL pch.9            PMOS   (                    LMIN     = 3.5E-07      
+LMAX    = '8.228E-07-dxl' WMIN    = 4E-07          WMAX     = '7.823E-07-dxw'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7272227'
+LVTH0   = -7.885572E-09  WVTH0    = -6.250807E-08  PVTH0    = 1.904511E-14   
+K1      = 0.3380176      LK1      = 1.490627E-08   WK1      = 1.340218E-08   
+PK1     = -3.09853E-15   K2       = -0.008506408   LK2      = -1.636434E-09  
+WK2     = 1.341123E-08   PK2      = -3.39797E-15   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 1.397638E-10   LUA      = 1.080694E-16   
+WUA     = 1.923266E-16   PUA      = -6.344423E-23  UB       = 1.316753E-18   
+LUB     = 2.70797E-25    WUB      = -3.094861E-25  PUB      = -2.33391E-32   
+UC      = -7.052166E-11  LUC      = 1.897971E-17   WUC      = 1.045854E-17   
+PUC     = -1.008023E-23  RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.009777177    
+LU0     = -6.732601E-10  WU0      = 1.798674E-09   PU0      = -3.152969E-16  
+A0      = 0.08632154     LA0      = -2.709721E-08  WA0      = 1.220898E-07   
+PA0     = 1.085306E-13   KETA     = -0.0005893141  LKETA    = -4.691097E-09  
+WKETA   = -5.518763E-10  PKETA    = 9.632065E-16   A1       = 0              
+A2      = 0.4            AGS      = -0.009088973   LAGS     = 2.189819E-08   
+WAGS    = 2.421076E-08   PAGS     = -1.822586E-14  B0       = 0              
+B1      = 0              VOFF     = -0.1157581     LVOFF    = -5.094894E-08  
+WVOFF   = -6.118378E-08  PVOFF    = 4.392342E-14   NFACTOR  = 1.598914       
+LNFACTOR= -1.722084E-07  WNFACTOR = 1.595103E-07   PNFACTOR = 1.120844E-13   
+CIT     = 0.0002671651   LCIT     = 1.019156E-11   WCIT     = -1.89281E-10   
+PCIT    = 3.429902E-17   CDSC     = 0              CDSCB    = -9.896482E-06  
+LCDSCB  = 2.189819E-11   WCDSCB   = 3.320585E-11   PCDSCB   = -1.822586E-17  
+CDSCD   = 0              ETA0     = -0.002054754   LETA0    = 2.456208E-09   
+WETA0   = 2.022026E-10   PETA0    = 3.073108E-17   ETAB     = 0.0005813941   
+LETAB   = -2.099622E-10  WETAB    = -1.28233E-10   PETAB    = 4.040082E-17   
+DSUB    = 0              PCLM     = 2.745758       LPCLM    = -3.361407E-07  
+WPCLM   = -1.957624E-08  PPCLM    = -9.897592E-15  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.360971      LPDIBLCB = 1.901786E-07   
+WPDIBLCB= 2.50575E-07    PPDIBLCB = -1.082191E-13  DROUT    = 0              
+PSCBE1  = 6.241878E+08   PSCBE2   = 1E-20          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 8E-09          BETA0    = 18             
+KT1     = -0.518584      LKT1     = 3.853044E-09   WKT1     = -2.407964E-08  
+PKT1    = 5.26131E-15    KT2      = -0.03174964    LKT2     = -2.678E-09     
+WKT2    = -1.465324E-08  PKT2     = 5.045232E-15   AT       = 63639.13       
+LAT     = -0.08554755    WAT      = -0.0665796     PAT      = 5.012112E-08   
+UTE     = -2.026918      LUTE     = 1.985872E-07   WUTE     = 1.258136E-07   
+PUTE    = -2.529622E-14  UA1      = -1.788096E-09  LUA1     = 3.773624E-16   
+WUA1    = 2.04894E-18    PUA1     = 7.326666E-23   UB1      = -3.558863E-19  
+LUB1    = -3.746053E-25  WUB1     = 6.583748E-25   PUB1     = -1.81943E-31   
+UC1     = 8.369506E-12   LUC1     = 8.511368E-18   WUC1     = 1.528052E-17   
+PUC1    = -1.130004E-23  KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 8.5E-12        
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )
*
*
.MODEL pch.10           PMOS   (                    LMIN     = '1.2228E-06-dxl'
+LMAX    = 2.01E-05       WMIN     = '19.9823E-06-dxw' WMAX  = 0.0002001      
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7371827'
+LVTH0   = -1.466368E-08  WVTH0    = -3.666763E-08  PVTH0    = -1.840033E-13  
+K1      = 0.3736005      LK1      = 9.856357E-09   WK1      = 1.068742E-06   
+PK1     = -9.989972E-13  K2       = 0.004450029    LK2      = -4.488514E-09  
+WK2     = -8.300249E-08  PK2      = -3.263122E-14  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 1.665056E-09   LUA      = -1.050176E-15  
+WUA     = -1.308449E-14  PUA      = 1.192978E-20   UB       = 5.963167E-19   
+LUB     = 1.639836E-24   WUB      = 1.772538E-23   PUB      = -2.684213E-29  
+UC      = -5.989704E-11  LUC      = 5.769085E-17   WUC      = 1.199875E-15   
+PUC     = -1.15568E-21   RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.02129731     
+LU0     = -6.572549E-09  WU0      = -3.815676E-08  PU0      = 3.465824E-14   
+A0      = 0.6007706      LA0      = -3.710333E-07  WA0      = -2.702396E-06  
+PA0     = 2.118372E-12   KETA     = -0.003602454   LKETA    = -1.890309E-08  
+WKETA   = -2.8214E-08    PKETA    = 3.252511E-14   A1       = 0              
+A2      = 0.4            AGS      = 0.03179434     LAGS     = -1.359651E-08  
+WAGS    = -2.362677E-07  PAGS     = 2.723694E-13   B0       = 0              
+B1      = 0              VOFF     = -0.09644017    LVOFF    = -7.070584E-08  
+WVOFF   = -2.099109E-06  PVOFF    = 1.906586E-12   NFACTOR  = 3.063436       
+LNFACTOR= 9.926317E-07   WNFACTOR = 2.916542E-07   PNFACTOR = -6.094435E-11  
+CIT     = -0.001396489   LCIT     = -4.456357E-10  WCIT     = 1.00027E-08    
+PCIT    = 3.519482E-14   CDSC     = 0              CDSCB    = 0.0002640108   
+LCDSCB  = -2.787483E-10  WCDSCB   = -5.411579E-09  PCDSCB   = 8.034899E-15   
+CDSCD   = 0              ETA0     = 7.950994E-05   LETA0    = 2.835853E-09   
+WETA0   = 3.613733E-11   PETA0    = -1.436851E-14  ETAB     = 4.104545E-05   
+LETAB   = 6.79628E-11    WETAB    = -9.45071E-10   PETAB    = 1.089478E-15   
+DSUB    = 0              PCLM     = 5.481165       LPCLM    = -4.049179E-06  
+WPCLM   = -5.945097E-05  PPCLM    = 7.575467E-11   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.008806934   LPDIBLCB = 3.320864E-08   
+WPDIBLCB= 5.762309E-06   PPDIBLCB = -6.642789E-12  DROUT    = 0              
+PSCBE1  = 6.241878E+08   PSCBE2   = 1E-20          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 8E-09          BETA0    = 18             
+KT1     = -0.4967754     LKT1     = -7.004862E-08  WKT1     = -4.052139E-07  
+PKT1    = 1.244704E-12   KT2      = -0.06552477    LKT2     = 2.301985E-08   
+WKT2    = 4.990029E-07   PKT2     = -4.931279E-13  AT       = -15423.63      
+LAT     = 0.4187727      WAT      = -0.6926445     PAT      = -8.38898E-06   
+UTE     = -1.721768      LUTE     = -4.373057E-07  WUTE     = -2.013997E-07  
+PUTE    = -2.227647E-12  UA1      = -1.471929E-09  LUA1     = -1.255656E-15  
+WUA1    = 2.312073E-14   PUA1     = -2.085367E-20  UB1      = 7.951824E-20   
+LUB1    = -6.762104E-25  WUB1     = -4.568463E-23  PUB1     = 5.890584E-29   
+UC1     = 4.279592E-11   LUC1     = -4.428028E-17  WUC1     = -2.722363E-15  
+PUC1    = 2.127207E-21   KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 8.5E-12       
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )
*
*
.MODEL pch.11           PMOS   (                    LMIN     = '8.228E-07-dxl'
+LMAX    = '1.2228E-06-dxl' WMIN   = '19.9823E-06-dxw' WMAX  = 0.0002001 
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7569252'
+LVTH0   = 8.095441E-09   WVTH0    = -2.160999E-07  PVTH0    = 2.28462E-14    
+K1      = 0.3710416      LK1      = 1.280615E-08   WK1      = 5.826215E-07   
+PK1     = -4.385974E-13  K2       = 0.003697245    LK2      = -3.620703E-09  
+WK2     = -3.631068E-07  PK2      = 2.90273E-13    K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 250000         UA       = 1.199491E-09   LUA      = -5.134727E-16  
+WUA     = -6.6987E-15    PUA      = 4.568244E-21   UB       = 1.98002E-18    
+LUB     = 4.47024E-26    WUB      = -2.44001E-23   PUB      = 2.172012E-29   
+UC      = -2.839614E-11  LUC      = 2.137661E-17   WUC      = 5.688399E-16   
+PUC     = -4.282227E-22  RDSW     = 900            PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01909702     
+LU0     = -4.036052E-09  WU0      = -2.332102E-08  PU0      = 1.75556E-14    
+A0      = 0.2084812      LA0      = 8.119802E-08   WA0      = -2.492375E-06  
+PA0     = 1.87626E-12    KETA     = 0.0009144947   LKETA    = -2.411023E-08  
+WKETA   = -4.189654E-07  PKETA    = 4.829833E-13   A1       = 0              
+A2      = 0.4            AGS      = 0.02           B0       = 0              
+B1      = 0              VOFF     = -0.1535852     LVOFF    = -4.829066E-09  
+WVOFF   = -1.283166E-06  PVOFF    = 9.659671E-13   NFACTOR  = 7.413813       
+LNFACTOR= -4.022483E-06  WNFACTOR = -0.0001515203  PNFACTOR = 1.140645E-10   
+CIT     = -0.004481022   LCIT     = 3.110213E-09   WCIT     = 1.168148E-07   
+PCIT    = -8.793822E-14  CDSC     = 0              CDSCB    = -3.846979E-05  
+LCDSCB  = 6.995124E-11   WCDSCB   = 6.166939E-09   PCDSCB   = -5.312816E-15  
+CDSCD   = 0              ETA0     = 0.0015488      LETA0    = 1.142055E-09   
+WETA0   = -1.905851E-08  PETA0    = 7.643801E-15   ETAB     = -0.0001091449  
+LETAB   = 2.411023E-10   WETAB    = 4.189654E-09   PETAB    = -4.829833E-15  
+DSUB    = 0              PCLM     = 2.328059       LPCLM    = -4.14279E-07   
+WPCLM   = 9.669695E-06   PPCLM    = -3.927623E-12  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 0.02           DROUT    = 0              
+PSCBE1  = 6.241878E+08   PSCBE2   = 1E-20          PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 8E-09          BETA0    = 18             
+KT1     = -0.5739956     LKT1     = 1.897084E-08   WKT1     = 1.943935E-06   
+PKT1    = -1.463394E-12  KT2      = -0.03736122    LKT2     = -9.447099E-09  
+WKT2    = -2.127518E-07  PKT2     = 3.273829E-13   AT       = 1096581        
+LAT     = -0.8631461     WAT      = -22.96865      PAT      = 1.72908E-05    
+UTE     = -2.111107      LUTE     = 1.152429E-08   WUTE     = -9.512969E-06  
+PUTE    = 8.50673E-12    UA1      = -3.03382E-09   LUA1     = 5.448915E-16   
+WUA1    = 1.449977E-14   PUA1     = -1.091543E-20  UB1      = -1.249096E-18  
+LUB1    = 8.554155E-25   WUB1     = 1.56015E-23    PUB1     = -1.174481E-29  
+UC1     = 7.410578E-11   LUC1     = -8.037429E-17  WUC1     = -2.527831E-15  
+PUC1    = 1.902951E-21   KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 8.5E-12     
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )   
*
*
.MODEL pch.12           PMOS   (                    LMIN     = 3.5E-07     
+LMAX    = '8.228E-07-dxl' WMIN    = '19.9823E-06-dxw' WMAX  = 0.0002801    
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp          RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp        
+XJ      = 1E-07          NCH      = 8.52E+16       LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 5E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 5E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl'    XW       = '1.5E-07+dxw'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp-0.7626531'
+LVTH0   = 1.240745E-08   WVTH0    = -2.807819E-07  PVTH0    = 7.153884E-14   
+K1      = 0.3817151      LK1      = 4.771137E-09   WK1      = -5.956208E-07  
+PK1     = 4.483834E-13   K2       = 0.01201855     LK2      = -9.884982E-09  
+WK2     = 3.761379E-08   PK2      = -1.138946E-14  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 234765.8       LVSAT    = 0.01146831     UA       = 6.60867E-10    
+LUA     = -1.079965E-16  WUA      = -3.657991E-15  PUA      = 2.279199E-21   
+UB      = 1.547748E-18   LUB      = 3.701174E-25   WUB      = 1.277354E-23   
+PUB     = -6.2642E-30    UC       = 8.396441E-13   LUC      = -6.320841E-19  
+RDSW    = 900            PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.01584556     LU0      = -1.588356E-09  
+WU0     = -1.023306E-12  PU0      = 3.097234E-19   A0       = -0.1302253     
+LA0     = 3.361762E-07   KETA     = -0.04330088    LKETA    = 9.175107E-09   
+WKETA   = 3.724136E-07   PKETA    = -1.127668E-13  A1       = 0              
+A2      = 0.4            AGS      = 0.02476439     LAGS     = -3.586633E-09  
+B0      = 0              B1       = 0              VOFF     = -0.1936444     
+LVOFF   = 2.532754E-08   NFACTOR  = 1.75984        LNFACTOR = 2.338282E-07   
+CIT     = -0.0004139497  LCIT     = 4.852149E-11   CDSC     = 0              
+CDSCB   = 9.109151E-05   LCDSCB   = -2.758251E-11  WCDSCB   = -1.489654E-09  
+PCDSCB  = 4.510674E-16   CDSCD    = 0              ETA0     = -0.001554761   
+LETA0   = 3.478416E-09   WETA0    = -1.489654E-08  PETA0    = 4.510672E-15   
+ETAB    = 0.0003531954   LETAB    = -1.069476E-10  WETAB    = -3.724136E-09  
+PETAB   = 1.127668E-15   DSUB     = 0              PCLM     = 2.230577       
+LPCLM   = -3.408944E-07  WPCLM    = 7.448274E-06   PPCLM    = -2.255337E-12  
+PDIBLC1 = 1E-05          PDIBLC2  = 0.0001         PDIBLCB  = -0.05990778    
+LPDIBLCB= 6.015457E-08   DROUT    = 0              PSCBE1   = 6.241878E+08   
+PSCBE2  = 1E-20          PVAG     = 0              DELTA    = 0.01           
+ALPHA0  = 8E-09          BETA0    = 18             KT1      = -0.5327772     
+LKT1    = -1.205833E-08  KT2      = -0.05792494    LKT2     = 6.033272E-09   
+WKT2    = 3.716073E-07   PKT2     = -1.125227E-13  AT       = -90373.34      
+LAT     = 0.03039305     UTE      = -2.310583      LUTE     = 1.616898E-07   
+WUTE    = 2.989703E-06   PUTE     = -9.052822E-13  UA1      = -3.117467E-09  
+LUA1    = 6.078609E-16   UB1      = 1.015796E-18   LUB1     = -8.495951E-25  
+UC1     = -3.445213E-11  LUC1     = 1.348104E-18   KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 8.5E-12 
+CJ      = cjp            CJSW     = cjswp          CJSWG    = cjswgp 
+MJ      = 0.6008857      MJSW     = 0.4471985      MJSWG    = 0.4471985
+PB      = 1.0864354      PBSW     = 1.0864354      PBSWG    = 1.0864354
+CTA     = 9.168207E-4    CTP      = 1.441221E-3    PTA      = 1.249266E-3
+PTP     = 1.249266E-3    CGDO     = cgop           CGSO     = cgop
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )     
.ENDL MOS 
*
***************************************************************
*                                                             *
*                                                             *
*                 5V NORMAL DEVICES MODEL                     *  
*                                                             *
*                                                             *
*                                                             *
***************************************************************
*
.LIB MOS_5V
*
***************************************************************
*                                                             *
*                 5V NMOS DEVICES MODEL                       *  
*                                                             *
***************************************************************
*


***************************************************************
*                                                             *
*                  5V NORMAL DEVICES LIB                      *
*                                                             *
***************************************************************
*
.MODEL nch5.1           NMOS   (                    LMIN     = '1.4768E-06-dxl5'
+LMAX    = 2.01E-05       WMIN     = '1.1866E-06-dxw5' WMAX  = '1.99866E-5-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.7160501'
+LVTH0   = 1.193414E-07   WVTH0    = -2.925136E-08  PVTH0    = -3.657939E-14  
+K1      = 0.8132342      LK1      = -2.139212E-08  WK1      = -2.121437E-07  
+PK1     = 3.090711E-13   K2       = 0.08275758     LK2      = 8.967889E-09   
+WK2     = 7.191232E-08   PK2      = -1.167222E-13  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 123421.3       LVSAT    = -0.05255322    WVSAT    = -0.05925493    
+PVSAT   = 7.081954E-08   UA       = -3.047443E-10  LUA      = -1.690591E-16  
+WUA     = 1.232956E-15   PUA      = -1.236268E-21  UB       = 2.352611E-18   
+LUB     = -7.935409E-25  WUB      = -2.192591E-24  PUB      = 2.144861E-30   
+UC      = 7.003104E-11   LUC      = -7.876901E-17  WUC      = -1.025695E-16  
+PUC     = 4.197229E-23   RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.04513566     
+LU0     = 9.964791E-10   WU0      = -2.613974E-09  PU0      = -5.342892E-15  
+A0      = 0.8039786      LA0      = -1.062299E-07  WA0      = 2.28216E-07    
+PA0     = -4.370248E-13  KETA     = 0.02111606     LKETA    = -1.5376E-08    
+WKETA   = -2.614258E-09  PKETA    = -3.644901E-15  A1       = 0              
+A2      = 0.99           AGS      = 0.03615667     LAGS     = -1.097324E-07  
+WAGS    = -1.592934E-08  PAGS     = 5.927313E-14   B0       = 0              
+B1      = 0              VOFF     = -0.1728738     LVOFF    = 2.866874E-08   
+WVOFF   = 6.36742E-08    PVOFF    = -2.661858E-13  NFACTOR  = 1              
+CIT     = -0.0002232942  LCIT     = 2.893404E-10   WCIT     = 4.166176E-10   
+PCIT    = -8.160311E-16  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.0001106705   LETA0    = 5.836071E-10   
+WETA0   = 7.453769E-11   PETA0    = 5.196463E-16   ETAB     = -7.636196E-06  
+LETAB   = -7.285695E-11  WETAB    = 1.400244E-11   PETAB    = 2.370925E-16   
+DSUB    = 0              PCLM     = 1.498093       LPCLM    = 2.957647E-07   
+WPCLM   = -2.684087E-07  PPCLM    = 1.860781E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0002105483   LPDIBLC2 = -8.12005E-11   WPDIBLC2 = -1.34493E-10   
+PPDIBLC2= 9.878853E-17   PDIBLCB  = 0.1144869      LPDIBLCB = 4.918969E-09   
+WPDIBLCB= 1.041207E-06   PPDIBLCB = -9.846616E-14  DROUT    = 0              
+PSCBE1  = 2.558995E+08   LPSCBE1  = 262.2747       WPSCBE1  = 126.2743       
+PPSCBE1 = -0.0004566628  PSCBE2   = 5.811373E-06   LPSCBE2  = -2.103779E-12  
+WPSCBE2 = 2.823782E-11   PPSCBE2  = -4.643062E-17  PVAG     = 0.2425753      
+LPVAG   = 7.897592E-07   WPVAG    = 1.675947E-06   PPVAG    = -2.374482E-12  
+DELTA   = 0.02           ALPHA0   = 1.7171E-05     BETA0    = 38.528         
+KT1     = -0.4366094     LKT1     = 1.910069E-08   WKT1     = 2.357561E-09   
+PKT1    = 8.99589E-14    KT2      = -0.04987791    LKT2     = -2.665453E-09  
+WKT2    = 2.2954E-09     PKT2     = 5.149059E-14   AT       = 259388.8       
+LAT     = -0.353334      WAT      = -0.2510155     PAT      = 3.556388E-07   
+UTE     = -1.820306      LUTE     = 3.587164E-07   WUTE     = 2.540486E-07   
+PUTE    = -1.580618E-13  UA1      = -9.183781E-11  LUA1     = 1.69318E-15    
+WUA1    = 3.675379E-16   PUA1     = -6.124889E-22  UB1      = 1E-20          
+UC1     = 1.476667E-12   LUC1     = 1.697575E-16   WUC1     = 1.984027E-18   
+PUC1    = -3.951542E-23  KT1L     = 0              PRT      = 0              
+JS      = 6.27496E-05    JSW      = 1.60291E-10    
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.2           NMOS   (                    LMIN     = '7.768E-07-dxl5'
+LMAX    = '1.4768E-06-dxl5'  WMIN = '1.1866E-06-dxw5' WMAX  = '1.99866E-5-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.7742557'
+LVTH0   = 3.687584E-08   WVTH0    = -4.470767E-08  PVTH0    = -1.468088E-14  
+K1      = 0.7606325      LK1      = 5.313388E-08   WK1      = 5.162972E-08   
+PK1     = -6.464309E-14  K2       = 0.108026       LK2      = -2.683247E-08  
+WK2     = -2.7284E-08    PK2      = 2.381914E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 97150.44       LVSAT    = -0.0153327     WVSAT    = -0.02368129    
+PVSAT   = 2.04188E-08    UA       = -3.654868E-10  LUA      = -8.299923E-17  
+WUA     = 2.891078E-16   PUA      = 1.009768E-22   UB       = 2.092632E-18   
+LUB     = -4.252023E-25  WUB      = -1.453934E-25  PUB      = -7.556084E-31  
+UC      = 6.154675E-11   LUC      = -6.674847E-17  WUC      = -7.54463E-17   
+PUC     = 3.54412E-24    RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.04112792     
+LU0     = 6.674643E-09   WU0      = -2.522283E-09  PU0      = -5.4728E-15    
+A0      = 0.9753814      LA0      = -3.490734E-07  WA0      = -3.799908E-07  
+PA0     = 4.246826E-13   KETA     = 0.03413409     LKETA    = -3.381995E-08  
+WKETA   = -3.286184E-08  PKETA    = 3.920987E-14   A1       = 0              
+A2      = 0.99           AGS      = -0.06356966    LAGS     = 3.15598E-08    
+WAGS    = 1.028388E-07   PAGS     = -1.089975E-13  B0       = 0              
+B1      = 0              VOFF     = -0.207608      LVOFF    = 7.788018E-08   
+WVOFF   = -1.819084E-07  PVOFF    = 8.175564E-14   NFACTOR  = 1              
+CIT     = -0.0004690668  LCIT     = 6.37551E-10    WCIT     = 4.13028E-10    
+PCIT    = -8.109454E-16  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.0002280999   LETA0    = 4.172331E-10   
+WETA0   = 5.879402E-10   PETA0    = -2.077425E-16  ETAB     = 0.0001467451   
+LETAB   = -2.915844E-10  WETAB    = -1.920416E-11  PETAB    = 2.841397E-16   
+DSUB    = 0              PCLM     = 1.077091       LPCLM    = 8.922393E-07   
+WPCLM   = 2.482068E-07   PPCLM    = -5.458628E-13  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0002077489   LPDIBLC2 = -7.723444E-11  WPDIBLC2 = -1.310873E-10  
+PPDIBLC2= 9.396341E-17   PDIBLCB  = 0.1722942      LPDIBLCB = -7.698244E-08  
+WPDIBLCB= 9.056039E-07   PPDIBLCB = 9.365683E-14   DROUT    = 0              
+PSCBE1  = 4.797392E+08   LPSCBE1  = -54.8615       WPSCBE1  = -345.1526      
+PPSCBE1 = 0.000211255    PSCBE2   = 6.995522E-06   LPSCBE2  = -3.781479E-12  
+WPSCBE2 = -8.382039E-12  PPSCBE2  = 5.452395E-18   PVAG     = 1.108201       
+LPVAG   = -4.366592E-07  WPVAG    = 3.725216E-07   PPVAG    = -5.277886E-13  
+DELTA   = 0.02           ALPHA0   = 1.7171E-05     BETA0    = 38.528         
+KT1     = -0.3700218     LKT1     = -7.52407E-08   WKT1     = 1.243145E-09   
+PKT1    = 9.153783E-14   KT2      = -0.04264374    LKT2     = -1.291483E-08  
+WKT2    = 2.817127E-08   PKT2     = 1.482966E-14   AT       = -6022.654      
+LAT     = 0.0227009      WAT      = 0.01326417     PAT      = -1.879268E-08  
+UTE     = -1.415707      LUTE     = -2.145197E-07  WUTE     = -1.867375E-08  
+PUTE    = 2.283313E-13   UA1      = 6.989369E-10   LUA1     = 5.728105E-16   
+WUA1    = -1.708799E-16  PUA1     = 1.503414E-22   UB1      = 1E-20          
+UC1     = 5.587832E-11   LUC1     = 9.268131E-17   WUC1     = 5.367844E-17   
+PUC1    = -1.127561E-22  KT1L     = 0              PRT      = 0              
+JS      = 6.27496E-05    JSW      = 1.60291E-10    
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.3           NMOS   (                    LMIN     = 5E-07      
+LMAX    = '7.768E-07-dxl5' WMIN   = '1.1866E-06-dxw5' WMAX  = '1.99866E-5-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.8816147'
+LVTH0   = -4.007912E-08  WVTH0    = -1.357187E-07  PVTH0    = 5.055582E-14   
+K1      = 0.8786767      LK1      = -3.148016E-08  WK1      = 1.437095E-09   
+PK1     = -2.866503E-14  K2       = 0.1318776      LK2      = -4.392925E-08  
+WK2     = 2.511806E-09   PK2      = 2.461502E-15   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 77382.76       LVSAT    = -0.001163218   WVSAT    = 0.007570815    
+PVSAT   = -1.982707E-09  UA       = -1.164636E-09  LUA      = 4.898312E-16   
+WUA     = 1.043561E-15   PUA      = -4.398154E-22  UB       = 3.581349E-18   
+LUB     = -1.492314E-24  WUB      = -3.118039E-24  PUB      = 1.375184E-30   
+UC      = 1.016678E-10   LUC      = -9.550721E-17  WUC      = -9.826651E-17  
+PUC     = 1.990164E-23   RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.0376413      
+LU0     = 9.173854E-09   WU0      = -6.315261E-09  PU0      = -2.753993E-15  
+A0      = 1.331732       LA0      = -6.045051E-07  WA0      = -1.003761E-08  
+PA0     = 1.595002E-13   KETA     = 0.01221691     LKETA    = -1.810972E-08  
+WKETA   = -4.289826E-10  PKETA    = 1.5962E-14     A1       = 0              
+A2      = 0.99           AGS      = -0.07807274    LAGS     = 4.195561E-08   
+WAGS    = -4.562323E-08  PAGS     = -2.579971E-15  B0       = 0              
+B1      = 0              VOFF     = -0.1008694     LVOFF    = 1.369923E-09   
+WVOFF   = -1.61013E-07   PVOFF    = 6.677785E-14   NFACTOR  = 1              
+CIT     = 0.0001247854   LCIT     = 2.118778E-10   WCIT     = -2.125891E-09  
+PCIT    = 1.008952E-15   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.00351763    LETA0    = 3.102172E-09   
+WETA0   = 7.265092E-10   PETA0    = -3.07069E-16   ETAB     = 0.0009769659   
+LETAB   = -8.866866E-10  WETAB    = -1.981018E-10  PETAB    = 4.123735E-16   
+DSUB    = 0              PCLM     = 2.472318       LPCLM    = -1.078595E-07  
+WPCLM   = -9.879333E-07  PPCLM    = 3.402023E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.2848955     LPDIBLCB = 2.507312E-07   
+WPDIBLCB= 2.475979E-06   PPDIBLCB = -1.031988E-12  DROUT    = 0              
+PSCBE1  = 3.337439E+08   LPSCBE1  = 49.78798       WPSCBE1  = -31.59911      
+PPSCBE1 = -1.350022E-05  PSCBE2   = 1.389228E-06   LPSCBE2  = 2.371121E-13   
+WPSCBE2 = -2.366666E-13  PPSCBE2  = -3.862086E-19  PVAG     = 1.167242       
+LPVAG   = -4.789795E-07  WPVAG    = -9.232066E-07  PPVAG    = 4.009893E-13   
+DELTA   = 0.02           ALPHA0   = 1.7171E-05     BETA0    = 38.528         
+KT1     = -0.5308903     LKT1     = 4.006981E-08   WKT1     = 2.054071E-07   
+PKT1    = -5.480687E-14  KT2      = -0.1298553     LKT2     = 4.959838E-08   
+WKT2    = 1.406478E-07   PKT2     = -6.579349E-14  AT       = 17940.48       
+LAT     = 0.005524126    WAT      = -0.02555081    PAT      = 9.029897E-09   
+UTE     = -1.586968      LUTE     = -9.175968E-08  WUTE     = 6.436011E-07   
+PUTE    = -2.463873E-13  UA1      = 8.171159E-10   LUA1     = 4.880997E-16   
+WUA1    = 1.154639E-15   PUA1     = -7.997908E-22  UB1      = 1E-20          
+UC1     = 2.591391E-10   LUC1     = -5.301601E-17  WUC1     = -1.936086E-16  
+PUC1    = 6.449927E-23   KT1L     = 0              PRT      = 0              
+JS      = 6.27496E-05    JSW      = 1.60291E-10    
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.4           NMOS   (                    LMIN     = '1.4768E-06-dxl5'
+LMAX    = 2.01E-05       WMIN     = '7.866E-07-dxw5' WMAX   = '1.1866E-06-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.716976'
+LVTH0   = 7.130424E-08   WVTH0    = -3.037783E-08  PVTH0    = 2.186268E-14   
+K1      = 0.34655        LK1      = 4.248781E-07   WK1      = 3.556242E-07   
+PK1     = -2.338612E-13  K2       = 0.2549874      LK2      = -1.562995E-07  
+WK2     = -1.376224E-07  PK2      = 8.434208E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 63928.49       LVSAT    = 0.01720822     WVSAT    = 0.01312399     
+PVSAT   = -1.405223E-08  UA       = 5.652651E-10   LUA      = -1.795517E-15  
+WUA     = 1.745027E-16   PUA      = 7.424808E-22   UB       = 1.895503E-19   
+LUB     = 3.726479E-24   WUB      = 4.389887E-25   PUB      = -3.354195E-30  
+UC      = -2.907984E-11  LUC      = 1.082396E-16   WUC      = 1.800878E-17   
+PUC     = -1.855424E-22  RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.04299843     
+LU0     = -1.015954E-08  WU0      = -1.382523E-11  PU0      = 8.229521E-15   
+A0      = 1.117108       LA0      = -1.165744E-06  WA0      = -1.527375E-07  
+PA0     = 8.519803E-13   KETA     = 0.01123998     LKETA    = -1.320881E-08  
+WKETA   = 9.400973E-09   PKETA    = -6.281518E-15  A1       = 0              
+A2      = 0.99           AGS      = 0.008902191    LAGS     = -1.855685E-07  
+WAGS    = 1.722848E-08   PAGS     = 1.515352E-13   B0       = 0              
+B1      = 0              VOFF     = 0.005775839    LVOFF    = -6.797976E-07  
+WVOFF   = -1.536709E-07  PVOFF    = 5.957343E-13   NFACTOR  = 1              
+CIT     = -0.000375391   LCIT     = -4.049137E-10  WCIT     = 6.016586E-10   
+PCIT    = 2.859847E-17   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 4.703133E-05   LETA0    = 2.13069E-09    
+WETA0   = 1.51961E-10    PETA0    = -1.362534E-15  ETAB     = -2.431403E-05  
+LETAB   = 4.801238E-10   WETAB    = 3.429267E-11   PETAB    = -4.356639E-16  
+DSUB    = 0              PCLM     = 0.4085876      LPCLM    = 2.675253E-06   
+WPCLM   = 1.057083E-06   PPCLM    = -2.708807E-12  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 2.634791       LPDIBLCB = -6.987976E-07  
+WPDIBLCB= -2.024994E-06  PPDIBLCB = 7.576754E-13   DROUT    = 0              
+PSCBE1  = 4.807397E+08   LPSCBE1  = -614.8711      WPSCBE1  = -147.2663      
+PPSCBE1 = 0.0006104726   PSCBE2   = 5.893929E-05   LPSCBE2  = -8.721632E-11  
+WPSCBE2 = -3.63976E-11   PPSCBE2  = 5.711729E-17   PVAG     = 4.598141       
+LPVAG   = -3.07018E-06   WPVAG    = -3.623034E-06  PPVAG    = 2.32152E-12    
+DELTA   = 0.02           ALPHA0   = 1.7171E-05     BETA0    = 38.528         
+KT1     = -0.4424202     LKT1     = 2.880304E-07   WKT1     = 9.426929E-09   
+PKT1    = -2.372209E-13  KT2      = -0.001672706   LKT2     = 9.298603E-08   
+WKT2    = -5.635105E-08  PKT2     = -6.487899E-14  AT       = 53063.35       
+LAT     = -0.06101216    UTE      = -2.033218      LUTE     = 4.962802E-07   
+WUTE    = 5.130771E-07   PUTE     = -3.254217E-13  UA1      = -7.493567E-10  
+LUA1    = 1.232709E-15   WUA1     = 1.167475E-15   PUA1     = -5.227951E-23  
+UB1     = 1E-20          UC1      = 2.470978E-11   LUC1     = 1.095636E-16   
+WUC1    = -2.628139E-17  PUC1     = 3.371659E-23   KT1L     = 0              
+PRT     = 0              JS       = 6.27496E-05    JSW      = 1.60291E-10   
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.5           NMOS   (                    LMIN     = '7.768E-07-dxl5'
+LMAX    = '1.4768E-06-dxl5' WMIN = '7.866E-07-dxw5' WMAX   = '1.1866E-06-dxw5' 
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.757386'
+LVTH0   = 1.405136E-08   WVTH0    = -2.418408E-08  PVTH0    = 1.308738E-14   
+K1      = 0.4186933      LK1      = 3.226654E-07   WK1      = 4.676329E-07   
+PK1     = -3.92555E-13   K2       = 0.2501783      LK2      = -1.494861E-07  
+WK2     = -2.002264E-07  PK2      = 1.730395E-13   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 76289.56       LVSAT    = -0.0003049522  WVSAT    = 0.001698046    
+PVSAT   = 2.136052E-09   UA       = -9.995526E-10  LUA      = 4.215168E-16   
+WUA     = 1.060512E-15   PUA      = -5.128172E-22  UB       = 4.329603E-18   
+LUB     = -2.139147E-24  WUB      = -2.866892E-24  PUB      = 1.329576E-30   
+UC      = 1.424847E-10   LUC      = -1.34833E-16   WUC      = -1.739154E-16  
+PUC     = 8.637577E-23   RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.04192219     
+LU0     = -8.634713E-09  WU0      = -3.488586E-09  PU0      = 1.315256E-14   
+A0      = -0.1736086     LA0      = 6.629432E-07   WA0      = 1.01787E-06    
+PA0     = -8.065365E-13  KETA     = -0.005120256   LKETA    = 9.970379E-09   
+WKETA   = 1.489499E-08   PKETA    = -1.406544E-14  A1       = 0              
+A2      = 0.99           AGS      = -0.01840011    LAGS     = -1.468866E-07  
+WAGS    = 4.788552E-08   PAGS     = 1.081003E-13   B0       = 0              
+B1      = 0              VOFF     = -0.7284026     LVOFF    = 3.603864E-07   
+WVOFF   = 4.516902E-07   PVOFF    = -2.619414E-13  NFACTOR  = 1              
+CIT     = -0.0006371906  LCIT     = -3.399597E-11  WCIT     = 6.175676E-10   
+PCIT    = 6.058589E-18   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.001105242    LETA0    = 6.314169E-10   
+WETA0   = -4.791907E-10  PETA0    = -4.683184E-16  ETAB     = 6.285548E-05   
+LETAB   = 3.566221E-10   WETAB    = 8.285589E-11   PETAB    = -5.044682E-16  
+DSUB    = 0              PCLM     = 2.496856       LPCLM    = -2.834049E-07  
+WPCLM   = -1.479078E-06  PPCLM    = 8.844256E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 2.141568       WPDIBLCB = -1.490214E-06  
+DROUT   = 0              PSCBE1   = -1.944705E+08  LPSCBE1  = 341.7668       
+WPSCBE1 = 475.0909       PPSCBE1  = -0.000271283   PSCBE2   = -5.433933E-06  
+LPSCBE2 = 3.987667E-12   WPSCBE2  = 6.739634E-12   PPSCBE2  = -3.999548E-18  
+PVAG    = 4.506817       LPVAG    = -2.940791E-06  WPVAG    = -3.762234E-06  
+PPVAG   = 2.518738E-12   DELTA    = 0.02           ALPHA0   = 1.7171E-05     
+BETA0   = 38.528         KT1      = -0.1774013     LKT1     = -8.744845E-08  
+WKT1    = -2.33099E-07   PKT1     = 1.063898E-13   KT2      = 0.1126152      
+LKT2    = -6.893709E-08  WKT2     = -1.607167E-07  PKT2     = 8.298633E-14   
+AT      = 25784.97       LAT      = -0.02236414    WAT      = -0.02543298    
+PAT     = 3.603344E-08   UTE      = -2.292395      LUTE     = 8.634823E-07   
+WUTE    = 1.047905E-06   PUTE     = -1.083166E-12  UA1      = -2.263129E-09  
+LUA1    = 3.377421E-15   WUA1     = 3.432769E-15   PUA1     = -3.261747E-21  
+UB1     = 1E-20          UC1      = 2.086569E-10   LUC1     = -1.510526E-16  
+WUC1    = -1.321919E-16  PUC1     = 1.837706E-22   KT1L     = 0              
+PRT     = 0              JS       = 6.27496E-05    JSW      = 1.60291E-10  
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.6           NMOS   (                    LMIN     = 5E-07      
+LMAX    = '7.768E-07-dxl5' WMIN   = '7.866E-07-dxw5' WMAX   = '1.1866E-06-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.754185'
+LVTH0   = 1.634588E-08   WVTH0    = 1.93123E-08    PVTH0    = -1.809083E-14  
+K1      = 1.310955       LK1      = -3.169078E-07  WK1      = -5.244728E-07  
+PK1     = 3.185861E-13   K2       = -0.004792294   LK2      = 3.327685E-08   
+WK2     = 1.687844E-07   PK2      = -9.146744E-14  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 128261.1       LVSAT    = -0.03755817    WVSAT    = -0.05432782    
+PVSAT   = 4.229539E-08   UA       = -3.472056E-09  LUA      = 2.193807E-15   
+WUA     = 3.850767E-15   PUA      = -2.512872E-21  UB       = 2.864159E-18   
+LUB     = -1.088717E-24  WUB      = -2.245506E-24  PUB      = 8.841667E-31   
+UC      = -2.594599E-11  LUC      = -1.410189E-17  WUC      = 5.698841E-17   
+PUC     = -7.913607E-23  RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.001911031    
+LU0     = 2.004528E-08   WU0      = 3.715418E-08   PU0      = -1.598017E-14  
+A0      = 4.16018        LA0      = -2.443516E-06  WA0      = -3.451127E-06  
+PA0     = 2.39684E-12    KETA     = 0.08663055     LKETA    = -5.579659E-08  
+WKETA   = -9.096062E-08  PKETA    = 6.181185E-14   A1       = 0              
+A2      = 0.99           AGS      = -0.3923464     LAGS     = 1.211581E-07   
+WAGS    = 3.367221E-07   PAGS     = -9.89377E-14   B0       = 0              
+B1      = 0              VOFF     = -0.4380599     LVOFF    = 1.522687E-07   
+WVOFF   = 2.492129E-07   PVOFF    = -1.168056E-13  NFACTOR  = 1              
+CIT     = -0.003066113   LCIT     = 1.707055E-09   WCIT     = 1.756155E-09   
+PCIT    = -8.100807E-16  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.001225382    LETA0    = 5.453E-10      
+WETA0   = -5.043839E-09  PETA0    = 2.803621E-15   ETAB     = 0.00203359     
+LETAB   = -1.056E-09     WETAB    = -1.483591E-09  PETAB    = 6.183606E-16   
+DSUB    = 0              PCLM     = 2.270198       LPCLM    = -1.209366E-07  
+WPCLM   = -7.420332E-07  PPCLM    = 3.561119E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 4.251054       LPDIBLCB = -1.51208E-06   
+WPDIBLCB= -3.042457E-06  PPDIBLCB = 1.112647E-12   DROUT    = 0              
+PSCBE1  = 2.581153E+08   LPSCBE1  = 17.35328       WPSCBE1  = 60.4106        
+PPSCBE1 = 2.595983E-05   PSCBE2   = -5.215625E-07  LPSCBE2  = 4.664796E-13   
+WPSCBE2 = 2.088001E-12   PPSCBE2  = -6.652571E-19  PVAG     = 0.7827297      
+LPVAG   = -2.713658E-07  WPVAG    = -4.554094E-07  PPVAG    = 1.484066E-13   
+DELTA   = 0.02           ALPHA0   = 1.7171E-05     BETA0    = 38.528         
+KT1     = -0.257047      LKT1     = -3.035837E-08  WKT1     = -1.277506E-07  
+PKT1    = 3.087606E-14   KT2      = 0.05983669     LKT2     = -3.110545E-08  
+WKT2    = -9.013142E-08  PKT2     = 3.239077E-14   AT       = -46166.95      
+LAT     = 0.02921099     WAT      = 0.05244228     PAT      = -1.978754E-08  
+UTE     = 1.026002       LUTE     = -1.515144E-06  WUTE     = -2.535337E-06  
+PUTE    = 1.485302E-12   UA1      = 8.612783E-09   LUA1     = -4.418432E-15  
+WUA1    = -8.329568E-15  PUA1     = 5.169495E-21   UB1      = 1E-20          
+UC1     = 4.23374E-10    LUC1     = -3.049618E-16  WUC1     = -3.934167E-16  
+PUC1    = 3.710164E-22   KT1L     = 0              PRT      = 0              
+JS      = 6.27496E-05    JSW      = 1.60291E-10    
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.7           NMOS   (                    LMIN     = '1.4768E-06-dxl5'
+LMAX    = 2.01E-05       WMIN     = 4E-07          WMAX     = '7.866E-07-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.7276775'
+LVTH0   = 1.104379E-07   WVTH0    = -3.911664E-08  PVTH0    = -1.009389E-14  
+K1      = 0.8510062      LK1      = 2.169435E-07   WK1      = -5.63147E-08   
+PK1     = -6.406188E-14  K2       = 0.04890428     LK2      = -7.47679E-08   
+WK2     = 3.066504E-08   PK2      = 1.776336E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 113839.4       LVSAT    = -0.05167251    WVSAT    = -0.02763327    
+PVSAT   = 4.219578E-08   UA       = 2.32315E-10    LUA      = 4.079006E-17   
+WUA     = 4.463897E-16   PUA      = -7.570474E-22  UB       = 1.293545E-18   
+LUB     = -1.10585E-24   WUB      = -4.625334E-25  PUB      = 5.918851E-31   
+UC      = -5.49437E-12   LUC      = -1.071675E-16  WUC      = -1.251108E-18  
+PUC     = -9.640929E-24  RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.04138438     
+LU0     = 7.996047E-10   WU0      = 1.304215E-09   PU0      = -7.19717E-16   
+A0      = 0.9677507      LA0      = -3.549583E-08  WA0      = -3.07721E-08   
+PA0     = -7.098053E-14  KETA     = 0.02698686     LKETA    = -1.8047E-08    
+WKETA   = -3.457925E-09  PKETA    = -2.330647E-15  A1       = 0              
+A2      = 0.99           AGS      = 0.040415       WAGS     = -8.504888E-09  
+B0      = 0              B1       = 0              VOFF     = -0.2188311     
+LVOFF   = 6.215273E-08   WVOFF    = 2.974309E-08   PVOFF    = -1.014232E-14  
+NFACTOR = 1              CIT      = 0.000464038    LCIT     = -5.521448E-10  
+WCIT    = -8.381916E-11  PCIT     = 1.488275E-16   CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 0.0004112525   
+LETA0   = -1.497303E-10  WETA0    = -1.45462E-10   PETA0    = 4.996568E-16   
+ETAB    = 4.746675E-05   LETAB    = -1.2805E-10    WETAB    = -2.432351E-11  
+PETAB   = 6.097093E-17   DSUB     = 0              PCLM     = 2.175756       
+LPCLM   = -1.326279E-06  WPCLM    = -3.859872E-07  PPCLM    = 5.588441E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = 0.0001         PDIBLCB  = 0.1430265      
+LPDIBLCB= 4.675931E-07   WPDIBLCB = 9.780725E-09   PPDIBLCB = -1.947993E-13  
+DROUT   = 0              PSCBE1   = 2.952797E+08   LPSCBE1  = 320.4201       
+WPSCBE1 = 4.180377       PPSCBE1  = -0.0001532861  PSCBE2   = 1.761226E-05   
+LPSCBE2 = -1.96731E-11   WPSCBE2  = -2.649951E-12  PPSCBE2  = 1.961496E-18   
+PVAG    = 0.2987112      LPVAG    = -6.726488E-07  WPVAG    = -1.121194E-07  
+PPVAG   = 3.63696E-13    DELTA    = 0.02           ALPHA0   = 1.7171E-05     
+BETA0   = 38.528         KT1      = -0.3702644     LKT1     = -5.461356E-08  
+WKT1    = -4.949553E-08  PKT1     = 4.258212E-14   KT2      = -0.0690529     
+LKT2    = 1.574866E-08   WKT2     = -1.328377E-09  PKT2     = -1.806951E-15  
+AT      = 19425.49       LAT      = -0.01335404    WAT      = 0.02746868     
+PAT     = -3.891762E-08  UTE      = -1.37406       LUTE     = -2.054924E-07  
+WUTE    = -2.519133E-08  PUTE     = 2.476457E-13   UA1      = 1.395157E-09   
+LUA1    = -3.52877E-16   WUA1     = -5.837347E-16  PUA1     = 1.24251E-21    
+UB1     = 1.003988E-20   LUB1     = -7.943019E-28  WUB1     = -3.256683E-29  
+PUB1    = 6.486269E-34   UC1      = -1.051866E-11  LUC1     = 6.130762E-18   
+WUC1    = 2.486163E-18   PUC1     = 1.181798E-22   KT1L     = 0              
+PRT     = 0              JS       = 6.27496E-05    JSW      = 1.60291E-10 
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.8           NMOS   (                    LMIN     = '7.768E-07-dxl5' 
+LMAX    = '1.4768E-06-dxl5' WMIN  = 4E-07          WMAX     = '7.866E-07-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.8013124'
+LVTH0   = 6.111921E-09   WVTH0    = -6.00544E-08   PVTH0    = 1.957073E-14   
+K1      = 1.285213       LK1      = -3.98241E-07   WK1      = -2.399673E-07  
+PK1     = 1.961371E-13   K2       = -0.1138082     LK2      = 1.557631E-07   
+WK2     = 9.700493E-08   PK2      = -7.6227E-14    K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 74606.2        LVSAT    = 0.003913108    WVSAT    = 0.003072686    
+PVSAT   = -1.308417E-09  UA       = -3.262286E-10  LUA      = 8.321349E-16   
+WUA     = 5.106758E-16   PUA      = -8.48128E-22   UB       = 9.340716E-19   
+LUB     = -5.965479E-25  WUB      = -9.410095E-26  PUB      = 6.989007E-32   
+UC      = -1.238161E-10  LUC      = 6.047078E-17   WUC      = 4.354589E-17   
+PUC     = -7.310933E-23  RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.03237708     
+LU0     = 1.356114E-08   WU0      = 4.305953E-09   PU0      = -4.972578E-15  
+A0      = 1.105779       LA0      = -2.310551E-07  WA0      = -2.687808E-08  
+PA0     = -7.649759E-14  KETA     = 0.02267514     LKETA    = -1.193815E-08  
+WKETA   = -7.802726E-09  PKETA    = 3.825065E-15   A1       = 0              
+A2      = 0.99           AGS      = 0.06131995     LAGS     = -2.961814E-08  
+WAGS    = -1.721389E-08  PAGS     = 1.233892E-14   B0       = 0              
+B1      = 0              VOFF     = -0.2260368     LVOFF    = 7.23618E-08    
+WVOFF   = 4.145836E-08   PVOFF    = -2.674053E-14  NFACTOR  = 1              
+CIT     = 0.0002170056   LCIT     = -2.021496E-10  WCIT     = -7.996917E-11  
+PCIT    = 1.433728E-16   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.001350041    LETA0    = -1.479806E-09  
+WETA0   = -6.790936E-10  PETA0    = 1.255706E-15   ETAB     = 0.0003952329   
+LETAB   = -6.207652E-10  WETAB    = -1.885635E-10  PETAB    = 2.936662E-16   
+DSUB    = 0              PCLM     = 0.7088658      LPCLM    = 7.520114E-07   
+WPCLM   = -1.900562E-08  PPCLM    = 3.890463E-14   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 0.6332092      LPDIBLCB = -2.26898E-07   
+WPDIBLCB= -2.584887E-07  PPDIBLCB = 1.852849E-13   DROUT    = 0              
+PSCBE1  = 5.607857E+08   LPSCBE1  = -55.74886      WPSCBE1  = -141.6514      
+PPSCBE1 = 5.332833E-05   PSCBE2   = 4.963393E-06   LPSCBE2  = -1.752178E-12  
+WPSCBE2 = -1.750823E-12  PPSCBE2  = 6.876093E-19   PVAG     = -0.4587352     
+LPVAG   = 4.005014E-07   WPVAG    = 2.926361E-07   PPVAG    = -2.097616E-13  
+DELTA   = 0.02           ALPHA0   = 1.7171E-05     BETA0    = 38.528         
+KT1     = -0.3505789     LKT1     = -8.250393E-08  WKT1     = -9.168211E-08  
+PKT1    = 1.023521E-13   KT2      = -0.07817478    LKT2     = 2.867252E-08   
+WKT2    = -4.917643E-09  PKT2     = 3.278322E-15   AT       = -10692.47      
+LAT     = 0.0293171      WAT      = 0.004354501    PAT      = -6.169458E-09  
+UTE     = -0.8306929     LUTE     = -9.753351E-07  WUTE     = -1.457213E-07  
+PUTE    = 4.184127E-13   UA1      = 2.7572E-09     LUA1     = -2.282619E-15  
+WUA1    = -6.668318E-16  PUA1     = 1.360242E-21   UB1      = -1.23839E-20   
+LUB1    = 3.097572E-26   WUB1     = 1.82787E-26    PUB1     = -2.529478E-32  
+UC1     = -6.157209E-12  LUC1     = -4.858668E-20  WUC1     = 4.322526E-17   
+PUC1    = 6.046069E-23   KT1L     = 0              PRT      = 0              
+JS      = 6.27496E-05    JSW      = 1.60291E-10    
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.9           NMOS   (                    LMIN     = 5E-07      
+LMAX    = '7.768E-07-dxl5' WMIN   = 4E-07          WMAX     = '7.866E-07-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.801025'
+LVTH0   = 6.317962E-09   WVTH0    = -1.893728E-08  PVTH0    = -9.902023E-15  
+K1      = 0.5422925      LK1      = 1.342845E-07   WK1      = 1.032171E-07   
+PK1     = -4.985744E-14  K2       = 0.2610573      LK2      = -1.129404E-07  
+WK2     = -4.830839E-08  PK2      = 2.793358E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 56894.82       LVSAT    = 0.01660862     WVSAT    = 0.003949918    
+PVSAT   = -1.937215E-09  UA       = 2.048742E-09   LUA      = -8.702442E-16  
+WUA     = -6.575166E-16  PUA      = -1.076766E-23  UB       = -2.657071E-20  
+LUB     = 9.204046E-26   WUB      = 1.150644E-25   PUB      = -8.003962E-32  
+UC      = 1.094896E-10   LUC      = -1.067628E-16  WUC      = -5.36083E-17   
+PUC     = -3.469208E-24  RDSW     = 1400           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.05079535     
+LU0     = 3.589268E-10   WU0      = -2.764758E-09  PU0      = 9.570658E-17   
+A0      = -0.4819689     LA0      = 9.070427E-07   WA0      = 3.396512E-07   
+PA0     = -3.392257E-13  KETA     = -0.02710977    LKETA    = 2.374767E-08   
+WKETA   = 1.91973E-09    PKETA    = -3.14399E-15   A1       = 0              
+A2      = 0.99           AGS      = -0.04005479    LAGS     = 4.304726E-08   
+WAGS    = 4.904073E-08   PAGS     = -3.515238E-14  B0       = 0              
+B1      = 0              VOFF     = -0.1513954     LVOFF    = 1.885885E-08   
+WVOFF   = 1.512268E-08   PVOFF    = -7.863109E-15  NFACTOR  = 1              
+CIT     = -0.002083355   LCIT     = 1.446749E-09   WCIT     = 9.536349E-10   
+PCIT    = -5.975145E-16  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.007208975   LETA0    = 4.655297E-09   
+WETA0   = 1.843658E-09   PETA0    = -5.526021E-16  ETAB     = -0.001153704   
+LETAB   = 4.895123E-10   WETAB    = 1.119153E-09   PETAB    = -6.437049E-16  
+DSUB    = 0              PCLM     = 1.100534       LPCLM    = 4.71264E-07    
+WPCLM   = 2.131145E-07   PPCLM    = -1.27479E-13   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = 0.5252922      LPDIBLCB = -1.49543E-07   
+DROUT   = 0              PSCBE1   = 5.433444E+08   LPSCBE1  = -43.24691      
+WPSCBE1 = -172.5074      PPSCBE1  = 7.544593E-05   PSCBE2   = 5.509004E-06   
+LPSCBE2 = -2.143271E-12  WPSCBE2  = -2.836559E-12  PPSCBE2  = 1.465865E-18   
+PVAG    = 0.1396675      LPVAG    = -2.84337E-08   WPVAG    = 6.971517E-08   
+PPVAG   = -4.997183E-14  DELTA    = 0.02           ALPHA0   = 1.7171E-05     
+BETA0   = 38.528         KT1      = -0.4333648     LKT1     = -2.316299E-08  
+WKT1    = 1.623052E-08   PKT1     = 2.500031E-14   KT2      = -0.02811505    
+LKT2    = -7.210284E-09  WKT2     = -1.831002E-08  PKT2     = 1.287798E-14   
+AT      = 30495.79       LAT      = -0.0002066445  WAT      = -0.01016051    
+PAT     = 4.2349E-09     UTE      = -3.073816      LUTE     = 6.325351E-07   
+WUTE    = 8.125732E-07   PUTE     = -2.684927E-13  UA1      = -4.870528E-09  
+LUA1    = 3.184935E-15   WUA1     = 2.680903E-15   PUA1     = -1.039414E-21  
+UB1     = 5.976984E-20   LUB1     = -2.074407E-26  WUB1     = -4.064204E-26  
+PUB1    = 1.69396E-32    UC1      = -4.316739E-10  LUC1     = 3.049616E-16   
+WUC1    = 3.048153E-16   PUC1     = -1.27047E-22   KT1L     = 0              
+PRT     = 0              JS       = 6.27496E-05    JSW      = 1.60291E-10   
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.10          NMOS   (                    LMIN     = '1.4768E-06-dxl5'
+LMAX    = 2.01E-05       WMIN     = '1.99866E-5-dxw5'  WMAX = 0.0002001      
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.7120259'
+LVTH0   = 1.242937E-07   WVTH0    = 5.129949E-08   PVTH0    = -1.357066E-13  
+K1      = 0.8026358      LK1      = -5.9514E-09    K2       = 0.08635022     
+LK2     = 3.13662E-09    K3       = 0              DVT0     = 0              
+DVT1    = 0              DVT2     = 0              DVT0W    = 0              
+DVT1W   = 0              DVT2W    = 0              NLX      = 0              
+W0      = 0              K3B      = 0              VSAT     = 120486.5       
+LVSAT   = -0.04952366    WVSAT    = -0.0005110129  PVSAT    = 1.017798E-08   
+UA      = -2.454454E-10  LUA      = -1.850583E-16  WUA      = 4.599222E-17   
+PUA     = -9.160173E-22  UB       = 2.268603E-18   LUB      = -1.194864E-24  
+WUB     = -5.110249E-25  PUB      = 1.017798E-29   UC       = 6.573998E-11   
+LUC     = -9.326611E-17  WUC      = -1.667719E-17  PUC      = 3.321548E-22   
+RDSW    = 1400           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.04500507     LU0      = 7.295559E-10   
+A0      = 0.7803909      LA0      = 1.261754E-07   WA0      = 7.003621E-07   
+PA0     = -5.088987E-12  KETA     = 0.01423347     LKETA    = -1.386974E-08  
+WKETA   = 1.351519E-07   PKETA    = -3.379531E-14  A1       = 0              
+A2      = 0.99           AGS      = 0.03536087     LAGS     = -1.067713E-07  
+B0      = 0              B1       = 0              VOFF     = -0.2128542     
+LVOFF   = 7.652159E-08   WVOFF    = 8.63945E-07    PVOFF    = -1.224037E-12  
+NFACTOR = 1              CIT      = -0.0005622225  LCIT     = 7.739986E-10   
+WCIT    = 7.200812E-09   PCIT     = -1.051724E-14  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 9.644974E-05   
+LETA0   = 6.349917E-10   WETA0    = 3.591888E-10   PETA0    = -5.088987E-16  
+ETAB    = -6.93665E-06   LETAB    = -6.101215E-11  DSUB     = 0              
+PCLM    = 1.245423       LPCLM    = 6.440455E-07   WPCLM    = 4.789186E-06   
+PPCLM   = -6.785319E-12  PDIBLC1  = 1E-05          PDIBLC2  = 0.0002038292   
+LPDIBLC2= -7.626517E-11  PDIBLCB  = 0.166504       DROUT    = 0              
+PSCBE1  = 2.6391E+08     LPSCBE1  = 205.5621       WPSCBE1  = -34.06823      
+PPSCBE1 = 0.0006785317   PSCBE2   = 7.188053E-06   LPSCBE2  = -3.745412E-12  
+WPSCBE2 = 6.81363E-13    PPSCBE2  = -1.357065E-17  PVAG     = 0.3263032      
+LPVAG   = 6.711337E-07   DELTA    = 0.02           ALPHA0   = 1.7171E-05     
+BETA0   = 38.528         KT1      = -0.4364917     LKT1     = 2.35949E-08    
+KT2     = -0.04976324    LKT2     = -9.305739E-11  AT       = 246848.4       
+LAT     = -0.3355669     UTE      = -1.807614      LUTE     = 3.508199E-07   
+UA1     = -7.77068E-11   LUA1     = 1.857497E-15   WUA1     = 8.468363E-17   
+PUA1    = -3.901561E-21  UB1      = 1E-20          UC1      = 3.277788E-12   
+LUC1    = 1.33885E-16    WUC1     = -3.406835E-17  PUC1     = 6.785315E-22   
+KT1L    = 0              PRT      = 0              JS       = 6.27496E-05    
+JSW     = 1.60291E-10   
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.11          NMOS   (                    LMIN     = '7.768E-07-dxl5'
+LMAX    = '1.4768E-06-dxl5' WMIN  = '1.99866E-5-dxw5' WMAX  = 0.0002001      
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.7765203'
+LVTH0   = 3.291817E-08   WVTH0    = -9.003649E-08  PVTH0    = 6.453816E-14   
+K1      = 0.7632119      LK1      = 4.990441E-08   K2       = 0.106663       
+LK2     = -2.56425E-08   K3       = 0              DVT0     = 0              
+DVT1    = 0              DVT2     = 0              DVT0W    = 0              
+DVT1W   = 0              DVT2W    = 0              NLX      = 0              
+W0      = 0              K3B      = 0              VSAT     = 95292.64       
+LVSAT   = -0.01382896    WVSAT    = 0.01350563     PVSAT    = -9.680849E-09  
+UA      = -1.537738E-10  LUA      = -3.149386E-16  WUA      = -3.948666E-15  
+PUA     = 4.743615E-21   UB       = 1.410646E-18   LUB      = 2.068977E-26   
+WUB     = 1.350565E-23   PUB      = -9.680849E-30  UC       = 3.575822E-11   
+LUC     = -5.078794E-17  WUC      = 4.407524E-16   PUC      = -3.159313E-22  
+RDSW    = 1400           PRWB     = 0              PRWG     = 0              
+WR      = 1              U0       = 0.04100191     LU0      = 6.40123E-09    
+A0      = 1.123611       LA0      = -3.600996E-07  WA0      = -3.347052E-06  
+PA0     = 6.453893E-13   KETA     = 0.02123828     LKETA    = -2.379417E-08  
+WKETA   = 2.252684E-07   PKETA    = -1.614723E-13  A1       = 0              
+A2      = 0.99           AGS      = -0.058432      LAGS     = 2.611446E-08   
+B0      = 0              B1       = 0              VOFF     = -0.2166959     
+LVOFF   = 8.196456E-08   NFACTOR  = 1              CIT      = -0.0004259418  
+LCIT    = 5.80916E-10    WCIT     = -4.501877E-10  PCIT     = 3.226946E-16   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = 0.00028023     LETA0    = 3.746118E-10   WETA0    = -4.555276E-10  
+PETA0   = 6.453911E-16   ETAB     = 0.0001457857   LETAB    = -2.773892E-10  
+DSUB    = 0              PCLM     = 0.959296       LPCLM    = 1.049429E-06   
+WPCLM   = 2.606065E-06   PPCLM    = -3.692274E-12  PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0002012      LPDIBLC2 = -7.254017E-11  PDIBLCB  = 0.2175369      
+LPDIBLCB= -7.230354E-08  DROUT    = 0              PSCBE1   = 4.175145E+08   
+LPSCBE1 = -12.06479      WPSCBE1  = 900.3766       PPSCBE1  = -0.00064539    
+PSCBE2  = 7.476399E-06   LPSCBE2  = -4.153942E-12  WPSCBE2  = -1.800755E-11  
+PPSCBE2 = 1.290781E-17   PVAG     = 1.126812       LPVAG    = -4.630267E-07  
+DELTA   = 0.02           ALPHA0   = 1.7171E-05     BETA0    = 38.528         
+KT1     = -0.3699597     LKT1     = -7.066761E-08  KT2      = -0.04123634    
+LKT2    = -1.217397E-08  AT       = -5360          LAT      = 0.02176205     
+UTE     = -1.359746      LUTE     = -2.837194E-07  WUTE     = -1.138815E-06  
+PUTE    = 1.613473E-12   UA1      = 9.60289E-10    LUA1     = 3.868649E-16   
+WUA1    = -5.402261E-15  PUA1     = 3.87234E-21    UB1      = 1E-20          
+UC1     = 1.357851E-11   LUC1     = 1.192909E-16   WUC1     = 9.003762E-16   
+PUC1    = -6.453898E-22  KT1L     = 0              PRT      = 0              
+JS      = 6.27496E-05    JSW      = 1.60291E-10    
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL nch5.12          NMOS   (                    LMIN     = 5E-07     
+LMAX    = '7.768E-07-dxl5'  WMIN  = '1.99866E-5-dxw5' WMAX  = 0.0002001      
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifn5         RSH      = 81.6           
+RD      = 0              RS       = 0              TOX      = toxn5       
+XJ      = 1E-07          NCH      = 8.521E+16      LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4.5E-08        LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 6E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'  
+DWG     = 0              DWB      = 0              VTH0     = 'dvtn5+0.9030557'
+LVTH0   = -5.778245E-08  WVTH0    = -5.648943E-07  PVTH0    = 4.049162E-13   
+K1      = 0.9096258      LK1      = -5.504504E-08  WK1      = -6.180575E-07  
+PK1     = 4.430237E-13   K2       = 0.1320031      LK2      = -4.380628E-08  
+K3      = 0              DVT0     = 0              DVT1     = 0              
+DVT2    = 0              DVT0W    = 0              DVT1W    = 0              
+DVT2W   = 0              NLX      = 0              W0       = 0              
+K3B     = 0              VSAT     = 78841.66       LVSAT    = -0.002036904   
+WVSAT   = -0.02163158    PVSAT    = 1.550552E-08   UA       = -8.753265E-10  
+LUA     = 2.022703E-16   WUA      = -4.747443E-15  PUA      = 5.316178E-21   
+UB      = 3.439471E-18   LUB      = -1.433572E-24  WUB      = -2.781197E-25  
+PUB     = 1.993567E-31   UC       = 2.202651E-10   LUC      = -1.830425E-16  
+WUC     = -2.472181E-15  PUC      = 1.77206E-21    RDSW     = 1400           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.0326943      LU0      = 1.235612E-08   WU0      = 9.270681E-08   
+PU0     = -6.645223E-14  A0       = 1.623284       LA0      = -7.182648E-07  
+WA0     = -5.845926E-06  PA0      = 2.436582E-12   KETA     = 0.01219548     
+LKETA   = -1.731228E-08  A1       = 0              A2       = 0.99           
+AGS     = -0.08035202    LAGS     = 4.182672E-08   B0       = 0              
+B1      = 0              VOFF     = -0.1089134     LVOFF    = 4.706042E-09   
+NFACTOR = 1              CIT      = 1.857912E-05   LCIT     = 2.622834E-10   
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.003534435   LETA0    = 3.108963E-09   WETA0    = 1.062894E-09   
+PETA0   = -4.430131E-16  ETAB     = 0.0009670691   LETAB    = -8.66085E-10   
+DSUB    = 0              PCLM     = 2.726752       LPCLM    = -2.174828E-07  
+WPCLM   = -6.080822E-06  PPCLM    = 2.534487E-12   PDIBLC1  = 1E-05          
+PDIBLC2 = 0.0001         PDIBLCB  = -0.1611993     LPDIBLCB = 1.991746E-07   
+DROUT   = 0              PSCBE1   = 3.321652E+08   LPSCBE1  = 49.11353       
+PSCBE2  = 1.377405E-06   LPSCBE2  = 2.178177E-13   PVAG     = 1.12112        
+LPVAG   = -4.589467E-07  DELTA    = 0.02           ALPHA0   = 1.7171E-05     
+BETA0   = 38.528         KT1      = -0.5206285     LKT1     = 3.733175E-08   
+KT2     = -0.1228287     LKT2     = 4.631143E-08   AT       = 10488.67       
+LAT     = 0.01040172     WAT      = 0.1236091      PAT      = -8.860297E-08  
+UTE     = -1.532411      LUTE     = -1.599531E-07  WUTE     = -4.484412E-07  
+PUTE    = 1.118613E-12   UA1      = -3.602656E-10  LUA1     = 1.333438E-15   
+WUA1    = 2.472181E-14   PUA1     = -1.772059E-20  UB1      = 1E-20          
+UC1     = 4.87685E-11    LUC1     = 9.406671E-17   WUC1     = 4.017295E-15   
+PUC1    = -2.879597E-21  KT1L     = 0              PRT      = 0              
+JS      = 6.27496E-05    JSW      = 1.60291E-10    
+CJ      = cjn5           CJSW     = cjswn5         CJSWG    = cjswgn5 
+MJ      = 0.3771327      MJSW     = 0.1449861      MJSWG    = 0.1449861
+PB      = 0.8293711      PBSW     = 0.8293711      PBSWG    = 0.8293711
+CTA     = 1.359E-3       CTP      = 1.4553E-3      PTA      = 2.5416E-3
+PTP     = 2.5416E-3      CGDO     = cgon5          CGSO     = cgon5
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
***************************************************************
*                                                             *
*                 5V PMOS DEVICES MODEL                       *  
*                                                             *
***************************************************************
*
.MODEL pch5.1           PMOS   (                    LMIN    = '1.5145E-06-dxl5' 
+LMAX    = 2.01E-5        WMIN     = '1.1804E-06-dxw5' WMAX = '1.99804E-05-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.01743'
+LVTH0   = -6.58148E-08   WVTH0    = -1.028983E-07  PVTH0    = 9.108871E-14   
+K1      = 0.5868915      LK1      = -5.522057E-08  WK1      = 8.656731E-08   
+PK1     = -2.830925E-13  K2       = 0.02409285     LK2      = 7.699812E-09   
+WK2     = -1.609027E-09  PK2      = 8.009042E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 175000         UA       = 3.012839E-09   LUA      = -7.001454E-16  
+WUA     = -1.736934E-15  PUA      = 9.921333E-22   UB       = 2.259061E-19   
+LUB     = 9.282935E-25   WUB      = 1.303256E-26   PUB      = -1.243839E-30  
+UC      = -6.306287E-11  LUC      = -3.62901E-18   WUC      = -6.907448E-17  
+PUC     = 5.156255E-24   RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.02274138     
+LU0     = -5.1246E-09    WU0      = -9.820416E-09  PU0      = 2.399724E-15   
+A0      = 0.6885419      LA0      = -3.563784E-08  WA0      = 4.127144E-08   
+PA0     = 6.784013E-13   KETA     = 0.008611895    LKETA    = -8.354743E-09  
+WKETA   = 5.76849E-09    PKETA    = 1.256345E-14   A1       = 0              
+A2      = 0.4120113      LA2      = -1.75906E-08   WA2      = -2.408324E-07  
+PA2     = 3.52699E-13    AGS      = 0.02133021     WAGS     = -2.66713E-08   
+B0      = 0              B1       = 0              VOFF     = -0.1507676     
+LVOFF   = 1.367832E-08   WVOFF    = -8.865081E-08  PVOFF    = 4.373965E-14   
+NFACTOR = 2.564515       LNFACTOR = -1.871363E-06  WNFACTOR = -1.866307E-06  
+PNFACTOR= 3.123807E-12   CIT      = -0.0004320731  LCIT     = 6.894969E-11   
+WCIT    = 2.197202E-09   PCIT     = -1.987243E-15  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = 0.0003150895   
+LETA0   = 1.303525E-09   WETA0    = -2.868963E-10  PETA0    = 7.953889E-16   
+ETAB    = -7.177569E-23  LETAB    = 1.051154E-28   WETAB    = 1.439132E-27   
+PETAB   = -2.107609E-33  DSUB     = 0              PCLM     = 2.72689        
+LPCLM   = 8.868492E-07   WPCLM    = -1.027345E-07  PPCLM    = 1.650042E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = 5E-05          PDIBLCB  = 0.1538261      
+LPDIBLCB= 2.531067E-07   WPDIBLCB = 1.585232E-08   PPDIBLCB = -3.164845E-13  
+DROUT   = 0              PSCBE1   = 3.983654E+08   LPSCBE1  = 148.8438       
+WPSCBE1 = -79.16951      PPSCBE1  = 0.0001159437   PSCBE2   = 4.129196E-06   
+LPSCBE2 = -1.892077E-13  WPSCBE2  = -2.590438E-12  PPSCBE2  = 3.793697E-18   
+PVAG    = 0              DELTA    = 0.01030478     LDELTA   = -4.463555E-10  
+WDELTA  = -6.111046E-09  PDELTA   = 8.949626E-15   ALPHA0   = 1.5E-06        
+BETA0   = 38.1           KT1      = -0.5452737     LKT1     = -7.328091E-08  
+WKT1    = 2.313836E-08   PKT1     = 5.078059E-14   KT2      = -0.0589422     
+LKT2    = 4.147233E-08   WKT2     = -3.060147E-09  PKT2     = -4.473898E-14  
+AT      = 4644.425       LAT      = -0.006757243   WAT      = -0.0006145891  
+PAT     = 5.880231E-09   UTE      = -1.423584      LUTE     = -4.47635E-07   
+WUTE    = 5.004158E-07   PUTE     = 4.194145E-13   UA1      = -6.598179E-10  
+LUA1    = -1.097188E-15  WUA1     = 3.344704E-15   PUA1     = -8.165371E-22  
+UB1     = -1.147026E-18  LUB1     = -2.014639E-24  WUB1     = -3.465708E-24  
+PUB1    = 4.317704E-30   UC1      = -5.10609E-11   LUC1     = -1.794797E-17  
+WUC1    = -4.40652E-17   PUC1     = 1.031208E-22   KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 2.42572E-11    
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.2           PMOS   (                    LMIN     = '8.145E-07-dxl5' 
+LMAX    = '1.5145E-06-dxl5' WMIN  = '1.1804E-06-dxw5' WMAX = '1.99804E-05-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.065191'
+LVTH0   = 4.131871E-09   WVTH0    = -2.637065E-08  PVTH0    = -2.098608E-14  
+K1      = 0.5679547      LK1      = -2.748778E-08  WK1      = -4.416883E-07  
+PK1     = 4.905379E-13   K2       = 0.02415008     LK2      = 7.616014E-09   
+WK2     = 1.525662E-07   PK2      = -1.456992E-13  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 169539.3       LVSAT    = 0.007997217    UA       = 2.836888E-09   
+LUA     = -4.424651E-16  WUA      = -2.050503E-15  PUA      = 1.451355E-21   
+UB      = 5.677195E-19   LUB      = 4.277076E-25   WUB      = -7.120744E-25  
+PUB     = -1.819195E-31  UC       = -7.428062E-11  LUC      = 1.279936E-17   
+WUC     = -1.21928E-16   PUC      = 8.256031E-23   RDSW     = 1200           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.02205643     LU0      = -4.121497E-09  WU0      = -1.109931E-08  
+PU0     = 4.272668E-15   A0       = 0.3312353      LA0      = 4.876377E-07   
+WA0     = 1.277385E-06   PA0      = -1.131888E-12  KETA     = 0.001164958    
+LKETA   = 2.551297E-09   WKETA    = 2.844879E-08   PKETA    = -2.065185E-14  
+A1      = 0              A2       = 0.4            AGS      = 0.06617814     
+LAGS    = -6.567981E-08  WAGS     = -4.997438E-08  PAGS     = 3.412738E-14   
+B0      = 0              B1       = 0              VOFF     = -0.1471531     
+LVOFF   = 8.384814E-09   WVOFF    = -2.030862E-08  PVOFF    = -5.634749E-14  
+NFACTOR = 1.352073       LNFACTOR = -9.574182E-08  WNFACTOR = -1.044086E-06  
+PNFACTOR= 1.919665E-12   CIT      = -0.0004427892  LCIT     = 8.464354E-11   
+WCIT    = 1.087327E-09   PCIT     = -3.618311E-16  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.0004445641  
+LETA0   = 2.416038E-09   WETA0    = 1.554751E-09   PETA0    = -1.901703E-15  
+ETAB    = 0.0005404234   LETAB    = -7.914502E-10  WETAB    = -6.531976E-10  
+PETAB   = 9.56608E-16    DSUB     = 0              PCLM     = 3.649409       
+LPCLM   = -4.641794E-07  WPCLM    = -1.929068E-07  PPCLM    = 2.970617E-13   
+PDIBLC1 = 1E-05          PDIBLC2  = 5E-05          PDIBLCB  = 0.3948266      
+LPDIBLCB= -9.983864E-08  WPDIBLCB = -4.905593E-07  PPDIBLCB = 4.251554E-13   
+DROUT   = 0              PSCBE1   = 4.808313E+08   LPSCBE1  = 28.07252       
+WPSCBE1 = 0.9510477      PPSCBE1  = -1.392807E-06  PSCBE2   = 5.091391E-06   
+LPSCBE2 = -1.598342E-12  WPSCBE2  = -2.039021E-13  PPSCBE2  = 2.986148E-19   
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 1.5E-06        
+BETA0   = 38.1           KT1      = -0.651789      LKT1     = 8.271075E-08   
+WKT1    = 1.296754E-07   PKT1     = -1.052429E-13  KT2      = -0.03489918    
+LKT2    = 6.261347E-09   WKT2     = -3.284913E-08  PKT2     = -1.113014E-15  
+AT      = -2256.74       LAT      = 0.003349516    WAT      = 0.009842439    
+PAT     = -9.434088E-09  UTE      = -1.843992      LUTE     = 1.680518E-07   
+WUTE    = 7.664132E-07   PUTE     = 2.986133E-14   UA1      = -1.855336E-09  
+LUA1    = 6.536486E-16   WUA1     = 3.633999E-15   PUA1     = -1.24021E-21   
+UB1     = -2.313158E-18  LUB1     = -3.068375E-25  WUB1     = -2.495357E-24  
+PUB1    = 2.896625E-30   UC1      = -2.869531E-11  LUC1     = -5.070237E-17  
+WUC1    = 4.403499E-18   PUC1     = 3.213845E-23   KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 2.42572E-11    
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.3           PMOS   (                    LMIN     = 5E-07      
+LMAX    = '8.145E-07-dxl5' WMIN   = '1.1804E-06-dxw5' WMAX = '1.99804E-05-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.091464'
+LVTH0   = 2.421732E-08   WVTH0    = -8.679404E-08  PVTH0    = 2.520761E-14   
+K1      = 0.4638654      LK1      = 5.208846E-08   WK1      = 6.023579E-07   
+PK1     = -3.076354E-13  K2       = 0.04872319     LK2      = -1.117013E-08  
+WK2     = -1.246207E-07  PK2      = 6.62102E-14    K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 179485.1       LVSAT    = 0.0003936442   WVSAT    = 0.01032402     
+PVSAT   = -7.89271E-09   UA       = 2.030989E-09   LUA      = 1.736449E-16   
+WUA     = 1.350387E-15   PUA      = -1.148626E-21  UB       = 9.130971E-19   
+LUB     = 1.636665E-25   WUB      = -1.399626E-24  PUB      = 3.437136E-31   
+UC      = -6.625377E-11  LUC      = 6.662843E-18   WUC      = 8.841018E-17   
+PUC     = -7.824326E-23  RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01828747     
+LU0     = -1.240127E-09  WU0      = -2.575862E-09  PU0      = -2.24351E-15   
+A0      = 0.4159315      LA0      = 4.228875E-07   WA0      = -7.724485E-07  
+PA0     = 4.352104E-13   KETA     = 0.01095301     LKETA    = -4.931666E-09  
+WKETA   = -3.126646E-08  PKETA    = 2.500046E-14   A1       = 0              
+A2      = 0.4758901      LA2      = -5.801796E-08  WA2      = 1.858323E-07   
+PA2     = -1.420688E-13  AGS      = -0.01932203    LAGS     = -3.149152E-10  
+WAGS    = -1.359347E-08  PAGS     = 6.314169E-15   B0       = 0              
+B1      = 0              VOFF     = -0.1262129     LVOFF    = -7.623908E-09  
+WVOFF   = 5.473556E-09   PVOFF    = -7.605796E-14  NFACTOR  = 1.62955        
+LNFACTOR= -3.078729E-07  WNFACTOR = 2.705804E-06   PNFACTOR = -9.471254E-13  
+CIT     = -0.0004200856  LCIT     = 6.728657E-11   WCIT     = 1.110909E-09   
+PCIT    = -3.79859E-16   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.002021108   LETA0    = 3.621305E-09   
+WETA0   = -2.314012E-09  PETA0    = 1.055966E-15   ETAB     = 2.765247E-05   
+LETAB   = -3.994368E-10  WETAB    = 6.202276E-10   PETAB    = -1.692563E-17  
+DSUB    = 0              PCLM     = 3.787691       LPCLM    = -5.69896E-07   
+WPCLM   = 8.412852E-08   PPCLM    = 8.52682E-14    PDIBLC1  = 9.967614E-06   
+LPDIBLC1= 2.475819E-14   WPDIBLC1 = 6.493273E-13   PPDIBLC1 = -4.964107E-19  
+PDIBLC2 = 4.887538E-05   LPDIBLC2 = 8.597742E-13   WPDIBLC2 = 2.254911E-11   
+PPDIBLC2= -1.72388E-17   PDIBLCB  = 0.3289984      LPDIBLCB = -4.951296E-08  
+WPDIBLCB= -1.53872E-08   PPDIBLCB = 6.188629E-14   DROUT    = 0              
+PSCBE1  = 6.8578E+08     LPSCBE1  = -128.6108      WPSCBE1  = -90.69588      
+PPSCBE1 = 6.867127E-05   PSCBE2   = 6.745792E-06   LPSCBE2  = -2.863132E-12  
+WPSCBE2 = -2.105688E-13  PPSCBE2  = 3.037114E-19   PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 1.5E-06        BETA0    = 38.1           
+KT1     = -0.438899      LKT1     = -8.004362E-08  WKT1     = -1.830154E-07  
+PKT1    = 1.338093E-13   KT2      = -0.0196842     LKT2     = -5.370511E-09  
+WKT2    = -7.022525E-08  PKT2     = 2.746103E-14   AT       = 1798.382       
+LAT     = 0.0002493745   WAT      = -0.007444003   PAT      = 3.781397E-09   
+UTE     = -0.8807635     LUTE     = -5.683361E-07  WUTE     = -5.864107E-07  
+PUTE    = 1.064095E-12   UA1      = 2.858233E-09   LUA1     = -2.949875E-15  
+WUA1    = -7.055729E-15  PUA1     = 6.932087E-21   UB1      = -4.434422E-18  
+LUB1    = 1.314869E-24   WUB1     = 1.03217E-23    PUB1     = -6.902017E-30  
+UC1     = -1.412041E-10  LUC1     = 3.531059E-17   WUC1     = 1.715727E-16   
+PUC1    = -9.566242E-23  KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 2.42572E-11    
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.4           PMOS   (                    LMIN     = '1.5145E-06-dxl5'
+LMAX    = 2.01E-05       WMIN     = '7.804E-07-dxw5'  WMAX  = '1.1804E-06-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.103757'
+LVTH0   = 1.779547E-08   WVTH0    = 5.044761E-09   PVTH0    = -1.345756E-14  
+K1      = 0.7060764      LK1      = -1.036255E-06  WK1      = -6.246133E-08  
+PK1     = 9.435926E-13   K2       = 0.03507507     LK2      = 2.215405E-07   
+WK2     = -1.534122E-08  PK2      = -1.87296E-13   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 188154.5       LVSAT    = -0.05040003    WVSAT    = -0.01644837    
+PVSAT   = 6.302018E-08   UA       = 2.627049E-09   LUA      = -8.546864E-16  
+WUA     = -1.254542E-15  PUA      = 1.185371E-21   UB       = 6.720354E-20   
+LUB     = 1.267025E-25   WUB      = 2.114743E-25   PUB      = -2.415296E-31  
+UC      = -2.931487E-11  LUC      = -1.080733E-16  WUC      = -1.11273E-16   
+PUC     = 1.357534E-22   RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01917714     
+LU0     = -9.664369E-09  WU0      = -5.363688E-09  PU0      = 8.076249E-15   
+A0      = 0.7336237      LA0      = 1.084121E-06   WA0      = -1.509902E-08  
+PA0     = -7.217449E-13  KETA     = -0.01447329    LKETA    = 4.433056E-08   
+WKETA   = 3.463419E-08   PKETA    = -5.331424E-14  A1       = 0              
+A2      = -0.1695826     LA2      = 9.275596E-07   WA2      = 4.863926E-07   
+PA2     = -8.291167E-13  AGS      = 1.682995E-21   LAGS     = -3.360001E-26  
+WAGS    = -2.104412E-27  PAGS     = 4.201345E-32   B0       = 0              
+B1      = 0              VOFF     = -0.1852838     LVOFF    = 4.752185E-08   
+WVOFF   = -4.54918E-08   PVOFF    = 1.421695E-15   NFACTOR  = 1.238119       
+LNFACTOR= 1.910709E-06   WNFACTOR = -2.077819E-07  PNFACTOR = -1.605295E-12  
+CIT     = 0.0006043693   LCIT     = -2.770646E-09  WCIT     = 9.012352E-10   
+PCIT    = 1.563386E-15   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 1.138794E-05   LETA0    = 1.86711E-09    
+WETA0   = 9.285205E-11   PETA0    = 9.068177E-17   ETAB     = 3.373461E-21   
+LETAB   = -4.940434E-27  WETAB    = -2.868791E-27  PETAB    = 4.201345E-33   
+DSUB    = 0              PCLM     = 2.181893       LPCLM    = 1.678933E-06   
+WPCLM   = 5.7873E-07     PPCLM    = -8.254174E-13  PDIBLC1  = 1.025245E-05   
+LPDIBLC1= -5.040004E-12  WPDIBLC1 = -3.156616E-13  PPDIBLC1 = 6.30202E-18    
+PDIBLC2 = 5.08415E-05    LPDIBLC2 = -1.680001E-11  WPDIBLC2 = -1.052205E-12  
+PPDIBLC2= 2.100673E-17   PDIBLCB  = 0.1665117      LPDIBLCB = -1.548601E-10  
+WPDIBLCB= -9.699071E-12  PPDIBLCB = 1.93637E-16    DROUT    = 0              
+PSCBE1  = 1.998263E+08   LPSCBE1  = 439.6042       WPSCBE1  = 169.0837       
+PPSCBE1 = -0.000247623   PSCBE2   = -2.13955E-06   LPSCBE2  = 1.023678E-11   
+WPSCBE2 = 5.248001E-12   PPSCBE2  = -9.242961E-18  PVAG     = 0              
+DELTA   = -0.003594867   LDELTA   = 6.404751E-09   WDELTA   = 1.126908E-08   
+PDELTA  = 3.830013E-16   ALPHA0   = 1.5E-06        BETA0    = 38.1           
+KT1     = -0.4606366     LKT1     = 2.002754E-07   WKT1     = -8.26919E-08   
+PKT1    = -2.912742E-13  KT2      = -0.144904      LKT2     = 3.022708E-08   
+WKT2    = 1.044265E-07   PKT2     = -3.067791E-14  AT       = 6797.024       
+LAT     = -0.006456166   WAT      = -0.003306198   PAT      = 5.503763E-09   
+UTE     = -0.6266242     LUTE     = -3.507708E-07  WUTE     = -4.961028E-07  
+PUTE    = 2.982954E-13   UA1      = 4.228125E-09   LUA1     = -3.30007E-15   
+WUA1    = -2.76718E-15   PUA1     = 1.937947E-21   UB1      = -6.399666E-18  
+LUB1    = 2.677785E-24   WUB1     = 3.102192E-24   PUB1     = -1.549702E-30  
+UC1     = -1.781346E-10  LUC1     = 2.693236E-16   WUC1     = 1.148277E-16   
+PUC1    = -2.560835E-22  KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 2.42572E-11    
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.5           PMOS   (                    LMIN     = '8.145E-07-dxl5'
+LMAX    = '1.5145E-06-dxl5' WMIN  = '7.804E-07-dxw5' WMAX   = '1.1804E-06-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.046213'
+LVTH0   = -6.647712E-08  WVTH0    = -5.0101E-08    PVTH0    = 6.73034E-14    
+K1      = -0.9877297     LK1      = 1.444324E-06   WK1      = 1.503539E-06   
+PK1     = -1.349815E-12  K2       = 0.4822159      LK2      = -4.332972E-07  
+WK2     = -4.201993E-07  PK2      = 4.056186E-13   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 113450.8       LVSAT    = 0.05900348     WVSAT    = 0.07013301     
+PVSAT   = -6.377823E-08  UA       = 8.304542E-10   LUA      = 1.776426E-15   
+WUA     = 4.583419E-16   PUA      = -1.323147E-21  UB       = -7.170376E-19  
+LUB     = 1.275224E-24   WUB      = 8.943859E-25   PUB      = -1.241654E-30  
+UC      = -2.1953E-10    LUC      = 1.704967E-16   WUC      = 5.969175E-17   
+PUC     = -1.146245E-22  RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01147307     
+LU0     = 1.61824E-09    WU0      = 2.134126E-09   PU0      = -2.904299E-15  
+A0      = 2.936364       LA0      = -2.141791E-06  WA0      = -1.980067E-06  
+PA0     = 2.15595E-12    KETA     = 0.03570177     LKETA    = -2.915083E-08  
+WKETA   = -1.473604E-08  PKETA    = 1.898848E-14   A1       = 0              
+A2      = 0.533437       LA2      = -1.020125E-07  WA2      = -1.668495E-07  
+PA2     = 1.275565E-13   AGS      = 0.03549903     LAGS     = -5.198832E-08  
+WAGS    = -1.16132E-08   PAGS     = 1.700753E-14   B0       = 0              
+B1      = 0              VOFF     = -0.09613537    LVOFF    = -8.303599E-08  
+WVOFF   = -8.410113E-08  PVOFF    = 5.796507E-14   NFACTOR  = -0.4545338     
+LNFACTOR= 4.3896E-06     WNFACTOR = 1.214895E-06   PNFACTOR = -3.688806E-12  
+CIT     = -0.002083016   LCIT     = 1.16503E-09    WCIT     = 3.138267E-09   
+PCIT    = -1.712746E-15  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.003446544    LETA0    = -3.163676E-09  
+WETA0   = -3.31069E-09   PETA0    = 5.07517E-15    ETAB     = -0.001827905   
+LETAB   = 2.676968E-09   WETAB    = 2.308161E-09   PETAB    = -3.380302E-15  
+DSUB    = 0              PCLM     = 2.108815       LPCLM    = 1.785955E-06   
+WPCLM   = 1.733451E-06   PPCLM    = -2.516506E-12  PDIBLC1  = 3.328151E-06   
+LPDIBLC1= 5.100628E-12   WPDIBLC1 = 8.342479E-12   PPDIBLC1 = -6.377825E-18  
+PDIBLC2 = 2.77605E-05    LPDIBLC2 = 1.700209E-11   WPDIBLC2 = 2.780826E-11   
+PPDIBLC2= -2.125942E-17  PDIBLCB  = 0.002299662    LPDIBLCB = 2.403336E-07   
+WPDIBLCB= 2.563326E-10   PPDIBLCB = -1.959662E-16  DROUT    = 0              
+PSCBE1  = 4.769574E+08   LPSCBE1  = 33.74586       WPSCBE1  = 5.794987       
+PPSCBE1 = -8.486756E-06  PSCBE2   = 6.700817E-06   LPSCBE2  = -2.709934E-12  
+WPSCBE2 = -2.216328E-12  PPSCBE2  = 1.68855E-18    PVAG     = 0              
+DELTA   = -0.009292756   LDELTA   = 1.474931E-08   WDELTA   = 2.412366E-08   
+PDELTA  = -1.844254E-14  ALPHA0   = 1.5E-06        BETA0    = 38.1           
+KT1     = -0.165207      LKT1     = -2.323812E-07  WKT1     = -4.787468E-07  
+PKT1    = 2.887481E-13   KT2      = -0.1231909     LKT2     = -1.571814E-09  
+WKT2    = 7.755077E-08   PKT2     = 8.681571E-15   AT       = 9207.46        
+LAT     = -0.009986251   WAT      = -0.004492399   PAT      = 7.240955E-09   
+UTE     = -0.5560366     LUTE     = -4.541463E-07  WUTE     = -8.440457E-07  
+PUTE    = 8.078578E-13   UA1      = 5.768875E-09   LUA1     = -5.556499E-15  
+WUA1    = -5.899314E-15  PUA1     = 6.524959E-21   UB1      = -1.098957E-17  
+LUB1    = 9.3997E-24     WUB1     = 8.353628E-24   PUB1     = -9.240429E-30  
+UC1     = 4.340329E-11   LUC1     = -5.511853E-17  WUC1     = -8.574859E-17  
+PUC1    = 3.766042E-23   KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 2.42572E-11    
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.6           PMOS   (                    LMIN     = 5E-07      
+LMAX    = '8.145E-07-dxl5' WMIN   = '7.804E-07-dxw5' WMAX   = '1.1804E-06-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.213369'
+LVTH0   = 6.131354E-08   WVTH0    = 6.563595E-08   PVTH0    = -2.117749E-14  
+K1      = 1.495269       LK1      = -4.539285E-07  WK1      = -6.873088E-07  
+PK1     = 3.250882E-13   K2       = -0.2729335     LK2      = 1.440145E-07   
+WK2     = 2.775787E-07   PK2      = -1.278326E-13  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 99618.88       LVSAT    = 0.06957798     WVSAT    = 0.1101887      
+PVSAT   = -9.440079E-08  UA       = 6.490906E-09   LUA      = -2.550989E-15  
+WUA     = -4.226292E-15  PUA      = 2.258255E-21   UB       = 1.549105E-19   
+LUB     = 6.086194E-25   WUB      = -4.515895E-25  PUB      = -2.126554E-31  
+UC      = 6.630156E-11   LUC      = -4.802149E-17  WUC      = -7.733701E-17  
+PUC     = -9.865972E-24  RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.02423079     
+LU0     = -8.135038E-09  WU0      = -1.000738E-08  PU0      = 6.377885E-15   
+A0      = -2.536917      LA0      = 2.042532E-06   WA0      = 2.919793E-06   
+PA0     = -1.589993E-12  KETA     = -0.05848336    LKETA    = 4.285371E-08   
+WKETA   = 5.555676E-08   PKETA    = -3.475036E-14  A1       = 0              
+A2      = 1.101813       LA2      = -5.365363E-07  WA2      = -5.968221E-07  
+PA2     = 4.562705E-13   AGS      = -0.05186437    LAGS     = 1.4801E-08     
+WAGS    = 2.709746E-08   PAGS     = -1.258677E-14  B0       = 0              
+B1      = 0              VOFF     = 0.248173       LVOFF    = -3.462598E-07  
+WVOFF   = -4.626586E-07  PVOFF    = 3.473723E-13   NFACTOR  = 9.505318       
+LNFACTOR= -3.224707E-06  WNFACTOR = -7.142056E-06  PNFACTOR = 2.700083E-12   
+CIT     = -0.000525524   LCIT     = -2.567271E-11  WCIT     = 1.242749E-09   
+PCIT    = -2.636227E-16  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.01178137    LETA0    = 8.478067E-09   
+WETA0   = 9.890224E-09   PETA0    = -5.01693E-15   ETAB     = 0.002543567    
+LETAB   = -6.650236E-10  WETAB    = -2.525672E-09  PETAB    = 3.15164E-16    
+DSUB    = 0              PCLM     = 6.942001       LPCLM    = -1.909015E-06  
+WPCLM   = -3.860021E-06  PPCLM    = 1.759703E-12   PDIBLC1  = 1.152208E-05   
+LPDIBLC1= -1.163633E-12  WPDIBLC1 = -1.29438E-12   PPDIBLC1 = 9.895537E-19   
+PDIBLC2 = 0.0001028572   LPDIBLC2 = -4.040936E-11  WPDIBLC2 = -4.494981E-11  
+PPDIBLC2= 3.436412E-17   PDIBLCB  = 0.3167475      LPDIBLCB = -6.175458E-11  
+WPDIBLCB= -6.86934E-11   PPDIBLCB = 5.25161E-17    DROUT    = 0              
+PSCBE1  = 7.38258E+08    LPSCBE1  = -166.0185      WPSCBE1  = -156.3144      
+PPSCBE1 = 0.0001154459   PSCBE2   = 8.84908E-06    LPSCBE2  = -4.352281E-12  
+WPSCBE2 = -2.840519E-12  PPSCBE2  = 2.165743E-18   PVAG     = 0              
+DELTA   = 0.01           ALPHA0   = 1.5E-06        BETA0    = 38.1           
+KT1     = -0.5926163     LKT1     = 9.437314E-08   WKT1     = 9.192481E-09   
+PKT1    = -8.42814E-14   KT2      = -0.2266637     LKT2     = 7.753317E-08   
+WKT2    = 1.885819E-07   PKT2     = -7.620172E-14  AT       = -17240.28      
+LAT     = 0.01023304     WAT      = 0.01636193     PAT      = -8.702179E-09  
+UTE     = -2.667988      LUTE     = 1.16044E-06    WUTE     = 1.648334E-06   
+PUTE    = -1.097567E-12  UA1      = -1.541431E-08  LUA1     = 1.063804E-14   
+WUA1    = 1.579226E-14   PUA1     = -1.005825E-20  UB1      = 2.266154E-17   
+LUB1    = -1.632658E-23  WUB1     = -2.355909E-23  PUB1     = 1.515684E-29   
+UC1     = 2.79781E-10    LUC1     = -2.358293E-16  WUC1     = -3.548269E-16  
+PUC1    = 2.433708E-22   KT1L     = 0              PRT      = 0              
+JS      = 0.0001         JSW      = 2.42572E-11   
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1         )
*
*
.MODEL pch5.7           PMOS   (                    LMIN     = '1.5145E-06-dxl5'
+LMAX    = 2.01E-05       WMIN     = 4E-07          WMAX     = '7.804E-07-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.072314'
+LVTH0   = -3.539007E-08  WVTH0    = -2.169438E-08  PVTH0    = 3.177143E-14   
+K1      = 0.8312609      LK1      = -2.175675E-07  WK1      = -1.689184E-07  
+PK1     = 2.473809E-13   K2       = -0.1059928     LK2      = 1.814702E-07   
+WK2     = 1.046229E-07   PK2      = -1.532202E-13  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 162736.9       LVSAT    = 0.03260433     WVSAT    = 0.00516676     
+PVSAT   = -7.56672E-09   UA       = 1.056216E-09   LUA      = 8.916792E-16   
+WUA     = 8.129451E-17   PUA      = -2.99738E-22   UB       = 3.957386E-19   
+LUB     = -1.555744E-25  WUB      = -6.791188E-26  PUB      = -1.48132E-33   
+UC      = -2.419266E-10  LUC      = 2.119447E-16   WUC      = 6.953203E-17   
+PUC     = -1.363899E-22  RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01261288     
+LU0     = 2.090131E-10   WU0      = 2.185545E-10   PU0      = -3.200731E-16  
+A0      = 0.2478382      LA0      = 9.208392E-07   WA0      = 3.98013E-07    
+PA0     = -5.828901E-13  KETA     = 0.03941834     LKETA    = -3.764223E-08  
+WKETA   = -1.119524E-08  PKETA    = 1.639542E-14   A1       = 0              
+A2      = 0.4874344      LA2      = -1.719827E-07  WA2      = -7.233463E-08  
+PA2     = 1.059341E-13   AGS      = -1.294299E-20  LAGS     = 3.36E-26       
+WAGS    = 1.033352E-26   PAGS     = -1.513344E-32  B0       = 0              
+B1      = 0              VOFF     = -0.2280561     LVOFF    = 3.349093E-08   
+WVOFF   = -9.118196E-09  PVOFF    = 1.33536E-14    NFACTOR  = -0.2363183     
+LNFACTOR= 1.824501E-06   WNFACTOR = 1.04608E-06    PNFACTOR = -1.531984E-12  
+CIT     = 0.001728264    LCIT     = -1.026132E-09  WCIT     = -5.452505E-11  
+PCIT    = 7.985197E-17   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.0001512361   LETA0    = 2.615693E-09   
+WETA0   = -2.607477E-11  PETA0    = -5.459134E-16  ETAB     = 0              
+DSUB    = 0              PCLM     = 3.29804        LPCLM    = 7.03623E-08    
+WPCLM   = -3.704412E-07  PPCLM    = 5.425111E-13   PDIBLC1  = 9.881256E-06   
+LPDIBLC1= 2.37065E-12    PDIBLC2  = 4.960419E-05   LPDIBLC2 = 7.902168E-12   
+PDIBLCB = 0.5711502      LPDIBLCB = -5.92537E-07   WPDIBLCB = -3.441143E-07  
+PPDIBLCB= 5.039554E-13   DROUT    = 0              PSCBE1   = 4.000485E+08   
+LPSCBE1 = 146.3789       WPSCBE1  = -1.185225      PPSCBE1  = 1.735769E-06   
+PSCBE2  = 4.031665E-06   LPSCBE2  = -6.321734E-13  PVAG     = 0              
+DELTA   = 0.009656633    LDELTA   = 6.855129E-09   ALPHA0   = 1.5E-06        
+BETA0   = 38.1           KT1      = -0.5663813     LKT1     = -1.29782E-07   
+WKT1    = 7.233437E-09   PKT1     = -1.059336E-14  KT2      = -0.01846169    
+LKT2    = -1.118631E-08  WKT2     = -3.100057E-09  PKT2     = 4.540033E-15   
+AT      = 3662.593       LAT      = -0.001087527   WAT      = -0.0006406783  
+PAT     = 9.382732E-10   UTE      = -0.4930697     LUTE     = -1.049945E-06  
+WUTE    = -6.096776E-07  PUTE     = 8.928728E-13   UA1      = 4.234363E-09   
+LUA1    = -5.795784E-15  WUA1     = -2.772484E-15  PUA1     = 4.060302E-21   
+UB1     = -4.954291E-18  LUB1     = 4.081095E-24   WUB1     = 1.873046E-24   
+PUB1    = -2.743076E-30  UC1      = -5.307838E-11  LUC1     = -1.720587E-17  
+WUC1    = 8.479915E-18   PUC1     = -1.241883E-23  KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 2.42572E-11   
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.8           PMOS   (                    LMIN     = '8.145E-07-dxl5'
+LMAX    = '1.5145E-06-dxl5' WMIN  = 4E-07          WMAX     = '7.804E-07-dxw5' 
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.064657'
+LVTH0   = -4.66039E-08   WVTH0    = -3.441667E-08  PVTH0    = 5.040321E-14   
+K1      = 0.7622073      LK1      = -1.164385E-07  WK1      = 1.539287E-08   
+PK1     = -2.254286E-14  K2       = 0.0166437      LK2      = 1.869144E-09   
+WK2     = -2.427664E-08  PK2      = 3.555314E-14   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 211262.6       LVSAT    = -0.03846158    WVSAT    = -0.01304613    
+PVSAT   = 1.910606E-08   UA       = 1.285739E-09   LUA      = 5.555428E-16   
+WUA     = 7.116781E-17   PUA      = -2.849074E-22  UB       = 4.622625E-19   
+LUB     = -2.529987E-25  WUB      = -1.08491E-25   PUB      = 5.79468E-32    
+UC      = -9.712279E-11  LUC      = -1.204112E-19  WUC      = -4.440331E-17  
+PUC     = 3.046834E-23   RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01418713     
+LU0     = -2.096477E-09  WU0      = -1.739138E-10  PU0      = 2.546967E-16   
+A0      = 0.886176       LA0      = -1.400649E-08  WA0      = -2.365873E-07  
+PA0     = 3.464821E-13   KETA     = 0.03189491     LKETA    = -2.662419E-08  
+WKETA   = -1.149869E-08  PKETA    = 1.683983E-14   A1       = 0              
+A2      = 0.1527727      LA2      = 3.181293E-07   WA2      = 1.568673E-07   
+PA2     = -2.297322E-13  AGS      = 0.02163085     LAGS     = -3.167838E-08  
+WAGS    = 1.802946E-10   PAGS     = -2.640401E-16  B0       = 0              
+B1      = 0              VOFF     = -0.1474396     LVOFF    = -8.457191E-08  
+WVOFF   = -4.047198E-08  PVOFF    = 5.927121E-14   NFACTOR  = 1.188145       
+LNFACTOR= -2.616256E-07  WNFACTOR = -1.820393E-07  PNFACTOR = 2.665965E-13   
+CIT     = 0.001317423    LCIT     = -4.24455E-10   WCIT     = 2.465334E-10   
+PCIT    = -3.610481E-16  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.001499284    LETA0    = 6.414783E-10   
+WETA0   = -1.65474E-09   PETA0    = 1.839267E-15   ETAB     = 0.001884275    
+LETAB   = -2.759521E-09  WETAB    = -8.486774E-10  PETAB    = 1.242888E-15   
+DSUB    = 0              PCLM     = 5.16654        LPCLM    = -2.666057E-06  
+WPCLM   = -8.668382E-07  PPCLM    = 1.269485E-12   PDIBLC1  = 1.412202E-05   
+LPDIBLC1= -3.839946E-12  WPDIBLC1 = -8.366262E-13  PPDIBLC1 = 1.225239E-18   
+PDIBLC2 = 6.046072E-05   LPDIBLC2 = -7.99722E-12   PDIBLCB  = 0.002601096    
+LPDIBLCB= 2.401032E-07   DROUT    = 0              PSCBE1   = 4.304707E+08   
+LPSCBE1 = 101.8257       WPSCBE1  = 45.32733       PPSCBE1  = -6.638188E-05  
+PSCBE2  = 2.437961E-06   LPSCBE2  = 1.701805E-12   WPSCBE2  = 1.408804E-12   
+PPSCBE2 = -2.063194E-18  PVAG     = 0              DELTA    = 0.02510046     
+LDELTA  = -1.576236E-08  WDELTA   = -5.124331E-09  PDELTA   = 7.504583E-15   
+ALPHA0  = 1.5E-06        BETA0    = 38.1           KT1      = -0.6983992     
+LKT1    = 6.355823E-08   WKT1     = -2.532004E-08  PKT1     = 3.70812E-14    
+KT2     = -0.03616643    LKT2     = 1.474229E-08   WKT2     = 3.5452E-09     
+PKT2    = -5.191946E-15  AT       = 2731.911       LAT      = 0.0002754563   
+WAT     = 0.001014408    PAT      = -1.485601E-09  UTE      = -1.758852      
+LUTE    = 8.03794E-07    WUTE     = 1.788287E-07   PUTE     = -2.618947E-13  
+UA1     = -2.61319E-09   LUA1     = 4.232455E-15   WUA1     = 1.228794E-15   
+PUA1    = -1.799569E-21  UB1      = 1.077108E-18   LUB1     = -4.75189E-24   
+WUB1    = -1.907875E-24  PUB1     = 2.794084E-30   UC1      = -5.846294E-11  
+LUC1    = -9.320186E-18  WUC1     = 8.784586E-19   PUC1     = -1.286503E-24  
+KT1L    = 0              PRT      = 0              JS       = 0.0001         
+JSW     = 2.42572E-11    
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.9           PMOS   (                    LMIN     = 5E-07      
+LMAX    = '8.145E-07-dxl5' WMIN   = 4E-07          WMAX     = '7.804E-07-dxw5'
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.279173'
+LVTH0   = 1.173942E-07   WVTH0    = 1.21596E-07    PVTH0    = -6.886849E-14  
+K1      = 0.8093314      LK1      = -1.524649E-07  WK1      = -1.039876E-07  
+PK1     = 6.872352E-14   K2       = 0.00210548     LK2      = 1.298362E-08   
+WK2     = 4.368557E-08   PK2      = -1.640397E-14  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 275336.5       LVSAT    = -0.08744607    WVSAT    = -0.03924157    
+PVSAT   = 3.913247E-08   UA       = 8.475663E-10   LUA      = 8.905258E-16   
+WUA     = 5.728044E-16   PUA      = -6.684087E-22  UB       = -8.811088E-19  
+LUB     = 7.740087E-25   WUB      = 4.294413E-25   PUB      = -3.533025E-31  
+UC      = 5.17434E-11    LUC      = -1.139286E-16  WUC      = -6.495675E-17  
+PUC     = 4.618146E-23   RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.009428292    
+LU0     = 1.541656E-09   WU0      = 2.580662E-09   PU0      = -1.851177E-15  
+A0      = 0.3730342      LA0      = 3.782906E-07   WA0      = 4.451705E-07   
+PA0     = -1.747218E-13  KETA     = -0.008465134   LKETA    = 4.231071E-09   
+WKETA   = 1.302126E-08   PKETA    = -1.905674E-15  A1       = 0              
+A2      = 0.5689         WA2      = -1.436326E-07  AGS      = -0.01980588    
+WAGS    = -1.650825E-10  B0       = 0              B1       = 0              
+VOFF    = -0.4310946     LVOFF    = 1.322824E-07   WVOFF    = 1.149906E-07   
+PVOFF   = -5.957997E-14  NFACTOR  = 0.9839504      LNFACTOR = -1.055187E-07  
+WNFACTOR= 1.045151E-07   PNFACTOR = 4.752564E-14   CIT      = 0.001695685    
+LCIT    = -7.136368E-10  WCIT     = -6.461679E-10  PCIT     = 3.21422E-16    
+CDSC    = 0              CDSCB    = 0              CDSCD    = 0              
+ETA0    = -0.006575817   LETA0    = 6.814894E-09   WETA0    = 5.463419E-09   
+PETA0   = -3.602567E-15  ETAB     = -0.0009065561  LETAB    = -6.259301E-10  
+WETAB   = 4.083129E-10   PETAB    = 2.819189E-16   DSUB     = 0              
+PCLM    = 1.178333       LPCLM    = 3.829284E-07   WPCLM    = 1.041403E-06   
+PPCLM   = -1.893662E-13  PDIBLC1  = 7.70446E-06    LPDIBLC1 = 1.066278E-12   
+WPDIBLC1= 1.952127E-12   PPDIBLC1 = -9.067632E-19  PDIBLC2  = 5E-05          
+PDIBLCB = 0.3166667      DROUT    = 0              PSCBE1   = 6.129551E+08   
+LPSCBE1 = -37.68366      WPSCBE1  = -49.7568       PPSCBE1  = 6.309942E-06   
+PSCBE2  = 9.82452E-06    LPSCBE2  = -3.945219E-12  WPSCBE2  = -3.670033E-12  
+PPSCBE2 = 1.819578E-18   PVAG     = 0              DELTA    = 0.0044826      
+WDELTA  = 4.691997E-09   ALPHA0   = 1.5E-06        BETA0    = 38.1           
+KT1     = -0.6020952     LKT1     = -1.006621E-08  WKT1     = 1.725337E-08   
+PKT1    = 4.533822E-15   KT2      = 0.01669304     LKT2     = -2.566878E-08  
+WKT2    = -1.836868E-08  PKT2     = 1.156122E-14   AT       = 3092.22        
+WAT     = -0.0009288238  UTE      = -0.3453608     LUTE     = -2.768203E-07  
+WUTE    = -3.268279E-07  PUTE     = 1.246799E-13   UA1      = 6.231264E-09   
+LUA1    = -2.529131E-15  WUA1     = -2.615141E-15  PUA1     = 1.13912E-21    
+UB1     = -9.300517E-18  LUB1     = 3.181805E-24   WUB1     = 3.621449E-24   
+PUB1    = -1.433085E-30  UC1      = -2.106855E-10  LUC1     = 1.070539E-16   
+WUC1    = 6.226576E-17   PUC1     = -4.821709E-23  KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 2.42572E-11   
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1           )
*
*
.MODEL pch5.10          PMOS   (                    LMIN     = '1.5145E-06-dxl5'
+LMAX    = 2.01E-05       WMIN     = '1.99804E-05-dxw5' WMAX = 0.0002001
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.017056'
+LVTH0   = -6.93358E-08   WVTH0    = -1.104035E-07  PVTH0    = 1.61686E-13    
+K1      = 0.5516948      LK1      = -1.147104E-08  WK1      = 7.922754E-07   
+PK1     = -1.160287E-12  K2       = 0.03024255     LK2      = 2.570502E-09   
+WK2     = -1.249129E-07  PK2      = 1.82935E-13    K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 175000         UA       = 3.01673E-09    LUA      = -1.111881E-15  
+WUA     = -1.814943E-15  PUA      = 9.247595E-21   UB       = 2.843372E-19   
+LUB     = 7.816373E-25   WUB      = -1.158536E-24  PUB      = 1.696676E-30   
+UC      = -7.099344E-11  LUC      = 3.197208E-18   WUC      = 8.993659E-17   
+PUC     = -1.317121E-22  RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.02334674     
+LU0     = -6.608755E-09  WU0      = -2.195811E-08  PU0      = 3.215765E-14   
+A0      = 0.6838011      LA0      = 8.154373E-09   WA0      = 1.363274E-07   
+PA0     = -1.996514E-13  KETA     = 0.00635177     LKETA    = -3.996862E-09  
+WKETA   = 5.10849E-08    PKETA    = -7.481383E-14  A1       = 0              
+A2      = 0.4            AGS      = 0.02           B0       = 0              
+B1      = 0              VOFF     = -0.1618556     LVOFF    = 2.562302E-08   
+WVOFF   = 1.336677E-07   PVOFF    = -1.957564E-13  NFACTOR  = 1.28945        
+LNFACTOR= 1.545114E-08   WNFACTOR = 2.369927E-05   PNFACTOR = -3.470758E-11  
+CIT     = -0.0004092128  LCIT     = 9.684422E-11   WCIT     = 1.738844E-09   
+PCIT    = -2.546537E-15  CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = 0.0002551735   LETA0    = 1.631116E-09   
+WETA0   = 9.144435E-10   PETA0    = -5.772949E-15  ETAB     = 0              
+DSUB    = 0              PCLM     = 2.631364       LPCLM    = 1.08172E-06    
+WPCLM   = 1.812601E-06   PPCLM    = -3.742228E-12  PDIBLC1  = 1E-05          
+PDIBLC2 = 5E-05          PDIBLCB  = 0.1546167      LPDIBLCB = 2.373222E-07   
+DROUT   = 0              PSCBE1   = 3.929429E+08   LPSCBE1  = 156.7851       
+WPSCBE1 = 29.55479       PPSCBE1  = -4.328278E-05  PSCBE2   = 4E-06          
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 1.5E-06        
+BETA0   = 38.1           KT1      = -0.5766668     LKT1     = -2.308303E-08  
+WKT1    = 6.525825E-07   PKT1     = -9.55707E-13   KT2      = -0.03111435    
+LKT2    = -1.73639E-09   WKT2     = -5.610196E-07  PKT2     = 8.216132E-13   
+AT      = 2422.758       LAT      = -0.003255229   WAT      = 0.04393074     
+PAT     = -6.433656E-08  UTE      = -1.866381      LUTE     = 2.583099E-07   
+WUTE    = 9.378672E-06   PUTE     = -1.373506E-11  UA1      = -1.206329E-09  
+LUA1    = -9.324564E-17  WUA1     = 1.430247E-14   PUA1     = -2.094597E-20  
+UB1     = -4.140797E-18  LUB1     = 2.331944E-24   WUB1     = 5.656061E-23   
+PUB1    = -8.283301E-29  UC1      = -7.951766E-11  LUC1     = 2.565148E-17   
+WUC1    = 5.265044E-16   PUC1     = -7.710656E-22  KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 2.42572E-11  
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1            )
*
*
.MODEL pch5.11          PMOS   (                    LMIN     = '8.145E-07-dxl5'
+LMAX    = '1.5145E-06-dxl5' WMIN  = '1.99804E-05-dxw5' WMAX = 0.0002001
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.078646'
+LVTH0   = 2.086317E-08   WVTH0    = 2.433973E-07   PVTH0    = -3.564553E-13  
+K1      = 0.5898317      LK1      = -6.732257E-08  WK1      = -8.803282E-07  
+PK1     = 1.289241E-12   K2       = 0.02005356     LK2      = 1.749228E-08   
+WK2     = 2.347025E-07   PK2      = -3.437219E-13  K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 181677.3       LVSAT    = -0.009778858   WVSAT    = -0.2433714     
+PVSAT   = 3.564174E-07   UA       = 9.757481E-10   LUA      = 1.877137E-15   
+WUA     = 3.52661E-14    PUA      = -4.50576E-20   UB       = 7.971141E-19   
+LUB     = 3.067552E-26   WUB      = -5.311529E-24  PUB      = 7.778732E-30   
+UC      = -4.29688E-11   LUC      = -3.784487E-17  WUC      = -7.497421E-16  
+PUC     = 1.097997E-21   RDSW     = 1200           PRWB     = 0              
+PRWG    = 0              WR       = 1              U0       = 0.01630683     
+LU0     = 3.701184E-09   WU0      = 1.041825E-07   PU0      = -1.525752E-13  
+A0      = 0.1661233      LA0      = 7.662933E-07   WA0      = 4.587941E-06   
+PA0     = -6.719039E-12  KETA     = 0.0009181837   LKETA    = 3.960625E-09   
+WKETA   = 3.339665E-08   PKETA    = -4.890939E-14  A1       = 0              
+A2      = 0.4            AGS      = 0.06368572     LAGS     = -6.397773E-08  
+B0      = 0              B1       = 0              VOFF     = -0.1481659     
+LVOFF   = 5.574528E-09   NFACTOR  = 1.3            CIT      = -0.0003885595  
+LCIT    = 6.659745E-11   CDSC     = 0              CDSCB    = 0              
+CDSCD   = 0              ETA0     = -0.0002827152  LETA0    = 2.418854E-09   
+WETA0   = -1.690397E-09  PETA0    = -1.958161E-15  ETAB     = 0.0005078459   
+LETAB   = -7.437402E-10  DSUB     = 0              PCLM     = 3.717283       
+LPCLM   = -5.086092E-07  WPCLM    = -1.55382E-06   PPCLM    = 1.187895E-12   
+PDIBLC1 = 1E-05          PDIBLC2  = 5E-05          PDIBLCB  = 0.3703603      
+LPDIBLCB= -7.863436E-08  DROUT    = 0              PSCBE1   = 4.808788E+08   
+LPSCBE1 = 28.00306       PSCBE2   = 5.081222E-06   LPSCBE2  = -1.583449E-12  
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 1.5E-06        
+BETA0   = 38.1           KT1      = -0.6123038     LKT1     = 2.910735E-08   
+WKT1    = -6.620191E-07  PKT1     = 9.69527E-13    KT2      = -0.05207413    
+LKT2    = 2.895922E-08   WKT2     = 3.115155E-07   PKT2     = -4.562143E-13  
+AT      = -1765.858      LAT      = 0.002878998    UTE      = -1.897773      
+LUTE    = 3.042837E-07   WUTE     = 1.844754E-06   PUTE     = -2.701642E-12  
+UA1     = -1.674093E-09  LUA1     = 5.91794E-16    UB1      = -2.437612E-18  
+LUB1    = -1.623707E-25  UC1      = -8.643698E-11  LUC1     = 3.578483E-17   
+WUC1    = 1.162147E-15   PUC1     = -1.701965E-21  KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 2.42572E-11 
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1          )
*
*
.MODEL pch5.12          PMOS   (                    LMIN     = 5E-07      
+LMAX    = '8.145E-07-dxl5' WMIN   = '1.99804E-05-dxw5' WMAX = 0.0002001
+LEVEL   = 49             TNOM     = 25             VERSION  = 3.1            
+TLEV    = 1              TLEVC    = 1              ACM      = 12             
+LDIF    = 1.2E-07        HDIF     = hdifp5         RSH      = 153            
+RD      = 0              RS       = 0              TOX      = toxp5       
+XJ      = 1E-07          NCH      = 4.3968E+16     LLN      = 1              
+LWN     = 1              WLN      = 1              WWN      = 1              
+LINT    = 4E-08          LL       = 0              LW       = 0              
+LWL     = 0              WINT     = 4E-08          WL       = 0              
+WW      = 0              WWL      = 0              MOBMOD   = 1              
+BINUNIT = 2              XL       = '3E-08+dxl5'   XW       = '1.5E-07+dxw5'   
+DWG     = 0              DWB      = 0              VTH0     = 'dvtp5-1.058984'
+LVTH0   = 5.831877E-09   WVTH0    = -7.380264E-07  PVTH0    = 3.938431E-13   
+K1      = 0.3834936      LK1      = 9.042292E-08   WK1      = 2.213848E-06   
+PK1     = -1.076257E-12  K2       = 0.07294988     LK2      = -2.294696E-08  
+WK2     = -6.103756E-07  PK2      = 3.023404E-13   K3       = 0              
+DVT0    = 0              DVT1     = 0              DVT2     = 0              
+DVT0W   = 0              DVT1W    = 0              DVT2W    = 0              
+NLX     = 0              W0       = 0              K3B      = 0              
+VSAT    = 168886.1       WVSAT    = 0.2228384      UA       = 5.177781E-09   
+LUA     = -1.335317E-15  WUA      = -6.174405E-14  PUA      = 2.910667E-20   
+UB      = -3.771157E-19  LUB      = 9.283744E-25   WUB      = 2.446966E-23   
+PUB     = -1.498899E-29  UC       = -1.931642E-10  LUC      = 7.69795E-17    
+WUC     = 2.633014E-15   PUC      = -1.48812E-21   RDSW     = 1200           
+PRWB    = 0              PRWG     = 0              WR       = 1              
+U0      = 0.02853129     LU0      = -5.644418E-09  WU0      = -2.079686E-07  
+PU0     = 8.606428E-14   A0       = 1.053803       LA0      = 8.766222E-08   
+WA0     = -1.356203E-05  PA0      = 7.156612E-12   KETA     = 0.01138427     
+LKETA   = -4.040701E-09  WKETA    = -3.991359E-08  PKETA    = 7.136286E-15   
+A1      = 0              A2       = 0.5625945      LA2      = -1.243035E-07  
+WA2     = -1.552626E-06  PA2      = 1.186983E-12   AGS      = -0.08883215    
+LAGS    = 5.262219E-08   WAGS     = 1.380112E-06   PAGS     = -1.055096E-12  
+B0      = 0              B1       = 0              VOFF     = -0.109096      
+LVOFF   = -2.429444E-08  WVOFF    = -3.377276E-07  PVOFF    = 2.581928E-13   
+NFACTOR = 0.8800734      LNFACTOR = 3.210339E-07   WNFACTOR = 1.77331E-05    
+PNFACTOR= -1.355696E-11  CIT      = -0.0007432703  LCIT     = 3.377738E-10   
+WCIT    = 7.590893E-09   PCIT     = -5.803238E-15  CDSC     = 0              
+CDSCB   = 0              CDSCD    = 0              ETA0     = -0.004140343   
+LETA0   = 5.36801E-09    WETA0    = 4.017752E-08   PETA0    = -3.396618E-14  
+ETAB    = -0.0003047791  LETAB    = -1.224885E-10  WETAB    = 7.285613E-09   
+PETAB   = -5.569851E-15  DSUB     = 0              PCLM     = 4.095334       
+LPCLM   = -7.976283E-07  WPCLM    = -6.084229E-06  PPCLM    = 4.651393E-12   
+PDIBLC1 = 1E-05          PDIBLC2  = 5E-05          PDIBLCB  = 0.40135        
+LPDIBLCB= -1.023259E-07  WPDIBLCB = -1.466066E-06  PPDIBLCB = 1.120808E-12   
+DROUT   = 0              PSCBE1   = 5.27386E+08    LPSCBE1  = -7.55169       
+WPSCBE1 = 3085.168       PPSCBE1  = -0.002358611   PSCBE2   = 3.245906E-06   
+LPSCBE2 = -1.803504E-13  WPSCBE2  = 6.996353E-11   PPSCBE2  = -5.348713E-17  
+PVAG    = 0              DELTA    = 0.01           ALPHA0   = 1.5E-06        
+BETA0   = 38.1           KT1      = -0.5319197     LKT1     = -3.234629E-08  
+WKT1    = 1.682085E-06   PKT1     = -8.225407E-13  KT2      = -0.00190553    
+LKT2    = -9.394682E-09  WKT2     = -4.266947E-07  PKT2     = 1.081473E-13   
+AT      = 2063.814       LAT      = -4.878597E-05  WAT      = -0.01276604    
+PAT     = 9.759638E-09   UTE      = -0.602981      LUTE     = -6.85585E-07   
+WUTE    = -6.156065E-06  PUTE     = 3.414984E-12   UA1      = 3.67648E-09    
+LUA1    = -3.498719E-15  WUA1     = -2.34619E-14   PUA1     = 1.793663E-20   
+UB1     = -6.626459E-18  LUB1     = 3.040003E-24   WUB1     = 5.427292E-23   
+PUB1    = -4.149165E-29  UC1      = -1.160362E-10  LUC1     = 5.841346E-17   
+WUC1    = -3.330525E-16  PUC1     = -5.588843E-22  KT1L     = 0              
+PRT     = 0              JS       = 0.0001         JSW      = 2.42572E-11  
+PB      = 1.236234       MJ       = 0.6625574      MJSW     = 0.4851755
+PBSW    = 1.236234       PBSWG    = 1.236234       CJ       = cjp5
+CJSW    = cjswp5         CJSWG    = cjswgp5        CGDO     = cgop5
+CGSO    = cgop5          CTA      = 1.377674E-3    CTP      = 4.878735E-4
+PTA     = 2.163191E-3    PTP      = 2.163191E-3    MJSWG    = 0.4851755 
+XTI     = 3              N        = 1              CAPMOD   = 0
+NQSMOD  = 0              XPART    = 1              CF       = 0 
+CALCACM = 1              SFVTFLAG = 0              VFBFLAG  = 1            )
.ENDL MOS_5V
******************************************************************************
.LIB BIP
*******************************************************************
*          MODEL OF P+/NW/PSUB PNP 10X10 VERTICAL BIPOLAR         *
*******************************************************************
.MODEL pnp10 PNP (                               LEVEL  = 1                  
+ BF     = 6.35            NF     = 1.01            ISE    = 2.95E-17           
+ NE     = 1.9             IS     = 2.95E-17        RB     = 71                 
+ IRB    = 9.5E-4          RBM    = 0.1             RE     = 2.35               
+ IKF    = 1.95E-3         NKF    = 0.549           VAF    = 300                
+ BR     = 0.01116         NR     = 1               ISC    = 2.95E-17           
+ NC     = 1.1             RC     = 21.08           IKR    = 0.087818           
+ VAR    = 7.8             TBF1   = 6.7E-3          TBF2   = 8E-6               
+ TNE1   = 9E-5            TNF1   = 9.5E-5          TRB1   = 3E-5               
+ TIRB1  = 9E-4            TRM1   = 9.44068E-6      TRE1   = 5E-4               
+ TIKF1  = -3.5E-3         TVAF1  = -9E-4           TBR1   = -7E-4              
+ TBR2   = 9.5E-6          TNR1   = 9E-5            TNC1   = 1.50731E-3         
+ XTB    = 0               XTI    = 3               TRC1   = 0                  
+ TIKR1  = -3.9E-3         EG     = 1.18            CJE    = 1.55101E-13        
+ VJE    = 1.23623         MJE    = 0.662557        FC     = 0.5                
+ CJC    = 3.131405E-14    VJC    = 0.552774        MJC    = 0.32993            
+ TLEVC  = 1               CTE    = 4.87874E-4      CTC    = 2.63294E-3         
+ TVJE   = 2.16319E-3      TVJC   = 2.955E-3        TREF   = 25                 
+ SUBS   = 1               TLEV   = 0               )                           
******************************************************************
*           MODEL OF P+/NW/PSUB PNP 5X5 VERTICAL BIPOLAR         *
******************************************************************
.MODEL pnp5 PNP (                                LEVEL  = 1                  
+ BF     = 7.55            NF     = 1.034           ISE    = 1.55E-17           
+ NE     = 1.45            IS     = 1.55E-17        RB     = 140                
+ IRB    = 1.95E-3         RBM    = 0.1             RE     = 0.05               
+ IKF    = 7.755E-4        NKF    = 0.515           VAF    = 290                
+ BR     = 4.15E-3         NR     = 1.0355          ISC    = 1.55E-17           
+ NC     = 1.4             RC     = 21.08           IKR    = 1E-4               
+ VAR    = 6.8             TBF1   = 6.75E-3         TBF2   = 1E-5               
+ TNE1   = 9E-6            TNF1   = 2.46E-4         TRB1   = 9E-5               
+ TIRB1  = 9E-5            TRM1   = 9.44068E-6      TRE1   = -1E-4              
+ TIKF1  = -3.15E-3        TVAF1  = 5.3E-5          TBR1   = -4E-4              
+ TBR2   = 8E-6            TNR1   = 1.961E-4        TNC1   = -4.507315E-4       
+ XTB    = 0               XTI    = 3               TRC1   = 1E-3               
+ TIKR1  = -1E-5           EG     = 1.18            CJE    = 4.292525E14       
+ VJE    = 1.23623         MJE    = 0.662557        FC     = 0.5                
+ CJC    = 1.31504E-14     VJC    = 0.552774        MJC    = 0.32993            
+ TLEVC  = 1               CTE    = 4.87874E-4      CTC    = 2.63294E-3         
+ TVJE   = 2.16319E-3      TVJC   = 2.955E-3        TREF   = 25                 
+ SUBS   = 1               TLEV   = 0               )                           
*                                                                               
.ENDL BIP 
*****************************************************************************
.LIB DIO
*********************************************************
*               MODEL OF N+/PW DIODE                    *
*********************************************************
.MODEL NDIO D (                                     LEVEL  = 3
+ IS     = 6.27496E-5      RS     = 2.15E-7         N      = 1.435              
+ BV     = 8.3             IBV    = 0.03            IK      = 7.5E6              
+ IKR     = 7.8E-3         JSW     = 2.51253E-9     AREA    = 7.5E-8             
+ PJ     = 1.1E-3          CJ     = 9.50957E-4      PB      = 0.6944804          
+ MJ     = 0.3297355       CJSW   = 2.84489E-10     PHP    = 0.6944804          
+ MJSW   = 0.1303453       TLEV   = 1               EG     = 1.17               
+ XTI    = 3               TCV    = -3E-4           TRS    = 1.712E-3           
+ TLEVC  = 1               CTA    = 9.373218E-4     CTP    = 1.423257E-3        
+ TPB    = 1.485657E-3     TPHP   = 4.517676E-3     TREF   = 25                 
+ FC     = 0.5             )                                                    
*                                                                               
*********************************************************
*               MODEL OF P+/NW DIODE                    *
*********************************************************
.MODEL PDIO D (                                     LEVEL  = 3                  
+ IS     = 1E-4            RS     = 2.2E-7          N      = 1.725              
+ BV     = 8.25            IBV    = 0.0266061      IK      = 8E6                
+IKR     = 6E-4           JSW     = 3.65E-7        AREA    = 7.5E-8             
+ PJ     = 1.1E-3          CJ     = 1.38871E-3     PB      = 1.0864354          
+ MJ     = 0.6008857       CJSW   = 3.86159E-10     PHP    = 1.0864354          
+ MJSW   = 0.4471985       TLEV   = 1               EG     = 1.17               
+ XTI    = 3               TCV    = -1.01E-3        TRS    = 1E-3               
+ TLEVC  = 1               CTA    = 9.175825E-4     CTP    = 1.162482E-3        
+ TPB    = 1.249266E-3     TPHP   = 3.6054E-4       TREF   = 25                 
+ FC     = 0.5             )                                                    
*********************************************************
*               MODEL OF NW/PW DIODE                    *
*********************************************************
.MODEL NW_DIO D (                                   LEVEL  = 3                  
+ IS     = 1.74283E-4      RS     = 1.655E-7        N      = 1.438              
+ BV     = 21              IBV    = 0.03            IK      = 1E5                
+IKR     = 0.025          JSW     = 1.72056E-9      AREA    = 7.6104E-8          
+ PJ     = 1.108E-3        CJ     = 1.02413E-4      PB      = 0.5540683          
+ MJ     = 0.3574083       CJSW   = 4.84677E-10     PHP    = 0.5540683          
+ MJSW   = 0.2837341       TLEV   = 1               EG     = 1.17               
+ XTI    = 3               TCV    = 8E-5            TRS    = 1.12E-3            
+ TLEVC  = 1               CTA    = 3.029206E-3     CTP    = 1.740045E-3        
+ TPB    = 3.002617E-3     TPHP   = 2.419203E-3     TREF   = 25                 
+ FC     = 0.5             )                                                    
*                                                                               
.ENDL DIO                                                                       


