selector = 0;

// Base Parameters
$fn=50;
thickness = 3;

// Customization Parameters
connection = 30;

outletHoseID = 40;
inletHoseID = 40;

outerFunnelLength = 150;
outerFunnelTopID = 80;
outerFunnelBottomID = 60;

inletHeight = 60;
innerFunnelLength = 80;

flangeTabs = 3;
flangeHole = 10;


// Multiple Export based on Selector
if (selector == 1) {
    outlet(outerFunnelTopID, outletHoseID, innerFunnelLength);
} else if (selector == 2) {
    inlet(outerFunnelTopID, inletHoseID, inletHeight);
} else if (selector == 3) {
    funnel(outerFunnelLength, outerFunnelTopID, outerFunnelBottomID);
} else {
    assembly();
}

// Full Assembly
module assembly() {
    
    translate([0, 0, outerFunnelLength+inletHeight]) {
        //color("red")
        outlet(outerFunnelTopID, outletHoseID, innerFunnelLength);
    }
    
    translate([0, 0, outerFunnelLength]) {
        //color("blue")
        inlet(outerFunnelTopID, inletHoseID, inletHeight);
    }
    
    translate([0, 0, 0]) {
        //color("green")
        funnel(outerFunnelLength, outerFunnelTopID, outerFunnelBottomID);
    }
}

// Top outlet, inner funnel, and inner funnel spiral baffle
module outlet(innerDiameter, hoseDiameter, innerLength) {
    difference() {
        union() {
            // Lid
            translate([0, 0, thickness]) {
                cylinder(d=innerDiameter+2*thickness, h=thickness);
                // Top connector
                translate([0, 0, thickness]) {
                    cylinder(d=hoseDiameter,h=connection);
                }
            }
            
            // Central Funnel
            translate([0, 0, thickness-innerLength]) {
                cylinder(h=innerLength, d=hoseDiameter);
                
                linear_extrude(height=innerLength, twist=360) {
                    translate([hoseDiameter/2-thickness/2,0,0]) {
                        square([hoseDiameter/3, thickness]);
                    }
                }
            }
            
            // Bottom Flange
            flange(innerDiameter, thickness=thickness);
            
        }
        
        translate([0, 0, -innerLength])
        cylinder(d=hoseDiameter-2*thickness, h=innerLength+2*thickness+connection);
    }
}

// Inlet port
module inlet(innerDiameter, hoseDiameter, overallHeight) {
    
    difference() {
        union() {
            // Top flange
            translate([0, 0, overallHeight-thickness]) {
                flange(innerDiameter, thickness = thickness);
            }
            
            // Main body
            translate([0, 0, thickness]) {
                cylinder(d=innerDiameter + 2*thickness, h=overallHeight - 2*thickness);
            }
            
            // Inlet port
            translate([innerDiameter/2 - hoseDiameter/2 + thickness, 0, overallHeight/2]) {
                rotate([90, 0, 0]) {
                    cylinder(d=hoseDiameter, h=innerDiameter/2 + thickness + connection);
                }
            }
            
            // Bottom flange
            flange(innerDiameter, thickness = thickness);
        }
        
        // Cut the inlet port through all pieces
        translate([innerDiameter/2 - hoseDiameter/2 + thickness, 0, overallHeight/2]) {
            rotate([90, 0, 0]) {
                cylinder(d=hoseDiameter-2*thickness, h=innerDiameter/2 + thickness + connection);
            }
        }
        
        // Ensure nothing is in the central cavity
        cylinder(d=innerDiameter,h=overallHeight);
    }
}

// Major funnel section
module funnel(overallHeight, topDiameter, bottomDiameter) {
    union() {
        // Top flange
        translate([0, 0, overallHeight-thickness]) {
            flange(topDiameter, thickness = thickness);
        }

        // Funnel body. Uses polygon to avoid scaling isues
        translate([0, 0, thickness]) {
            rotate_extrude() {
                polygon(points=[
                    [bottomDiameter/2, 0],
                    [bottomDiameter/2+thickness, 0],
                    [topDiameter/2+thickness, overallHeight-2*thickness],
                    [topDiameter/2, overallHeight-2*thickness]
                ]);
            }
        }

        // Bottom flange
        flange(bottomDiameter, thickness = thickness);
    }
}

// Sub-Part defining the flange(s)
module flange(innerDiameter) {
    linear_extrude(height=thickness) {
        
        difference() {
            union() {
                outerDiameter = innerDiameter+2*thickness;

                circle(d=outerDiameter);

                // Space the flange tabs evenly around the part
                for(i = [0:flangeTabs - 1]) {
                    angle = 360/flangeTabs * i;
                   
                    rotate([0,0,angle]) {
                        difference() {
                    
                            hull() {
                                square([flangeHole+2*thickness, flangeHole+2*thickness], center=true);
                                translate([outerDiameter/2 + flangeHole/2 + thickness, 0, 0]) {
                                    circle(d=flangeHole+2*thickness);
                                }
                            }
                            
                            translate([outerDiameter/2 + flangeHole/2 + thickness, 0, 0]) {
                                circle(d=flangeHole);
                            }
                        }
                    }
                }
            }
            
            circle(d=innerDiameter);
        }
    }
}