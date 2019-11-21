part = "both"; //[both, top, bottom]

ductWidth = 39; //[200]
ductLength = 59; //[200]
ductDepth = 20; //[200]

//Duct Wall Thickness
wallThickness = 2; //[10]

//Baseplate Width
plateWidth = 47; //[200]
//Baseplate Length
plateLength = 99; //[200]
basePlateThickness = 3; //[20]

outletAngleDegrees = 30; //[90]
outletWallThickness = 1; //[10]

//Screwhole Diameter
holeDiameter = 4; //[10]
//X-offset from outer edge to center of screwhole
xHoleOffset = 10; //[100]
//Y-offset from outer edge to center of screwhole
yHoleOffset = 14; //[100]

module mountingHoles(depth){
    x = plateLength - (2 * xHoleOffset);
    y = plateWidth - (2 * yHoleOffset);
    module mountingHole(depth, diameter) {
        cylinder(h = depth, r = 0.5 * diameter, center = false, $fs=0.1);
    }
    union(){
        mountingHole(depth, holeDiameter);
        translate([x,0]) mountingHole(depth, holeDiameter);
        translate([x,y]) mountingHole(depth, holeDiameter);
        translate([0,y]) mountingHole(depth, holeDiameter);
    }
}

module basePlate(){
    cutoutX = ductLength - 2 * wallThickness;
    cutoutY = ductWidth - 2 * wallThickness;
    translate([-0.5 * plateLength, -0.5 * plateWidth]) difference(){
        cube(size = [plateLength, plateWidth, basePlateThickness]);
        translate([xHoleOffset, yHoleOffset, 0]){
            mountingHoles(basePlateThickness);
        }
        translate([0.5 * (plateLength - cutoutX), 0.5 * (plateWidth - cutoutY), 0]){ 
            cube(size = [ cutoutX, cutoutY, basePlateThickness]);
        }
    }
}

module ductPipe(){
    translate([-0.5 * ductLength, -0.5 * ductWidth]) difference(){
        cube(size = [ductLength, ductWidth, ductDepth]);
        translate([wallThickness, wallThickness]){
            cube(size = [
                ductLength - 2 * wallThickness,
                ductWidth - 2 * wallThickness,
                ductDepth]);
        }
    }
}

module duct(){
    basePlate(plateLength, plateWidth);
    translate([0, 0, -1 * ductDepth]) ductPipe();
}

module outlet(){
    innerWidth = ductWidth - 2 * wallThickness;
    innerLength = ductLength - 2 * wallThickness;
    innerHeight = tan(outletAngleDegrees) * innerLength;
    
    outerWidth = innerWidth + 2 * outletWallThickness;
    outerHeight = innerHeight + (outletWallThickness/cos(outletAngleDegrees));
    outerLength = outerHeight / tan(outletAngleDegrees);
    
    translate([-0.5 * innerLength, -0.5 * outerWidth, 0]){
        difference(){
            //Outer
            translate ([0, outerWidth, 0]) rotate([90, 0, 0]) linear_extrude(outerWidth){
                polygon(points=[
                    [0, 0],
                    [0, outerHeight], 
                    [outerLength, 0]
                ]);
            }
            //Inner
            translate([0, innerWidth + outletWallThickness, 0]){
                rotate([90, 0, 0]) linear_extrude(innerWidth){
                    polygon(points=[
                        [0, 0],
                        [0, innerHeight], 
                        [innerLength, 0]
                    ]);
                }
            }
        }
    }
}

module ductCover() {
    basePlate(plateLength, plateWidth);
    translate([0, 0, basePlateThickness]) outlet();
}

if(part == "both"){
    translate([0, 0, 50]) ductCover();
    duct();
} else if(part == "top"){
    ductCover();
} else{
    duct();
}

