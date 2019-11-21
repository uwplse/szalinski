//circle resolution
$fn=100;

//total width of the mount
mountHeight = 24; 

//length of your phone or case
phoneLength = 140; 

//thickness of the arm
armThichness = 3; 

//width of each arm
armWidth = 8; 

//height of the tab on the two ends of phone
tabHeight = 8; 

//diameter of the handlebar on your bike
barDiameter = 25.4; 

//thickness of the three plates
finThickness = 3; 

//thickness of the arc surface
cylinderThickness = 4; 

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
    [armThichness,25],
    [armThichness,-25],
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
    cube(size = [armThichness,phoneLength,mountHeight], center = false);
    }
}

module armHollow(){
    translate ([0,25,armWidth]) {
    cube ([armThichness,phoneLength/2-25,mountHeight-armWidth*2],center=false);
    
}
}

module tab(){
translate([-tabHeight,phoneLength/2,0]) {
cube(size=[armThichness+tabHeight,armThichness,mountHeight], center = false);
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