/* Wanhao i3 V2.., Monoprice Maker Select V2 et al USB cable retainer */
/* By Luther Barber */
/* Parameters for Thingiverse customizer */

// The size of the slot for the cable (in mm), allowing for print shrinkage, etc.
Cable_diameter = 4; // [2,3,4,5,6]

// The length (in mm)of the USB cable housing & strain relief from the case to the cable.
Cable_collar_to_case = 28; // [20:1:40]

// Adjustment to the 120mm case size (in mm) to allow for print shrinkage, etc.
Case_width_tolerance = 1; // [-2,-1,0,1,2,3]

/* [Hidden] */
// All remaining parameters probably will not need to be changed
Prong_size = 4;
Prong_length = 10;
Cable_distance_from_top = 10;

Clip_width = 10;
Clip_thickness = 2;
Case_width = 120 + Case_width_tolerance;
Slop = .01; // extra amount only to make cutouts clear

/* Code */

Overall_length = Clip_thickness + Case_width + Cable_collar_to_case + Prong_size;
Overall_height = Clip_thickness + Cable_distance_from_top + Cable_diameter + Prong_size;
Overall_width = Clip_width + Prong_length;

/* Create a box of the overall size. Then carve out a gap
/* for the control box, discard the space up to the prongs,
/* and remove the gap between the prongs.
/* Rotate the model for the desired printing orientation.
/* Translate it to start on the z plane, extend along the x axis, and be roughly centered */
translate ([Overall_length / 2, - Overall_width / 2 , Overall_height]) {
    rotate ([0, 90, 90]){    // for printing direction
        difference() {
            difference () {
                difference (){
                    // Cuboid of the overall size
                    cube([Overall_width, Overall_length, Overall_height]);
                    // Less the cutout for the control box
                    translate([-Slop, Clip_thickness, -Slop]){
                        cube([Overall_width + (2 * Slop), Case_width, Overall_height - Clip_thickness]);
                    }
                }
                // Less the volume behind the prongs
                translate ([-Slop, -Slop, -Slop]) {
                    cube([Prong_length + Slop, Overall_length - Prong_size + Slop, Overall_height + (2 * Slop)]);
                }
            }
            // and finally remove the gap between the prongs
            translate ([-Slop, Slop, Prong_size]) {
                cube([Prong_length, Overall_length, Cable_diameter]);
            }
        }   
    }
}