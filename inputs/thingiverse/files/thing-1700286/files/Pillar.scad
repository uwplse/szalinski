//---------------------------------------------------------------
//-- CUSTOMIZER PARAMETERS
//---------------------------------------------------------------


// - Pillar height
Pillar_Height = 50;
// - Pillar external diameter
Pillar_ext_dia = 20;
// - Pillar internal diameter
Pillar_int_dia = 3.05; // M3
// - Pillar base hole diameter
Pillar_bh_dia = 9;
// - Pillar Fillet
Pillar_Fillet = 12;
// - Pillar top thickness
Pillar_top_thick = 7;


Pillar_bh_height = Pillar_Height - Pillar_top_thick;


//---------------------------------------------------------------
//-- MODULES
//---------------------------------------------------------------



module Bpillar(pillar_height, ext_diameter, int_diameter, base_hole_diameter, base_hole_height, pillar_Fillet){
    translate([0, 0, 0])
     difference() {
        cylinder(d = ext_diameter + pillar_Fillet, h = pillar_height, $fn=64);
        rotate_extrude($fn = 64) {
          translate([(ext_diameter + pillar_Fillet * 2)/2, pillar_Fillet, 0]) {
            minkowski(){
              square(pillar_height);
              circle(pillar_Fillet, $fn=64);
            }
          }
        }
    cylinder(d = int_diameter, h = pillar_height, $fn = 64);
    color("red") 
      translate([0, 0, 0])
        cylinder(d = base_hole_diameter, h = base_hole_height, $fn = 64);
    }
} 



//---------------------------------------------------------------
//-- RENDERS
//---------------------------------------------------------------


difference() {
Bpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
translate([0, -50, 0]) cube([100, 100, 100], center = true);
}