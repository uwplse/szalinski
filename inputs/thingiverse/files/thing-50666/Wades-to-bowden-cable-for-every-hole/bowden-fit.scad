/*I made this part to check customizer and play with openscad.
*It is based on this: http://www.thingiverse.com/thing:36240 from Petehagoras
*The dimensions for the holes are taken from jonaskuehling's openscad
* model http://www.thingiverse.com/thing:18379 (Greg's Wade reloaded)
* The dimensions are tight, so i don't know if it will work out of the box.
*Wade's to bowden cable by cr3a7ure
*I'm not familiar with licences so i'll keep the original
*/

bowden_cable_diameter = 6;// [6:3mm_Filament,4:1.75mm_Filament,3.5:Fill_that_hole]
hotend_mount_hole = 16; //[16:J_head_or_grrf_peek,12.7:Wildseyed_mount_or_Mendel_parts_v6,15:geared_extruder,10:reprapfab.org]
hole_height = 10; // [10:what_you_want,20:reprapfab.org]


difference(){
cylinder(r=hotend_mount_hole/2,h=hole_height,$fn=60);
cylinder(r=bowden_cable_diameter/2,h=hole_height,$fn=60);
translate([-1.6/2,-hotend_mount_hole/2,4]) cube([1.6,hotend_mount_hole,16]);
translate([-1.3+hotend_mount_hole/2,-hotend_mount_hole/2,4]) cube([1.3,hotend_mount_hole,16]);
translate([-hotend_mount_hole/2,-hotend_mount_hole/2,4]) cube([1.3,hotend_mount_hole,16]);
}
