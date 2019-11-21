//configuration
//Enter desired diamanter of plates
//d1=54.7;
d1=40;

//enter desired diamanter of spacers
sp=4;

//enter top bay heigth
tb=50;
// shelf spacing
ss=10;
//enter shelf thickness
st=2;



ra1=d1/2;
ra2=((ra1)*-1);
sp1=sp/2;
th=(ss*2)+(st*4)+tb;

 union() {
cylinder($fn = 360, $fa = 12, $fs = 2, h = st, r1 = ra1, r2 = ra1, center = false);
translate([(ra1-(sp/2)),0,0]) 
   cylinder($fn = 360, $fa = 22, $fs = 2, h = th, r1 = sp1, r2 =sp1, center = false);
     translate([(ra2+(sp/2)),0,0]) 
   cylinder($fn = 360, $fa = 22, $fs = 2, h = th, r1 = sp1, r2 =sp1, center = false);
        translate([0,(ra1-(sp/2)),0]) 
   cylinder($fn = 360, $fa = 22, $fs = 2, h = th, r1 = sp1, r2 =sp1, center = false);
           translate([0,(ra2+(sp/2)),0]) 
   cylinder($fn = 360, $fa = 22, $fs = 2, h = th, r1 = sp1, r2 =sp1, center = false);
//layer 2
  translate([0,0,(ss+st)])   
     cylinder($fn = 360, $fa = 12, $fs = 2, h = st, r1 = ra1, r2 = ra1, center = false);
//layer 3
     
 translate([0,0,(ss+st+ss+st)])   
     cylinder($fn = 360, $fa = 12, $fs = 2, h = st, r1 = ra1, r2 = ra1, center = false);    
 //top  
   
   translate([0,0,(th-st)])   
     cylinder($fn = 360, $fa = 12, $fs = 2, h = st, r1 = ra1, r2 = ra1, center = false);   
     
     }