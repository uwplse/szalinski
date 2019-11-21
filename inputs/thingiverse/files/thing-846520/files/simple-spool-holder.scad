
// thickness of the holder (z height)
height = 16;

// how far to raise the holder (20-100)
raiser = 35;

// base mount thickness (you need to 16 to this to get the M3 screw needed - ie, thickess of 9mm would need a M3d 25mm)
base_thickness = 5;

// end caps
cap_size = 25;

// length of the holder (thickness of the spool)
length = 92;

/* [Hidden] */

len = length + 6;

epsilon = 0.01;

module printrbot_holder()
{    
    difference() {
    
        union() {
        intersection() {
            difference() {    
                union() {
            
                    // spool support
                    translate([len/2, -6, 0])
                        cube([len, 2*cap_size, height+epsilon], center=true);

                }
            }

            difference()
            {
                union() {
                    rotate([90,0,90])
                    {
                        // round the support
                        translate([-3.0, 0, len/2 -cap_size/2])
                            cylinder(r=height/2 + 2, h=2*len, center=true , $fn=36);

                        
                        // far end stop
                        translate([2, 0, len - 3/2]) {
                            intersection() {
                                cube([cap_size,cap_size,3], center=true);
                                cylinder(r=cap_size*0.5, h=3, center=true);
                            }
                        }
                        
                        // base end stop
                        translate([2, 0, 3/2]) {
                            intersection() {
                                cube([cap_size,cap_size,3], center=true);
                                cylinder(r=cap_size*0.5, h=3, center=true);
                            }
                        }

                    }
                } // union
                    
                rotate([90,0,90])
                    translate([-10, 0, len/2])
                    cylinder(r=height/2, h=len - 3 - 3 , center=true , $fn=4);
            }
        }
        
        
        difference()
        {
            union() {
                
                // attach lip
                translate([-46/2, -raiser,0])
                    cube([46, base_thickness, height], center=true);
                
                // raiser
                hull() {
                    translate([2,-(raiser+14)/2,0])
                        cube([4, (raiser+14), height+epsilon], center=true);

                    translate([10,0,0])
                    rotate([90,0,90])
                        intersection() {
                            cube([3, height, 3], center=true);
                                cylinder(r=cap_size*0.5, h=3, center=true);
                        }
                    
                }

                hull() {
                    translate([-12,-raiser,0])
                        cube([2, 2, height+epsilon], center=true);

                    translate([26,0,0])
                    rotate([90,0,90])
                        intersection() {
                            cube([2, height, 3], center=true);
                                cylinder(r=cap_size*0.5, h=3, center=true);
                        }
                 
                    translate([-36,-raiser,0])
                        cube([2, 2, height+epsilon], center=true);

        
                    translate([2,2,0])
                    rotate([90,0,90])
                        intersection() {
                            cube([2, height, 3], center=true);
                                cylinder(r=cap_size*0.5, h=3, center=true);
                        }
                        
                    
                    // bottom    
                    #translate([-4,-raiser,0])
                    rotate([90,0,90])
                        intersection() {
                            cube([2, height, 3], center=true);
                                cylinder(r=cap_size*0.5, h=3, center=true);
                        }
                        

                }
                
            }
            
            
            // attach screw
            translate([-40.25,-30,0])
                rotate([90,0,0])
                cylinder(r=3.3/2, h=20, $fn=24, center=true);
            
        }
    }
    
        hull() {
            translate([-24,-raiser + 5,0])
                cylinder(r=2, h=height+epsilon, $fn=24, center=true);

            translate([0,-6,0])
                cylinder(r=2, h=height+2*epsilon, $fn=24, center=true);
        }

        hull() {
            translate([-12,-raiser + 5,0])
                cylinder(r=2, h=height+epsilon, $fn=24, center=true);

            translate([12 - 6,-6 - 6,0])
                cylinder(r=2, h=height+2*epsilon, $fn=24, center=true);
        }
        
    }

}


rotate([0,0,-60])
    printrbot_holder();
