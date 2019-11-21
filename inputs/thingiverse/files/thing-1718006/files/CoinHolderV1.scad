// Parametric Coin Stand
// www.thingiverse.com/gkstmr
// Goksenin Tumer
// Stand Height in mm
Stand_Height=12; 
// Coin diameter in mm
Coin_Diameter=49;
// Coin thickness in mm 
Coin_Thickness=2.8;
// Stand Text 
Coin_Label="2016";
// Font Size
FontS=08;
coinr=Coin_Diameter/2;
//Type == 0  Rectangular: Type == 1 Conical
type=1;               
if (type==0)
{
difference()
    {
minkowski(){cube ([coinr*1.2-4,coinr*2-4,Stand_Height]); cylinder (r=2, h=1);}; translate ([coinr/2,coinr,Stand_Height+coinr-6])rotate ([0,70,0])  cylinder (Coin_Thickness+0.1,coinr,coinr,true) ;
}
union () {linear_extrude(Stand_Height+2) rotate ([0,0,90]) translate ([coinr, -coinr/2, Stand_Height])  text (Coin_Label, halign = "center", size=FontS);}
};
//translate ([coinr,coinr*4,0])
if (type!=0)
{
difference() { cylinder (Stand_Height,coinr,coinr-5,false);
    translate ([0,0,Stand_Height+coinr-6])rotate ([0,70,0])
    cylinder (Coin_Thickness+0.1,coinr,coinr,false);
    ;}
  
   
union () {linear_extrude(Stand_Height+1) rotate ([0,0,90]) translate ([coinr/100, coinr/10, Stand_Height])  text (Coin_Label, halign = "center", size=FontS);}
 };

