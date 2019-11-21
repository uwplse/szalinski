// An Atomizer box to allow travellers to take their atomisers
// Enter here the parameters for your Atomizer

// Total height of the atomizer, including the screw
h_atomiseur=42;//[0:1:100]

// Diameter of the atomizer
d_atomiseur=22;//[20:1:40]

// Screw length of the atomizer (default value should work for any atomizer)
screw_length=4;//[4:1:8]


/* [Hidden] */

diameter_of_hole=8;
epaisseurboite=2;
delta=0.3;
h_total=h_atomiseur+epaisseurboite+4;
h_couvercle=10;

$fn=50;



boite();

module boite ()
{

    
    difference()
    {
     union()

     {
        cylinder(r1=(d_atomiseur/2)+2*epaisseurboite+delta-1,r2=(d_atomiseur/2)+2*epaisseurboite+delta+1,h=2);

        translate([0,0,0]) cylinder(r=(d_atomiseur/2)+epaisseurboite,h=h_total);
        translate([0,0,epaisseurboite])cylinder(r=(d_atomiseur/2)+2*epaisseurboite+delta+1,h=h_total-h_couvercle+1.5-delta-epaisseurboite);

        translate([(d_atomiseur/2)+0.5,0,h_total-3]) sphere(r=3);
        translate([-(d_atomiseur/2)-0.5,0,h_total-3]) sphere(r=3);
     }
    translate([0,0,epaisseurboite+screw_length+1])cylinder(r=(d_atomiseur/2),h=h_total);
    translate([0,0,epaisseurboite])cylinder(r=diameter_of_hole/2,h=h_total);
    }


translate ([2*d_atomiseur+10,0,0]) couvercle();
}


module couvercle()
{


    difference()
    {
    union()
    {
        cylinder(r1=(d_atomiseur/2)+2*epaisseurboite+delta-1,r2=(d_atomiseur/2)+2*epaisseurboite+delta+1,h=epaisseurboite);
         translate([0,0,epaisseurboite])        cylinder(r=(d_atomiseur/2)+2*epaisseurboite+delta+1,h=h_couvercle-epaisseurboite);
    }
//creuser le couvercle
    translate([0,0,epaisseurboite])cylinder(r=(d_atomiseur/2)+epaisseurboite+delta,h=h_couvercle);

//descente de la sphere
hull()
    {
    translate([(d_atomiseur/2)+epaisseurboite+delta-1,0,epaisseurboite+3]) sphere(r=3);  
    translate([(d_atomiseur/2)+epaisseurboite+delta-1,0,epaisseurboite+13]) sphere(r=3);  
    }

// chemin tournant        
hull()
    {
    translate([(d_atomiseur/2)+epaisseurboite+delta-1,0,epaisseurboite+3]) sphere(r=3);  
    rotate([0,0,-40])    translate([(d_atomiseur/2)+epaisseurboite+delta-1,0,epaisseurboite+3]) sphere(r=3);  
    }


//descente de la sphere
hull()
    {
    translate([-(d_atomiseur/2)-epaisseurboite-delta+1,0,epaisseurboite+3]) sphere(r=3);  
    translate([-(d_atomiseur/2)-epaisseurboite-delta+1,0,epaisseurboite+13]) sphere(r=3);  
    }


// chemin tournant          
hull()
    {
    translate([-(d_atomiseur/2)-epaisseurboite-delta+1,0,epaisseurboite+3]) sphere(r=3);  
    rotate([0,0,-40])    translate([-(d_atomiseur/2)-epaisseurboite-delta+1,0,epaisseurboite+3]) sphere(r=3);  
    }


   }

}
