//
// Tuning peg knob
// version 1.0   7/26/2015
// by daozenciaoyen
//

/* [Hole (Peg)] */
// length of the hole (in mm)
hole_x = 5 ; // [3:0.1:8]
// the shorter dimension (in mm)
hole_y = 3.4 ; // [2:0.1:6]
// in mm
hole_depth = 8 ; // [5:12]

/* [Knob] */
// in mm
knob_width = 22 ; // [14:30]
// same direction as hole depth (in mm)
knob_height = 14 ; // [10:30]
// the minimum thickness (in mm)
min_thickness = 3 ; // [1:0.2:5]
// chamfer % (width)
chamfer_width_pct = 0.3 ; // [0:0.1:0.4]
// chamfer % (thickness)
chamfer_thick_pct = 0.3 ; // [0:0.1:0.4]

/* [Hidden] */
knob_thickness = hole_y + min_thickness*2 ;
knob_width_slope = knob_width * chamfer_width_pct ;
knob_thick_slope = knob_thickness * chamfer_thick_pct ;
knob_slope_angle = atan(knob_thick_slope/knob_width_slope) ;
knob_slope_hyp = sqrt(pow(knob_width_slope,2)+pow(knob_thick_slope,2)) ;
hole_flat = hole_x/2 - hole_y/2 ;
knob_height1 = knob_height < hole_depth + min_thickness ? 
  hole_depth + min_thickness :
  knob_height ;
ff = 0.001 ;
$fn = 32 ;

main() ;

module main()
{
    translate([0,0,knob_height1])
    rotate([-90,0,0])
    difference() 
    {
        knob() ;
        hole() ;
        slope() ;
        mirror([1,0,0]) slope() ;
        mirror([0,0,1]) slope() ;
        mirror([1,0,0]) mirror([0,0,1]) slope() ;
    }
} 

module knob() 
{
    translate([0,knob_height1/2+ff,0])
    cube([knob_width-ff*2,knob_height1-ff*2,knob_thickness-ff*2], center=true) ;
}

module hole()
{
    rotate([-90,0,0])
    linear_extrude(height=hole_depth)
    hull() 
    {
        translate([-hole_flat,0,0]) circle(hole_y/2) ;
        translate([hole_flat,0,0]) circle(hole_y/2) ;
    }
}

module slope()
{
    translate([knob_width/2-knob_width_slope,ff,-knob_thickness/2])
    rotate([0,-knob_slope_angle,0])
    difference() 
    {
        rotate([0,knob_slope_angle,0])
            cube([knob_width_slope,knob_height1,knob_thick_slope]) ;
        translate([0,-ff,0])
            cube([knob_slope_hyp,knob_height1+ff*2,knob_thick_slope]) ;
    }
}