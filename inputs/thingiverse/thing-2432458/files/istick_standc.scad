// All dimension are in mm

/* [Basic settings] */
rows = 3;              // [1:1:12]
cols = 3;               // [1:1:12]

//  Enlarge all holes by this value. 1mm suggested for around 10mm diameter, more for lower diameter less for higher
ht = 0.8;               // [0.5:0.1:2]

// thin slice draft just to check for holes, stick & usb dimensions
fingerprint= 0;       // [0: Normal, 1: FingerPrint]
slice_thick = 0.2;      // Thick of the test slice

// ABS/PLA thickness at end of holes
back_thick = 0.5;    // [0.1:0.1:0.3]
holes_depth = 10;   // [5:1:25]

/* [Tray settings (mm)] */
tray_round = 5;         // [0:1:20]
tray_thick = holes_depth + back_thick;      // Tray thickness
tray_x_border = 0;        // [0:1:50]
tray_y_border = 0;        // [0:1:50]


/* [Bottles settings (mm)] */
// 10.4 AAA battery
// 21.2 10ml istick bottle
bottle_diameter = 18;    // [10:0.1:60]
bottle_round_end = 0;

//  Interval between bottles / bottles & stick
bottle_intvl = 1;             // [0:1:10]

/* [IStick Settings (mm)] */
cig_holder = 0;             // [0: No, 1: Yes]
cig_orientation = 0;        // [0: North-South, 1: East-West]

//cigarette hole length
cig_hlength = 45.1;         // [10:0.1:60]

// cigarette hole thickness
cig_thicks = 23.1;              // [10:0.1:40]

// Additionnal space around stick
cig_add_space = 0;        // [0:1:30]

/* [Usb Connector */
// usb room
cig_usb_hwidth = 12;       // [5:1:20]

// Start height of usb connector
cig_usb_starty = 6;         // [0:1:10]

//  Usb hole on the left
cig_usb_left=0;             // [0:No, 1:Yes]

// Usb hole on the right
cig_usb_right=1;           // [0:No, 1:Yes]

/* [Hidden] */
// Do not edit below values
// (Unless for fun :-D)
// --------------------------------
$fn=96;             // [32:1:128]
cig_thick = cig_thicks+ht;
cig_usb_width = cig_usb_hwidth+ht;
cig_usb_start = cig_usb_starty-ht;
bottle_d = bottle_diameter + ht;
cig_length = cig_hlength+ht;
cig_rotate = 1 * cig_holder * cig_orientation;

x1 = rows * bottle_d + (rows -1) * bottle_intvl + tray_x_border*2;
y1 = cols * bottle_d+ (cols-1) * bottle_intvl + tray_y_border*2;
y2 = y1 + (bottle_intvl + cig_thick)*cig_holder;
y3 = y2 + cig_rotate * (cig_length - cig_thick)+cig_add_space*cig_holder;

xstart = (bottle_d+bottle_intvl)*(rows-1)/2;
ystart = (bottle_d+bottle_intvl)*(cols-1)/2+tray_y_border;

cig_li = cig_length-cig_thick;
// cig_usb_x = (cig_thick/2-cig_length)/2-tray_round;
cig_usb_x = 1000;

// Clipping (should be little greater than the tray dimension
hx = 1.1*(x1+tray_round*2);
hy = 1.1*(y3+tray_round*2);

difference()
{
    base();
    holes();
    
    // slice
    if (fingerprint)
    {
        z_slice=cig_usb_start+bottle_round_end*bottle_d/2;
        z_slize = tray_thick;

        translate([-hx/2, -hy/2, -0.01])
        cube([hx, hy, z_slice-slice_thick, ], center=false);
        //translate([0,0,250+back_thick+1+z_slice]) cube([hx, hy, 500], center=true);
    }
}

module base()
{
    // Pavé support cig + flacons
    union()
    {
        difference()
        {
            translate([0, 0, tray_thick/2])
            {
                cube(size=[x1,y3,tray_thick], center=true);
                translate([0,0,tray_thick/2-tray_round])
                {
                    translate([-x1/2,0,0])
                        rotate([90,0,0]) cylinder(h=y3, r=tray_round,center=true);
                    translate([x1/2,0,0])
                        rotate([90,0,0]) cylinder(h=y3, r=tray_round,center=true);
                    translate([0, y3/2, 0])
                        rotate([0, 90, 0]) cylinder(h=x1, r=tray_round, center=true);
                    translate([0, -y3/2, 0])
                        rotate([0, 90, 0]) cylinder(h=x1, r=tray_round, center=true);
                    for(xs = [-x1/2 : x1 : x1/2])
                        for(ys = [-y3/2 : y3 : y3/2])
                            translate([xs,ys,0])
                                sphere(r=tray_round);
                }
            }
            
            // Clip
            translate([0,0, -500])
                cube([hx, hy, 1000], center = true);
        }
        
        hc = tray_thick-tray_round;
        if (hc>0)
        {
            translate([0, 0, hc/2])
                cube(size=[x1+2*tray_round,y3, hc], center=true);
            translate([0, 0, hc/2])
                cube(size=[x1,y3+2*tray_round, hc], center=true);
            for(xs = [-x1/2 : x1 : x1/2])
                for(ys = [-y3/2 : y3 : y3/2])
                    translate([xs,ys,0])
                        cylinder(h=hc, r=tray_round);
        }
    }
}

module holes()
{
    translate([0,tray_y_border,back_thick])
    union()
    {
        // Holes for bottles
        translate([0,(y3-y1)/2,0])
            for(nx = [0 : 1 : rows-1 ])
                for(nb = [0:1:cols-1])
                    translate([-xstart+nx*(bottle_d+bottle_intvl), -ystart+nb*(bottle_d+bottle_intvl), bottle_round_end*bottle_d/2])
                    {
                        cylinder(h = holes_depth+1, d=bottle_d, center=false);
                        if (bottle_round_end)
                        {
                            sphere(d=bottle_d);
                        }
                    }

        if (cig_holder)
        {
            // Hole for istick
            translate([0, (cig_thick-y2)/2, 0])
            {
                rotate([0,0,cig_rotate*90])
                {
                    translate([0,0,holes_depth/2])
                        cube(size=[cig_length-cig_thick, cig_thick, holes_depth+0.01], center=true);
                    translate([cig_li/2, 0, ])
                        cylinder(h = holes_depth+1, d=cig_thick, center=false);
                    translate([-cig_li/2, 0, ])
                        cylinder(h = holes_depth+1, d=cig_thick, center=false);
                    
                    translate([0, 0, cig_usb_start+50])
                    {
                        if (cig_usb_left)
                            translate([1000,0,0]) cube([2000, cig_usb_width, 100], center=true);
                        if (cig_usb_right)
                            translate([-1000,0,0]) cube([2000, cig_usb_width, 100], center=true);
                    }   
                }
            }
        }
    }
}

