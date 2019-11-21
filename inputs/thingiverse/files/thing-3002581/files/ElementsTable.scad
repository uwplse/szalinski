include <ElementsList.scad>;
$fn = 30;


setElement = 10  ;

//Main Configuration Settings
boxSize=200;  // in mm
labelBoxSize=5; //A 1/X Scale from the Box Size
wallSize=15; // in mm

//Draw Main Cube and Cut it with the Inner Cube
difference() {
    cube([boxSize,boxSize,boxSize]);
    translate([wallSize/2,-wallSize/2,wallSize/2])
    cube([boxSize-wallSize,boxSize,boxSize-wallSize]);
}

//Draw The Cubes for the Labels
//Lower Left Label
translate([wallSize/2,0,wallSize/2])
    cube([boxSize/labelBoxSize,wallSize/2,boxSize/labelBoxSize]);
//Lower Right Label
translate([(boxSize-wallSize/2)-(boxSize/labelBoxSize),0,wallSize/2])
    cube([boxSize/labelBoxSize,wallSize/2,boxSize/labelBoxSize]);
//Upper Left Label
translate([wallSize/2,0,(boxSize-wallSize/2)-(boxSize/labelBoxSize)])
    cube([boxSize/labelBoxSize,wallSize/2,boxSize/labelBoxSize]);

//Guard Rails
rotate([0,90,0]) {
    //Lower Rail
    translate([-((wallSize/labelBoxSize)+.5*wallSize),wallSize/labelBoxSize,(boxSize/labelBoxSize)+.5*wallSize])
        cylinder(  boxSize-(2*(boxSize/labelBoxSize))-wallSize, wallSize/labelBoxSize, wallSize/labelBoxSize); 
    //Middle Rail
    translate([-((wallSize/labelBoxSize)+.25*wallSize+.5*(boxSize/labelBoxSize)),wallSize/labelBoxSize,(boxSize/labelBoxSize)+.5*wallSize])
        cylinder(  boxSize-(2*(boxSize/labelBoxSize))-wallSize, wallSize/labelBoxSize, wallSize/labelBoxSize); 
    //Upper Rail
    translate([-((wallSize/labelBoxSize)+(boxSize/labelBoxSize)),wallSize/labelBoxSize,(boxSize/labelBoxSize)+.5*wallSize])
        cylinder(  boxSize-(2*(boxSize/labelBoxSize))-wallSize, wallSize/labelBoxSize, wallSize/labelBoxSize);
}
//Element Name
rotate([90,0,0]) {
    translate([wallSize/2,.4*(boxSize/labelBoxSize),0])
        linear_extrude(3)
            text(str(Elements[setElement][1]), (boxSize/labelBoxSize)/2, Helvetica);
}
//Element Number
rotate([90,0,0]) {
    translate([.3*(boxSize/labelBoxSize),boxSize-.9*(boxSize/labelBoxSize),0])
        linear_extrude(3)
            text(str(Elements[setElement][0]), (boxSize/labelBoxSize)/2, Helvetica);
}

//Element Weight
rotate([90,0,0]) {
    translate([boxSize-((boxSize/labelBoxSize)+wallSize/2),.5*(boxSize/labelBoxSize),0])
        linear_extrude(3)
            text(str(Elements[setElement][3]), (boxSize/labelBoxSize)/4, Helvetica);
}


 
