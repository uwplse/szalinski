
//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// Support rod diameter, in mm
rod_diameter = 8.0;  // [3:0.1:40]

// Bolt diameter, in mm
bolt_diameter = 3.0;    // [2:0.1:20]

// Nut diameter, in mm
nut_diameter = 6.0;  // [3:0.1:40]

// Nut thickness, in mm
nut_thickness = 2.8;  // [2:0.1:30]

// margin around the rod, in mm
rod_margin = 4; // [2:40]

//CUSTOMIZER VARIABLES END

// Sanity checks
if( rod_diameter <= 0
    || bolt_diameter <= 0 || nut_diameter <= 0 || nut_thickness <= 0)
{
    echo("<B>Error: Missing important parameters</B>");
}

if(nut_diameter<=bolt_diameter)
{
    echo("<B>Error: Nut size too small for bolt</B>");
}

// how much extra space to allow in nut trap
nut_space_factor = 1.2;

// z depth
main_depth= max( 10, nut_diameter+2*rod_margin );

nut_trap_len = nut_thickness*nut_space_factor;

// our object, translated to be flat on xy plane for easy STL generation
translate([0,0,main_depth/2])
    optics_clamp();

module optics_clamp(){

    bolt_rad= (bolt_diameter+1)/2;  // this should be sorta loose
    rod_rad= (rod_diameter+0.5)/2;  // should be almost tight
    clamp_rad = rod_rad + rod_margin;

    main_width= rod_rad + rod_margin + nut_trap_len;
    main_height= nut_diameter + 2*rod_margin;
    
    rod_x= 0;
    nut_x= rod_x + rod_rad + rod_margin/2;
    nut_y = 0;
    
    rod_length= main_depth + 20;
    
    difference() {

        union() {
          // the main block
          block_x = main_width/2;
          translate([block_x,0,0])
            cube([main_width,main_height,main_depth],center = true);
            
        translate([0,0,0])
            cylinder(main_depth,clamp_rad,clamp_rad,center=true);
        }

    // rod clamp nut and bolt hole
      translate([nut_x,nut_y,0])
        rotate([0,0,90])
          nuttrap();
      translate([rod_x,nut_y,0])
        rotate([0,90,0])
          cylinder(main_width*2,bolt_rad,bolt_rad);

    // the support rod
#   color("green")
      translate([rod_x,0,-rod_length/2])
        cylinder(rod_length,rod_rad,rod_rad);
    }
}

module hexagon(height,radius) 
{
  linear_extrude(height)
    circle(radius,$fn=6);
}

module nuttrap(){
  translate([0,-nut_trap_len/2,main_depth/2])
    cube([nut_diameter,nut_trap_len,main_depth],center =true);
  rotate([90,360/12,0]) // so point is down, nut trapped by straight sides
    hexagon(nut_trap_len,(nut_diameter+1)/2);
}