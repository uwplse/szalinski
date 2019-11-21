// Connecteur pour une fractale de serpinski en paille
// Association AMT 
// site web http://www.alan-turing.club/
// 2018
// il ne faut pas de support - de brim à l'impression

a=13;
$fn = 15;                   // nombre de face de cylindre 
rayonF=2.52;                // rayon final de la paille
rayonI=2.25;                 //rayon initial pour inserer la paille 
longueur =15;               // longeur du cylindre

delta=17;                     // ecart entre les pieces

nbDePieces=5;               //nb de piece au carre;

module Paille()
    {cylinder (r=rayonF,r2=rayonI,h=longueur);
    translate([0,0,longueur/2])cylinder(r=rayonF,r2=rayonI-0.2,h=2);
    translate([0,0,3*longueur/4])cylinder(r=rayonF,r2=rayonI-0.2,h=2);
    }
    
module triedre()
    {translate([0,0,sqrt(2/3)*longueur/4])
            rotate([0,0,-30])translate([0,0,-longueur/4])
                        union(){
                                rotate([36.5,0,0]) Paille();
                                rotate([36.5,0,120]) Paille();
                                rotate([36.5,0,-120]) Paille();
                                }
    }
 
 module connecteurDouble()   
    {rotate([0,180+109.7,0])
        union()
            { triedre();
            rotate([0,109.7,60])triedre();
            translate([0,0,sqrt(2/3)*longueur/4])rotate([180,0,0])cylinder(r1=0.5774*longueur,r2=0,h=sqrt(2/3)*longueur,$fn=3);
}
}



for(i = [1:1:nbDePieces]) 
   for(j = [1:1:nbDePieces]) translate([i*delta+j*longueur, i*delta-j*longueur,0])connecteurDouble();
                         
    