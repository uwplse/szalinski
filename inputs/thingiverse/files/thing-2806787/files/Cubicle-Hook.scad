// Cubicle Wall Curved Top Hook
// By Jay Littlefield
// February 10, 2018

// All dimenions in mm

// Wall Ellipse
WallWidth = 42;
WallLength = 86;

// Hook Dimensions
HookTopLength=WallLength+16;
HookWidth=WallWidth/2 +6;
HookTopHeight=50;
//HookTopHeight=5;
HookArmLength=250;
HookArmThickness=8;
HookEndLength=40;
HookEndRadius=17;

// Smooth Curve
$fn=300;

module WallTop() {
    resize([WallLength+4,WallWidth]) {
        //cylinder(h=HookTopHeight+2, r=10, center=false);
        linear_extrude(height=HookTopHeight+2) {
            circle(d=90);   
        }
    }   
}

module HookBase() {
        translate([-HookTopLength/2-HookEndLength+20,HookArmLength/2-HookWidth-10,HookTopHeight/2]) {
            rotate([0,90,0]) {
                cylinder(h=HookEndLength,r=HookEndRadius+10);
            }
        }    
}

module HookArm() {
    union() {
        intersection() {
            translate([-HookTopLength/2-2,-HookTopHeight/2-10,0]) {
                cube([HookArmThickness,HookArmLength,HookTopHeight]);
            }
            translate([-WallLength/2-12,HookTopHeight/1.085,HookTopHeight/2]) {
                rotate([0,90,0]) {
                    cylinder(h=HookTopHeight*2+2,r=HookTopHeight*1.5);   
                } 
            }        

            translate([0,0,0]) {
                rotate([0,0,0]) {
                    cylinder(h=100,r=HookTopLength/2);
                }
            }
            
        }   
        
        intersection() {
            translate([-HookTopLength/2+1,-10,0]) {
                cube([HookArmThickness,HookArmLength/2,HookTopHeight]);
            }    
            
            HookBase();
        }
        
        translate([-HookTopLength/2+1,-10,0]) {
            cube([HookArmThickness,HookArmLength/2.5,HookTopHeight]);
        }            
    }
}


module HookTop() {
    
    intersection() {
         translate([-HookTopLength/2,-HookWidth-2,0]) {
                cube([HookTopLength,HookWidth*2+2, HookTopHeight], center=false);
        }
        
        translate([-WallLength/2-8,HookTopHeight/1.085,HookTopHeight/2]) {
            rotate([0,90,0]) {
                cylinder(h=HookTopHeight*2+2,r=HookTopHeight*1.5);   
            } 
        }
        
        translate([0,0,0]) {
            rotate([0,0,0]) {
               cylinder(h=100,r=HookTopLength/2);
            }
        }
    }
}

module HookEnd() {
    difference() {
        translate([-HookTopLength/2-HookEndLength+1,HookArmLength/2-HookWidth-10,HookTopHeight/2]) {
            rotate([0,90,0]) {
                cylinder(h=HookEndLength,r=HookEndRadius);
            }
        }
        translate([-HookTopLength/2-HookEndLength+11,HookArmLength/2-HookWidth-40,HookWidth/6]) {
            cube([30,20,40]);
        }
    }
}



difference() {
    union() {
        HookTop();
        HookArm();
        HookEnd();
    }

    // This removes the curved wall top
    // from the design
    translate([0,0,-1]) {
        WallTop();  
    }
    
   
    // This flattens the bottom of the
    // top portion of the hook
    translate([-HookTopLength/2+HookArmThickness,WallWidth/4,-2]) {
        cube([HookTopLength+1,HookWidth*4,HookTopHeight+4]);
    }
   
}