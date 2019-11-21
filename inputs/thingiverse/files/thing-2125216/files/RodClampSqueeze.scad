
//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// larger or smaller will need a bit of additional design work
// Rod diameter, in mm
rod_diameter = 8.0; // [2.0:0.1:50]

// Bolt diameter, in mm
bolt_diameter = 3.0;    // [2:0.1:20]

// margin along the rod, in mm
depth_margin = 3;   // [2:30]

// margin around the rod, in mm
rod_margin = 3;   // [2:30]

// this saves material, but increases stress, requires supports for FDM printing
// Make the clamp arms smaller - won't print FDM, boolean
small_arms = 0;   // [0:false, 1:true]

//CUSTOMIZER VARIABLES END


// Sanity checks
if( rod_diameter<=0
    || bolt_diameter <= 0 )
{
    echo("<B>Error: Missing important parameters</B>");
}


max_gap_thickness = 6;  // don't let the arms get too thick

// z depth
main_depth= max(3, bolt_diameter) + depth_margin*2;

// our object, translated to be flat on xy plane for easy STL generation
translate([0,0,main_depth/2])
    optics_clamp();

module optics_clamp(){

    bolt_rad= (bolt_diameter+1)/2;  // this should be sorta loose
    rod_rad= (rod_diameter * 1.06)/2;  // don't increment this one as much - it needs to be a tight fit
    holder_rad = rod_rad + rod_margin;

    main_height= rod_diameter+rod_margin;
    
    rod_x = 0;

    rod_clamp_depth_without= bolt_diameter+rod_margin;
    rod_clamp_depth_with= max( bolt_diameter+rod_margin, main_depth);
    rod_clamp_depth= (small_arms == 0) ? rod_clamp_depth_with : rod_clamp_depth_without;

    rod_clamp_space= min( max_gap_thickness, max(1, rod_rad / 2 ) );
    rod_clamp_length= min( 10, max( 7, rod_rad ) ) + max( bolt_diameter, rod_margin ) + rod_margin;
    rod_clamp_thickness= min( rod_clamp_space+2*max_gap_thickness, max( rod_clamp_space + 3, rod_rad * 1.5 ) );
    rod_clamp_x= rod_x - rod_rad - (rod_clamp_length/2) + 0.1;  // fudge for small rods

    rod_nut_x= rod_clamp_x - (rod_clamp_length/2) + (rod_margin/2) + bolt_rad;

    rod_length= main_depth + 20;

    difference() {

        union() {

          // diode holder
          translate([rod_x,0,-main_depth/2])
            cylinder(main_depth,holder_rad,holder_rad);

          if (small_arms == 0)  {
              // hacky fillet long
              translate([0,0,-main_depth/2])
                linear_extrude(main_depth)
                    polygon( [ [rod_x, -holder_rad], [rod_x, holder_rad], [rod_nut_x, 0] ] );
              // hacky fillet short
              translate([0,0,-main_depth/2])
                linear_extrude(main_depth)
                    polygon( [ [rod_x, -main_height/2], [rod_x, main_height/2], [(rod_x+rod_nut_x)/2, 0] ] );
          }

          // diode clamp arms
         translate([rod_clamp_x,0,0])
             cube([rod_clamp_length+1,rod_clamp_thickness,rod_clamp_depth],center = true);
        }

    // diode clamp gap
      translate([rod_clamp_x,0,0])
        cube([rod_clamp_length+2,rod_clamp_space,main_depth+5],center = true);

    // diode clamp bolt hole
   translate([rod_nut_x,10,0])
      rotate([90,0,0])
        cylinder(20,bolt_rad,bolt_rad);

    // the rod
    #color("magenta")
      translate([rod_x,0,-rod_length/2])
        rotate([0,0,0])
          cylinder(rod_length,rod_rad,rod_rad,$fn=32);    // needs to be fairly smooth
    }
}
