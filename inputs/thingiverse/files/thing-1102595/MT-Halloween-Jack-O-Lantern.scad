//Morgan Thatcher
//Jack the Pumpkin 

//Add supports to the teeth to make it printable
Supports = 0; //[1:On, 0:Off]

//Add a face
Face = 1; //[1:Yes, 0:No]


Render_Quality=50; // [30:100]

//END CUSTOMIZER

$fn=Render_Quality;
module pumpkin() {
    //pumpkin base
    for ( z = [0, 30, 60, 90, 120, 150]) {
        rotate( [0, 0, z] ) {
            scale([1,1.5,1.15]) {
                sphere(r=50);
            }
        }  
    }
    //stem
    module stem() {
        for (m=[45, 60, 80, 100, 120]) {
            rotate([0,0,m]) {
                cube([30,30,70], center=true);
            }
        }
    }
    //uses a cube to cut off the top of the stem
    difference() {
        translate([0,0,55]) {
            rotate([0,-8,0]) {
                scale([.5,.5,.5]) {
                    stem();
                }    
            }
        }
        translate([-20,-20,70]) {
            cube([40,40,40]);
        }
    }
}
module eye() {
    rotate([0,45,0]) {
        scale([5,20,5]){
            difference() {
                //difference of two cubes to create triangle
                cube(5,5,5);
                translate([0,-1,0]) {
                    rotate([0,45,0]) {
                        cube(10,10,10);
                    }
                }
            }
        }
    } 
}   
module mouth() {
    difference() {
        //difference of 2 cylinders to create mouth
        rotate([90,0,0]) {
            cylinder(r=25, h=50);
        }
        translate([0,2,17.5]) {
            rotate([90,0,0]) {
                cylinder(r=30, h=60);
            }
        }
        //bottom tooth
        translate([0,0,-23]) {
            cube([10,120,10], center=true);
        }
        //top left tooth
        translate([-12,0,-10]) {
            cube([10,120,10], center=true);
        }
        //top right tooth
        translate([12,0,-10]) {
            cube([10,120,12], center=true);
        }
        if (Supports==1) {
            //left side left tooth support
            translate([-16.5, 0, -15]) {
                cube([1,120,10], center=true);
            }
            //right side left tooth support
            translate([-7.5, 0, -15]) {
                cube([1,120,20], center=true);
            }
            //left side right tooth support
            translate([7.5,0,-15]) {
                cube([1,120,20], center=true);
            }
            //right side right tooth support
            translate([16.5,0,-18]) {
                cube([1,120,10], center=true);
            }
        }
        //cuts off top of smile
        translate([0,0,8]) {
            cube([50,120,20], center=true);
        }
    }
}
rotate([0,0,220]) {
    difference() {
        //pumpkin
        pumpkin();
        if (Face==1) {
            //left eye
            translate([10,0,20]){
                eye();
            }
            //right eye
            translate([-45,0,20]){
                eye();
            }
            //mouth
            translate([0,80,8]) {
                    mouth(); 
            }
            //nose
            translate([8,20,15]) {
                rotate([0,180,0]) {
                    scale([.5,1,.7]) {
                        eye();
                    }
                }
            }
            //hollow out inside
            scale([1,1,.8]) {
                sphere(r=65);
            }
        }
            //cut off bottom
            translate([0,0,-100]) {
                cube([100,100,100], center=true);
            }
    }
}
