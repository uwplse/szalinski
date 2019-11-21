/**
* Author: Ivan Mihov
* www.imihov.com
*
* Customizable desk cable passage guide 
*/

draw = "both"; //["guide":Guide Only,"cover": Cover Only,"both":Both]

// Thickness of the lip
lip_thickness = 3;
// Width of the lip
lip_width = 10;

// Outside diameter of the cylinder
outside_diameter = 53;
// Wall thicknes of the cylinder
wall_thickness = 4;
// Inside diameter of the cylinder
inside_diameter = outside_diameter - wall_thickness;
// Height of the cylinder
height = 35;

// The cover thickness with the lip
cover_thickness = 6;
// How big the cover hole is
cover_hole = 45;
// Thickness of the cover lip
cover_wall_thickness = 2;
// Cover lip thickness
cover_lip_thickness = 1;

$fn = 120;

module guide() {
      
  outside_radius = outside_diameter / 2;
  inside_radius = inside_diameter / 2;
  lip_radius = outside_radius+lip_width;
      
  difference() {
    union() {
       //lip
       cylinder(r1=lip_radius-3, r2=lip_radius, h=lip_thickness);
       //cylinder
       cylinder(r=outside_radius, h=height+lip_thickness);
     }
     //hole
     translate([0,0,-1]) // for pretty preview + 2mm in height
     cylinder(r=inside_radius, h=height+lip_thickness+2);
   }
   cover_lip(inside_radius);
}

module guide_cover(
    diameter=inside_diameter) {
    translate([0,outside_diameter+lip_width+5,0]){
        difference() {
            //cover
            cylinder(r=(diameter/2)-0.5, h=cover_thickness);
            
            //cover hole
            translate([(diameter/2),0,-1]) {
                cylinder(r=cover_hole/2, h=cover_thickness+2);
            }
            
            //cover lip
            translate([0,0,cover_thickness/2]) {
                cylinder(r=((diameter/2)-0.5)-cover_wall_thickness, h=cover_thickness);
            }
        }
    }
}

//form top 3d shape
module cover_lip (radius) {
    translate([0,0,cover_thickness+cover_lip_thickness]) {
        rotate_extrude()
            translate([radius, 0, 0])
                difference() {
                circle(cover_lip_thickness);
            }
   }
}

if(draw == "guide" || draw == "both") {
    guide();
}
if(draw == "cover" || draw == "both") {
    guide_cover();
}