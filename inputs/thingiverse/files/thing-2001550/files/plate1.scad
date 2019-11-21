// total height 69.21
// to top of fins: 6.7mm + 5.6
// to bottom of fins: 32mm + 5.6
// to nozzle (volcano): 58.2mm + 5.6

// set to your fan diameter and hole dimensions (relative from center of fan)

/* [Global] */
// Fan size
fan_dim = 40; // [first:30,second:40]
// Hotend type
hotend = "e3dv6"; // [first:e3dv6,second:volcano,third:magmajhead]


/* [Hidden] */

fan_hole_sep = (fan_dim == 40 ? 32 : 24);
volcano_height = 73.8;
e3dv6_height = 61.8;
magmajhead_height = 58.8;
blower_height = (hotend == "magmajhead" ? magmajhead_height : (hotend == "e3dv6" ? e3dv6_height : volcano_height));

// roundness option
$fs=0.2; 
$fa=0.1; 
// utility function, generates a cube with rounded edges on its xy.
module roundcube(dims, r = 3, center = false)
{
  hull() {
    if (center)
    {
      translate([r -dims[0]/2,r - dims[1]/2,-dims[2]/2]) cylinder(r=r, h=dims[2]);
      translate([r -dims[0]/2,(dims[1]/2)-(r),-dims[2]/2]) cylinder(r=r, h=dims[2]);
      translate([dims[0]/2-(r),(dims[1]/2)-(r),-dims[2]/2]) cylinder(r=r, h=dims[2]);
      translate([dims[0]/2-(r),r - (dims[1]/2),-dims[2]/2]) cylinder(r=r, h=dims[2]);

    } else {
      translate([r,r,0]) cylinder(r=r, h=dims[2]);
      translate([r,dims[1]-(r),0]) cylinder(r=r, h=dims[2]);
      translate([dims[0]-(r),dims[1]-(r),0]) cylinder(r=r, h=dims[2]);
      translate([dims[0]-(r),r,0]) cylinder(r=r, h=dims[2]);
    }
  }
}

// Blower cutout, including stem
// increasing blower_length will bring the blower nozzle closer to the hotend
module blower(cutout=false, height=40, blower_length=20) {
    width=(cutout ? 13 : 15); // first value is for the subtraction
    length=(cutout ? 8 : 10); // cube stem
    nozzle=(cutout ? 2 : 5); // nozzle aperture in Z 
    shift=(cutout ? 1 : 0);
    short=(cutout ? 0 : 10);
    height=(cutout ? height-20 : height);
    shift_nozzle = (cutout ? 3 : 0); // use this to change the angle the blower goes 0 is a right-angle
    translate([0,0,shift]) {
        if (cutout) {
            #translate([-5,0,(height-short)/2 - 5])roundcube([length,width,height-short], r=0.5, center=true);
        } else {
            translate([-5,0,(height-short)/2 - 5])roundcube([length,width,height-short], r=0.5, center=true);
        }
        rotate([0,90,0])
            hull() {
                translate([0,0,-1])roundcube([length,width,1], r=0.5, center=true);
                translate([(10-nozzle)/2 + shift_nozzle,0,blower_length])
                    roundcube([nozzle,width,2], r=0.5, center=true);
            }
    }
}
   
mirror([0,0,1]) { // reorient for placement
    difference() {
        translate([0,0,5.6/2])roundcube([70,30,5.6], center=true);
        #hull() {
            cylinder(d=12, h=5.6);
            translate([0,30,0])cylinder(d=12, h=5.6);
        }

        if (hotend == "magmajhead") {
            translate([0,0,-4.5])
                #hull() {
                    cylinder(d=17, h=5.6);
                    translate([0,30,0])cylinder(d=17, h=5.6);
                }
            for (i=[-34/2, 34/2])
            translate([i,0,3])
            rotate([-90,0,0])#cylinder(d=3.3, h=25.6);
        }

        for (i = [1, -1]) 
            translate([i*(55.80-35.80),0,0])
                #hull() {
                    cylinder(d=5.4, h=10);
                    translate([i*10,0,0])cylinder(d=5.4, h=10);
                }
    }
    translate([-42.5,0,-9.4])
        rotate([0,0,90])
        {
            rotate([90,0,0]) 
            {
                translate([0,(30-fan_dim)/2,0])
                difference() { // 30mm fan
                    union() {
                        hull() { 
                            roundcube([fan_dim,fan_dim,2], r=2, center=true);
                            translate([0,0,4])
                                roundcube([15,10,2], r=2, center=true);
                        }
                        for (i = [-1, 1])
                        hull() { 
                            roundcube([fan_dim,fan_dim,2], r=2, center=true);
                            translate([0,i*((fan_dim/2)-(15/2)),4])
                                roundcube([15,15,2], r=2, center=true);
                        }

                    }
                    hull () {
                        cylinder(d=fan_dim-5, h=2, center=true);
                        translate([0,0,4])
                            roundcube([12,8,2], r=0.5, center=true);
                    }
                    for (x = [-1, 1])
                        for (y = [-1, 1])
                            #translate([x*fan_hole_sep/2, y*fan_hole_sep/2,0])
                                cylinder(d=3.2, h=6, center=true);
                }
            }

        }

    translate([-18,0,0])
        translate([-10,0,-(blower_height-15.6)])
        translate([0,0,5])
        difference() {
            blower(height=blower_height);
            blower(true, height=blower_height-3.8);
            translate([0,0,(30-fan_dim)/2])
            translate([-10,0,(blower_height-30.3)]) // cutout for the fan into the blower shaft. magic number 35.3 for 40mm fan, 30.3 for 30mm
                rotate([90,0,0])
                #roundcube([14,10,12], r=2 ,center=true);
        }
}
