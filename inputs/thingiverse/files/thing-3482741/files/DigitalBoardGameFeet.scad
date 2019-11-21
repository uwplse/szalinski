// Digital Board Game Feet
// Autor: Carsten Hutsch

/*****************************/
/* Settings                  */
/*****************************/
material = 2;       // Material width
wHeight = 100;      // Wood height (MEASURE)
wWidth = 18;        // Wood width  (MEASURE)
mount = 18;         // The length of the mount
foot = 20;          // The height of the foot
edgeRadius = 6.3;   // Outer edge. If your wood has no one, set to zero.
tol = 0.1;          // Tollerance. It will be left as extra space for easy fitment

gDepth = 5;         // The depth of the cut for the glass
gHeight = 5;        // The height/thickness of your glass
gGap = 5;           // The distance between the top of your wood and the top of your glass

monHeight = 25;     // The height of the cut for your monitor

// Settings for screwhole
// d1=3,5    d2=7	k=2,1
screwD1 = 3.7;    // for 3.5 screw 
screwD2 = 7.5;    // for 3.5 screw 
screwK = 2.28;

// Resolution
$fn = 128;

/*****************************/
/* Stupid code               */
/*****************************/
width = wWidth + 2 * material;
length = mount + width;
height = wHeight + 2 * material + foot;
edge = edgeRadius + material; // tool + material!!!

Feet();

module Feet() {
    difference() {
        translate([0,0,0]) {
            Pfosten();
            Mount();
            translate([0,2*width+mount,0])
            rotate([0,0,-90])
                Mount();
        }
        
        // Cutout for glass and monitor
        tmp = material+wWidth-tol-gDepth;
        translate([tmp,tmp,material+wHeight-gHeight-gGap])
        cube([wWidth+mount*2,wWidth+mount*2,gHeight+tol*2]);
        
        tmp2 = material+wWidth-tol;
        translate([tmp2,tmp2,material+wHeight-gHeight-gGap-monHeight])
        cube([wWidth+mount*2,wWidth+mount*2,monHeight+tol]);
    }
}

module ScrewHole() {
    pos1 = width-material*2;
    pos2 = width-screwK/2+0.4;
    pos3 = width+mount/2;
    
    translate([pos3,pos1,0])
        rotate([-90,0,0])
            cylinder(d=screwD1,h=material*3,center=true);
    translate([pos3,pos2,0])
        rotate([-90,0,0])
            cylinder(d1=screwD1,d2=screwD2,h=screwK,center=true);
}

module Mount() {
    difference() {
        translate([0,0,0]) {
            // II. Mount
            // We will create a body and cut all other from that
            difference() {
                translate([width,0,0])
                    cube([mount,width,wHeight+2*material]);
                
                translate([width-mount/2,-edge,wHeight+2*material-edge])
                    cube([mount*2,edge*2,edge*2]);
            }
            top = height-edge-foot;
            translate([width,edge,top])
            rotate([0,90,0])
                cylinder(r=edge,h=mount);
        }
        
        // From now on cut!
        delta = material-tol;
        translate([width-mount/2,delta,delta])
            cube([mount*2,wWidth+2*tol,wHeight+2*tol-edge+material]);
        
        translate([width-mount/2,edge,material+tol+wHeight-2*edge])
            cube([mount*2,wWidth+tol-edge+material,edge*2]);
        
        top = height-edge-foot;
        translate([width-mount/2,edge,top])
            rotate([0,90,0])
                cylinder(r=edge+tol-material,h=mount*2);
        
        // Screw holes
        translate([0,0,10])
            ScrewHole();
        
        translate([0,0,material+wHeight-gHeight-gGap-monHeight-8])
            ScrewHole();
    }
}

module Pfosten() {
    // I. The main pole
    difference() {
        // Pole with edge
        translate([0,0,-foot])
            cube([width, width, height - edge]);
        
        translate([-edge,-edge,-foot-edge/2])
            cube([edge*2, edge*2, height]);
    }
    // Edge pole
    translate([edge,edge,-foot])
        cylinder(r=edge,h=height-edge);
    
    // Edge top
    top = height-edge-foot;
    translate([edge,edge,top])
        sphere(r=edge);
    
    translate([edge,edge,top])
    rotate([0,90,0])
        cylinder(r=edge,h=width-edge);
    
    translate([edge,edge,top])
    rotate([-90,0,0])
        cylinder(r=edge,h=width-edge);
    
    // Fill top
    translate([edge,edge,top])
        cube([width-edge,width-edge,edge]);
}