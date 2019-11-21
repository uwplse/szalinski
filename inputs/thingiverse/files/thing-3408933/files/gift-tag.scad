to_name = "Alexandra";
from_name = "Bartholomew";

scale(0.5) union() {
    difference() {
        union() {
            difference() {
                linear_extrude(height = 4) {
                        polygon(points=[[3,7],[28,32],[162,32],[162,-32],[29,-32],[3,-7]], paths=[[0,1,2,3,4,5]]);
                };
                translate([0,0,2]) {
                    linear_extrude(height = 2) {
                        polygon(points=[[5,5],[30,30],[160,30],[160,-30],[30,-30],[5,-5]], paths=[[0,1,2,3,4,5]]);
                    }
                };
            }
            translate([20,0,0]) {
                cylinder(r = 7, h = 5);
            }
        }
        translate([20,0,0]) {
            cylinder(r = 5, h = 9);
        }
    }


    linear_extrude(height = 4) {
        translate([92, --4]) text(str("To: ",to_name), font="Liberation Sans:style=Bold", halign = "center");
        translate([92, -16]) text(str("From: ",from_name), font="Liberation Sans:style=Bold", halign = "center");
    }
}