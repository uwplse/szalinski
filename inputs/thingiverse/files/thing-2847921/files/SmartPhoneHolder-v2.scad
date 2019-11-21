// Smartphone Stand by DrLex, 2018/04 - 2019/07
// Released under Creative Commons - Attribution license

// Thickness of your phone. Depending on the shape, you may need to add some extra margin.
thick = 12.0; //[3.0:0.1:25.0]
// How high to raise the phone from the surface. This should be high enough if you want to be able to plug in a USB cable.
lift = 40; //[10.0:0.5:60.0]
// Width of the holder.
width = 60.0; //[5:0.5:100.0]
// Length of the lip at the rear.
rearLip = 15; //[5:0.5:60]
// Enable slots in the rear (to reduce material, route cables, or just for the looks). Only if width is at least 34.
rearSlots = "yes"; //[yes,no]
// Omit the rear lip entirely to allow mounting to a wall.
wallMount = "no"; //[yes,no]
// Create a hole for a USB cable. Cannot be used if thick < 9.
usbHole = "no"; //[yes,no]
// Create a cable hole in the bottom front.
frontHole = "no"; //[yes,no]
// Create a cable hole in the bottom rear.
rearHole = "no"; //[yes,no]
// Create a gap in the front for easier cable routing (overrides frontHole and usbHole, requires thick ≥ 9). A support will be included that must be broken away after printing. Some sanding may be needed for a nice result.
frontGap = "no"; //[yes,no]

// Enable this and set width to 5 to print a quick test slice to see whether your phone fits well. (Rounded corners and holes will be omitted.)
testPiece = "no"; //[yes,no]

// Show the model in its normal use orientation without any built-in supports. On an FDM printer you probably shouldn't try to print it like this.
preview = "no"; //[yes,no]

/* [Advanced] */
// When using frontGap, leave this much of a gap between the built-in support and the actual object.
suppGap = 0.2; //[0.1:0.01:0.4]


/* [Hidden] */
// Unlike the OpenSCAD customizer, the Thingiverse customizer does not support simple checkboxes, hence this kludge.
bRearSlots = (rearSlots == "yes");
bWallMount = (wallMount == "yes");
bUsbHole   = (usbHole == "yes" || frontGap == "yes") && thick >= 8.8;
bFrontHole = (frontHole == "yes");
bRearHole  = (rearHole == "yes");
bFrontGap  = (frontGap == "yes" && thick >= 8.8);
bTestPiece = (testPiece == "yes");
bPreview   = (preview == "yes");

rear = rearLip + 14.495;
ox = thick * cos(10);
ox2 = ox + (thick * sin(10) + lift - 38.2967) * tan(10);
lift2 = lift + thick * sin(10);

rearSlot1 = lift < 30 || lift >= 53 ? lift/2 + 14 : lift/2 + 4;
rearSlot2 = lift >= 30 ? rearSlot1 + 21.5 : 0.0;
rearSlot3 = lift >= 53 ? rearSlot1 - 21.5 : 0.0;

rotation = bPreview ? [90, 0, 90] : [0, 0, 90];
shift = bPreview ? [-width/2, 0, 0] : [lift/2 + 10, 0, 0];

translate(shift) rotate(rotation) difference() {
    linear_extrude(width, convexity=10) extrusionProfile();

    if(! bTestPiece) {
        translate([rear, 0, 0]) rotate([90, 0, 0]) cornerCutter();
        translate([rear, 0, width]) rotate([-90, 0, 0]) cornerCutter();
        translate([-1.00976 - ox, 7.13165 + lift2, 0]) rotate([90, 0, 80]) cornerCutter();
        translate([-1.00976 - ox, 7.13165 + lift2, width]) rotate([-90, 0, 80]) cornerCutter();

        if(bRearSlots && width >= 34) {
            translate([13.495, rearSlot1, width/2]) rotate([0, 90, 0]) stretchCylinder(7, width - 20, 5);
            if(rearSlot2 > 0)
                translate([13.495, rearSlot2, width/2]) rotate([0, 90, 0]) stretchCylinder(7, width - 20, 5);
            if(rearSlot3 > 0)
                translate([13.495, rearSlot3, width/2]) rotate([0, 90, 0]) stretchCylinder(7, width - 20, 5);
        }

        if(bUsbHole && thick >= 8.8) {
            translate([(-0.982058 + 0.725908 - ox)/2, (lift - 0.30121 + lift2)/2, width/2]) rotate([100,90,0]) smoothCube(14.8, 9, 5);
        }

        // Extra fanciness has been added to reduce the need for supports. You still need good cooling and print at thin layers to avoid making a mess, though. Or, simply cut away the mess after printing.
        if(bFrontGap) {
            translate([-ox2, 0, width/2]) {
                difference() {
                    translate([-9, -0.49, 0]) rotate([90, 0, 0]) stretchCylinder(7.4, 30, 5);
                    translate([-28, -4, -8]) cube([25, 7, 16]);
                }
                if(bPreview) {
                    translate([-10, -2, -7.4]) rotate([0,0,-10]) cube([7.6, lift+20, 14.8]);
                    translate([0, lift-2, -7.4]) rotate([0,0,-10]) cube([thick/2, 20, 14.8]);
                }
                else {
                    translate([-10, -2, 7.4-suppGap]) rotate([0,0,-10]) cube([7.6, lift+20, suppGap]);
                    translate([0, lift-2, 7.4-suppGap]) rotate([0,0,-10]) cube([thick/2, 20, suppGap]);
                    translate([-10, -2, -7.4]) rotate([0,0,-10]) cube([7.6, lift+20, suppGap]);
                    translate([0, lift-2, -7.4]) rotate([0,0,-10]) cube([thick/2, 20, suppGap]);
                    // Do not waste material in support, thinner also makes it easier to remove
                    translate([-9.5, 0, 0]) rotate([90,0,-9.95]) translate([0, 0, -lift/2-7]) smoothCube(3, 12, lift+20);
                }
                translate([-2.5, 0, 0]) cube([2.0, 10, 14.8], center=true);
            }
        }
        else if(bFrontHole) {
            translate([-ox2, 0, width/2]) {
                translate([-9, -0.49, 0]) rotate([90, 0, 0]) stretchCylinder(7.4, 30, 5);
                translate([-10, 0, 0]) rotate([90, 0, 90]) stretchCylinder(7, 21, 17);
                translate([-3.3, 0, 0]) cube([3.6, 10, 14.8], center=true);
            }
        }

        if(bRearHole) {
            difference() {
                translate([13.495, -0.49, width/2]) rotate([90, 0, 0]) stretchCylinder(7.4, 22, 5);
                translate([13.495, 0, width/2-7.4]) cube([2.0, 10, .8], center=true);
                translate([13.495, 0, width/2+7.4]) cube([2.0, 10, .8], center=true);
            }
            translate([13.495, 0, width/2]) rotate([90, 0, 90]) stretchCylinder(7, 21, 8);
            translate([11.495, 0, width/2]) cube([2, 10, 14.8], center=true);
            translate([15.495, 0, width/2]) cube([2, 10, 14.8], center=true);
        }

//        if(bFrontHole) {
//            translate([-ox - 10, 1, width/2]) rotate([90, 0, 0]) stretchSphere(7, 30, 5);
//        }
//        
//        if(bRearHole) {
//             translate([13.495, 1, width/2]) rotate([90, 0, 0]) stretchSphere(7, 22, 5);
//        }

        if(bWallMount) {
            translate([14.495, -5, -5]) cube([rearLip+1, 12, width+10]);
        }
    }
}


module cornerCutter() {
    difference() {
        cube([10, 10, 5], center=true);
        translate([-5, 5, 0]) cylinder(r=5, h=6, $fn=24, center=true);
    }
}

module smoothCube(w, d, ht) {
    minkowski() {
        cube([w-2, d-2, ht-1], center=true);
        cylinder(r=1, h=1, $fn=20);
    }
}

module stretchCylinder(r, l, h) {
    hull() {
        translate([-l/2+r, 0, 0]) cylinder(r=r, h=h, center=true, $fn=32);
        translate([l/2-r, 0, 0]) cylinder(r=r, h=h, center=true, $fn=32);
    }
}

module stretchSphere(r, l, h) {
    hull() {
        translate([-l/2+r, 0, h/2]) sphere(r=r, center=true, $fn=32);
        translate([l/2-r, 0, h/2]) sphere(r=r, center=true, $fn=32);        
        translate([-l/2+r, 0, -h/2]) sphere(r=r, center=true, $fn=32);
        translate([l/2-r, 0, -h/2]) sphere(r=r, center=true, $fn=32);        
    }
}

// These coordinates were extracted from a prototype model created in Blender.
// In retrospect I might have used a single line instead, and add thickness to it with offset(). However, I'm not sure how easy it would be to add the various rounded corners.
module extrusionProfile() {
    polygon(points = [
        [rear, 0], // rear T-joint outer (0)
        [rear, 2],
        [16.495, 2],
        [15.877, 2.09789],
        [15.3195, 2.38197],
        [14.877, 2.82443],
        [14.5929, 3.38197],
        [14.495, 4],
        [12.495, 4], // rear T-joint inner (8)
        [12.3971, 3.38197],
        [12.1131, 2.82443],
        [11.6706, 2.38197],
        [11.1131, 2.09789],
        [10.495, 2],
        [14.495, 22.7912 + lift], // top arc outer (14)
        [14.4182, 23.5716 + lift],
        [14.1905, 24.322 + lift],
        [13.8209, 25.0135 + lift],
        [13.3234, 25.6196 + lift],
        [12.7173, 26.1171 + lift],
        [12.0258, 26.4867 + lift],
        [11.2754, 26.7144 + lift],
        [10.495, 26.7912 + lift],
        [8.758, 26.7912 + lift],
        [7.96429, 26.7155 + lift],
        [7.17439, 26.4914 + lift],
        [6.41864, 26.1273 + lift],
        [5.72611, 25.6374 + lift],
        [5.12338, 25.0405 + lift],
        [4.63365, 24.3595 + lift],
        [4.27570, 23.6205 + lift],
        [4.06332, 22.852 + lift],
        [6.08829, 22.8216 + lift], // top arc inner (32)
        [6.24633, 23.3314 + lift],
        [6.52989, 23.8064 + lift],
        [6.91965, 24.2143 + lift],
        [7.38906, 24.5273 + lift],
        [7.90612, 24.7241 + lift],
        [8.43559, 24.7912 + lift],
        [10.495, 24.7912 + lift],
        [11.0127, 24.7231 + lift],
        [11.495, 24.5233 + lift],
        [11.9092, 24.2054 + lift],
        [12.2271, 23.7912 + lift],
        [12.4269, 23.3089 + lift],
        [12.495, 22.7912 + lift],
        [0.176419, 0.811108 + lift], // cradle rear outer (46)
        [0.034995, 0.447456 + lift],
        [-0.234827, 0.165604 + lift],
        [-0.591969, 0.008461 + lift],
        [-0.982058, lift],
        [-1.32935, -1.96966 + lift], // cradle rear inner (51)
        [-0.658872, -2.01151 + lift],
        [0.0041122, -1.90311 + lift],
        [0.626352, -1.6499 + lift],
        [1.17665, -1.26458 + lift],
        [1.62741, -0.766468 + lift],
        [1.95602, -0.180542 + lift],
        [2.14601, 0.463818 + lift],
        [0.725908 - ox, -0.30121 + lift2], // cradle front (59)
        [0.362259 - ox, -0.159795 + lift2],
        [0.080406 - ox, 0.110022 + lift2],
        [-0.076738 - ox, 0.467158 + lift2],
        [-0.085251 - ox, 0.857245 + lift2],
        [0.959858 - ox, 6.78435 + lift2],
        [-1.00976 - ox, 7.13165 + lift2],
        [-0.779844 - ox, -3.08198 + lift2], // cradle T-joint inner (66)
        [-0.638426 - ox, -2.71833 + lift2],
        [-0.368612 - ox, -2.43648 + lift2],
        [-0.011475 - ox, -2.27934 + lift2],
        [0.378613 - ox, -2.27083 + lift2],
        [-7.80451 - ox2, 6.89365], // front outer (71)
        [-7.90847 - ox2, 5.81525],
        [-7.83752 - ox2, 4.7634],
        [-7.59339 - ox2, 3.764],
        [-7.1821 - ox2, 2.84167],
        [-6.61377 - ox2, 2.0191],
        [-5.90239 - ox2, 1.31657],
        [-5.06549 - ox2, 0.751364],
        [-4.12367 - ox2, 0.3374],
        [-3.10012 - ox2, 0.084871],
        [-2.02004 - ox2, 0],
        [-1.63654 - ox2, 2], // front inner (82)
        [-2.59531 - ox2, 2.09461],
        [-3.48387 - ox2, 2.37482],
        [-4.26807 - ox2, 2.82985],
        [-4.91777 - ox2, 3.44222],
        [-5.40802 - ox2, 4.18839],
        [-5.71996 - ox2, 5.03969],
        [-5.84161 - ox2, 5.96341],
        [-5.7683 - ox2, 6.92404] // (90)
    ], paths = [
        [0, 1, 2, 3, 4, 5, 6, 7, // rear T-joint outer
        14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, // top arc outer
        46, 47, 48, 49, 50, // cradle rear outer
        59, 60, 61, 62, 63, 64, 65, // cradle front
        71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, // front outer
        0], // close outer loop
        [8, 9, 10, 11, 12, 13, // rear T-joint inner
        82, 83, 84, 85, 86, 87, 88, 89, 90, // front inner
        66, 67, 68, 69, 70, // cradle T-joint inner
        51, 52, 53, 54, 55, 56, 57, 58, // cradle rear inner
        32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, // top arc inner
        8]
        ]);
}