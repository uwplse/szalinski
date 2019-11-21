//circle resolution
$fn=100;

//total width of the mount
mountHeight = 24; 

//length of your phone or case
phoneLength = 150; 

//thickness of the arm
armThickness = 4; 

//width of each arm
armWidth = 8;

//maximum distance between braces in the arms
maxBridge = 13;

//height of the tab on the two ends of phone
phoneThickness = 9.5; 

//radius of the fillets
filletRadius = 2;

//diameter of the handlebar on your bike
barDiameter = 22.2; 

//thickness of the three plates
finThickness = 3; 

//thickness of the arc surface
cylinderThickness = 3; 

//offset of the cutout grabing the phone clamp, larger is looser
tolerance = 0.05;

offsetDepth = 16+cylinderThickness+barDiameter/2;

hexPts = [
    [0,-15.08-tolerance], //0
    [0,15.08+tolerance], //1
    [4.5,17.68+tolerance], //3
    [8.2,15.54+tolerance], //5
    [8.2,-15.54-tolerance], //4
    [4.5,-17.68-tolerance], //2
    ];

module hex () {
    linear_extrude(height=mountHeight) polygon(hexPts);
}

finPts = [
    [armThickness,25],
    [armThickness,-25],
    [offsetDepth,-barDiameter/2-cylinderThickness],
    [offsetDepth,barDiameter/2+cylinderThickness],
];

module hexClamp (){
    difference (){
        linear_extrude(height=mountHeight) polygon(finPts);
        translate ([11,-25,0]){    
            cube([offsetDepth,50,mountHeight],center=false);
        }
    }
    
}

module fin () {
    linear_extrude(height=finThickness) polygon(finPts);
}


module arm () {
translate([0,-phoneLength/2,0]) {
    cube(size = [armThickness,phoneLength,mountHeight], center = false);
    }
}

module armHollow(){
    translate ([0,25,armWidth]) {
    difference() {
        cube ([armThickness,phoneLength/2-25,mountHeight-armWidth*2],center=false);
        armBraces();
    }
}
}

module armBraces(){
    braceWidth   = max(2, armWidth/3);
    hollowLength = phoneLength/2 - 25;
    hollowWidth  = mountHeight-(2*armWidth);
    numBraces    = floor((hollowLength/maxBridge - 1) / (1 - braceWidth/maxBridge));
    bridgeLength = (hollowLength/(numBraces+1)) - (braceWidth*numBraces/(numBraces+1));
    echo("Brace Width: ", braceWidth);
    echo("number of Braces: ", numBraces);
    echo("bridge length: ", bridgeLength);
    
    for (i = [1:1:numBraces]) {
        translate([0,bridgeLength*i + braceWidth*(i-1)])
        cube ([armThickness, braceWidth, hollowWidth], center=false);
    }
}

module tab(){
    translate([-phoneThickness,phoneLength/2,0]) {
        cube(size=[armThickness+phoneThickness,armThickness,mountHeight], center = false);
        //fillet
        translate([phoneThickness-filletRadius,-filletRadius]) {
            difference() {
                cube(size = [filletRadius, filletRadius, mountHeight], center = false);
                union() {
                    cylinder(mountHeight, filletRadius, filletRadius, center=false);
                    translate([0, 0, armWidth]) {
                        cube(size = [
                            filletRadius,
                            filletRadius,
                            mountHeight - 2 * armWidth
                        ], center = false);
                    }
                }
            }
        }
        //bump
        difference() {
            union() {
                translate([-(cos(30)*filletRadius+filletRadius),0]) {
                    cube([cos(30)*filletRadius+filletRadius, armThickness, mountHeight], center = false);
                }
                translate([-filletRadius,sin(30)*filletRadius]) {
                    cylinder(mountHeight, filletRadius, filletRadius, center = false);
                }
            }
            translate([-2*(cos(30)*filletRadius+filletRadius),0]) {
                cube([cos(30)*filletRadius+filletRadius, armThickness, mountHeight], center = false);
            }
        }
    }
}

module tabAll() {
tab();
mirror ([0,1,0]){
    tab();
}
}

module finAll () {
translate([0,0,0]) {
    fin();
}
translate([0,0,mountHeight-finThickness]) {
    fin();
}
translate([0,0,mountHeight/2-finThickness/2]) {
    fin();
}
}

module smallCylinder () {
translate([offsetDepth,0,0]) {
cylinder(h=mountHeight, r=barDiameter/2);
}
}

module largeCylinder () {
translate([offsetDepth,0,0]) {
cylinder(h=mountHeight, r=barDiameter/2+cylinderThickness);
}
}


module positive (){
union () {
        finAll();
        tabAll();
        arm();
        largeCylinder();
        hexClamp();
}
}

module negative(){
    union () {
        smallCylinder();
        translate([offsetDepth,-20,0]) {
            cube(size=[offsetDepth,40,mountHeight], center = false);
        }
        hex();
        translate ([-7,0,0]){
            hex();
            }
        armHollow();
        mirror ([0,1,0]){
            armHollow();};
    }
}

difference (){
    positive();
    negative();
}