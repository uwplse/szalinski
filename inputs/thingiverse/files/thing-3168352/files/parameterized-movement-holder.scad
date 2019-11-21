//Parameters, all values in mm

movement_width = 28.4; //Outer diameter of the movement
movement_height = 3.35; //Movement height
bottom_height = 7; //Bottom height
bottom_thickness = 3; //Bottom thickness
    
lip_width = 2; //Width of the "lip" the movement will rest on
wall_thickness = 2; //Thickness of outer walls 
tolerance = 0.3; //Tolerance, increase/decrease to get a good fit
crown_slot_width = 2.5; //Width of the crown slot

lid_wall_thickness = 2;
lid_tolerance = 0;
lid_bottom_thickness = 1;

render_lid = true; //Set to false if you dont want the lid
render_holder = true; //Set to false if you dont want the holder

module movement_holder ()
{    
    if(render_holder) {
        union() {
            rotate([180,0,0]){
            difference() {
                cylinder(h = bottom_height, r1 = (movement_width/2)+wall_thickness, r2 = (movement_width/2)+wall_thickness, $fn=128); 
                #translate () {
                    cylinder (h = bottom_height-bottom_thickness, r1 = (movement_width/2)-lip_width, r2 = (movement_width/2)-            lip_width, $fn=128);	
                }
            }
            #translate([0,0,-movement_height]) {
                difference() {
                    cylinder(h = movement_height, r1 = (movement_width/2)+wall_thickness, r2= (movement_width   /2)+wall_thickness, $fn=128); 
                    cylinder(h = movement_height, r1 = (movement_width/2)+tolerance/2, r2 = (     movement_width/2) + tolerance/2, $fn=128);
                    #translate([movement_width/2-crown_slot_width/2,0,0]) {
                        #rotate([0, 0, crown_slot_width]) {
                            cube([wall_thickness+crown_slot_width, crown_slot_width, movement_height]);
                        }
                }
            }
        }
      }
    }    
  }
}
module movement_holder_lid()
{
    if(render_lid) {
    #translate([movement_width+10,0,-bottom_height]) {
        lidRadius = ((movement_width+wall_thickness+tolerance+lid_tolerance)/2)+lid_wall_thickness;
        difference() {
            cylinder(h = movement_height+lid_bottom_thickness, r1 = lidRadius, r2 = lidRadius, $fn=128);
                 #translate([movement_width/2-crown_slot_width/2,0,lid_bottom_thickness]) {
                    #rotate([0, 0, crown_slot_width]) {
                        cube([wall_thickness+crown_slot_width, crown_slot_width, movement_height]);
                    }
            }
            #translate([0,0,lid_bottom_thickness]) {
                cylinder(h = movement_height, r1 = lidRadius-(lid_wall_thickness/2), r2 = lidRadius-(lid_wall_thickness/2), $fn=128);
            }
        }
    }
}
}

movement_holder();
movement_holder_lid();
