//
// raspberry pi original (A and B model)
//
// design by Egil Kvaleberg, 2 Aug 2015
//
// drawing of the B+ model, for referrence:
// https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/Raspberry-Pi-B-Plus-V1.2-Mechanical-Drawing.pdf
//
// notes:
// design origin is middle of PCB
//

part = "top"; // [ top, bottom, all, demo ]

have_plugrow = 1; // [ 1:true, 0:false ]
have_open_plugrow = 0; // [ 1:true, 0:false ]
have_camera = 0; // [ 1:true, 0:false ]
have_sdcard_support = 1; // [ 1:true, 0:false ]
have_leds = 0; // [ 1:true, 0:false ]
is_rev_b = 1; // [ 1:true, 0:false ]
pin_count = 2;

/* [Hidden] */
mil2mm = 0.0254;

pcb = [85.0, 56.0, 1.5]; // main board
pcb2floor = 4.0; // 3.5
pcb2roof = 29.0; // 15.7

pcbmnt2dia = 2.75; // mounting holes
pcbmnt2dx = 59.5 - pcb[0]/2; // 
pcbmnt2dy = pcb[1]/2 - 17.8;
pcbmnt3dx = 4.8 - pcb[0]/2;  // 
pcbmnt3dy = pcb[1]/2 - 43.5;
pcbmnthead = 6.2; // countersunk
pcbmntthreads = 2.2;
breakaway = 0.3; // have hidden hole for screw, 0 for no extra pegs 

cardsy = 24.0;
cardsz = 4.5;
cardsx = 32.0;
carddy = pcb[1]/2 - 30.0;

ethersy = 16.0; // ethernet contact width
ethersz = 13.5 + 0.5;
etherdy = pcb[1]/2 - 10.25;
usbsy = 13.5;
usbsz = 15.8 + 0.5;
usbdy = pcb[1]/2 - 31.0;
powerpsy = 11.0; // power plug width 
powerpsz = 4.5; // plug height
powerssy = 8.0; // power socket width 
powerssz = 3.3; // socket height
powerdz = -1.7; // for plug 
powerdy = pcb[1]/2 - 7.5;
hdmisx = 15.2; // hdmi contact width
hdmisz = 6.2;
hdmipsx = 25.0; // typical plug
hdmipsz = 12.0;
hdmidx = 40.5 - pcb[0]/2;
audior = 7.0; // audio contact radius
audiodz = 11.4 - 1.4 - 6.9/2 + 0.2; // above pcb
audiodx = 20.5 - pcb[0]/2 + 0.3;
videor = 10.0; // video contact radius
videodz = 13.3 - 1.4 - 8.1/2 + 0.2;  // above pcb
videodx = 39.0 - pcb[0]/2 - 0.2;
led1dx = 2.2 - pcb[0]/2;
led2dx = 9.2 - pcb[0]/2;
leddy = 7.1 - pcb[1]/2;
leddx = 2.0;

plugrow1 = [51.2+2.56/2 - pcb[0]/2, pcb[1]/2 - (54.8-5.12/2), 0]; // coordinates D7 pin, mid

cam_box = 34.5;

frame_w = 2.5; // width of lip for frame 
snap_dia = 1.8; // snap lock ridge diameter
snap_len = 50.0; // snap lock length
tol = 0.5; // general tolerance

wall = 1.2; // general wall thickness
thinwall = 0.4;
corner_r = wall; // casing corner radius
corner2_r = wall+tol+wall; // corners of top casing
d = 0.01;

extra_y = 0; // extra space in y

module nut(af, h) { // af is 2*r
	cylinder(r=af/2/cos(30), h=h, $fn=6);
}

module c_cube(x, y, z) {
	translate([-x/2, -y/2, 0]) cube([x, y, z]);
}

module cr_cube(x, y, z, r) {
	hull() {
		for (dx=[-1,1]) for (dy=[-1,1]) translate([dx*(x/2-r), dy*(y/2-r), 0]) cylinder(r=r, h=z, $fn=20);
	}
}

module cr2_cube(x, y, z, r1, r2) {
	hull() {
		for (dx=[-1,1]) for (dy=[-1,1]) translate([dx*(x/2-r1), dy*(y/2-r1), 0]) cylinder(r1=r1, r2=r2, h=z, $fn=20);
	}
}

module bottom() {
	module snap2(ex) {
		translate([pcb[0]/2+tol+wall+ex, -snap_len/2, wall+pcb2floor+pcb[2]-frame_w/2]) rotate([-90, 0, 0]) cylinder(r=snap_dia/2, h=snap_len, $fs=0.3);
		translate([-snap_len/2, pcb[1]/2+tol+wall, wall+pcb2floor+pcb[2]-frame_w/2]) rotate([0, 90, 0]) cylinder(r=snap_dia/2, h=snap_len, $fs=0.3);
	}
    module plugs(extra) { 
        z0 = wall+pcb2floor+pcb[2];
        // card slot
        translate([pcb[0]/2, carddy, wall+pcb2floor+pcb[2]-cardsz-extra]) 
			c_cube(cardsx, cardsy+2*extra, cardsz+2*extra);
        // power plug (at left side)
        translate([pcb[0]/2+2.1*wall, powerdy, z0+powerdz-extra]) 
			c_cube(2*wall, powerpsy+2*extra, powerpsz+2*extra+frame_w);
        // hdmi socket (near side)
        translate([hdmidx, pcb[1]/2+19.9/2-8.25/2, -extra-frame_w]) 
			c_cube(hdmipsx+2*extra, 8.25, hdmipsz+2*extra+frame_w);    
    }
    module plugs_add() { 
        z0 = wall+pcb2floor+pcb[2];
        // audio plug (far side)
        difference() /*/ color("green")*/ {
            translate([audiodx, -pcb[1]/2 - 1.4*wall, z0-snap_dia/2-tol]) 
                c_cube(audior, 1.6*wall, audiodz+snap_dia);
            translate([audiodx, -pcb[1]/2 - wall/2 + d, z0+audiodz]) 
                rotate([90, 0, 0]) cylinder(r=audior/2+tol, h=1.8*wall+2*d, $fn=20);
        }
        // video plug (far side)
        difference() {
            translate([videodx, -pcb[1]/2 - 1.4*wall, z0-snap_dia/2-tol]) 
                c_cube(videor, 1.6*wall, videodz+snap_dia);
            translate([videodx, -pcb[1]/2 - wall/2 + d, z0+videodz]) 
                rotate([90, 0, 0]) cylinder(r=videor/2+tol, h=1.8*wall+2*d, $fn=20);
        }
        // card slot
        if (have_sdcard_support) difference () {
            translate([pcb[0]/2 + cardsx/2/2, carddy, 0]) 
                c_cube(cardsx/2-2*d, cardsy+2*tol+2*wall, wall+frame_w-tol);
            plugs(tol);
        }
    }

	module add() {
		hull () for (x = [-1, 1]) for (y = [-1, 1])
			translate([x*(pcb[0]/2+tol+wall-corner_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner_r), corner_r]) {
				sphere(r = corner_r, $fs=0.3);
				cylinder(r = corner_r, h = wall+pcb2floor+pcb[2]-corner_r, $fs=0.3);
		}
		snap2(0);
        rotate([0, 0, 180]) snap2(0);
	}
	module sub() {
        module pedestal(dx, dy, hg, dia) {
            translate([dx, dy, wall]) {
				cylinder(r = dia/2+wall, h = hg, $fs=0.2);
                // pegs through pcb mount holes
                if (breakaway > 0) translate([0, 0, hg]) 
                        cylinder(r = dia/2 - tol, h = pcb[2]+d, $fs=0.2);
            }
        }
        module pedestal_hole(dx, dy, hg, dia) {
            translate([dx, dy, breakaway]) {	
				cylinder(r = dia/2, h = wall+hg-2*breakaway, $fs=0.2);
				cylinder(r = 1.0/2, h = wall+hg+pcb[2]+d, $fs=0.2); // needed to 'expose' internal structure so it dows not get removed
				cylinder(r1 = pcbmnthead/2 - breakaway, r2 = 0, h = pcbmnthead/2 - breakaway, $fs=0.2); // countersunk head
		    }
        }
		difference () {
			// pcb itself
			translate([-(pcb[0]/2+tol), -(pcb[1]/2+tol), wall])
				cube([2*tol+pcb[0], 2*tol+pcb[1], pcb2floor+pcb[2]+d]);
			// less pcb mount pedestals 
            pedestal(pcbmnt2dx, pcbmnt2dy, pcb2floor, pcbmnt2dia);
            pedestal(pcbmnt3dx, pcbmnt3dy, pcb2floor, pcbmnt2dia);
		}
		// hole for countersunk pcb mounting screws, hidden (can be broken away)
        pedestal_hole(pcbmnt2dx, pcbmnt2dy, pcb2floor, pcbmnt2dia);
        pedestal_hole(pcbmnt3dx, pcbmnt3dy, pcb2floor, pcbmnt2dia);
        plugs(tol);
	}
	difference () {
		add();
		sub();
	}
    plugs_add();
    
    //color("red") plugs(0);
}

// Z base is top of pcb
module top() {
	module snap2(ex) {
		translate([pcb[0]/2+tol+wall+ex, -snap_len/2-tol, -frame_w/2]) rotate([-90, 0, 0]) cylinder(r=snap_dia/2, h=snap_len+2*tol, $fs=0.3);
		translate([-snap_len/2-tol, pcb[1]/2+tol+wall, -frame_w/2]) rotate([0, 90, 0]) cylinder(r=snap_dia/2, h=snap_len+2*tol, $fs=0.3);
	}
    module plugs(extra) { 
        // card slot
        translate([pcb[0]/2, carddy, -cardsz-extra - 1.2]) // fudge 
			c_cube(19.9, cardsy+2*extra, cardsz+2*extra);
        // power socket (at left side)
        translate([pcb[0]/2, powerdy, -extra-frame_w]) 
			c_cube(19.9, powerssy+2*extra, powerssz+2*extra+frame_w);
        // room for power plug
        translate([pcb[0]/2+9.9/2+wall*1.4, powerdy, -extra-frame_w]) 
			c_cube(9.9, powerpsy+2*extra, powerpsz+2*extra+frame_w);
        if (is_rev_b) {
            // ether plug 
            translate([-pcb[0]/2, etherdy, -extra-frame_w]) 
                c_cube(19.9, etherdy+2*extra, ethersz+2*extra+frame_w);
        }
        // usb plug 
       translate([-pcb[0]/2, usbdy, -extra-frame_w]) 
				c_cube(19.9, usbsy+2*extra, usbsz+2*extra+frame_w);
        // hdmi socket (near side)
        translate([hdmidx, pcb[1]/2, -extra-frame_w]) 
			c_cube(hdmisx+2*extra, 19.9, hdmisz+2*extra+frame_w);
        translate([hdmidx, pcb[1]/2+19.9/2-7.8/2, -extra-frame_w]) 
			c_cube(hdmipsx+2*extra, 7.8, hdmipsz+2*extra+frame_w);
        // audio plug (far side)
        translate([audiodx, -pcb[1]/2 + 19.9/2, audiodz]) 
			rotate([90, 0, 0]) cylinder(r=audior/2+extra, h=19.9, $fn=20);
        translate([audiodx, -pcb[1]/2, -extra-frame_w]) 
			c_cube(audior+2*extra, 19.9, audiodz+2*extra+frame_w);
        // video plug (far side)
        translate([videodx, -pcb[1]/2 + 19.9/2, videodz]) 
			rotate([90, 0, 0]) cylinder(r=videor/2+extra, h=19.9, $fn=20);
        translate([videodx, -pcb[1]/2, -extra-frame_w]) 
			c_cube(videor+2*extra, 19.9, videodz+2*extra+frame_w);
        // camera opening
        if (have_camera) translate([-8.0, 0, pcb2roof - extra]) 
			c_cube(cam_box, cam_box, wall+2*extra);
    }
    module plugs_add() { 
       // usb plug 
       translate([-pcb[0]/2, usbdy, -frame_w]) 
				c_cube(11.0, usbsy+2*tol+2*wall, usbsz+tol+frame_w+wall+0.185);
    }
	module add() {
		hull () for (x = [-1, 1]) for (y = [-1, 1]) {
			translate([x*(pcb[0]/2+tol+wall-corner_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner_r), -frame_w]) 
				cylinder(r = corner_r+tol+wall, h = d, $fs=0.3); // include frame
			translate([x*(pcb[0]/2+tol+wall-corner2_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner2_r), pcb2roof+wall-corner2_r]) 
					sphere(r = corner2_r, $fs=0.3);	
		}
        plugs_add();
	}

	module sub() { 
		module plugrow_frame(xy, start, pins) {
			frmheight = 3.0;
            if (have_open_plugrow) translate([xy[0]+(start+(pins-1)/2)*2.56, xy[1], 1.0]) 
				c_cube(pins*2.56+2*tol+2*wall, 2*2.56+2*tol+2*wall, pcb2roof-1.0);
			else translate([xy[0]+(start+(pins-1)/2)*2.56, xy[1], frmheight]) 
				c_cube(pins*2.56+2*tol+2*wall, 2*2.56+2*tol+2*wall, pcb2roof-frmheight);
       }
		module plugrow_hole(xy, start, pins) {
			if (have_open_plugrow) translate([xy[0]+(start+(pins-1)/2)*2.56+9.9/2, xy[1]-9.9/2, -frame_w-d]) 
				c_cube(pins*2.56+2*tol+9.9, 2*2.56+2*tol+9.9, frame_w+pcb2roof+wall);
            else translate([xy[0]+(start+(pins-1)/2)*2.56, xy[1], 0]) 
				c_cube(pins*2.56+2*tol, 2*2.56+2*tol, pcb2roof+wall);
        }
        module led_frame(dx, leds) {
			frmheight = 1.0;
			for (n = [0:1:leds-1]) translate([dx+n*leddx, leddy, frmheight]) 
				cylinder(r=leddx/2+wall, h=pcb2roof+d-frmheight, $fn=16);
        }
        module led_hole(dx, leds) {
			for (n = [0:1:leds-1]) translate([dx+n*leddx, leddy, 0]) 
				cylinder(r=leddx/2-d, h=pcb2roof+wall+d, $fn=16);
            
        }
		// room for bottom case within frame 
		hull () for (x = [-1, 1]) for (y = [-1, 1])
			translate([x*(pcb[0]/2+tol+wall-corner_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner_r), -frame_w-d]) 
                cylinder(r = corner_r+tol, h = d+frame_w, $fs=0.3); 
		// snap lock
		snap2(0);
		rotate([0, 0, 180]) snap2(0);
		difference() { 
			// room for pcb
			translate([0, 0, -d]) cr_cube(2*tol+pcb[0], 2*tol+pcb[1], d+pcb2roof, 1.0);
			union () {
				// plug rows
				//if (have_plugrow || have_open_plugrow) 
				//	plugrow_frame(plugrow1, 0, pin_count);
                // leds
				if (have_leds) {
					led_frame(led1dx, 3);
                    led_frame(led2dx, 2);
                }
			}

		}
        // hole for usb, ether and power
        plugs(tol);
		// plug rows
		if (have_plugrow || have_open_plugrow) 
			plugrow_hole(plugrow1, 0, pin_count);
        // leds
		if (have_leds) {
			led_hole(led1dx, 3);
            led_hole(led2dx, 2);
        }
	}
	difference () {
		add();
		sub();
	}
    
    if (part == "demo") 
        color("red") plugs(0);
 
	// pcb support pegs
    /*
    translate([pcbmnt2dx, pcbmnt2dy, 0]) {
         difference () {
             cylinder(r1 = pcbmnt2dia/2 +wall, r2 = pcbmnt2dia/2 +2.5*wall, h = pcb2roof, $fs=0.2);
             translate([0, 0, -d]) cylinder(r = pcbmntthreads/2, h = pcb2roof, $fs=0.2); // hole
         }  
     }   
        
    translate([pcbmnt3dx, pcbmnt3dy, 0]) {
         difference () {
             cylinder(r1 = pcbmnt2dia/2 +wall, r2 = pcbmnt2dia/2 +2.5*wall, h = pcb2roof, $fs=0.2);
            translate([0, 0, -d]) cylinder(r = pcbmntthreads/2, h = pcb2roof, $fs=0.2); // hole
         }
    }
    */
} 


//

if (part=="demo") { bottom(); translate([0, 0, wall+pcb2floor+pcb[2]]) top(); }
if (part=="bottom" || part=="all") translate([0, -35, 0]) bottom();
if (part=="top" || part=="all") translate([-0, 35, pcb2roof+tol+wall]) rotate([180,0,0]) top();

	