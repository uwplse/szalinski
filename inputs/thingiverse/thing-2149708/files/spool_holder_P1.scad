// Parametric spool holder for MBI R2 by Woale modified by TheFisherOne

// preview[view:north west, tilt:top diagonal]

/* [General] */
// an allowance that has to be made because the plastic is likely to expand to larger than is desired, usually a small positive number of mm. ALL Dimensions are in mm, multiply inches by 25.4 to get mm.
expansion_allowance=0; // [0:0.1:2]

/* [Size of Hole and Lip that it has to fit into] */
// the width of the hole it has to fit into (note it will be built smaller than this)
measured_lip_width=51; // [23:1:75]
// the depth of the lip that it will be hanging on to
measured_lip_depth=7.1; // [5:0.1:25]
// how high the space is above the lip
measured_lip_height=16; // [5:0.1:40]

/* [ measurements of the spool that needs to hang on it] */
//the spool that wants to hang on it
// the diameter of the hole in the spool
measured_spool_hole_diameter = 53; // [23:0.5:75]
// how long the hole is (not the overall width of the spool, but the part that will sit on the holder)
measured_inside_spool_width=64; //[23:0.5:100]
// offset of the edge of the spool compared to the edge of the hole, note that this is on the inside facing the wall
measured_spool_offset_on_inside=0; //[0:0.1:25]
 
/* [Hidden] */
//corrections to allow for expansion
lip_max_width=measured_lip_width-expansion_allowance;
lip_height=measured_lip_height-expansion_allowance;
spool_hole_diameter=measured_spool_hole_diameter-expansion_allowance;
inside_spool_width=measured_inside_spool_width+expansion_allowance;
spool_offset=measured_spool_offset_on_inside+expansion_allowance;
lip_depth=measured_lip_depth+expansion_allowance;

//fixed
thickness=5;
plate_top_length=23;
spindle_plate_length=75;
spindle_lip_height=5;


//formulas
//need space to put one lip and the shaft through the hole
final_diameter=spool_hole_diameter-spindle_lip_height;
// narrow the width so that the spindle will have a flat side and it is easier to print without supports
lip_width=((final_diameter-thickness) < lip_max_width)? final_diameter-thickness:lip_max_width;

//fix
$fn=40;

//plate holder
module plt_hld()
{
	//box1 with the end cut at 45 degrees
    // the length is the length of the part that sticks above the bar plus the side of a triangle whose hypotonuse is the lip_height and the other side is approximated by a 45 triangle of size lip_depth
    temp_plate_len=plate_top_length+sqrt((lip_height*lip_height)-(lip_depth/sqrt(2))*lip_depth/sqrt(2));
    difference(){
	  cube([temp_plate_len,thickness,lip_width]);
        // cut off the end at a 45 degree angle, make it just a little longer in every dimension to make the cut clean
      translate([temp_plate_len,thickness,-1])
         rotate([0,0,225])
            cube([thickness*2, thickness*2, lip_width+2]);
    }
	//box2
	translate([plate_top_length,thickness,0]) 
        cube([thickness,lip_depth,lip_width]);
	//box3
	translate([plate_top_length,thickness+lip_depth,0]) 
        cube([spindle_plate_length,thickness,lip_width]);
}



//spool holder
module spl_hld()
{
    //the main holder
    y_offset_of_cylinder=2*thickness+lip_depth;
    x_offset_of_cylinder=plate_top_length+thickness+spindle_lip_height+final_diameter/2;
    translate([x_offset_of_cylinder,y_offset_of_cylinder , lip_width/2])
      rotate([-90,0,0])
      cylinder(h=inside_spool_width+spool_offset+thickness, 
             d=final_diameter);
    // the inside lip
    translate([x_offset_of_cylinder-spindle_lip_height, y_offset_of_cylinder+spool_offset-thickness, lip_width/2])
      rotate([-90,0,0])
      cylinder(h=spindle_lip_height, 
             d=final_diameter);
    // the outside lip
    translate([x_offset_of_cylinder-spindle_lip_height, y_offset_of_cylinder+spool_offset+inside_spool_width, lip_width/2])
      rotate([-90,0,0])
      cylinder(h=spindle_lip_height, 
             d=final_diameter);

}
intersection(){
union(){
    spl_hld();
    plt_hld();
}
cube([plate_top_length+spindle_plate_length, 3*thickness+lip_depth+inside_spool_width+spool_offset, lip_width]);
}
