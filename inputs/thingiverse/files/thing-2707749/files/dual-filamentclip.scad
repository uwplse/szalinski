//////////////////////////////////////////////////////////////////
// Double-sided filament clip - securely grips both strands
//
// Remixed from: Universal 1.75mm filament clip by mpmselenic
//               Published on March 9, 2017
//               www.thingiverse.com/thing:2166143
//////////////////////////////////////////////////////////////////

// Parameters

// Nominal filament dia in mm (Typicallly 1.75 or 2.85)
filament_dia    = 1.75;
// offset in mm - typically slightly negative to lighty grip filament (-0.1)
offset             = -0.1;    
// Wall thickness. Cura seems to not produce full curved walls at 0.8mm?
thick           = 0.91;     
// height of extrusion
height          = 7;

// Derived variables
inner_r = (filament_dia + offset)/2;
spacing = inner_r * 0.5;        // depth of throat bigger than diameter to allow curvature and better retention
outer_r = inner_r + thick;

$fn=60*1;

// Objects

// fuse 2 "C" clips back-to-back
union() {    
    translate ([+outer_r,0,0]) c_clip();
    mirror ([1,0,0]) translate ([+outer_r,0,0]) c_clip();
}

module c_clip() {
    difference() {
      union() {
        // handle
        translate([-(spacing+outer_r),-thick/2,0])
            cube([thick*2,thick, height]);
        
        // Outer shell
        hull() {
          cylinder(h=height, r1=outer_r, r2=outer_r);
          translate([spacing,0,0])
            cylinder(h=height, r1=outer_r, r2=outer_r);
        }
      }
      
      // Make subtractive objects +2 taller and offset by -1 in z to avoid conincdent faces 
      // screwing up preview or causing non-manifold objects
      
      // inner oval
      hull() {
        translate ([0,0,-1]) cylinder(h=height+2, r1=inner_r, r2=inner_r);
        translate([spacing,0,-1])
            cylinder(h=height+2, r1=inner_r, r2=inner_r);
      }
      
      // notch in end
      translate([spacing+0.2+10/1.414,0,0])
        rotate([0,0,45])
            translate([-5,-5,-1])
                cube([10,10,height+2], center=1);
    }
}