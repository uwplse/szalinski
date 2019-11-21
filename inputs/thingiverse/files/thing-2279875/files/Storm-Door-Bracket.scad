$fn = 100;

rotate([0,-90,0]){
    difference(){
        union(){
            cube([40,40,7.5]); //base

            translate([0,28,5]){
                rotate([90,0,0]){
                    triangle(65,40,16);
                }
            }

            translate([0,12,45]){
                cube([15,16,25]);
            }
        }

        translate([7,30,61+5.5/2]){
            rotate([90,0,0]){
                cylinder(h=20,r=5.5/2);
           }
        }
        translate([10,7.5,-5]){
            cylinder(h=20,r=6/2);
        }
        translate([30,7.5,-5]){
            cylinder(h=20,r=6/2);
        }
        translate([10,32.5,-5]){
            cylinder(h=20,r=6/2);
        }
        translate([30,32.5,-5]){
            cylinder(h=20,r=6/2);
        }
        translate([-2,17.25,53]){
            cube([20,5.5,20]);
        }
    }
}

module triangle(o_len, a_len, depth)
{
    linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}