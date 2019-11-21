$fn = 200;

spacerHeight = 6.5;
spacerRadius = 7.5;

knobBaseWidth = 15;
knobSphereRadius = 20;
knobScaleY = 0.75;
knobScaleZ = 0.5;

clearance = 0.5;
baseWidth = 8;
baseHeight = 34.5;
extraHeight = spacerHeight + 1/2 * knobBaseWidth + knobScaleZ * 1.5 * knobSphereRadius;
cutOff = 2.5;

module ax(){
    union(){
        translate([-1/2 * baseWidth, -1/2 * baseWidth, 0]){
            cube([baseWidth, baseWidth, baseHeight + extraHeight - 1/2 * baseWidth]);
        }
        translate([0, 0, baseHeight + extraHeight - baseWidth]){
           intersection(){
                translate([-1/2 * baseWidth, -1/2 * baseWidth, 0]){
                    cube(baseWidth);
                }
                translate([0,0,1/2 * baseWidth]){
                    sphere(r = baseWidth - cutOff);
                }
            } 
        }
    }
}

module spacer(){
    layerHeight = 0.1;
    layers = floor(spacerHeight / layerHeight);
    
    a = -spacerRadius / (spacerHeight * spacerHeight);
    b = 0;
    c = spacerRadius;
    
    difference(){
        for(i = [1:layers]){
            rotate_extrude(){
                polygon(points  =   [   [a * (i - 1) * layerHeight * (i - 1) * layerHeight + b * (i - 1) * layerHeight + c, (i - 1) * layerHeight],
                                        [a * i * layerHeight * i * layerHeight + b * i * layerHeight + c, i * layerHeight],
                                        [0, i * layerHeight],
                                        [0, (i - 1) * layerHeight],
                ]);
            }
        }
        translate([-1/2 * baseWidth - clearance, -1/2 * baseWidth - clearance, -clearance]){
            cube([baseWidth + 2 * clearance, baseWidth + 2 * clearance, spacerHeight + 2 * clearance]);
        }
    }
}

module knob(){
    translate([0,0,1/2 * knobBaseWidth + knobScaleZ * knobSphereRadius]){
        rotate([0,180,0]){
            difference(){
                translate([-1/2 * knobBaseWidth, -1/2 * knobBaseWidth, 0]){
                    cube(knobBaseWidth);
                    translate([1/2 * knobBaseWidth, 1/2 * knobBaseWidth, 1/2 * knobBaseWidth + knobScaleZ * knobSphereRadius]){
                        scale([1, knobScaleY, knobScaleZ]){
                            sphere(r = knobSphereRadius);
                        }
                    }
                }
                translate([-1/2 * baseWidth - clearance, -1/2 * baseWidth - clearance, -clearance]){
                    cube([baseWidth + 2 * clearance, baseWidth + 2 * clearance, 1/2 * knobBaseWidth + knobScaleZ * 1.5 * knobSphereRadius]);
                }
                translate([-knobSphereRadius, -knobSphereRadius, 1/2 * knobBaseWidth + knobScaleZ * knobSphereRadius]){
                    cube(2 * knobSphereRadius);
                }
            }
        }
    }
    
    translate([45, 0, 0]){
        rotate([0,0,90]){
            difference(){
                scale([1, knobScaleY, knobScaleZ]){
                    sphere(r = knobSphereRadius);
                }
                translate([-knobSphereRadius, -knobSphereRadius, -2 * knobSphereRadius]){
                    cube(2 * knobSphereRadius);
                }
                translate([-1/2 * baseWidth - clearance, -1/2 * baseWidth - clearance, -clearance]){
                    cube([baseWidth + 2 * clearance, baseWidth + 2 * clearance, 0.25 * knobSphereRadius + 2 * clearance]);
                }
            }
        }
    }
}

ax();

translate([30, 0, 0]){
    spacer();
}

translate([0, 45, 0]){
    knob();
}