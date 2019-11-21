// totem type jungle speed
 

d=45; // diametre base red
h1=5; // hauteur base
h=120; // hauteur totale
d1=20; // diametre mini
d2=35; // diametre centre
h2=22; // hauteur cone base blue
h3=33; // hauteur cone centre

module totem (){

// crée le disque des bases
color ("red")
cylinder (h=h1, r=d/2, $fn=100);


// crée le cone de base
color ("blue")
translate ([0,0,-(h2+0.5)]) 
cylinder(h = h2+1, r1 = d1/2, r2 = d/2, center = false, $fn=100);

// crée le cone de centre
color ("green")
translate ([0,0,-(h3+h2)]) 
cylinder(h = h3+1, r1 = d2/2, r2 = d1/2, center = false, $fn=100);

}
union () {
totem ();
translate ([0,0,-(h-h1*2)]) mirror([0,0,180])totem();
// intégre le logo
color ("black")
translate ([1,-2,4]) linear_extrude (height=2)  
import (file="/.../.../logo.dxf",  $fn=100); 

}
