use <MCAD/bearing.scad>
use <nutsnbolts/cyl_head_bolt.scad>
use <nutsnbolts/materials.scad>

// preview[view:north, tilt:bottom]

// Which part do you want to see?
part = "Preview"; // [Focuser:Focuser,Adapter:Adapter,Both:Focuser and Adapter,Preview:Preview]

// This is the maximum diameter the focuser will accept with some bending, I use mine with a tapered draw tube which is 35mm wide at both ends, but only 34mm wide in the middle. Change this value to the maximum outer diameter of your draw tube. For a 2" draw tube with 1.5mm wall thickness, this should be 54mm (2*2.54mm + 2*1.5mm). 
drawTubeMaxOuterDiameter = 35; // [31:0.1:100]

/* [Bearings and Screws] */

// Type of the ball bearings
bearingType= 623; // [623,624]

// Mounting angle of the ball bearings. The lower the angle, the finer adjustments are possible with the focuser. The focus travel for one rotation depends on the angle and the draw tube outer diameter D; it is given by t=tan(angle)*π*D. For small angles, this can be approximated by t = 0.055*angle*D.
bearingAngle = 5; // [2:0.1:15]

/* [Focus Ring] */

// Height of the focuser. The higher the more stable.
outerRingHeight = 12; // [10:0.5:25]

// Width of the focuser ring
outerRingWidth = 10; // [8:0.5:25]

// how wide is the gap in the ring?
gap = 4; // [1:0.1:15]

// how thick is the screw support at the gap
gapBridge = 3; // [1:0.1:10]

/* [Telescope Adapter] */
// Height of the adapter.
adapterBaseHeight = 40; // [10:100]

// Thickness of the base plate
adapterPlateHeight = 2; // [0.5:0.1:10]

// Distance of the three holes to fix the adapter at the telescope tube. This creates holes arranged in a equilateral triangle, and determines the overall dimensions of the adapter. 
tubeHoleDistance = 66; // [20:0.1:150]

// Circumference of the telescope tube
tubeCircumference = 444; // [100:4000]

// Orientation of the screws on the telescope tube
tubeScrewOrientation = 0; // [0:360]

/* [Hidden] */

bearingScrew = "M3x20";
spannScrew = "M3x20";
brDim = bearingDimensions(bearingType);
bearingDiameter = brDim[1];
bearingInnerDiameter = brDim[0]+0.2;
bearingHeight = brDim[2];

tubeRadius = tubeCircumference/3.141592654/2.0;
tubeHoleEncircle = tubeHoleDistance * sqrt(3)/3;

ringOversize = 0.5;
outerRingInnerRadius = drawTubeMaxOuterDiameter/2+ringOversize;

correction = -360*(0.5*(bearingDiameter+0.5))/(2*3.141592654*(outerRingInnerRadius+0.5*outerRingWidth));

// rendering
$fn=100;
$fs=0.5;
$fa=0.5;

module Ring() {
    difference() {
    linear_extrude(height=outerRingHeight, center=true, convexity=10) {
        difference() {
            circle(outerRingInnerRadius+outerRingWidth);
            circle(outerRingInnerRadius);
        }
    }
    for(i=[2:3]) {
        rotate([0,0,80+360/3*i])translate([outerRingInnerRadius-ringOversize+0.5*outerRingWidth,0,outerRingHeight/2]) cylinder(r=1.5, h=2*outerRingHeight+1, center=true);
        rotate([0,0,40+360/3*i])translate([outerRingInnerRadius-ringOversize+0.5*outerRingWidth,0,outerRingHeight/2]) cylinder(r=bearingInnerDiameter/2, h=2*outerRingHeight+1, center=true);
    }
}
}
////////
module TiltAtHeight(height, offset = 0, moveToInside=ringOversize) {
    translate([outerRingInnerRadius+0.5*(bearingDiameter+offset)-moveToInside,0,0]) {      
        rotate([bearingAngle,0,0]) 
            translate([0,0,height])
                children();
    }
}
module TiltedCube(height) {
    offset = 1.5;
    TiltAtHeight(height, 0) {
        union() {
        cube([bearingDiameter+8*offset,bearingDiameter+offset,bearingHeight], center=true);
        cylinder(h=2*outerRingHeight, r=bearingInnerDiameter/2, center=true);
        }
    }
}

module ThreeCubes() {
    for(i=[0:2]) {
        
        rotate([0,0,360/3*i]) TiltedCube(outerRingHeight/2);
        rotate([0,0,360/3*i]) TiltedCube(-outerRingHeight/2);
    }
}

module Bearings() {
     for(i=[0:2]) {
        rotate([0,0,360/3*i]) {
            TiltAtHeight(outerRingHeight/2-bearingHeight/2) bearing(model=623);
            TiltAtHeight(-outerRingHeight/2-tan(bearingAngle)*bearingDiameter-bearingHeight/2) bearing(model=623);
        }
 }
}

module Screws() {
    for(i=[0:2]) {
        rotate([0,0,360/3*i]) {
            TiltAtHeight(outerRingHeight/2+bearingHeight/2) stainless() screw(bearingScrew);
            TiltAtHeight(-outerRingHeight/2-bearingHeight/2) stainless() nut(_get_famkey(bearingScrew));
        }
    }
}
module Spanneinrichtung() {
    translate([-2*outerRingInnerRadius+gapBridge/2, gap/2+gapBridge, -3]) 
        cube([outerRingInnerRadius-gapBridge,outerRingInnerRadius,6]);
    mirror([0,1,0]) 
        translate([-2*outerRingInnerRadius+gapBridge/2, gap/2+gapBridge, -3]) 
            cube([outerRingInnerRadius-gapBridge,outerRingInnerRadius,6]);
    translate([-outerRingInnerRadius-outerRingWidth/2, 0, 0]) cube([outerRingWidth+2,gap, outerRingHeight+1], center=true);
    translate([-outerRingInnerRadius-outerRingWidth/2, 0, -0.5*bearingInnerDiameter+0.5*gapBridge]) rotate([90,0,0]) cylinder(h=2*outerRingHeight, r=bearingInnerDiameter/2, center=true);
}

module SpannSchraube() {
    translate([-outerRingInnerRadius-outerRingWidth/2, -gap/2-gapBridge, -0.5*bearingInnerDiameter+0.5*gapBridge]) rotate([90,0,0]) stainless() screw(spannScrew);
translate([-outerRingInnerRadius-outerRingWidth/2, gap/2+gapBridge, -0.5*bearingInnerDiameter+0.5*gapBridge]) rotate([90,0,0]) stainless() nut(_get_famkey(spannScrew));
}
module DrawTube() {
    // assumes 1.5mm thickness of the draw tube, and a diameter equal to the maximum accepted diameter.
    stainless() difference()
    {
        cylinder(r=(drawTubeMaxOuterDiameter)/2, h=65, center=true);
        cylinder(r=(drawTubeMaxOuterDiameter-3)/2, h=66, center=true);
    }
}

module Focuser() {
union() {
difference() {
    Ring();
    ThreeCubes();
    Spanneinrichtung();
}

if(part == "Preview") {
    Screws();
    Bearings();
    SpannSchraube();
    DrawTube();
}
}
}

module TubeAdapter() {

    difference() {

        union() {
            // vertical ring which fits to the main telescope tube
            linear_extrude(height=adapterBaseHeight, convexity=5) {
                difference() {
                circle(r=tubeHoleEncircle+adapterPlateHeight/2);
                circle(r=tubeHoleEncircle-adapterPlateHeight/2);
                }
            }
            
            // base plate of the adapter
            translate([0,0,adapterBaseHeight-adapterPlateHeight])
                linear_extrude(height=adapterPlateHeight, convexity=5) {
                    difference() {
                        circle(r=tubeHoleEncircle);
                        circle(r=outerRingInnerRadius);
                    }
            }
            
            for(i=[0:2]) {
                // vertical support for adapter base plate
                rotate([0,0,60+360/3*i]) 
                translate([tubeHoleEncircle/2,0,adapterBaseHeight/2]) 
                cube([tubeHoleEncircle,3,adapterBaseHeight], center=true);
            
                rotate([0,0,120+360/3*i]) 
                translate([tubeHoleEncircle/2,0,adapterBaseHeight/2]) 
                cube([tubeHoleEncircle,3,adapterBaseHeight], center=true);
                
                // support for outer screw holes
                rotate([0,0,tubeScrewOrientation+90+360/3*i])
                translate([tubeHoleEncircle,0,adapterBaseHeight/2]) 
                cylinder(r=adapterPlateHeight+bearingInnerDiameter/2, h=adapterBaseHeight, center=true);
            }
        }
        
        // substract main telescope tube
        translate([0,0,-tubeRadius+adapterBaseHeight/2])
            rotate([0,90,0]) 
                cylinder(r=tubeRadius, h=600, center=true);
        
        for(i=[0:2]) {
            // screw holes for main tube
            rotate([0,0,tubeScrewOrientation+90+360/3*i])
            translate([tubeHoleEncircle,0,adapterBaseHeight]) 
            cylinder(r=bearingInnerDiameter/2, h=2*adapterBaseHeight, center=true);
            
            // oversized screw holes for crayford ring
            rotate([0,0,80+360/3*i])
            translate([outerRingInnerRadius+0.5*outerRingWidth,0,adapterBaseHeight]) 
            cylinder(r=bearingInnerDiameter/2+0.5, h=2*adapterBaseHeight, center=true);
            
            rotate([0,0,40+360/3*i])
            translate([outerRingInnerRadius+0.5*outerRingWidth,0,adapterBaseHeight]) 
            cylinder(r=bearingInnerDiameter/2+0.5, h=2*adapterBaseHeight, center=true);
            
            // space for bearings
            rotate([0,0,360/3*i+bearingAngle/2])
            translate([outerRingInnerRadius+bearingDiameter/2,0,adapterBaseHeight/2]) 
            cube([bearingDiameter+4,bearingDiameter+4,adapterBaseHeight+1], center=true);
        }
        
        // remove space for focuser tube
        cylinder(r=outerRingInnerRadius, h=adapterBaseHeight+1, center=false);
    }
}

rotate([0,180,0]) 
{ 
    if(part == "Adapter" || part == "Both" || part == "Preview")  TubeAdapter();
    if(part == "Focuser" || part == "Both" || part == "Preview")  translate([0,0,adapterBaseHeight+outerRingHeight/2]) Focuser();
}

