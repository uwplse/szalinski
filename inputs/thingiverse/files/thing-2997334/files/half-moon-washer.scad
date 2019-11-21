$fn=100;
diameter_of_washer=38.1; // Diameter of Half Moon
height_of_washer=30.0; // Height of Half Moon
hole_diameter=12.7; // Hole Diameter

difference(){
    linear_extrude(center=true, height=height_of_washer){
        difference(){
            circle(d=diameter_of_washer);
            translate([0,-diameter_of_washer,0]){
                square(diameter_of_washer*2);
            }
        }
    }
    rotate([0,90,0]){
        translate([0,0,-height_of_washer/2]){
            cylinder(h=height_of_washer, d1=hole_diameter, d2=hole_diameter, center=true);
        }
    }
}
