// Case for Protractor Proximity Sensor
// www.robogao.com/protractor

// THERE ARE 3 OBJECTS IN THE MODEL
//Protractor(); // Comment out before printing
CaseBottom();
translate([0,-wallt,ledHeight - photoHeight]) rotate([180,0,0]) // Uncomment for Side by Side
CaseTop();

// SETTINGS TO CUSTOMIZE YOUR CASE:
// Note: All dimensions are in mm
capTop = true;                // Do you need a hole in the top for the Capacitor?
capBottom = false;            // Do you need a hole in the bottom for the Capacitor?
headerTopStraight = true;     // Which way are your header pins soldered on?
headerTopAngle =true;         // If you don't know yet, set all headers to
headerBottomStraight = true;  // true
headerBottomAngle = true;
labelCutouts = true; // Removes material so you can see the connection labels on the PCB without disassembing case
ledCutouts = true;   // Do you want to be able to see the LEDs through the case top?
caset = 1.5;         // Thickness of the base. 1.5mm is recommended
wallt = 1.5;         // Thickness of the walls. 1.0mm to 1.5mm is recommended
overhang = 3;        // How far the case will overhang the edge of the protractor pcb. 3mm is recommended
clearance = 0.5;     // Clearance between protractor and the case. 0.5mm to 1mm is recommended

// These parameters control the quality / resolution of the STL.
// Don't mess with these unless you know what you're doing.
$fa=0.25;
$fs=0.25;

// PROTRACTOR BOARD DIMENSIONS.
// Don't mess with these unless you know what you're doing.
prd = 2*1.75*25.4; // protractor diameter
prt = 1.6; // protractor pcb thickness
holed = 3.35; // diameter of mounting holes
hole1x = -1.25*25.4; // x-axis location of hole 1
hole1y = 0.25*25.4;  // y-axis location of hole 1
hole2x = 0*25.4;
hole2y = 1.25*25.4;
hole3x = 1.25*25.4;
hole3y = 0.25*25.4;
hole4x = -0.75*25.4;
hole4y = 1.375*25.4;
hole5x = 0.35*25.4;
hole5y = 1.375*25.4;
capx = -0.98*25.4; // x-axis location of capacitor
capy = 0.7*25.4;   // y-axis location of capacitor
capd = 10; // diameter of capacitor *subject to change*
caph = 14; // height of capacitor *subject to change*
hdrw = 0.8*25.4; // header width
hdrd = 0.1*25.4; // header depth
hdrh = 10; // header height
hdrx = 0.4*25.4; // x-axis location of header
hdry = 0.15*25.4; // y-axis location of header
photoHeight = 2.5; // Height of phototransistors above the PCB
ledHeight = 2.35; // Height of LEDs above the PCB

module CaseBottom(){
    vClr = photoHeight + clearance;
    photoOffset = 5.5; // distance to offset the wall around the phototransistors. Don't change unless you know what you're doing.
    translate([0,0,-prt/2-caset/2-vClr])
    difference(){
        union(){
            translate([0,0,-caset/4])
            cylinder(d=prd+overhang,h=caset/2,center=true); // semicircle plate
            translate([0,0,caset/4])
            cylinder(d2=prd,d1=prd+overhang,h=caset/2,center=true); // semicircle plate
            translate([hole1x,hole1y,vClr/2+caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 1
            translate([hole2x,hole2y,vClr/2+caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 2
            translate([hole3x,hole3y,vClr/2+caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 3
            translate([hole4x,hole4y,vClr/2+caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 4
            translate([hole5x,hole5y,vClr/2+caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 5
            translate([-6.5,15.9,vClr/2+caset/2])
            cube([wallt,8.9,vClr],center=true); // Center Support
            translate([6.5,15.9,vClr/2+caset/2])
            cube([wallt,8.9,vClr],center=true); // Center Support
            translate([0,0,vClr/2+caset/2])
            difference(){
                cylinder(d=prd-photoOffset,h=vClr,center=true); // Edge Support / Light Shield
                cylinder(d=prd-photoOffset-2*wallt,h=vClr+0.1,center=true);
                for(a=[0:1:3]){
                    rotate([0,0,a*-45])
                    translate([-prd/2+photoOffset+wallt/2+0.8,15.5*1.03,0])
                    rotate([0,0,67.5])
                    cube([13.5,1.8*wallt,vClr+0.1],center=true);
                }
            }
            translate([0,wallt/2+0.01,vClr/2+caset/2])
            cube([prd-photoOffset-2*wallt,wallt,vClr],center=true); // Rear Support / Light Shield
        }
        union(){
            translate([0,-prd/4-overhang/2,vClr/2])
            cube([prd+2*overhang,prd/2+overhang,caset+vClr+0.1],center=true); // make pcb into semicircle
            translate([hole1x,hole1y,vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 1
            translate([hole2x,hole2y,vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 2
            translate([hole3x,hole3y,vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 3
            translate([hole4x,hole4y,vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 4
            translate([hole5x,hole5y,vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 5
            translate([-18.4,36.9,vClr/2+caset/2+0.06])
            rotate([0,0,-15])
            cube([10,5,vClr+0.1],center=true); // relief of hole 4 around phorotransistor
            if(capBottom == true){
                translate([capx,capy,0])
                cylinder(d=capd+2*clearance,h=caset+0.1,center=true); // capacitor cutout
            }
            translate([capx,capy,caset/2])
            cylinder(d=wallt,h=caset/2+0.05,center=true); // capacitor drill guide
            if(headerBottomStraight == true){
                translate([hdrx,hdry,0])
                cube([hdrw+2*clearance,hdrd+2*clearance,caset+0.1],center=true); // Straight Header Cutout
            }
            if(headerBottomAngle == true){
                translate([hdrx,hdry-hdry/2,0])
                cube([hdrw+2*clearance,hdrd+hdry+2*clearance,caset+0.1],center=true); // Angle Header Cutout
                translate([hdrx,wallt/2,vClr/2+caset/2+0.099])
                cube([hdrw+2*clearance,wallt+0.1,vClr+0.1],center=true);
            }
            if(headerTopStraight == true || headerTopAngle == true){
                translate([hdrx,wallt/2,vClr-wallt/2+caset/2+0.099])
                cube([hdrw+2*clearance,wallt+0.1,wallt],center=true); // Relief for header sticking out opposite side of board
            }
            if(labelCutouts == true){
                translate([hdrx,hdry+3,0])
                cube([hdrw+2*clearance,3+2*clearance,caset+0.1], center=true);
            }
        }
    }
}

module CaseTop() {
    vClr = ledHeight + clearance; // Vertical Clearance
    translate([0,0,prt/2+caset/2+vClr])
    difference(){
        union(){
            translate([0,0,-caset/4])
            cylinder(d1=prd,d2=prd+overhang,h=caset/2,center=true); // semicircle plate
            translate([0,0,caset/4])
            cylinder(d=prd+overhang,h=caset/2,center=true); // semicircle plate
            translate([hole1x,hole1y,-vClr/2-caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 1
            translate([hole2x,hole2y,-vClr/2-caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 2
            translate([hole3x,hole3y,-vClr/2-caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 3
            translate([hole4x,hole4y,-vClr/2-caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 4
            translate([hole5x,hole5y,-vClr/2-caset/2])
            cylinder(d=holed+2*wallt,h=vClr,center=true); // standoff 5
            translate([-6.5,15.9,-vClr/2-caset/2])
            cube([wallt,8.9,vClr],center=true); // Center Support
            translate([6.5,15.9,-vClr/2-caset/2])
            cube([wallt,8.9,vClr],center=true); // Center Support
            translate([0,0,-vClr/2-caset/2])
            intersection(){
                difference(){
                    cylinder(d=prd,h=vClr,center=true); // Edge Support
                    cylinder(d=prd-2*wallt,h=vClr+0.1,center=true);
                    translate([17.4,36.8,-vClr/2+0.4])
                    cube([4,4.5,0.9],center=true); // cutout for resistor
                }
                for(a=[0:1:3]){
                    rotate([0,0,a*-45])
                    translate([-36.5*1.1,15.5*1.1,0])
                    rotate([0,0,67.5])
                    cube([14,4,vClr+0.1],center=true);
                }
            }
            translate([0,wallt/2+0.01,-vClr/2-caset/2])
            cube([prd-9-2*wallt,wallt,vClr],center=true); // Rear Support / Light Shield
        }
        union(){
            translate([0,-prd/4-overhang/2,-vClr/2])
            cube([prd+2*overhang,prd/2+overhang,caset+vClr+0.1],center=true); // make pcb into semicircle
            translate([hole1x,hole1y,-vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 1
            translate([hole2x,hole2y,-vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 2
            translate([hole3x,hole3y,-vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 3
            translate([hole4x,hole4y,-vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 4
            translate([hole5x,hole5y,-vClr/2])
            cylinder(d=holed,h=caset+vClr+0.1,center=true); // hole 5
            if(capTop == true){
                translate([capx,capy,0])
                cylinder(d=capd+2*clearance,h=caset+0.1,center=true); // capacitor cutout
            }
            translate([capx,capy,-caset/2])
            cylinder(d=wallt,h=caset/2+0.05,center=true); // capacitor drill guide
            translate([-12.7,wallt/2,-caset/2-vClr*3/4])
            cube([6,wallt+0.1,vClr/2+0.1],center=true); // cutout for resistor
            translate([-36,wallt/2,-caset/2-vClr*3/4])
            cube([9,wallt+0.1,vClr/2+0.1],center=true); // cutout for resistor
            if(headerTopStraight == true){
                translate([hdrx,hdry,0])
                cube([hdrw+2*clearance,hdrd+2*clearance,caset+0.1],center=true); // Straight Header Cutout
            }
            if(headerTopAngle == true){
                translate([hdrx,hdry-hdry/2,0])
                cube([hdrw+2*clearance,hdrd+hdry+2*clearance,caset+0.1],center=true); // Angle Header Cutout
                translate([hdrx,wallt/2,-vClr/2-caset/2-0.099])
                cube([hdrw+2*clearance,wallt+0.1,vClr+0.1],center=true);
            }
            if(headerBottomStraight == true || headerBottomAngle == true){
                translate([hdrx,wallt/2,-vClr+wallt/2-caset/2-0.099])
                cube([hdrw+2*clearance,wallt+0.1,wallt],center=true); // Relief for header sticking out opposite side of board
            }
            if(ledCutouts == true){ // LED Cutouts
                translate([-12.7,25.4,-vClr-caset/2])
                cylinder(d=vClr*2+caset*2,h=vClr+caset+0.1);
                translate([12.7,25.4,-vClr-caset/2])
                cylinder(d=vClr*2+caset*2,h=vClr+caset+0.1);
                translate([-12.7,5.4,-vClr-caset/2])
                cylinder(d=vClr*2+caset*2-wallt+0.6,h=vClr+caset+0.1);
            }
            if(labelCutouts == true){
                translate([hdrx,hdry+1,0]) // Cutout to see header labels
                cube([hdrw+2*clearance,1+2*clearance,caset+0.1], center=true);
            }
        }
    }
}

//NOTE: This model does not include all the components on the board
module Protractor(){
    color([0.8,0.8,0.8])
    difference(){
        union(){
            cylinder(d=prd,h=prt,center=true); // pcb
            if(capTop == true){
                translate([capx,capy,(caph+prt)/2])
                cylinder(d=capd,h=caph,center=true); // capacitor
            }
            if(capBottom == true){
                translate([capx,capy,-(caph+prt)/2])
                cylinder(d=capd,h=caph,center=true); // capacitor
            }
            if(headerTopStraight == true) {
                translate([hdrx,hdry,(hdrh+prt)/2])
                cube([hdrw,hdrd,hdrh],center=true); // straight header top
            }
            if(headerTopAngle == true){
                translate([hdrx,hdry-hdrh/2+hdrd/2,hdrd/2+prt/2+3.8])
                rotate([90,0,0])
                cube([hdrw,hdrd,hdrh],center=true); // angle header top
                translate([hdrx,hdry,(3.8+prt)/2])
                cube([hdrw,hdrd,3.8],center=true);
            }
            if(headerBottomStraight == true) {
                translate([hdrx,hdry,-(hdrh+prt)/2])
                cube([hdrw,hdrd,hdrh],center=true); // straight header bottom
            }
            if(headerBottomAngle == true){
                translate([hdrx,hdry-hdrh/2+hdrd/2,-hdrd/2-prt/2-3.8])
                rotate([90,0,0])
                cube([hdrw,hdrd,hdrh],center=true); // angle header bottom
                translate([hdrx,hdry,-(3.8+prt)/2])
                cube([hdrw,hdrd,3.8],center=true);
            }
            for(a = [0:1:3]){
                rotate([0,0,a*-45]){
                    translate([-prd/2+3.175,4.445,prt/2+2.35/2])
                    rotate([0,0,90-12.25])
                    cube([3.6,1.7,2.35],center=true); // LED
                    translate([-prd/2+12.7,26.67,prt/2+2.35/2])
                    rotate([0,0,90-33.75])
                    cube([3.6,1.7,2.35],center=true); // LED
                    translate([-prd/2+7.62,15.24,-prt/2-2.5/2])
                    rotate([0,0,67.5])
                    cube([4.0,2.75,2.5],center=true); // Phototransistor
                }
            }
            
        }
        union(){
            translate([0,-prd/4,0])
            cube([prd,prd/2,prt+0.1],center=true); // make pcb into semicircle
            translate([hole1x,hole1y,0])
            cylinder(d=holed,h=prt+0.1,center=true); // hole 1
            translate([hole2x,hole2y,0])
            cylinder(d=holed,h=prt+0.1,center=true); // hole 2
            translate([hole3x,hole3y,0])
            cylinder(d=holed,h=prt+0.1,center=true); // hole 3
            translate([hole4x,hole4y,0])
            cylinder(d=holed,h=prt+0.1,center=true); // hole 4
            translate([hole5x,hole5y,0])
            cylinder(d=holed,h=prt+0.1,center=true); // hole 5
            
        }
    }
}