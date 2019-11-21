include <../models/lib/box/box_waterproof.scad>;
include <../models/lib/display/display.scad>;
include <../models/lib/pcb/pcb_mount.scad>;

parts = ["case", "cover_display"];

name="CRAFTBOX MK2";

$fn = 20;

boxSizeX=110;
boxSizeY=50;
boxInnerHeight=25;
boxBottomTopThickness=1.5;
boxScrewCornerRadius=6;
boxScrewDiameter=3.2;
boxWallThickness=3;
barrierThickness=1.2;
barrierHeight=2;
barrierTolerance=0.2;
screwnoseNumber=0;
screwnoseDiameter=4;
screwnoseHeight=5;
screwnoseWallThickness=2.8;
boxClearance=0.2;

module rpi_holder() {
    // RPI holder
    pcb_mount_height=15;
    translate([26,-56.5,3]) pcb_mount(height1=5, radius2=1.3);
    translate([26,-56.5,3]) translate([58,0,0]) pcb_mount(height1=5, radius2=1.3);
    translate([84,-34,3]) pcb_mount(height1=5, radius2=0);
    translate([26,-34,3]) pcb_mount(height1=5, radius2=0);
}


module hole_helper() {
    CubePoints = [
      [  0,  0,  0 ],  //0
      [ 10,  0,  0 ],  //1
      [ 10,  5,  0 ],  //2
      [  0,  5,  0 ],  //3
      [  5,  5,  5 ],  //4
      [ 5,  0,  5 ],  //5
      [ 5,  5,  5 ],  //6
      [  5,  5,  5 ]]; //7
      
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left

    polyhedron( CubePoints, CubeFaces );
}

module case() {
    difference() {
        waterproofBoxCase(
            boxSizeX=boxSizeX,
            boxSizeY=boxSizeY,
            boxInnerHeight=boxInnerHeight,
            boxBottomTopThickness=2.5,
            boxScrewCornerRadius=6,
            boxScrewDiameter=3.1,
            boxWallThickness=3,
            barrierThickness=1.2,
            barrierHeight=2,
            barrierTolerance=0.2,
            screwnoseNumber=0,
            screwnoseDiameter=4,
            screwnoseHeight=5,
            screwnoseWallThickness=2.8,
            boxClearance = 0.1,
            screwHoles = false
        );
   
        // cable holes
        translate([boxSizeX-28,10,0.2]) cylinder(r=5,h=5);
        translate([boxSizeX-19,boxSizeY-0.5,10]) rotate([90,0,0]) cylinder(r=5,h=5);
        
        // connector holes
        // POWER
        translate([22.50,boxSizeY/2+20,7]) cube([8+0.1,6+0.1,2.6+0.1]);
        translate([30.6,boxSizeY/2+20,13.4])        
        rotate([-90,0,0]) rotate([0,0,90]) scale([0.9,1.62,1]) hole_helper();
        translate([20.5,boxSizeY/2+24,5.5]) cube([12,10,6]);

        // USB
        translate([35,boxSizeY/2+20,7]) cube([8+0.1,6+0.1,2.6+0.1]);
        translate([43.1,boxSizeY/2+20,13.4])        
        rotate([-90,0,0]) rotate([0,0,90]) scale([0.9,1.62,1]) hole_helper();
        translate([33,boxSizeY/2+24,5.5]) cube([12,10,6]);

        // HDMI
        translate([62.5,boxSizeY/2+20,7]) cube([11.3+0.1,7.5+0.1,3.1+0.1]);
        translate([73.85,boxSizeY/2+21,13.6])        
        rotate([-90,0,0]) rotate([0,0,90]) scale([0.9,2.275,1]) hole_helper();
        translate([60,boxSizeY/2+24,5.5]) cube([16,12,7]);
    }

    // rpi holder
    translate([-7,boxSizeY+27,-2.5]) rpi_holder();

    // logo
    translate([boxSizeX-15,20,2.5]) scale([0.4,0.4,0.3]) rotate([0,0,180]) import("../assets/craftama-logo.stl");

}

for (part = parts) {

    if (part == "case") {
        case();
    };

    if (part == "cover_display") {
        difference() {
            waterproofBoxLid(
                boxSizeX=boxSizeX,
                boxSizeY=boxSizeY,
                boxInnerHeight=40,
                boxBottomTopThickness=1.5,
                boxScrewCornerRadius=6,
                boxScrewDiameter=3.1,
                boxWallThickness=3,
                barrierThickness=1.2,
                barrierHeight=2,
                barrierTolerance=0.2,
                screwnoseNumber=4,
                screwnoseDiameter=4,
                screwnoseHeight=5,
                screwnoseWallThickness=2.8,
                boxClearance = 0.1,
                screwHoles = false
            );
            translate([35,25,2.9])
                rotate([180,0,0])
                    scale([1,1,2.4])
                        oled_display(holes=false);
            translate([80,25,0])
                cylinder(r=5, h=4);
        }
    }
}
