/*************************************
 
         Adjustable Hose Coupling


         Adjustable for different
            hose diameters &
             Wall thickness

         Author: Lee J Brumfield

      

 
       Enter the inside diameter & wall
      thickness of hose 1 & hose 2 here.
     
       

      With 2 different sizes make the
        larger of the two hose1

*************************************/

// With 2 different sizes make the larger of the two hose1
Inside_diameter_of_hose1_in_mm = 20 ; // [6:.1:60]
// Inside diameter of hose is the outside diameter of the coupling
Inside_diameter_of_hose2_in_mm = 15;// [6:.1:60]
Wall_thickness__of_hose1_in_mm = 3;// [2:1:10]
Wall_thickness__of_hose2_in_mm = 3;// [2:1:10]


/* [Hidden] */
// No changes below here

D2=Inside_diameter_of_hose2_in_mm/2;
D1=Inside_diameter_of_hose1_in_mm/2;
WT1=Wall_thickness__of_hose1_in_mm;
WT2=Wall_thickness__of_hose2_in_mm;


$fn=200;
color ("red")
{
difference()
{
union()
{
hull()
{
translate([0,0,1])
cylinder(h=2,r=D1+2,center=true);
translate([0,0,-1])
cylinder(h=2,r=D1,center=true);
}
translate([0,0,-10])
cylinder(h=20,r=D1,center=true);
translate([0,0,10])
cylinder(h=20,r=D2,center=true);
translate([0,0,-20])
sphere(r=D1+.5,center=true);
translate([0,0,20])
sphere(r=D2+.5,center=true);
}
translate([0,0,-13])
cylinder(h=22.01,r=D1-WT1,center=true);
translate([0,0,11])
cylinder(h=26,r=D2-WT2,center=true);
translate([0,0,38.5])
cylinder(h=30,r=D2+2,center=true);
translate([0,0,-38.5])
cylinder(h=30,r=D1+2,center=true);
}
}