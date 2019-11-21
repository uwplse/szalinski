// TODO - supports underneath platform (hard to print without flat platform, print inverted - but could modify current model)


//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// Platform style
platform_style = 3; // [0:"Flat", 1:"V Outward", 2:"V Across", 3:"Double V"]

// Platform length, in mm
platform_length = 40; // [10:1:100];

// Platform width, in mm
platform_width = 40; // [10:1:100];

// Platform height, in mm
platform_height = 4;    // [1:40]

// V cut height, in mm
v_height = 10;  // [1:100]

// Rod diameter, in mm
rod_diameter = 8.0;  // [2.0:0.1:40]

// Bolt diameter, in mm
bolt_diameter = 3.0;    // [2:0.1:20]

// Nut diameter, in mm
nut_diameter = 6.0;  // [3:0.1:40]

// Nut thickness, in mm
nut_thickness = 2.8;  // [1.0:0.1:30]


/* [Extra_Features_for_Strength] */

// Extra height for rod clamp, in mm
clamp_extra = 10;    // [0:100]

// Margin to support the rods, in mm
rod_margin = 5; // [2:30]

// Nut clamp width margin, in mm
nut_clamp_margin = 4;   // [2:30]

//CUSTOMIZER VARIABLES END


// Sanity checks
if( rod_diameter <= 0
    || bolt_diameter <= 0 || nut_diameter <= 0 || nut_thickness <= 0)
{
    echo("<B>Error: Missing important parameters</B>");
}

if(nut_diameter <= bolt_diameter)
{
    echo("<B>Error: Nut size too small for bolt</B>");
}

// how much extra space to allow in nut trap, not user settable
nut_space_factor = 1.20;

nut_trap_len = nut_thickness*nut_space_factor;

bolt_rad = (bolt_diameter+0.7)/2;  // this should be almost loose
rod_rad = (rod_diameter+0.5)/2;  // should be sorta tight

z_rod_diameter = (rod_rad*2);
z_nut_size = 0;


// x length
main_width = max( 10, (rod_rad*2) + rod_margin/2 + nut_trap_len + nut_clamp_margin );
// y length
main_height= max( 10, max(z_rod_diameter+rod_margin,z_nut_size), (bolt_rad*2)+nut_clamp_margin );
// z length
main_depth = max( 10, nut_diameter + nut_clamp_margin, (bolt_rad*2)+nut_clamp_margin, platform_height ) + clamp_extra;




// our object, translated to be flat on xy plane for easy STL generation
component_platform();


module hexagon(height,radius) 
{
  linear_extrude(height)
    circle(radius,$fn=6);
}

module nuttrap(){
  trap_depth = max( main_depth, main_height );
  translate([0,-nut_trap_len/2,trap_depth/2])
    cube([nut_diameter,nut_trap_len,trap_depth],center=true);
  rotate([90,360/12,0]) // so point is down, nut trapped by straight sides
    hexagon(nut_trap_len,(nut_diameter+1)/2);
}


module component_platform() {

    rod_x = 0;
    
    nut_x = rod_x + rod_rad + (nut_clamp_margin/2);
    nut_y = 0;

    rod_length = max(main_height,main_depth) + 20;
    
    platform_x = -rod_rad -rod_margin/2;
    
    platform_depth = platform_height + ((platform_style == 0) ? 0 : v_height);
    
    difference() {
        translate([-platform_length/2 + platform_x,0,platform_depth/2])
            cube([platform_length,platform_width,platform_depth],center = true);
        
        cut_width = platform_width + 1;
        cut_length = platform_length + 1;
        cut_height = v_height + 1;
       
        if (platform_style == 1 || platform_style == 3) {
            v_width = cut_width/2;
            translate([platform_x-cut_length,0,platform_height])
              rotate([90,0,90])
                linear_extrude(cut_length)
                  polygon( [ [0, 0], [v_width, cut_height], [-v_width, cut_height] ] );
        }
        
        if (platform_style == 2 || platform_style == 3) {
            v_width = cut_length/2;
            translate([platform_x-cut_length/2,cut_width/2,platform_height])
              rotate([90,0,0])
                linear_extrude(cut_width)
                  polygon( [ [0, 0], [v_width, cut_height], [-v_width, cut_height] ] );
        }
    }
    

    tri_width = platform_width/2 - main_height/2;
    tri_height = main_depth - platform_height;
    translate([platform_x+platform_height,main_height/2,platform_height])
      rotate([0,-90,0])
        linear_extrude(platform_height)
          polygon( [ [0, 0], [tri_height, 0], [0, tri_width] ] );
    translate([platform_x+platform_height,-main_height/2,platform_height])
      rotate([0,-90,0])
        linear_extrude(platform_height)
          polygon( [ [0, 0], [tri_height, 0], [0, -tri_width] ] );
    
    tri2_width = (rod_rad*2) + rod_margin/2 - platform_height;
    tri2_height = tri_width;
    translate([platform_x+platform_height,main_height/2,0])
        linear_extrude(platform_height)
          polygon( [ [0, 0], [tri2_width, 0], [0, tri2_height] ] );
    translate([platform_x+platform_height,-main_height/2,0])
        linear_extrude(platform_height)
          polygon( [ [0, 0], [tri2_width, 0], [0, -tri2_height] ] );
 
 
    translate([0,0,main_depth/2])
        difference() {
    
          union() {
              // the main block
              testx = -main_width/2 + rod_rad + nut_trap_len + nut_clamp_margin;
              translate([testx,0,0])
                cube([main_width,main_height,main_depth],center = true);

             // strength bar next to platform, connects to triangles, can overlap rod!
             translate([platform_x,-platform_width/2,-main_depth/2])
                cube([platform_height,platform_width,platform_height]);
          }
    
          // rod clamp nut and bolt hole
          translate([nut_x,nut_y,0])
            rotate([0,-90,90])
              nuttrap();
          translate([rod_x,nut_y,0])
            rotate([0,90,0])
              cylinder(main_width,bolt_rad,bolt_rad,$fn=32);
    
          // the rod
        #color("green")
          translate([rod_x,0,0])
            rotate([0,0,0])
              cylinder(rod_length,rod_rad,rod_rad,center=true,$fn=32);
    
       }

}


