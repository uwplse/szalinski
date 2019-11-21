// Customizable Filament Spool insert for use with Roller Bearings.
// This should be able to be used with any size roller bearing, as long as 
// the roller bearing is smaller than the hole in the filament spool.
//
// Numerous prints were done using this 8x22x7 ball bearing:
// 608ZZ 8x22x7 Shielded Greased Miniature Ball Bearings
// http://www.amazon.com/gp/product/B002BBD6X4
//
// Tony Hansen 2015


// The diameter of the hole in the filament spool (in mm):
customizable_spool_diameter = 25.4;
// If desired, a convex insert can be created by setting a different top value:
customizable_spool_diameter_top = 25.4;
// The diameter of the ball bearing (in mm):
customizable_bearing_diameter = 22;
// The height of the ball bearing (in mm):
customizable_bearing_depth = 7;

module SpoolerWithBearing(
    spool_diameter,
    spool_diameter_top,
    bearing_diameter,
    bearing_depth,
    bearing_extra_diameter = 1,
    bearing_extra_depth = 0.25,
    spool_outer_lip_width = 2,
    spool_outer_lip_depth = 2,
    spool_inner_lip_depth = 2,
    spool_inner_top_lip_depth = 2,
    spool_inner_bottom_lip_width = 0.1,
    spool_diameter_slop = 0.5
) {
    spool_depth = bearing_depth + bearing_extra_depth + spool_inner_top_lip_depth;
    bearing_epsilon = 0.01;


    difference() {
        $fn = 100;
        union() {
            // outer lip
            color("green") cylinder(d=spool_diameter + spool_outer_lip_width*2, h=spool_outer_lip_depth);

            // spool holder
            color("blue") cylinder(d1=spool_diameter - spool_diameter_slop, 
                                d2=spool_diameter_top - spool_diameter_slop, h=spool_outer_lip_depth + spool_depth);
        }

        // inner core
        translate([0,0,-bearing_epsilon])
        color("yellow") 
        cylinder(d=bearing_diameter + bearing_extra_diameter - spool_inner_lip_depth, 
            h=spool_outer_lip_depth + spool_depth+2*bearing_epsilon);
        
        // bearing slot
        translate([0,0,spool_inner_lip_depth])
        color("red") cylinder(d=bearing_diameter + bearing_extra_diameter, h=bearing_depth + bearing_extra_depth);
        
        // nub
        color("green") cylinder(d=bearing_diameter + bearing_extra_diameter - spool_inner_bottom_lip_width,h=spool_inner_lip_depth);
    }
}

SpoolerWithBearing(
    spool_diameter = customizable_spool_diameter,
    spool_diameter_top = customizable_spool_diameter_top,
    bearing_diameter = customizable_bearing_diameter,
    bearing_depth = customizable_bearing_depth);
