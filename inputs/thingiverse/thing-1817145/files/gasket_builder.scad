use <utils/build_plate.scad>

//----------------------------------------------------------------------------
// Customize a gasket mold
// http://www.thingiverse.com/thing:1817145
// 
// by Erwin Ried (2016-10-11)
// http://www.thingiverse.com/eried/things

//---[ USER Customizable Parameters ]-----------------------------------------

/* [ Gasket ] */

// Inner diameter (mm)
inner_diameter = 50;  //[10:1:300]

// Outer diameter (mm)
outer_diameter = 60;  //[10:1:300]

// Gasket tickness (mm)
gasket_tickness = 2; //[1:0.1:9]

/* [ Mold ] */

// Bottom tickness (mm)
bottom_wall_tickness = 0.6; //[0.1:0.1:9]

// Lateral tickness (mm)
lateral_walls_width = 2; //[1:1:9]

//---[ Build Plate ]----------------------------------------------------------

/* [Build plate] */
//: for display only, doesn't contribute to final object
build_plate_selector = 2; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//: when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//: when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south, tilt:top]

//----------------------------------------------------------------------------

module draw()
{
    //translate([0,0,gasket_tickness])
    difference()
    {
        difference()
        {
            cylinder(gasket_tickness+bottom_wall_tickness,(outer_diameter+lateral_walls_width)/2,(outer_diameter+lateral_walls_width)/2, $fn=50);
            cylinder(gasket_tickness+bottom_wall_tickness+1,(inner_diameter-lateral_walls_width)/2,(inner_diameter-lateral_walls_width)/2, $fn=50);
        }
        
        translate([0,0,bottom_wall_tickness])
         difference()
        {
            cylinder(gasket_tickness,outer_diameter/2,outer_diameter/2, $fn=50);
            cylinder(gasket_tickness+1,inner_diameter/2,inner_diameter/2, $fn=50);
        }
    }
}

draw();