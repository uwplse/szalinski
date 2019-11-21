width = 32;
depth = 15;
height = 20;

thickness = 4;
screw_d = 6.2;
nut_width = 10;

difference(){
  union(){
	chamferCube([width+2*thickness, height+2*thickness, depth]);
  }
  translate([thickness,-3,-2])chamferCube([width, height+thickness+3, depth+4], ch = 2);
  
  #translate([width/2+thickness,0,depth/2])rotate([-90,0,0])cylinder(d = screw_d, h = depth+3*thickness+2, $fn = 40);
}

chamferCube([thickness*2,thickness,depth],[[1,1,1,1],[1,1,1,1],[1,1,0]]);
translate([width,0,0])chamferCube([thickness*2,thickness,depth],[[1,1,1,1],[1,1,1,1],[1,1,1]]);

translate([width/2+thickness+nut_width/2,height,0])cube([thickness,thickness, depth]);
translate([width/2-nut_width/2,height,0])cube([thickness,thickness, depth]);


module chamferCube(size, chamfers = [undef, undef, undef], ch = 1, ph1 = 1, ph2 = undef, ph3 = undef, ph4 = undef, sizeX = undef, sizeY = undef, sizeZ = undef, chamferHeight = undef, chamferX = undef, chamferY = undef, chamferZ = undef) {
    if(size[0]) {
        chamferCubeImpl(size[0], size[1], size[2], ch, chamfers[0], chamfers[1], chamfers[2]);
    } else {
        // keep backwards compatibility
        size     = (sizeX == undef) ? size : sizeX;
        chamfers = (sizeY == undef) ? chamfers : sizeY;
        ch       = (sizeZ == undef) ? ch : sizeZ;
        ph1      = (chamferHeight == undef) ? ph1 : chamferHeight;
        ph2      = (chamferX == undef) ? ph2 : chamferX;
        ph3      = (chamferY == undef) ? ph3 : chamferY;
        ph4      = (chamferZ == undef) ? ph4 : chamferZ;
        
        chamferCubeImpl(size, chamfers, ch, ph1, ph2, ph3, ph4);
    }
}
    
module chamferCubeImpl(sizeX, sizeY, sizeZ, chamferHeight, chamferX, chamferY, chamferZ) {
    chamferX = (chamferX == undef) ? [1, 1, 1, 1] : chamferX;
    chamferY = (chamferY == undef) ? [1, 1, 1, 1] : chamferY;
    chamferZ = (chamferZ == undef) ? [1, 1, 1, 1] : chamferZ;
    chamferCLength = sqrt(chamferHeight * chamferHeight * 2);

    difference() {
        cube([sizeX, sizeY, sizeZ]);
        for(x = [0 : 3]) {
            chamferSide1 = min(x, 1) - floor(x / 3); // 0 1 1 0
            chamferSide2 = floor(x / 2); // 0 0 1 1
            if(chamferX[x]) {
                translate([-0.1, chamferSide1 * sizeY, -chamferHeight + chamferSide2 * sizeZ])
                rotate([45, 0, 0])
                cube([sizeX + 0.2, chamferCLength, chamferCLength]);
            }
            if(chamferY[x]) {
                translate([-chamferHeight + chamferSide2 * sizeX, -0.1, chamferSide1 * sizeZ])
                rotate([0, 45, 0])
                cube([chamferCLength, sizeY + 0.2, chamferCLength]);
            }
            if(chamferZ[x]) {
                translate([chamferSide1 * sizeX, -chamferHeight + chamferSide2 * sizeY, -0.1])
                rotate([0, 0, 45])
                cube([chamferCLength, chamferCLength, sizeZ + 0.2]);
            }
        }
    }
}