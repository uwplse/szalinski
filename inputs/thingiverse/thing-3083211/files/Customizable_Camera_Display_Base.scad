/*[Base Dimensions]*/
width = 100; //[20:400]
depth = 100; //[20:400]

/*[Mounting Hole]*/
hole_x_offset = 0; //[-300:300]
hole_y_offset = 0; //[-300:300]
hole_diameter = 7; //[0:12]
hex_diameter = 12; //[0:20]

/*[Hidden]*/
$fn=50;
height = 10;

difference(){
union(){
    //base layer
    cube([width,depth,height/4]);

    //rounded layer
    hull(){
        intersection(){
            translate([0,2.5,2.5]){
                rotate([0,90,0]){
                    cylinder(h=width,d=5);
                }
            }
            translate([2.5,0,2.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth,d=5);
                }
            }
        }
        intersection(){
            translate([0,depth-2.5,2.5]){
                rotate([0,90,0]){
                    cylinder(h=width,d=5);
                }
            }
            translate([width-2.5,0,2.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth,d=5);
                }
            }
        }
        intersection(){
            translate([0,2.5,2.5]){
                rotate([0,90,0]){
                    cylinder(h=width,d=5);
                }
            }
            translate([width-2.5,0,2.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth,d=5);
                }
            }
        }
        intersection(){
            translate([2.5,0,2.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth,d=5);
                }
            }
            translate([0,depth-2.5,2.5]){
                rotate([0,90,0]){
                    cylinder(h=width,d=5);
                }
            }
        }
    }

    //step layer
    translate([2.5, 2.5, 5]){
        cube([width-5,depth-5,1]);
    }

    //inverted rounded layer
    intersection(){
        difference(){
            translate([2.5,2.5,6]){
                    cube([width-5,5,2.5]);
            }
            translate([2.5,2.5,8.5]){
                rotate([0,90,0]){
                    cylinder(h=width-5,d=5);
                }
            }
        }
        difference(){
            translate([2.5,2.5,6]){
                cube([5,depth-5,2.5]);
            }
            translate([2.5,2.5,8.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth-5,d=5);
                }
            }
        }
    }
    intersection(){
        difference(){
            translate([2.5,depth-5-2.5,6]){
                    cube([width-5,5,2.5]);
            }
            translate([2.5,depth-5+2.5,8.5]){
                rotate([0,90,0]){
                    cylinder(h=width-5,d=5);
                }
            }
        }
        difference(){
            translate([width-5-2.5,2.5,6]){
                cube([5,depth-5,2.5]);
            }
            translate([width-5+2.5,2.5,8.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth-5,d=5);
                }
            }
        }
    }
    intersection(){
        difference(){
            translate([2.5,depth-5-2.5,6]){
                    cube([width-5,5,2.5]);
            }
            translate([2.5,depth-5+2.5,8.5]){
                rotate([0,90,0]){
                    cylinder(h=width-5,d=5);
                }
            }
        }
        difference(){
            translate([2.5,2.5,6]){
                cube([5,depth-5,2.5]);
            }
            translate([2.5,2.5,8.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth-5,d=5);
                }
            }
        }
    }
    intersection(){
        difference(){
            translate([2.5,2.5,6]){
                    cube([width-5,5,2.5]);
            }
            translate([2.5,2.5,8.5]){
                rotate([0,90,0]){
                    cylinder(h=width-5,d=5);
                }
            }
        }
        difference(){
            translate([width-5-2.5,2.5,6]){
                cube([5,depth-5,2.5]);
            }
            translate([width-5+2.5,2.5,8.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth-5,d=5);
                }
            }
        }
    }
    translate([5,5,6]){
        cube([width-10,depth-10,2.5]);
    }
    difference(){
        translate([5,2.5,6]){
            cube([width-10,5,2.5]);
        }
        translate([5,2.5,8.5]){
            rotate([0,90,0]){
                cylinder(h=width-10,d=5);
            }
        }
    }
    difference(){
        translate([2.5,5,6]){
            cube([5,depth-10,2.5]);
        }
        translate([2.5,5,8.5]){
            rotate([-90,0,0]){
                cylinder(h=depth-10,d=5);
            }
        }
    }
    difference(){
        translate([5,depth-5-2.5,6]){
            cube([width-10,5,2.5]);
        }
        translate([5,depth-2.5,8.5]){
            rotate([0,90,0]){
                cylinder(h=width-10,d=5);
            }
        }
    }
    difference(){
        translate([width-5-2.5,5,6]){
            cube([5,depth-10,2.5]);
        }
        translate([width-2.5,5,8.5]){
            rotate([-90,0,0]){
                cylinder(h=depth-10,d=5);
            }
        }
    }
    intersection(){
        difference(){
            translate([2.5,depth-5-2.5,6]){
                    cube([width-5,5,2.5]);
            }
            translate([2.5,depth-5+2.5,8.5]){
                rotate([0,90,0]){
                    cylinder(h=width-5,d=5);
                }
            }
        }
        difference(){
            translate([width-5-2.5,2.5,6]){
                cube([5,depth-5,2.5]);
            }
            translate([width-5+2.5,2.5,8.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth-5,d=5);
                }
            }
        }
    }
    intersection(){
        difference(){
            translate([2.5,depth-5-2.5,6]){
                    cube([width-5,5,2.5]);
            }
            translate([2.5,depth-5+2.5,8.5]){
                rotate([0,90,0]){
                    cylinder(h=width-5,d=5);
                }
            }
        }
        difference(){
            translate([2.5,2.5,6]){
                cube([5,depth-5,2.5]);
            }
            translate([2.5,2.5,8.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth-5,d=5);
                }
            }
        }
    }
    intersection(){
        difference(){
            translate([2.5,2.5,6]){
                    cube([width-5,5,2.5]);
            }
            translate([2.5,2.5,8.5]){
                rotate([0,90,0]){
                    cylinder(h=width-5,d=5);
                }
            }
        }
        difference(){
            translate([width-5-2.5,2.5,6]){
                cube([5,depth-5,2.5]);
            }
            translate([width-5+2.5,2.5,8.5]){
                rotate([-90,0,0]){
                    cylinder(h=depth-5,d=5);
                }
            }
        }
    }

    //second rounder layer
    translate([5,5,6]){
        hull(){
            intersection(){
                translate([0,2.5,2.5]){
                    rotate([0,90,0]){
                        cylinder(h=width,d=5);
                    }
                }
                translate([2.5,0,2.5]){
                    rotate([-90,0,0]){
                        cylinder(h=depth,d=5);
                    }
                }
            }
            intersection(){
                translate([0,depth-10-2.5,2.5]){
                    rotate([0,90,0]){
                        cylinder(h=width,d=5);
                    }
                }
                translate([width-10-2.5,0,2.5]){
                    rotate([-90,0,0]){
                        cylinder(h=depth,d=5);
                    }
                }
            }
            intersection(){
                translate([0,2.5,2.5]){
                    rotate([0,90,0]){
                        cylinder(h=width,d=5);
                    }
                }
                translate([width-10-2.5,0,2.5]){
                    rotate([-90,0,0]){
                        cylinder(h=depth,d=5);
                    }
                }
            }
            intersection(){
                translate([2.5,0,2.5]){
                    rotate([-90,0,0]){
                        cylinder(h=depth,d=5);
                    }
                }
                translate([0,depth-10-2.5,2.5]){
                    rotate([0,90,0]){
                        cylinder(h=width,d=5);
                    }
                }
            }
        }
    }

    //top step
    translate([7.5,7.5,11]){
        cube([width-15,depth-15,1]);
    }
}
translate([width/2+hole_x_offset,depth/2+hole_y_offset,-1]){
    union(){
        cylinder(h=15,d=hole_diameter);
        cylinder(h=9,d=hex_diameter,$fn=6);
    }
}
}


