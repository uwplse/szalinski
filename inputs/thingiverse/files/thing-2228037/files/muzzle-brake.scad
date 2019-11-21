/* [Body] */

// length of main body
length = 66;

// diameter of main body
dia = 18;

// bore size in mm
bore = 6;

// indention depth at the tip of muzzle
indentionDepth = 2;

/* [Holes] */

// number of rows of holes
brakeRows = 7;

// diameter of holes
brakeDia = 4;

// spacing between rows
brakeSpacing = 2;

// how far from tip to start holes
brakeStart = 6;

/* [Attachment] */

// chose to enable threads or use a smooth slide
threaded = "no"; // [yes,no]

// [threaded] the diameter of the threaded hole
threadDia = 15;

// [threaded] thread pitch (mm per revolution)
threadPitch = 1;

// [threaded] length of threaded shaft
threadLength = 20;

// [non-threaded] slide diameter at the base (closest to gun)
slideDiaBase = 14.4;

// [non-threaded] slide diameter at the barrel end
slideDiaStop = 14.1;

// [non-threaded] gap to allow for front sights
slideGap = 7.9;

// [non-threaded] distance to the sight gap behind the end of barrel
slideGapStart = 4;

// [non-threaded] slide length
slideLength = 20;

/* [hidden] */
fudge = 0.001;

include <threads.scad>;

difference() {
    $fn=100;
    // main cylinder
    cylinder(d=dia, h=length);
    
    // rifle bore
    translate([0, 0, -fudge])
    cylinder(d=bore, h=length+2*fudge);
    
    // tip indention
    translate([0, 0, length-indentionDepth])
    cylinder(d1=bore, d2=dia-2, h=indentionDepth+fudge);
    
    for (n =[0:brakeRows-1]) {
        echo(n);
        
        translate([0, 0, length-brakeStart-n*(brakeDia+brakeSpacing)]) {
            rotate([90, 0, 0+(n%2*30)])
            cylinder(d=brakeDia, h=dia, center=true);
            
            rotate([90, 0, 60+(n%2*30)])
            cylinder(d=brakeDia, h=dia, center=true);
            
            rotate([90, 0, 120+(n%2*30)])
            cylinder(d=brakeDia, h=dia, center=true);
        }
    }
    
    if (threaded == "yes") {
        translate([0, 0, -fudge])
        metric_thread(diameter=threadDia, pitch=threadPitch, length=threadLength, internal=true);
    } else {
        translate([0, 0, -fudge])
        cylinder(d1=slideDiaBase, d2=slideDiaStop, h=slideLength);
        
        translate([-slideGap/2, -dia, -fudge])
        cube([slideGap, dia, slideLength-slideGapStart]);
    }
}