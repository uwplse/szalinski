$fn=100;
diameter_of_washer=38.1; // Diameter of Half Moon
height_of_washer=30.0; // Height of Half Moon
hole_diameter=12.7; // Hole Diameter
nut_depth=11.1125; // Nut Depth
nut_width=19.05; // Nut Width

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
    translate([-nut_depth/2.01,0,0]){
        rotate([0,90,0]){
            rotate([0,0,90]){
                hexagon(nut_width,nut_depth);
        
            }
        }
    }
}

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
