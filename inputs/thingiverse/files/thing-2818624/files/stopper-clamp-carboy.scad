/*==================================
Name:       Carboy Stopper Clamp
Author:     Nathan Allen
Desc:       Stopper for 3/5/6.5 gallon glass carboys from Northern Brewer. Keeps fresh wet stoppers from pushing up and out of the jug.

V-1.0 (9/5/17)
   -Initial Model
   -Work based on 1 gallon milk bottle version adapted to fit

V-1.1 (9/6/17)
   -Adjusted fit

====================================*/

//SYSTEM VARIABLES
$fn=200;                   //Resolution
//END OF SYSTEM VARIABLES

wall_t=3.25;               // Overall part wall thickness
swall_t=5;                 //sidewall thickness
neck_d=48.5;               // Jug neck diameter
neck_h=12;                 // Jug neck height
lip_d=56;                  // Jug lip diameter
lip_h=5.5;                 // Jug lip height
seal_h=10;                  // Stopper height above jug lip
seal_d=37.5;               // Stopper diameter
seal_hole_d=15;            // Outlet hole diameter for airlock access
cutaway_w=54.5;            // Cutaway width (1.5-2mm smaller than jug lip for nice snap on action with good hold)
//END OF MODEL CUSTOMIZATION

//MODEL GENERATION
rotate([90, 0, 0]) difference(){
   intersection(){
      translate([0, 0, (neck_h+lip_h+seal_h+wall_t)/2])
         sphere(d=lip_d+(swall_t*2));
      cylinder(d=lip_d+(swall_t*2), h=neck_h+lip_h+seal_h+wall_t);
   }
   cylinder(d1=neck_d, d2=lip_d, h=neck_h);
   translate([-neck_d/2, 0, 0])
   cube([neck_d, lip_d/2+swall_t, neck_h]);
   translate([0, 0, neck_h]){
      cylinder(d=lip_d, h=lip_h);
      translate([-cutaway_w/2, 0, 0])
         cube([cutaway_w, lip_d/2+swall_t, lip_h]);
   }
   translate([0, 0, neck_h+lip_h]){
      cylinder(d=seal_d, h=seal_h);
      translate([-seal_d/2, 0, 0])
         cube([seal_d, lip_d/2+swall_t, seal_h]);
   }
   translate([0, 0, neck_h+lip_h+seal_h]){
      cylinder(d=seal_hole_d, h=wall_t);
      translate([-seal_hole_d/2,0,0])
         cube([seal_hole_d, lip_d/2+swall_t, wall_t]);
   }
   translate([-cutaway_w/2, 0, neck_h])
      rotate([0, atan(neck_h/((lip_d-neck_d)/2)), 0])
         cube([sqrt(pow((cutaway_w-neck_d)/2, 2)+pow(neck_h, 2)), lip_d/2+swall_t, sqrt(pow((cutaway_w-neck_d)/2, 2)+pow(neck_h, 2))]);
   translate([cutaway_w/2, 0, neck_h])
      rotate([0, 180+atan(((lip_d-neck_d)/2)/(neck_h)), 0])
         cube([sqrt(pow((cutaway_w-neck_d)/2, 2)+pow(neck_h, 2)), lip_d/2+swall_t, sqrt(pow((cutaway_w-neck_d)/2, 2)+pow(neck_h, 2))]);

}