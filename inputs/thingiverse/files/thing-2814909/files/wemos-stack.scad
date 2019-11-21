//
// WeMOS D1 Mini Stack Enclosure Script
// This Version is inspired from https://www.thingiverse.com/thing:1776349/#files
//
// This script was written to generate a suitable 3D printed enclosure for a WeMOS "stack" of shields.
// Since there are a variety of connectors, sizes and arrangements, the decission was to let the customizer
// allow for various positionings of each shields port.
//
// To use, you will need to assemble your device put it on a flat surface (e.g. table) and measureeach layer. 
// For measuring you need the distance from your flat surface to the lower end of the opening in the case.
//  - the total innerSizeZ (height) of the stack
//  - the inner offsets for any shields that require an opening in the case.
//
// For instance, We have the following Stack:
//
// +----------------+
// | SD Card Shield |
// +----------------+
// | Battery Shield |
// +----------------+
// | WeMOS D1 Mini  |
// +----------------+ 2 mm
//
// All have stackable headers, that have had their pins trimmed to make the stack as short
// as possible.  The resulting measurements of the stack yield the default values of this script.
//

/* [inner Height Z] */
// Final height of the stack measured when placing the sole stack on a flat surface.
//innerHeightZ = 58.7;
innerHeightZ = 18.4;


/* [Shield Ports] */

// Distance from the bottom of PCB Board to the bottom of the usb connector opening (-99 to omit)
usbHeight = -1.0;

// Distance from the bottom of PCB Board to the bottom of the microsd shield opening (-99 to omit)
//microsdHeight = 30;
// microsdHeight = 8;
 microsdHeight = -99;

// Distance from the bottom of PCB Board to the bottom of the battery shield connector opening (-99 to omit)
//batteryHeight = 18.0;
//batteryHeight = 15;
batteryHeight = -99;

// Distance from the bottom of PCB Board to the bottom of the DC Power shield connector terminal opening (-99 to omit)
//dcPowerHeight=25;
dcPowerHeight=-99;

// Distance from the bottom of PCB Board to the bottom of the relay shield connector terminal opening (-99 to omit)
relayHeight = 38.0;

// Show Base housing
showBase=true;

/* [LID] */

// There are visible cutouts in the lid for 
lidHasVisiblePinoutSlits=false;

// The lid should contain a cutout connecting the PINs
lidCutOutType="LED"; // [ LCD:LCD Shield , DHT:Dht Shield,DHThorizontal:Dht Shield, BUTTON:Button Shield , NONE:No cutout]

// Do you want the Lid to show up
showLid=true;

//Side and Front slits for letting warm air out
airSlits=true;

/* [Others] */
wallThickness = 1.8;

// cut through at Bottom for Pins
bottomHasPinoutSlits=true;

// Add mounting clips with screw holes a bottom
numberOfBaseMountingClips=4;

// show some Examples
showExamples=false;

// show each Tape once
showAllOnce=false;

// ---------------------------------------------------------------------------------------------------------
// do not need to modify anything below here
// ---------------------------------------------------------------------------------------------------------
/* [Hidden] */

extraGap=0.2;
printerWobble=0.01;
printerWobbleXYZ=printerWobble*[1,1,1];
printerWobbleXYZ2=printerWobbleXYZ*2;

$fn=20;

// Final outerSizeZ of the stack walls.
// outerSizeZ = 36.0;

innerSizeX = 26.70;
innerSizeY = 35.5;
//innerSizeZ = innerHeightZ;


holeDiameter = 20.0;

// Offset of all stacked Boards because of the WIFI Antenna
antennaOffsetY=6.2;
lcdDimensions=[18.5,18.1,4.5]
              +2*printerWobble*[1,1,0];

// Size of the slits for pins of PCB board
slitDimension=[2.6,23.0,10.0];


/* calculated */
extraGap2=2*extraGap;

// ===================================================
// Main
// ===================================================

if (showAllOnce){
    translate([0,-50,0])  
        LidExamples();
    
    BaseExamples();

} else {

    // base
    if (showBase)
        base(innerSizeZ=innerHeightZ-wallThickness,numberOfBaseMountingClips=numberOfBaseMountingClips);

    // lid
    if (showLid)
        translate([-40,0,0])   
            lid(lidCutOutType=lidCutOutType);


    // All kind of examples
    if ( showExamples)
        translate([0,200,0])  
            examples();

}

// ===================================================
// Modules
// ===================================================

module examples(){
    translate([0,-50,0])  {
        LidExamples();
    translate([0,-45,40])  
        rotate([270,0,0]) 
            LidExamples();
    }
    
    BaseExamples();

}


module BaseExamples(){
        translate([0,0,0])   {
            translate([000,0,0])     base(innerSizeZ=17,        numberOfBaseMountingClips=0);
            translate([050,0,0])     base(innerSizeZ=17,        numberOfBaseMountingClips=2);
            translate([100,0,0])     base(innerSizeZ=17,        numberOfBaseMountingClips=4);
        }
        
        translate([0,60,0])  {
            translate([000,0,0])     base(innerSizeZ=12.5, numberOfBaseMountingClips=0);
            translate([040,0,0])     base(innerSizeZ=22.5, numberOfBaseMountingClips=0);
            translate([080,0,0])     base(innerSizeZ=36,   numberOfBaseMountingClips=0);
            translate([120,0,0])     base(innerSizeZ=47,   numberOfBaseMountingClips=0);
        }
        
        translate([0,120,0])   {
            translate([000,0,0])     base(innerSizeZ=27);
            translate([040,0,0])     base(innerSizeZ=27, dcPowerHeight=12,  microsdHeight=0, batteryHeight=0, relayHeight=0 , numberOfBaseMountingClips=0);
            translate([080,0,0])     base(innerSizeZ=27, dcPowerHeight=0,  microsdHeight=12, batteryHeight=0, relayHeight=0 , numberOfBaseMountingClips=0);
            translate([120,0,0])     base(innerSizeZ=27, dcPowerHeight=0,  microsdHeight=0, batteryHeight=12, relayHeight=0 , numberOfBaseMountingClips=0);
            translate([160,0,0])     base(innerSizeZ=27, dcPowerHeight=0,  microsdHeight=0, batteryHeight=0, relayHeight=12 , numberOfBaseMountingClips=0);
        }

}

module LidExamples(){
        translate([000,0,0])   lid(lidCutOutType="BUTTON");
        translate([040,0,0])   lid(lidCutOutType="LCD");
        translate([080,0,0])   lid(lidCutOutType="DHT");
        translate([120,0,0])   lid(lidCutOutType="HOLE");
        translate([160,0,0])   lid(lidCutOutType="NONE");

}


module lcdCutOut(){
   cube(lcdDimensions+extraGap*[1,1,0]);

    // Flat cable for connection
    cableX=14;
    cableY=6;
    cableZ=4;
    translate([lcdDimensions[0]/2-cableX/2,-cableY+.001,.5])
        cube([cableX,cableY,cableZ]);
}


module pinHoleSlits(visibleFromOutside=1){
    
    slitOffsetY=wallThickness
                +innerSizeY
                -slitDimension[1]
                -antennaOffsetY;
    
    translate([0,0,visibleFromOutside==1?-.01:+.8])
        translate([.7,slitOffsetY,0])
            for ( x=[0,22.6]){
                translate([x,0,0])
                    cube(slitDimension);
            }
}


// ========================================
// Lid
// ========================================

module lid(lidCutOutType="BUTTON"){
    outerSizeX = innerSizeX + (2 * wallThickness);
    outerSizeY = innerSizeY + (2 * wallThickness);
//    outerSizeZ = innerSizeZ + (2 * wallThickness);
    diameterButton=8;
    
    difference() {
        union () {
            // Lid Base Plate
            translate([0, 0, 0.0]) cube([outerSizeX, outerSizeY, 2.0]);

            // Lid inner part
            translate([ wallThickness+printerWobble, wallThickness+printerWobble,wallThickness]) {
                color("green")
                    cube([innerSizeX-2*printerWobble, innerSizeY-2*printerWobble, 2.3]);
                LidNotch(wobble=-1);
             }
        }
        
        // Space for PCB Board
        innerFrameOffset=2;
        translate([ wallThickness+innerFrameOffset, wallThickness+innerFrameOffset,wallThickness]) 
                cube([innerSizeX-innerFrameOffset*2, innerSizeY-innerFrameOffset*2, 4]);
        
        translate([wallThickness,0,0])
            pinHoleSlits(visibleFromOutside=lidHasVisiblePinoutSlits);
        
        // Lid Cutout
        if(lidCutOutType=="LCD"){
                translate(wallThickness*[1,1,-0.001]
                        +[innerSizeX/2,innerSizeY,0])
                        translate([-lcdDimensions[0]/2,-lcdDimensions[1],0]
                                  +[0,-antennaOffsetY,0]
                                ) 
                            lcdCutOut();

                // Text LCD
                translate([wallThickness+innerSizeX/2,9,-0.01])
                    linear_extrude(height = 0.5) 
                        rotate([180,0,0])
                            text("LCD", ,size=7,halign="center");
        } else if (lidCutOutType=="DHT") {
                dhtSensorDimensions=[12.1+extraGap2,5.6+extraGap2,6];
                translate(wallThickness*[1,1,-0.001]
                         +[innerSizeX/2,0,0])
                    translate([-dhtSensorDimensions[0]/2,16.8,0] -printerWobbleXYZ   ) 
                        cube(dhtSensorDimensions+printerWobbleXYZ2);

                // Text DHT
                translate([wallThickness+innerSizeX/2,32,-0.01])
                    linear_extrude(height = 0.5) 
                        rotate([180,0,0])
                            text("DHT", ,size=7,halign="center");   
        } else if (lidCutOutType=="LED") {
                dLED=4.2;
                translate(wallThickness*[1,1,1.001]
                         +[innerSizeX/2,0,0])
                    translate([-0,15.2,0] -printerWobbleXYZ   ) 
                        cylinder(d1=dLED,d1=dLED+1,h=4,center=true);

                // Text DHT
                translate([wallThickness+innerSizeX/2,32,-0.01])
                    linear_extrude(height = 0.5) 
                        rotate([180,0,0])
                            text("LED", ,size=7,halign="center");   
        } else if (lidCutOutType=="DHThorizontal") {
                dhtSensorDimensions=[12.1+extraGap,15.6+extraGap,6];
                translate(wallThickness*[1,1,-0.001]
                         +[innerSizeX/2,0,0])
                    translate([-dhtSensorDimensions[0]/2,0.6,0] -printerWobbleXYZ   ) 
                        cube(dhtSensorDimensions+printerWobbleXYZ2);

                // Text DHT
                translate([wallThickness+innerSizeX/2,32,-0.01])
                    linear_extrude(height = 0.5) 
                        rotate([180,0,0])
                            text("DHT", ,size=7,halign="center");   
        } else if (lidCutOutType=="BUTTON" ){
                translate(wallThickness*[1,1,-0.001]
                         +[innerSizeX/2,innerSizeY,0])
                    translate([0,-innerSizeY/2, 2.5-0.01]) 
                        cylinder(h = 5 , d = diameterButton+2*printerWobble, center = true);

                // Text Button
                translate([wallThickness+innerSizeX/2,35,-0.01])
                    linear_extrude(height = 0.5) 
                        rotate([180,0,0])
                            text("Button", ,size=7,halign="center");   
        } else if (lidCutOutType=="HOLE" ){
                translate(wallThickness*[1,1,-0.001]
                         +[innerSizeX/2,innerSizeY,0])
                    translate([0,-innerSizeY/2, 2.5-0.01]) 
                        cylinder(h = 5 , d = holeDiameter, center = true);

                // Text Button
                translate([wallThickness+innerSizeX/2,35,-0.01])
                    linear_extrude(height = 0.5) 
                        rotate([180,0,0])
                            text("Button", ,size=7,halign="center");   

        } else if (lidCutOutType=="NONE"){
        } else {
            echo("!!!!!!!!!!!!!!! Error Wrong Type for lidCutOutType");
        }
        
        
    }

    if (lidCutOutType=="BUTTON" ){
        buttonGap=.3;
        color("blue")
       translate([-20,innerSizeY/2, 0]) 
            difference(){
                union(){
                    cylinder(h = 2 , d = diameterButton+4 );
                    translate([0,0,2])
                    cylinder(h = wallThickness+1  , d = diameterButton);
                }
                
                // inner Hole
                innerHoleZ=3;
                translate([-3.8/2,-3.8/2, -.001]-printerWobbleXYZ) 
                   cube([3.8,3.8,innerHoleZ-.2]+printerWobbleXYZ2);
        }
    }

}


module LidNotch(wobble=1){
    notchHeight=1.2;
    notchAdditionalSize=.5*[0,1,0];
    notchInnerSize=[innerSizeX-2*printerWobble, innerSizeY-2*printerWobble, notchHeight];
    notchOuterSize=notchInnerSize + 2*notchAdditionalSize + printerWobbleXYZ*wobble;

    translate([ wobble*printerWobble, wobble*printerWobble,2.4]
                -notchAdditionalSize
                -[0,0,notchHeight]) 
        color("blue")
       difference(){
           cube(    notchOuterSize);
           for (y=[0,.1+notchOuterSize[1]]){
                translate([-.1,y,.4])            
                    rotate([wobble*-45,0,0])
                        cube([notchOuterSize[0]+1,4,4]);
           }
//            translate(notchAdditionalSize+[0,0,-.1])            cube(    notchInnerSize+[0,0,2.2]);

    }
}



// ========================================
// Base Modules
// ========================================


module baseBars(){
    difference(){
        union(){
            translate([0,  6,    0]) cube([innerSizeX, 3, 1.36]);
            translate([0, 28.5,  0]) cube([innerSizeX, 3, 2.6]);
        }
        
        // Cutouts
        translate([0,   5, 0]) cube([5.8, 2, 2]); // cutout reset 
        translate([8, 2.5, 0]) cube([9,   6, 2]); // cutout USB
        
        pinHoleSlits(visibleFromOutside=1);
    }
}

module BaseMountingClips(numberOfBaseMountingClips=4){
    sizeBaseMountX=8;
    sizeBaseMountY=10;
    sizeBaseMountZ=2.5;
    diameterBaseClipHoles=3;
    
    outerSizeX = innerSizeX + (2 * wallThickness);
    outerSizeY = innerSizeY + (2 * wallThickness);
//    outerSizeZ = innerSizeZ + (2 * wallThickness);


        yRange= (numberOfBaseMountingClips==4)?[6,outerSizeY-sizeBaseMountY-2]
                :(numberOfBaseMountingClips==2)?[outerSizeY/2-sizeBaseMountY]:[];

    
    for( x=[-sizeBaseMountX,outerSizeX]){
//        for( y=[0,outerSizeY-sizeBaseMountY]){
        for( y=yRange){
            translate([x,y,0])
                BaseMountingClip(
                    sizeBaseMountX=sizeBaseMountX,
                    sizeBaseMountY=sizeBaseMountY,
                    sizeBaseMountZ=sizeBaseMountZ,
                    diameterBaseClipHoles=diameterBaseClipHoles,
                    x=x);
        }
    }
}

module BaseMountingClip(sizeBaseMountX=8,
                        sizeBaseMountY=10,
                        sizeBaseMountZ=2.5,
                        diameterBaseClipHoles=3,
                        x=0
                        ){
    union(){
        difference(){
            cube([sizeBaseMountX,sizeBaseMountY,sizeBaseMountZ]);

            // central hole for screw
            translate([sizeBaseMountX/2,sizeBaseMountY/2,-0.01])
                cylinder(d=diameterBaseClipHoles,h=sizeBaseMountZ+1);

            //  hole for screw-head
            translate([sizeBaseMountX/2,sizeBaseMountY/2,2])
                cylinder(d=diameterBaseClipHoles+4,h=sizeBaseMountZ+1);

            translate([2,2,2])
                cube([sizeBaseMountX-3*2,sizeBaseMountY-3*2,sizeBaseMountZ]);
        }
        
        reinforcementY=1.5;
        for(y=[0,sizeBaseMountY-reinforcementY])
            difference(){
                translate([0,y,2])
                    cube([sizeBaseMountX,reinforcementY,2]);
                translate([sizeBaseMountX/2,reinforcementY/2+y,4])
                    rotate([0,(x>10)?10:-10,0])
                            cube([sizeBaseMountX+1,reinforcementY+.1,2],center=true);
            }
    }        
}


// ========================================
// Base
// ========================================
module  base(
    innerSizeZ=innerHeightZ,
    numberOfBaseMountingClips=4,
    dcPowerHeight=dcPowerHeight,
    microsdHeight=microsdHeight,
    batteryHeight=batteryHeight,
    relayHeight=relayHeight 
    ){
    
    outerSizeX = innerSizeX + (2 * wallThickness);
    outerSizeY = innerSizeY + (2 * wallThickness);
    outerSizeZ = innerSizeZ + (2 * wallThickness);

    BaseMountingClips(numberOfBaseMountingClips=numberOfBaseMountingClips);

    translate(wallThickness*[1,1,1])
        union() {
            baseBars();


            difference () {
                    // Set Outer Base level to -wallThickness. So coordinate zero is at front lower inner corner.
                    // So we can measure all other Heights and positions from the front corner of the Wemos PCB (-2mm)
                    translate(-wallThickness*[1,1,1]) 
                        cube([outerSizeX, outerSizeY, outerSizeZ]); 
                    translate([-1,-1,0]*printerWobble)
                        cube([innerSizeX+2*printerWobble, innerSizeY+2*printerWobble, innerSizeZ+wallThickness+.001]);


                   if (airSlits){
                       // Side Air slits
                        for ( z=[3.8:2:innerSizeZ-4])
                            for ( x=[0,outerSizeX-1])
                                for(y=[1.2,outerSizeY-10])
                                    translate([-5,-1,0]+[x,y,z])
                                        cube([8, 7.2, .8]);

                        // Front Air slits
                        for ( z=[3.8:2:innerSizeZ-4])
                            for ( x=[2.5,outerSizeX-6])
                                for(y=[-4,outerSizeY-6])
                                    translate([-2,-1,0]+[x,y,z])
                                        cube([4, 7.2, .8]);
                     }

                     translate([0,0,innerSizeZ+wallThickness+.2]) {
                         mirror([0,0,1])
                                LidNotch(wobble=1);
                     }

                    // Cut-out in Basement
                    bodenGitter=1;
                    translate([1, 0, -wallThickness ]) 
                        if (bodenGitter){
                            for ( y=[10:3:25])
                                translate([2.5,y,-.1])
                                    cube([20,2,20]);
                                }
                        else 
                            translate([innerSizeX,innerSizeY,-0.01]/2) 
                                    cylinder(h = wallThickness+4 , d = holeDiameter);

                    // Cutouts for solder Pins
                    translate([0,0,-wallThickness])                     
                        pinHoleSlits(visibleFromOutside=bottomHasPinoutSlits);
                    
                    // Reset Hole
                    translate([-wallThickness-.01-1, 2.5, 0.5]) 
                        cube([4,3, 2.5]);

                    // =======================
                    // Front Holes                    
                    textX=-innerSizeX/2-wallThickness+.7;
                    translate([innerSizeX/2,-wallThickness-0.01,0]) {
                        // USB
                        if (usbHeight != 0.0)  {
                            translate([ -7.5, 0, -1+usbHeight]) cube([12,4 ,1+6.2]);

                            // Front Text
                            translate([textX,0.5,2+usbHeight])
                                rotate([90,0,0]) 
                                    linear_extrude(height = 0.7,width=12) 
                                        text("USB", ,size=2.3,halign="left"); 
                        }
                        
                        // Micro USB Shield
                        if (microsdHeight != 0.0)  {
                            translate([ -6, 0,microsdHeight]) 
                                    cube([ 15,4 ,3]);
                            // Front Text
                            translate([textX,0.5,1+microsdHeight]) rotate([90,0,0]) text("SD", ,size=2,halign="left"); 
                        }
                        
                        // Battery Shield
                        if (batteryHeight != 0.0) {
                            translate([-innerSizeX/2+4.7, 0,batteryHeight]) cube([ 7.3, 6,8]);
                            translate([-innerSizeX/2+13.8, 0,batteryHeight]) cube([ 9, 6.1,8]);
                            // Front Text
                            translate([textX,0.5,2+batteryHeight]) 
                                    linear_extrude(height = 0.5) 
                                        rotate([90,0,0]) text("BAT", ,size=2,halign="left"); 
                        }
                        
                        // DC Power Shield
                        if (dcPowerHeight != 0.0) {
                            translate([-innerSizeX/2+5.5, 0,dcPowerHeight]) cube([ 9, 4,10.8]);
                            // Front Text
                            translate([textX,0.5,4+dcPowerHeight]) rotate([90,0,0]) text("DC", ,size=2,halign="left"); 
                        }
                        
                        // Relay Shield
                        if (relayHeight != 0.0) {
                            translate([ -7.5, 0,2+relayHeight]) cube([15,4,7]);
                            // Front Text
                            translate([textX,0.5,2+relayHeight]) rotate([90,0,0]) text("Relay", ,size=2,halign="left"); 
                        }
                    }
                }
        }
}
