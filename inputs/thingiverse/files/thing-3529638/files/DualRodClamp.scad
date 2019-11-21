// NOTE - could try to rotate for "easiest" FDM printing, but that depends on rod/nut/bolt sizes and orientation.
// Someone requested a 45 degree rod option: good idea!


//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// Second rod rotation
second_rod_rotation = 45; // [ -45:Negative45, 0:Parallel, 45:Plus45, 90:RightAngle]

// First rod diameter, in mm
first_rod_diameter = 12.0;  // [2.0:0.1:40]

// Second rod diameter, in mm
second_rod_diameter = 8.0; // [2.0:0.1:40]

// Additional rod offset, in mm
rod_offset = 0.0;   // [0.0:0.1:100]

// Bolt diameter, in mm
bolt_diameter = 3.0;    // [2:0.1:20]

// Nut diameter, in mm
nut_diameter = 6.0;  // [3:0.1:40]

// Nut thickness, in mm
nut_thickness = 2.8;  // [1.0:0.1:30]


/* [Extra_Features_for_Strength] */

// Margin to support the rods, in mm
rod_margin = 5; // [2:30]

// Nut clamp width margin, in mm
nut_clamp_margin = 4;   // [2:30]

//CUSTOMIZER VARIABLES END


// Sanity checks
if( second_rod_diameter <= 0 || first_rod_diameter <= 0
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
first_rad = (first_rod_diameter+0.5)/2;  // should be sorta tight
second_rad = (second_rod_diameter+0.5)/2;  // should be sorta tight

z_rod_diameter = (second_rod_rotation == 90) ? (first_rad*2) : max((first_rad*2),(second_rad*2));
z_nut_size = (second_rod_rotation == 90) ? nut_diameter+nut_clamp_margin : 0;

// x length
main_width = max( 10, (first_rad*2) + (second_rad*2) + max(rod_offset, rod_margin/2) + 2*nut_trap_len + 2*nut_clamp_margin );
// z length
main_depth= max( 10, max(z_rod_diameter+rod_margin,z_nut_size), (bolt_rad*2)+nut_clamp_margin );
// y length
main_heighty = max( 10, (second_rod_rotation==90) ? (second_rad*2)+rod_margin : nut_diameter + nut_clamp_margin, (bolt_rad*2)+nut_clamp_margin );
main_height = (second_rod_rotation == -45 || second_rod_rotation == 45) ? max(main_heighty,main_depth) : main_heighty;


// our object, translated to be flat on xy plane for easy STL generation
translate([0,0,main_depth/2])
    dual_rod_clamp();


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


module dual_rod_clamp() {

    first_x = 0;
    second_x = first_x - (second_rad + first_rad + max( rod_offset, rod_margin/2 ) );
    
    first_nut_x = first_x + first_rad + (nut_clamp_margin/2);
    first_nut_y = 0;
    
    second_nut_x = second_x - second_rad - (nut_clamp_margin/2);
    second_nut_y = 0;
    
    rod_length = max(main_height,main_depth) + 20;

    difference() {

      // the main block
      testx = -main_width/2 + first_rad + nut_trap_len + nut_clamp_margin;
      translate([testx,0,0])
        cube([main_width,main_height,main_depth],center = true);


      // first rod clamp nut and bolt hole
      translate([first_nut_x,first_nut_y,0])
        rotate([0,0,90])
          nuttrap();
      translate([first_x,first_nut_y,0])
        rotate([0,90,0])
          cylinder(main_width,bolt_rad,bolt_rad,$fn=32);

      // the first rod
    #color("green")
      translate([first_x,0,0])
        rotate([90,0,0])
          cylinder(rod_length,first_rad,first_rad,center=true,$fn=32);
       

      // second rod clamp nut and bolt hole
      nut_rotation = (second_rod_rotation == 90) ? -90 : 0;  // nut hole also up for +-45
      translate([second_nut_x-nut_trap_len,second_nut_y,0])
        rotate([0,nut_rotation,90])
          nuttrap();
      translate([second_x-main_width,second_nut_y,0])
        rotate([0,90,0])
          cylinder(main_width,bolt_rad,bolt_rad,$fn=32);

      // the second rod
    #color("magenta")
      translate([second_x,0,0])
        rotate([second_rod_rotation-90,0,0])
          cylinder(rod_length,second_rad,second_rad,center=true,$fn=32);
    }
}


