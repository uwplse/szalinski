// Prusa lack shim + standoff
//


/* Global */
// Print a standoff
use_standoff = 1; // [1:True, 0:False]

// Customizer doesn't like boolean
// you can set it here if you use OpenSCAD
standoff = ( use_standoff == 1) ? true: false ;
//standoff = false; 

// Shim thickness in mm
shim_thickness = 0.8 ; 

// screw diameter used
screw_hole = 5.0 ;

// fudge
// corner radius
corner_cylinder_r = 2.5;  
// part clearance (you probably don't want to change this)
clearance = 0.3; 

// from the part 

// Space between the surface where the screw head rests and outside of the part (you probably don't want to change this)
depth_of_bottom = 2.9 ; // 
// Size of the screw hole (you probably don't want to change this)
part_screw_hole = 7 ; //
// Length and width of the part (you probably don't want to change this)
part_width = 50 ; // 

// calculate (once?)
shim_trans = (part_width/2 - corner_cylinder_r/2) ;

/* [Hidden] */
// ignore variable values
$fn=24;

// the parts

difference()
{
    union()
    {
            
        // screw standoff
        if ( standoff == true )
        {
            cylinder( h=  depth_of_bottom, d = part_screw_hole - clearance );
        }
        // shim
        hull()
        {
            translate([ shim_trans, shim_trans ,0 ])
            cylinder( h= shim_thickness , d = corner_cylinder_r );
            translate([ -shim_trans, shim_trans ,0 ])
            cylinder( h= shim_thickness , d = corner_cylinder_r );
            translate([ shim_trans, -shim_trans ,0 ])
            cylinder( h= shim_thickness , d = corner_cylinder_r );
            translate([ -shim_trans, -shim_trans ,0 ])
            cylinder( h= shim_thickness , d = corner_cylinder_r );
            
        }
    }
    
    // hole for screw
    hole_size = standoff ? screw_hole - clearance : part_screw_hole ;
    translate([0,0, - clearance/2])
    cylinder( h=  depth_of_bottom + clearance, d = screw_hole - clearance );

}
    