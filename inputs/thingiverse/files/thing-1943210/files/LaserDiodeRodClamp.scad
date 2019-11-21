// TODO - what else can be done to reduce cost, while keeping it easy to print?
// v1 Shapeways price difference when reducing material with existing settings (Nylon $5.65 vs $6.62)
// v2 Shapeways price difference when reducing material with existing settings (Nylon $4.89 vs $6.11)

//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// larger or smaller will need a bit of additional design work
// Diode diameter, in mm
diode_diameter = 12.0; // [2.0:0.1:50]

// Support rod diameter, in mm
rod_diameter = 8.0;  // [3:0.1:40]

// Bolt diameter, in mm
bolt_diameter = 3.0;    // [2:0.1:20]

// Nut diameter, in mm
nut_diameter = 6.0;  // [3:0.1:40]

// Nut thickness, in mm
nut_thickness = 2.8;  // [2:0.1:30]

/* [Extra_Features_for_Strength] */

// rod clamp width margin, in mm
clamp_margin = 5;   // [3:30]

// margin to support the rod in xy, in mm
rod_margin = 7; // [3:30]

// margin to support the rod in z, in mm
depth_margin = 6;   // [3:30]

// margin to support the diode and clamp, in mm
diode_margin = 5;   // [3:30]

// this saves material, but increases stress
// Match body to diode length or not, boolean
full_size_block = 1;   // [0:false, 1:true]

// this saves material, but increases stress, fails FDM printing
// Make the clamp arms smaller - won't print FDM, boolean
small_arms = 0;   // [0:false, 1:true]

//CUSTOMIZER VARIABLES END

// how much extra space to allow in nut trap
nut_space_factor = 1.2;

// Sanity checks
if( diode_diameter<=0 || rod_diameter <= 0
    || bolt_diameter <= 0 || nut_diameter <= 0 || nut_thickness <= 0)
{
    echo("<B>Error: Missing important parameters</B>");
}

if(nut_diameter<=bolt_diameter)
{
    echo("<B>Error: Nut size too small for bolt</B>");
}


max_gap_thickness = 6;  // don't let the arms get too thick

// z depth
main_depth= max( 10, max(rod_diameter,bolt_diameter,nut_diameter)+depth_margin );

nut_trap_len = nut_thickness*nut_space_factor;

// our object, translated to be flat on xy plane for easy STL generation
translate([0,0,main_depth/2])
    optics_clamp();

module optics_clamp(){

    bolt_rad= (bolt_diameter+1)/2;  // this should be sorta loose
    rod_rad= (rod_diameter+0.5)/2;  // should be almost tight
    diode_rad= (diode_diameter * 1.04)/2;  // don't increment this one as much - it needs to be a tight fit
    holder_rad = diode_rad + diode_margin/2;

    main_width= (rod_diameter+rod_margin)+clamp_margin+nut_trap_len;
    clamp_height= diode_diameter+diode_margin;

    main_height_without= max((nut_diameter+clamp_margin), bolt_diameter+rod_margin );
    main_height_with= max(clamp_height,main_height_without);
    main_height= (full_size_block != 0) ? main_height_with : main_height_without;

    rod_x= 0;
    diode_x= -(diode_rad + rod_rad + max(rod_margin,diode_margin)/2);
    nut_x= rod_x + rod_rad + clamp_margin/2;
    nut_y = 0;

    diode_clamp_depth_without= bolt_diameter+clamp_margin;
    diode_clamp_depth_with= max( bolt_diameter+clamp_margin, main_depth);
    diode_clamp_depth= (small_arms == 0) ? diode_clamp_depth_with : diode_clamp_depth_without;

    diode_clamp_space= min( max_gap_thickness, max(1, diode_rad / 2 ) );
    diode_clamp_length= min( 10, max( 7, diode_rad ) ) + max( bolt_diameter, clamp_margin ) + diode_margin/2;
    diode_clamp_thickness= min( diode_clamp_space+2*max_gap_thickness, max( diode_clamp_space + 3, diode_rad * 1.5 ) );
    diode_clamp_x= diode_x - diode_rad - (diode_clamp_length/2) + 0.1;  // fudge for small diodes

    diode_nut_x= diode_clamp_x - (diode_clamp_length/2) + (clamp_margin/2) + bolt_rad;

    diode_length= main_depth + 20;
    rod_length= main_height + 20;

    difference() {

        union() {
          // the main block
          translate([(clamp_margin)/2,0,0])
            cube([main_width,main_height,main_depth],center = true);

          // diode holder
          translate([diode_x,0,-main_depth/2])
            cylinder(main_depth,holder_rad,holder_rad);
          translate([diode_x/2,0,0])
            cube([-diode_x,main_height,main_depth],center = true);

          if (small_arms == 0) {
              // hacky fillet long
              translate([0,0,-main_depth/2])
                linear_extrude(main_depth)
                    polygon( [ [diode_x, -holder_rad], [diode_x, holder_rad], [diode_nut_x-bolt_diameter, 0] ] );
              // hacky fillet short
              translate([0,0,-main_depth/2])
                linear_extrude(main_depth)
                    polygon( [ [diode_x, -main_height/2], [diode_x, main_height/2], [(diode_x+diode_nut_x)/2, 0] ] );
          }

          // diode clamp arms
         translate([diode_clamp_x,0,0])
             cube([diode_clamp_length+1,diode_clamp_thickness,diode_clamp_depth],center = true);
        }

    // diode clamp gap
      translate([diode_clamp_x,0,0])
        cube([diode_clamp_length+2,diode_clamp_space,main_depth+5],center = true);

    // diode clamp bolt hole
      translate([diode_nut_x,rod_length/2,0])
        rotate([90,0,0])
          cylinder(rod_length,bolt_rad,bolt_rad);

    // rod clamp nut and bolt hole
      translate([nut_x,nut_y,0])
        rotate([0,0,90])
          nuttrap();
      translate([rod_x,nut_y,0])
        rotate([0,90,0])
          cylinder(main_width,bolt_rad,bolt_rad);

    // the support rod
    #color("green")
      translate([rod_x,rod_length/2,0])
        rotate([90,0,0])
          cylinder(rod_length,rod_rad,rod_rad);

    // the diode
    #color("magenta")
      translate([diode_x,0,-diode_length/2])
        rotate([0,0,0])
          cylinder(diode_length,diode_rad,diode_rad,$fn=32);    // needs to be fairly smooth
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