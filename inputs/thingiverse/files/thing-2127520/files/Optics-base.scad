// Optics base with and without magnet, with optional nut and bolt, which also makes a good safety cap when inverted.
// "it's a floor wax AND dessert topping!"

// Based on http://www.thingiverse.com/thing:28133  by jpearce
// ccox - Customization options added, height defined as a whole, chamfer option added, bolt option added

//CUSTOMIZER VARIABLES

// Height of base, in mm
base_height= 40;  // [10:100]

// Diameter of base, in mm
base_diameter= 50;   // [10:100]

// Diameter of rod, in mm
rod_diameter= 8;  // [2:0.1:30]

// depth of rod inside base, in mm
rod_depth= 20;  // [5:0.1:80]

// Margin for support around rod, in mm
rod_margin= 3;  // [1:0.1:20]


// Include hole on bottom for magnet, boolean
magnet_hole= 1;   // [0:false, 1:true]

// Diameter of magnet hole, in mm
magnet_diameter= 13;  // [2:1:30]

// Thickness/Height of magnet hole, in mm
magnet_thickness= 3.5;  // [2:0.5:20]


// Chamfer bottom edge, boolean
chamfer_edge= 1;   // [0:false, 1:true]


// Include bolt and nut to secure rod, boolean
include_bolt= 1;   // [0:false, 1:true]

// Bolt diameter, in mm
bolt_diameter = 3.0;    // [2:0.1:20]

// Nut diameter, in mm
nut_diameter = 6.0;  // [3:0.1:40]

// Nut thickness, in mm
nut_thickness = 2.8;  // [2:0.1:30]

// Nut holder margin for strength, in mm
nut_margin = 4;  // [2:0.1:30]

//CUSTOMIZER VARIABLES END


// how much extra space to allow in nut trap
nut_space_factor = 1.2;


// Sanity checks
if(base_height<=rod_depth)
{
    echo("<B>Error: Rod goes through base</B>");
}

if(rod_diameter>=base_diameter)
{
    echo("<B>Error: Base too small for rod</B>");
}

nut_trap_len = nut_thickness*nut_space_factor;
section_height = base_height / 8;


// our object, flat on XY plane for easy STL generation
optics_base();

module optics_base() {
   
    base_radius = base_diameter / 2;
    rod_radius = (rod_diameter+0.5)/2;  // should be almost tight
    bolt_rad= (bolt_diameter+1)/2;  // this should be sorta loose
    support_radius = rod_radius + rod_margin;
    magnet_radius = magnet_diameter / 2;
    nut_block_len = rod_radius + rod_margin + nut_trap_len + nut_margin/2;
    nut_block_width = nut_diameter + nut_margin;

    difference(){
        
        union() {
            
            // lower section
            if (chamfer_edge == 1) {
                half_section = section_height/2;
                translate([0,0,half_section])
                    cylinder(half_section,base_radius,base_radius);
                cylinder(half_section,base_radius-half_section,base_radius);
            } else {
                cylinder(section_height,base_radius,base_radius);
            }
            
            // sloping section
            translate([0,0,section_height])
                cylinder(section_height*5,base_radius,support_radius);
            
            // support for rod
            cylinder(base_height,support_radius,support_radius);
            
            if (include_bolt == 1) {
                translate([0,-nut_block_width/2,0])
                    cube([nut_block_len,nut_block_width,base_height]);
            }
        }
        
        // our optional magnet hole
        if (magnet_hole == 1){
            cylinder(magnet_thickness,magnet_radius,magnet_radius);
        }

        // rod clamp nut and bolt hole
        if (include_bolt == 1) {
           nut_x = nut_block_len - nut_trap_len - rod_margin/2;
           nut_y = 0;
           nut_z = base_height - section_height;
           translate([nut_x,nut_y,nut_z])
              rotate([0,0,90])
                nuttrap();
           translate([0,nut_y,nut_z])
              rotate([0,90,0])
                cylinder(support_radius*2,bolt_rad,bolt_rad);
        }
        
        // the rod
        rod_height = base_height - rod_depth;
#        translate([0,0,rod_height])
            cylinder(10+rod_depth*2,rod_radius,rod_radius);
    }
    
}

module hexagon(height,radius) 
{
  linear_extrude(height)
    circle(radius,$fn=6);
}

module nuttrap(){
  translate([0,-nut_trap_len/2,(section_height+6)/2])
    cube([nut_diameter,nut_trap_len,section_height+6],center =true);
  rotate([90,360/12,0]) // so point is down, nut trapped by straight sides
    hexagon(nut_trap_len,(nut_diameter+1)/2);
}

// ok, it had to be said:  "All your base are belong to us"   :-)

