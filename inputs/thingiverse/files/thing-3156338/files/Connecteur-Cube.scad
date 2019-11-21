// Connecteur pour solide de platon en paille
// Association AMT 
// site web http://www.alan-turing.club/
// 2018
// il ne faut pas de support - de brim à l'impression


$fn = 15;                   // nombre de face de cylindre 
rayonF=2.52;                // rayon final de la paille
rayonI=2.25;                 //rayon initial pour inserer la paille 
longueur =12;               // longeur du cylindre

delta=6;                     // ecart entre les pieces

nbDePieces=8;               //multiple de 2;

module Paille()
{cylinder (r=rayonF,r2=rayonI,h=longueur);
 translate([0,0,longueur/2])cylinder(r=rayonF,r2=rayonI-0.2,h=2);
 translate([0,0,2*longueur/3])cylinder(r=rayonF,r2=rayonI-0.2,h=2);}

module connecteurSimple()
{       union()
            {
    
                    Paille();
                    rotate([0,90,0])  Paille();
                    rotate([0,90,90])   Paille();
                   translate([0,0,-0.5]) cube([rayonF*2,rayonF*2,rayonF*2],center=true);
            }
}

for(i = [1:1:nbDePieces/2]) {translate([i*delta, i*delta,0])connecteurSimple();
                            translate([i*delta+longueur+3, i*delta-(longueur+3),0])connecteurSimple();}