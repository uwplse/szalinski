// Customizable hex key holder

// diameter for key #1
hex1 = 4; // [1.5:0.5:5]

// diameter for key #2 
hex2 = 2.5; //[1.5:0.5:5]

// diameter for key #3
hex3 = 1.5; //[1.5:0.5:5]

// tolerance for the print
tolerance = 0.25;

/*[Hidden]*/
$fn=32;


// Lets build it
block();

module hexHole(h){
    h = h+tolerance;
    face = (h)/sqrt(3);
    
    color("red")
    union(){
        cube([h/sqrt(3),h,8], center = true);
        rotate(60) cube([face,h,8], center = true);
        rotate(120) cube([face,h,8], center = true);
    }
}

function d(h=5) = 2*h/sqrt(3);

module hexHoles(){
    space = (18-d(hex1)-d(hex2)-d(hex3))/4;

    translate([-9+space+d(hex1)/2,0,0])
    hexHole(hex1);

    translate([-9+2*space+d(hex1)+d(hex2)/2,0,0])
    hexHole(hex2);

    translate([-9+3*space+d(hex1)+d(hex2)+d(hex3)/2,0,0])
    hexHole(hex3);
}


module block(){
    union(){
        // BODY
        difference(){
            minkowski(){
                sphere(1);
                
                translate([0,0,0])
                cube([18,8,4], center = true);
            }
            
            hexHoles();
        }
        // NECK
        union(){
            translate([0,-5.5,0]) 
            rotate([90,0,0]) 
            cylinder(h=3, r=3, center=true);
            
            translate([0,-7,0]) 
            cube([3, 3,3], center = false);

            translate([-3,-7,-3]) 
            cube([3,3,3], center = false);

        }
        // HEAD
        intersection(){
            union(){
                translate([0,-9.8,0]) 
                rotate([-90,0,0]) 
                cylinder(h=2.8, r=5, center=false);
                
                translate([0,-9.8,0]) 
                cube([5, 2.8,5], center = false);

                translate([-5,-9.8,-5])  
                cube([5, 2.8,5], center = false);
                
                union(){
                    intersection(){
                        translate([0,-9.8,0])
                        rotate([90,0,0])
                        linear_extrude(height = 1, scale = 0.6)
                        square([10, 10], center = true);
                        
                        union(){
                            translate([0,-10.8,0])
                            cube([5, 1,5], center=false);
                            
                            translate([-5,-10.8,-5])
                            cube([5,1,5], center=false);
                        }
                    }
                    translate([0,-9.8,0])
                    rotate([90,0,0])
                    linear_extrude(height = 1, scale = 0.6)
                    circle(5, center = true);
                }
            }

            translate([-5,-10.8,-3])
            cube([10,3.8,6], center = false);
        }
    }
}
echo(version=version());