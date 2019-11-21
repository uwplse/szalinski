//rayon du cercle exterieur (30)
a=30;
//Epaisseur du cercle exterieur (4)
b=4;
//hauteur du cercle exterieur (8)
c=8;
//largeur des cubes internes (10)
d=10;
//hauteur des cubes internes (4)
e=4;
//largeur des cubes d'emboitement (6)
f=6;
//rayon du cercle interieur (3)
g=3;
difference(){
union(){
difference(){
union(){
difference(){
cylinder (r=a+b, h=c,$fn=90);
cylinder ( r=a, h=c,$fn=90);}
translate([-a,-d/2,c-e]) cube([a*2,d,e]);
translate([-d/2,-a,c-e]) cube([d,a*2,e]);}
union(){
    color("red") translate([-f/2,0,0]) cube([f,a+b+1,c]);
    color("red") cylinder (r=g, h=c,$fn=90);}
}
translate([0,0,c*2]) rotate([0,180,180]) intersection(){
union(){
difference(){
cylinder (r=a+b, h=c,$fn=90);
cylinder ( r=a, h=c,$fn=90);}
translate([-a,-d/2,c-e]) cube([a*2,d,e]);
translate([-d/2,-a,c-e]) cube([d,a*2,e]);}
union(){
    color("red") translate([-f/2,0,0]) cube([f,a+b+1,c]);
    color("red") cylinder (r=g, h=c,$fn=90);}
}}
color("blue") cylinder (r=g+0.1, h=c*2,$fn=90);}
