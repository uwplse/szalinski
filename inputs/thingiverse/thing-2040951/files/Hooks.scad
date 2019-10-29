// Copyright by Drato Lesandar @ www.robotmama.de
// 
// Customizable Hanger
// 
// Calculates number of hooks automatically, if you want other parameters,
// send a mail to info@robotmama.de or via Thingiverse
//

//(mm)
CylinderHeight = 10;
//(mm)
CubeWidth = 210;
//(mm)
CubeDepth = 20;
//(mm)
CubeHeight = 2;
//(mm)
DistanceBetweenHooks = 34;
//(mm, used 7 in image with bigger hooks)
SphereRadius = 3.5;
//(mm, used 5 in image with bigger hooks)
CylinderRadius = 2.5;
numHooks = round(CubeWidth / DistanceBetweenHooks);
cubeBorderSize = (CubeWidth-numHooks*DistanceBetweenHooks)/2;
union() {
    cube([CubeWidth,CubeDepth,CubeHeight],false);
    // Cylinder
    for(i=[0:numHooks-1]) translate([i*DistanceBetweenHooks+cubeBorderSize+DistanceBetweenHooks/2,CubeDepth/2,CubeHeight]) cylinder(CylinderHeight, CylinderRadius, CylinderRadius, false, $fn=50);
    // Spheres
    for(i=[0:numHooks-1]) translate([i*DistanceBetweenHooks+cubeBorderSize+DistanceBetweenHooks/2,CubeDepth/2,CylinderHeight+CubeHeight+SphereRadius/2]) sphere(SphereRadius, $fn=50);
}