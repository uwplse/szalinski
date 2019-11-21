/* [Main disc] */

//How big is the main disc.  All values in mm
disc_radius = 30;
//How thick is the main disc.
disc_thickness = 3;
//How big is the center hole?
hole_radius = 5;

/* [Slots] */
//How big is your slot?
slot_height = 6;
//How wide is your slot?
slot_width = 3;
//How far from the edge of the disk do you want the slot?
slot_offset = 1;

//How much rotation before I draw the next slot.  You'll get the best results if this is a clean divisor of 360.
rotate_by = 15; //[1:360]

/* [Hidden] */
current_rotation = 0;

rotate_steps = 360 / rotate_by;

difference(){
    cylinder(disc_thickness,disc_radius,disc_radius);
    cylinder(disc_thickness,hole_radius,hole_radius);
  
    for(i  = [0:1:rotate_steps])
    {
        rotate([0,0,rotate_by*i]){
            slot();
        }
    }
}
    
module slot(){
    translate([disc_radius - slot_height - slot_offset,-(slot_width/2),0]) 
        cube([slot_height,slot_width,disc_thickness]);
}