// An Atomizer box to allow travellers to take their atomisers
// Enter here the parameters for your Atomizer


// Diameter of the atomizer
d_atomizer=22;//[20:1:50]

// height of the atomizer, without the screw  (h_atomizer+screw_length)  = Total height of the atomizer.
h_atomizer=38;//[0:1:150]

// Screw length of the atomizer (default value should work for any atomizer) 
screw_length=4;//[0:1:10]



/* [Hidden] */
diameter_delta=0.5;
diameter_of_hole=8;
boxthickness=2;
delta=0.3;

//1 mm de jeu en hauteur, cela permet de pouvoir coller potentiellement une mousse de protection de 1mm au fond de la boite ?...
h_total=boxthickness+h_atomizer+(screw_length+1)+2;
h_cap=10;

$fn=50;



boite();

module boite ()
{
    difference()
    {
     union()

     {
        //cylindre de la base, en bizeau 
        cylinder(r1=((d_atomizer+diameter_delta)/2)+boxthickness+delta+boxthickness-1,r2=((d_atomizer+diameter_delta)/2)+2*boxthickness+delta+1,h=2);
        //cylindre principal, petit diametre
        cylinder(r=((d_atomizer+diameter_delta)/2)+boxthickness,h=h_total);
        // cylindre exterieur : gros diametre.
        translate([0,0,boxthickness])cylinder(r=((d_atomizer+diameter_delta)/2)+2*boxthickness+delta+1,h=h_total-h_cap-delta-0.5);
        //2 spheres
        translate([((d_atomizer+diameter_delta)/2)+0.5,0,h_total-3]) sphere(r=3);
        translate([-((d_atomizer+diameter_delta)/2)-0.5,0,h_total-3]) sphere(r=3);
     }
    translate([0,0,boxthickness])cylinder(r=((d_atomizer+diameter_delta)/2),h=h_total);
    // no longer needed since we only put  the support in the cap.
    //translate([0,0,boxthickness])cylinder(r=diameter_of_hole/2,h=h_total);
    }


translate ([2*(d_atomizer+diameter_delta)+10,0,0]) couvercle();
}


module couvercle()
{
    // Ajout du support dans le couvercle : 
   difference(){
                translate([0,0,boxthickness])cylinder(r=((d_atomizer-2)/2),h=screw_length+1);
                translate([0,0,boxthickness])cylinder(r=((diameter_of_hole)/2),h=screw_length+1);
       }

    difference()
    {
    union()
    {
        cylinder(r1=((d_atomizer+diameter_delta)/2)+2*boxthickness+delta-1,r2=((d_atomizer+diameter_delta)/2)+2*boxthickness+delta+1,h=boxthickness);
        translate([0,0,boxthickness])        cylinder(r=((d_atomizer+diameter_delta)/2)+2*boxthickness+delta+1,h=h_cap-boxthickness);
        translate([0,0,boxthickness])        cylinder(r=((d_atomizer+diameter_delta)/2)-2*boxthickness,h=h_cap-boxthickness);

    }
//creuser le couvercle
    translate([0,0,boxthickness])cylinder(r=((d_atomizer+diameter_delta)/2)+boxthickness+delta,h=h_cap);



//descente de la sphere
hull()
    {
    translate([((d_atomizer+diameter_delta)/2)+boxthickness+delta-1,0,boxthickness+3]) sphere(r=3);  
    translate([((d_atomizer+diameter_delta)/2)+boxthickness+delta-1,0,boxthickness+13]) sphere(r=3);  
    }

// chemin tournant        
hull()
    {
    translate([((d_atomizer+diameter_delta)/2)+boxthickness+delta-1,0,boxthickness+3]) sphere(r=3);  
    rotate([0,0,-40])    translate([((d_atomizer+diameter_delta)/2)+boxthickness+delta-1,0,boxthickness+3]) sphere(r=3);  
    }


//descente de la sphere
hull()
    {
    translate([-((d_atomizer+diameter_delta)/2)-boxthickness-delta+1,0,boxthickness+3]) sphere(r=3);  
    translate([-((d_atomizer+diameter_delta)/2)-boxthickness-delta+1,0,boxthickness+13]) sphere(r=3);  
    }


// chemin tournant          
hull()
    {
    translate([-((d_atomizer+diameter_delta)/2)-boxthickness-delta+1,0,boxthickness+3]) sphere(r=3);  
    rotate([0,0,-40])    translate([-((d_atomizer+diameter_delta)/2)-boxthickness-delta+1,0,boxthickness+3]) sphere(r=3);  
    }


   }

}



module VerticalTag(TPosition=[0,0,0],Tstr="Text",Tsize=2,Thalign="center",Tcolor="red",Tfont = "Liberation Sans")
{
    
//Tcolor="blue"
//font = "Liberation Sans";

//haligne=left,center,right
 translate(TPosition) rotate([90,0,0]) linear_extrude(height = 0.5) {
   color([0.2,0,0])  text(text = Tstr, font = Tfont, size = Tsize, halign = Thalign);

 }   

}
module HorizontalTag(TPosition=[0,0,0],Tstr="Text",Tsize=2,Thalign="center",Tcolor="red",Tfont = "Liberation Sans")
{
    
//Tcolor="blue"
//font = "Liberation Sans";

//haligne=left,center,right
 translate(TPosition) linear_extrude(height = 0.5) {
   color([0.2,0,0])  text(text = Tstr, font = Tfont, size = Tsize, halign = Thalign);

 }   

}


