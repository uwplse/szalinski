cylinderHeight = 12;
cylinderRadius = 4.9;
holeSize = 5.5;

handleDepth = 3;
handleWidth = 11;
handleHeight = 6;
handleRadius = 5;
handleOffset = 7;
handleHoleRadius = 2; 

// Circle/Sphere Fragments
fragments = 100;

union() {
    difference() {
        union() {
            cylinder(h = cylinderHeight, r = cylinderRadius, center = false, $fn = fragments);
            translate(v=[0, 0, cylinderHeight]) 
                sphere(r = cylinderRadius, center = true, $fn = fragments);

            translate(v=[0, -handleWidth/2, cylinderHeight + cylinderRadius + handleRadius - handleOffset]) {
                rotate([0,-90,0]) {
                    union(){
                        translate(v=[0,0,-handleDepth/2]) {
                            difference() {
                                union() {
                                    translate(v=[0,0,0])
                                        cylinder(h=handleDepth, r = handleRadius, $fn= fragments);

                                    translate(v=[0,handleWidth,0])
                                        cylinder(h=handleDepth, r = handleRadius, $fn= fragments);
                                
                                    translate(v=[handleHeight,0,0])
                                        cylinder(h=handleDepth, r = handleRadius, $fn= fragments);

                                    translate(v=[handleHeight,handleWidth,0])
                                        cylinder(h=handleDepth, r = handleRadius, $fn= fragments);
                                    
                                    translate(v=[0,handleWidth/2,0])
                                        translate(v=[0,-(handleRadius*2+handleWidth)/2,0])
                                            cube([handleHeight,(handleRadius*2+handleWidth),handleDepth]);

                                    translate(v=[handleRadius,handleWidth/2,0])
                                        translate(v=[-handleRadius*2,-(handleWidth)/2,0])
                                            cube([handleRadius*2+handleHeight,(handleWidth),handleDepth]);
                                }
                                #translate(v=[handleHeight,handleWidth,-1])
                                    cylinder(h=handleDepth+2, r = handleHoleRadius, $fn= fragments);
                            }

                        }
                    }
                }
            }
        }
        translate(v=[0,0,4.5]) 
            cube([holeSize, holeSize, cylinderHeight], center = true);
    }
}



