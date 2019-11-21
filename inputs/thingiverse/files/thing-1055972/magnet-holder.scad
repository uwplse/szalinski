/* Magnet Holder.scad */

$fn = 30;

// The Magnet:
blockWidth = 49.1;
blockDepth = 9.2;
blockHeight = 4.9;

// Amount of magnets
nrOfBlocks = 4;

// Nr of rows of magnets:
nrOfRows = 1;

// space between them
rowDist = 20;

nrOfMounts = 3; // * 2 == nr of screws. 

// The amount of PLA around the magnet and overall sturdyness
skinDepth = 2;

// screw holes:
holeInnerR = 5 / 2;
holeOuterR = 10 / 2;

totalWidth = (blockWidth * nrOfBlocks);
mountWidth = holeOuterR * 2;

distScrews = mountWidth + (totalWidth - (mountWidth * nrOfMounts)) / (nrOfMounts - 1);

// These are little 'bumps' on the inside that exercise some pressure on the magnets
// keeping them in place. 
ribAngle = 3;
ribRadius = 2;
ribOffset = .1; // move 'inward' by this distance
nrOfRibs = nrOfBlocks * 3 + 1;
ribDistance = (ribRadius * 2) + (totalWidth - (ribRadius * 2 * nrOfRibs)) / (nrOfRibs - 1);

// The teeth prevent objects from turning around, snapping to the magnet
teethX = 1.5;
teethZ = 1.7; // was 1.3
teethOverhang = .3;
teethY = skinDepth + teethOverhang;

nrOfTeeth = nrOfBlocks * 5 + 1;
teethDistance = (teethX * 2) + (totalWidth - (teethX * 2 * nrOfTeeth)) / (nrOfTeeth - 1);

teethDistance = (totalWidth - teethX) / (nrOfTeeth - 1);



for (y = [0 : nrOfRows -1]) {
    translate (v = [0, y * (rowDist + blockDepth + (skinDepth * 2)), 0]) {
        // body
        difference () {
            cube ([totalWidth, blockDepth + 2 * skinDepth, blockHeight + skinDepth]);
            translate (v = [-1, skinDepth, skinDepth])
                cube (size = [totalWidth + 2, blockDepth, blockHeight + 1]);
        }

        // Teeth: 
        for (x = [0 : nrOfTeeth -1]) {
            translate (v = [x * teethDistance, 0, skinDepth + blockHeight]) {
                difference () {
                    burtBridgeHouse(teethX, teethY, teethZ);

                    // The 45 degree edge on the teeth:
                    translate (v = [-1, skinDepth, 0])
                        rotate (a = [-45, 0, 0])
                            cube ([teethX + 2, teethX, teethX]);
                }

                translate (v = [0, blockDepth + skinDepth - teethOverhang, 0]) {
                    difference () {            
                        burtBridgeHouse(teethX, teethY, teethZ);


                        translate (v = [0, teethOverhang, 0]) {
                            rotate (a = [45 + 90, 0, 0]) {
                                cube ([teethX + 2, teethX, teethX]);
                            }
                        }
                    }
                }
            }
        }

        // friction ribs:
        intersection () {
            cube ([totalWidth, blockDepth + 2 * skinDepth, blockHeight + skinDepth]);

            for (x = [0 : nrOfRibs - 1]) {
                rotate (a = [- ribAngle, 0, 0])
                translate (v = [x * ribDistance + ribRadius, skinDepth - ribRadius - ribOffset, skinDepth])
                    cylinder (r = ribRadius, h = blockHeight * 2);

                rotate (a = [ribAngle, 0, 0])
                translate (v = [(ribDistance / 2) + x * ribDistance + ribRadius, skinDepth + blockDepth + ribRadius + ribOffset, skinDepth])
                    cylinder (r = ribRadius, h = blockHeight * 2);
            }
        }
    }
}




// Mounting lips 
for (x = [0 : nrOfMounts - 1]) {
    difference () {
        union () {
            translate (v = [x * distScrews, - holeOuterR, 0]) {
                cube ([mountWidth, holeOuterR * 2 + (blockDepth + 2 * skinDepth) * nrOfRows + rowDist * (nrOfRows - 1), skinDepth]);

                translate (v = [holeOuterR, 0, 0])
                    cylinder (r = holeOuterR, h = skinDepth);

                translate (v = [holeOuterR, holeOuterR * 2 + ((blockDepth + 2 * skinDepth) * nrOfRows) + (rowDist * (nrOfRows - 1)), 0])
                    cylinder (r = holeOuterR, h = skinDepth);
            }
        }

        // holes: 
        translate (v = [x * distScrews, - holeOuterR, -1]) {
            translate (v = [holeOuterR, 0, 0])
                cylinder (r = holeInnerR, h = skinDepth + 2);

            translate (v = [holeOuterR, holeOuterR * 2 + (blockDepth + 2 * skinDepth) * nrOfRows + (rowDist * (nrOfRows - 1)), 0])
                cylinder (r = holeInnerR, h = skinDepth + 2);
        }
    }
}














module burtBridgeHouse(sizeX, sizeY, sizeZ) {
    // this will generate a smooth bridge with a 4 degree angle
    // use this as a negative cube in cases where it would form a bridge
    // assuming y is the stupid dimension that's just every wide everywhere
    
    intersection () {
        // The main block, the desired shape
        cube ([sizeX, sizeY, sizeZ]);

        // intersect with what's possible to print:
        union () {
            // top diamond shape:
            // half a diagonal: sqrt(pow(sizeX / 2, 2) * 2)
            // whole diagonal;  sqrt(pow(sizeX, 2) * 2)
            translate (v = [(- sqrt(pow(sizeX / 2, 2) * 2) / 2) + (sizeX / 2), 0, sizeZ - sqrt(pow(sizeX / 2, 2) * 2) / 2])
                rotate(a = [0, 45, 0])
                    cube([(sizeX / 2), sizeY, sizeX / 2]);

            // middle part is a cylinder:
            translate(v = [sizeX / 2, sizeY, sizeZ - sqrt(pow(sizeX / 2, 2) * 2)])
                rotate(a = [90, 0, 0])
                    cylinder (r = sizeX / 2, h = sizeY);

            // bottom cube for extra bass // it extends way below the bottom, but that's being cut off by the intersection with the main cube:
            translate(v = [0, 0, - sqrt(pow(sizeX / 2, 2) * 2)])
                cube([sizeX, sizeY, sizeZ]);
        }
    }
}
