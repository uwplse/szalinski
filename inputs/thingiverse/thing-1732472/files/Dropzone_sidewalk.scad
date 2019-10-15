// Sidewalk lengths: 105, 34
sidewalkLength=105;
// how far out from the building does the sidewalk extend.
sidewalkWidth=10;
// height of the sidewak.
sidewalkHeight=1.5;
// Depth of the sidewalk grooves
grooveZ=0.5;
// How wide to make the support that the building is in. 3 might be too thin. 5 might be better.
buildingSupportWidth=3;
// How high above the sidewalk to make the building supports.
buildingSupportHeight=3;
// Thickness of the paper buildings, i.e. how wide a groove to make for the building.
paperY=1;

//Sidewalk
difference() {
    cube([sidewalkLength, sidewalkWidth + buildingSupportWidth*2, sidewalkHeight]);
//  front groove
    translate([-1,grooveZ,sidewalkHeight-grooveZ]) cube([sidewalkLength+sidewalkWidth+2, 0.5, grooveZ]);
    // grooves
    for(x=[grooveZ : 6.5 : sidewalkLength]) {
        translate([x, grooveZ, sidewalkHeight-grooveZ]) cube([grooveZ,sidewalkWidth-2*grooveZ,grooveZ]);
    }
}
translate([0, sidewalkWidth, sidewalkHeight]) difference() {
    cube([sidewalkLength, buildingSupportWidth,buildingSupportHeight]);
    translate([-1,(buildingSupportWidth-paperY)/2,0]) cube([sidewalkLength+2,paperY,buildingSupportHeight+1]);
}
