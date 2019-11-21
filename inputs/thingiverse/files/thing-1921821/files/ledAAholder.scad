$fn=60;
module lid(height)
{
    cylinder (r=2, h=height, $fn=60);
    translate([0,-2,0])
        cube ([13.5,4,height]);
    translate([13.5,0,0])
        cylinder (r=2, h=height, $fn=60);
}


module holder() {
    difference () {
        cube ([31,15,3.5]);
        translate ([23,-1,13])
            rotate([-90,0,0])
            cylinder(r=10, h=17, $fn=60);
    }
    translate([4,7.5,3.4])
        lid(2.6);

    translate([31,0,0])
    linear_extrude (height=3.5) 
       polygon([[15,0],[15,6],[0,15],[-1,15],[-1,0]]);

    difference() {
        union() {
            translate([31,0,0])
                cube([15,3.5,18]);
            translate([38.5,0,18])
                rotate([-90,0,0])
                {
                    cylinder (r=7.5,h=3.5);
                    cylinder (r=4.5,h=6.3);
                }
            }
         translate([38.5,-1,18])
                rotate([-90,0,0])
            cylinder(r=3,h=8);
    }
}

rotate([90,0,0])
holder();