/* [Basic] */
// inner radius of the holder, without border
innerRadius = 20; // [0:100]

// strength of the wall
wallStrength = 2.1;

// height of the plate
plateHeight = 2; // [0:10]

// height of the wall
wallHeight = 10; // [0:100]

module unionCube(){
    translate([0,innerRadius,(plateHeight+wallHeight)/2])
        cube(size=[innerRadius*4,innerRadius*2,plateHeight*2+wallHeight], center = true);
}

module plate(){
    cylinder(plateHeight, innerRadius+wallStrength, innerRadius+wallStrength, true, $fn = 50);
}
module plateWall(){
    translate([0,0,plateHeight*2]){
        difference(){
            cylinder(wallHeight, innerRadius+wallStrength, innerRadius+wallStrength, true, $fn = 50);
            cylinder(wallHeight, innerRadius, innerRadius, true, $fn = 50);
        }
    }
}

module everything(){
    union(){
        plate();

        // halfcircle wall
        intersection(){
            plateWall();
            translate([0,-innerRadius,(plateHeight+wallHeight)/2]){
                cube(size=[innerRadius*4,innerRadius*2,plateHeight+wallHeight], center = true);
            }
        }

        // helper walls
        difference(){
            translate([0,innerRadius/2+wallStrength/2,0]){
                cube(size = [innerRadius*4,innerRadius+wallStrength,plateHeight], center = true);
            }
            union(){
                intersection(){
                    unionCube();
                    translate([-innerRadius*2-wallStrength,0,0]){
                        plate();
                    }
                }
                intersection(){
                    unionCube();
                    translate([innerRadius*2+wallStrength,0,0]){
                        plate();
                    }
                }
            }
        }

        union(){
            intersection(){
                unionCube();
                translate([-innerRadius*2-wallStrength,0,0]){
                    plateWall();
                    //plate();
                }
            }
            intersection(){
                unionCube();
                translate([innerRadius*2+wallStrength,0,0]){
                    plateWall();
                    //plate();
                }
            }
        }
    }
}

intersection(){
    everything();
    cylinder(1000, (innerRadius+wallStrength)*1.5, (innerRadius+wallStrength)*1.5, true, $fn = 50);
}