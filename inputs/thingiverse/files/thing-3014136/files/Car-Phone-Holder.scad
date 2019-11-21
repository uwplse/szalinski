//Phone Dimensions
phoneHeight = 150;
phoneWidth = 80;
phoneThickness=13;

//General dimensions
walls=7.6;
width=round(0.75*phoneWidth);
height=round(0.75*phoneHeight);

//Vent dimensions for vehicle
ventSpacing=8;
ventWidth=18;
ventDepth=32;

//Dimensions of the USB hole
USBw = 6;
USBh = 12;

//Support bar location
barLength = (phoneWidth+walls*2)*1.02;
barOffsetx = walls/2-2;
barOffsety = 0.2*height;
barOffsetz = -1*(barLength-width)/2;

//Side support dimensions
sideSupport=10;
supporty = barOffsety+2-sideSupport/2;

// Create the basic shape
module step1() {
    cube([walls,height,width]);
    translate([walls,height,0])
    cylinder(h = width, d=walls*2);
}

// Build the base with curved corners
module step2() {
    difference(){
        step1();
        translate([walls,0,0]) cube([walls,height,width]);
    }
    translate([walls,height,0]) 
    cube([phoneThickness,walls,width]);
    translate([phoneThickness+walls,height,0]) 
    cylinder(h=width,d=walls*2);
}
module step3() {
    difference() {
        step2();
        translate([walls,height-walls,0])
        cube([phoneThickness,walls,width]);
    }
}

// Cut a hole for the USB cord
module step4() {
    holex = walls+(phoneThickness-USBw)/2;
    holey = (width-USBh)/2;
    difference() {
        step3();
        translate([holex,height,holey])
        cube([USBw,walls,USBh]);       
    }
}

// Cut a hole for front controls
module step5() {
    difference() {
        step4();
        translate([walls+phoneThickness,height-walls,walls])
        cube([walls,walls,width-walls*2]);        
    }
    //Add vent mounts
    translate([-1*ventDepth,0.5*height,(width-ventWidth)/2])
    cube([ventDepth,2,ventWidth]);
    translate([-1*ventDepth,0.5*height+ventSpacing-4,(width-ventWidth)/2])
    cube([ventDepth,2,ventWidth]);
}


//Cut hole for side supports
//Main holder body is now complete
module step6() {
    difference() {
        step5();
        translate([walls/2-2,0.2*height,0])
        cube([4,4,width]);
    }
}

module body() {
    step6();
}

//Rectangular support bar to print
//Slightly smaller to accomodate printing tolerance
module supportBar() {
    translate([barOffsetx,barOffsety,barOffsetz])
    cube([3.6,3.6,barLength]);
}

// Use a 4x4 bar to bore the appropriate holes
module supportBar4x4() {
    translate([barOffsetx,barOffsety,barOffsetz])
    cube([4,4,barLength]);
}

//Basic shape for side support
module step7() {
    translate([-1,supporty,barOffsetz])
    cube([phoneThickness+walls+1,sideSupport,walls]);   
}

module step8() {
    difference() {
        step7();
        supportBar4x4();
    }
    translate([walls+phoneThickness,supporty+sideSupport,barOffsetz+walls])
    rotate(a=[90,0,0])
    cylinder(h = sideSupport, d=walls*2); 
}

module step9() {
    difference() {
        step8();
        thisX = walls;
        thisY = supporty;
        thisZ = barOffsetz+walls;
        translate([thisX,thisY,thisZ])
        cube([phoneThickness,sideSupport,walls]); 
    }
}

module supportLeft() {
    step9();
}

module supportRight() {
    thisX = 0*(walls+phoneThickness);
    thisY = -2*supporty-sideSupport;
    thisZ = -1*barLength-2*barOffsetz;
    rotate(a=[180,0,0])
    translate([thisX,thisY,thisZ])
    supportLeft();
}

//See all at once
module onePiece() {
    translate([0,0,height])
    rotate(a=[90,180,90])
    union() {
        body();
        supportBar();
        supportLeft();
        supportRight();
    }
}
//Comment out this line to enable printing one part at a time.
onePiece();

//Un-Comment these out to print each part separately
//body();
//supportBar();
//supportLeft();
//supportRight();