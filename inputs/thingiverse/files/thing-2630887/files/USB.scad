//----------Variables----------
WallThickness = 1;
USBThick = 5;
USBLength = 13;
USBHeight = 15;
CableThick = 2.5;
CableWidth = 8;

//----------Code----------
color("RoyalBlue")union(){
    //USB part
    color("gray")union(){
        //Bottom
        color("green")translate([0,0,-(USBThick+WallThickness)/2])cube([USBHeight, USBLength, WallThickness], center=true);
        //Top
        color("Lightgreen")translate([0,0,(USBThick+WallThickness)/2])cube([USBHeight, USBLength, WallThickness], center=true);
        //Right
        color("blue")translate([0,(USBLength+WallThickness)/2,0])cube([USBHeight, WallThickness, USBThick+(2*WallThickness)], center=true);
        //Left
        color("purple")translate([0,-(USBLength+WallThickness)/2,0])difference(){
            cube([USBHeight, WallThickness, USBThick+(2*WallThickness)], center=true);
            cube([USBHeight+WallThickness, WallThickness*3, CableThick-0.5], center=true);
        };
        //Back
        color("red")translate([-(USBHeight+WallThickness)/2,0,0])difference(){
            cube([WallThickness, USBLength+2*WallThickness, USBThick+2*WallThickness], center=true);
            translate([0,-WallThickness,0])cube([2*WallThickness, USBLength+2*WallThickness, (CableThick-0.5)], center=true);
            cube([2*WallThickness, CableWidth, CableThick], center=true);
        };
    };

    //Holders
    Length = 10;
    //Top
    color("red")translate([(USBHeight-WallThickness)/2, 0, -(Length/2+(USBThick+WallThickness)/2)])cube([WallThickness, USBLength+2*WallThickness, Length+WallThickness], center=true);
    translate([USBHeight-WallThickness, 0, -(Length+(USBThick+2*WallThickness)/2+WallThickness/2)])difference(){
        color("orange")cube([USBHeight,USBLength+2*WallThickness,WallThickness], center=true);
        translate([-1.5,0,0])cube([7,3,WallThickness*3], center=true);
    };

    //Bottom
    color("green")translate([(USBHeight-WallThickness)/2, 0, (Length/2+(USBThick+WallThickness)/2)])cube([WallThickness, USBLength+2*WallThickness, Length+WallThickness], center=true);
    translate([USBHeight-WallThickness, 0, (Length+(USBThick+2*WallThickness)/2+WallThickness/2)])difference(){
        cube([USBHeight,USBLength+2*WallThickness,WallThickness], center=true);
        translate([-1.5,0,0])cube([7,3,WallThickness*3], center=true);
    };
};