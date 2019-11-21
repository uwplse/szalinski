// Connecteur pour solide de platon en paille
// Icosaèdre
// Association AMT 
// site web http://www.alan-turing.club/
// 2018
// il ne faut pas de support - de brim à l'impression


$fn = 15;                   // nombre de face de cylindre 
rayonF=2.52;                // rayon final de la paille
rayonI=2.25;                 //rayon initial pour inserer la paille 
longueur =15;               // longeur du cylindre

delta=18;                     // ecart entre les pieces
angle =180-118;
nbDePieces=10;               //multiple de 2;

module Paille()
{cylinder (r=rayonF,r2=rayonI,h=longueur);
 translate([0,0,longueur/2])cylinder(r=rayonF,r2=rayonI-0.2,h=2);
 translate([0,0,2*longueur/3])cylinder(r=rayonF,r2=rayonI-0.2,h=2);}

module connecteurSimple()
{   rotate([-90,0,0])union(){  
    for(k = [1:1:5])  {rotate([0,k*360/5,0])rotate([(angle)/2,0,0])Paille();}
        translate([0,3,0])rotate([90,10,0])cylinder(r=5,h=3,$fn=5);}
}

for(i = [1:1:nbDePieces/2]) {translate([i*delta, i*delta,0])connecteurSimple();
                            translate([i*delta+longueur+3, i*delta-(longueur+5),0])connecteurSimple();}