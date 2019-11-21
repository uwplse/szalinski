$fn = 60;

//Diameter of the vials to be held.
vial_diameter = 14.5; //[1:0.1:100]
//Gap or wall between the vials
vial_gap = 2.5; //[1:0.1:100]
//number of vials to hold -- square root of this number must be a whole number
number_of_vials = 9; //[1:100]
//the overall height of the holder
holder_height = 30; //[1:100]

difference() {
    cube([vial_diameter*sqrt(number_of_vials)+vial_gap*sqrt(number_of_vials)+vial_gap, vial_diameter*sqrt(number_of_vials)+vial_gap*sqrt(number_of_vials)+vial_gap, holder_height]);
    for (x=[1:sqrt(number_of_vials)], y=[1:sqrt(number_of_vials)]) {
        translate([-vial_diameter/2, -vial_diameter/2, 0]) {
            translate([(vial_diameter*x)+(vial_gap*x),(vial_diameter*y)+(vial_gap*y),4]) {
                color("purple") cylinder(r=vial_diameter/2, h=holder_height);
            }
        }
    }
}
