$fn = 60;

//Diameter of the vials to be held.
vial_diameter = 15; //[1:0.1:100]
//Gap or wall between the vials
vial_gap = 2.5; //[1:0.1:100]
//Vials X
number_of_vials_x = 6; //[1:100]
//Vials Y
number_of_vials_y = 12; //[1:100]
//the overall height of the holder
holder_height = 30; //[1:100]
//the width of the holder walls
wall_width = 7;
difference() {    
    cube_width = vial_diameter*number_of_vials_x+vial_gap*number_of_vials_x+vial_gap;
    cube_length = vial_diameter*number_of_vials_y+vial_gap*number_of_vials_y+vial_gap;
    
    difference(){
        cube([cube_width + wall_width, cube_length + wall_width, holder_height]);
        translate([wall_width/2, wall_width/2, 4]){
            color("purple") cube([cube_width, cube_length, holder_height - 8]);
        }
        for (x=[1:number_of_vials_x], y=[1:number_of_vials_y]) {
            translate([-vial_diameter/2, -vial_diameter/2, 0]) {
                translate([(vial_diameter*x)+(vial_gap*x) + wall_width/2,(vial_diameter*y)+(vial_gap*y) + wall_width/2,4]) {
                        color("purple") cylinder(r=(vial_diameter/2) + 1, h=holder_height);
                }
            }
        }
    }

}
    for (x=[1:number_of_vials_x], y=[1:number_of_vials_y]) {
        translate([-vial_diameter/2, -vial_diameter/2, 0]) {
            translate([(vial_diameter*x)+(vial_gap*x) + wall_width/2,(vial_diameter*y)+(vial_gap*y) + wall_width/2,0]) {
                difference(){
                    color("purple") cylinder(r=(vial_diameter/2) + 1, h=holder_height);
                    translate([0,0,4]){
                        color("purple") cylinder(r=(vial_diameter/2), h=holder_height + 4);
                    }
                }
            }
        }

    }
