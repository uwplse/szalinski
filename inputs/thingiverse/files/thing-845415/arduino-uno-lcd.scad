//
// arduino lcd keypad shield
//
// design by Egil Kvaleberg, 24 May 2015
//
// TODO:
// update with real measurements from original Uno drawings
// https://www.wayneandlayne.com/blog/2010/12/19/nice-drawings-of-the-arduino-uno-and-mega-2560/
// (incomplete) drawings of the LCD shield:
//  http://www.dfrobot.com/wiki/index.php?title=Arduino_LCD_KeyPad_Shield_%28SKU:_DFR0009%29
// display module dimensions:
//  https://www.adafruit.com/datasheets/rgblcddimensions.gif
// what about screws?
//
// notes:
// design origin is top surface of center of lcd/keypad pcbwith_battery ? batt[0]+wall+2*tol : 0
//
// extra PCB in example is 20x33.7

part = "top"; // [ top, bottom, button, buttons, all ]
with_battery = 0; // [ 1:true, 0:false ] 
extra_room = 0; //20.6; // size of extra room, if any, set to 0 otherwise

have_usb_plug = 1; // [ 1:true, 0:false ] 
have_power_plug = 1; // [ 1:true, 0:false ] 
have_power_switch = 0; // [ 1:true, 0:false ] 
have_up_key = 1; // [ 1:true, 0:false ] 
have_down_key = 1; // [ 1:true, 0:false ] 
have_left_key = 1; // [ 1:true, 0:false ] 
have_right_key = 1; // [ 1:true, 0:false ] 
have_select_key = 1; // [ 1:true, 0:false ] 
have_reset_key = 1; // [ 1:true, 0:false ] 
have_plugrow_upper = 1; // [ 1:true, 0:false ]
have_plugrow_lower = 1; // [ 1:true, 0:false ]

/* [Hidden] */
mil2mm = 0.0254;
DATUMX = 1120; // BUG: approx, in mils
DATUMY = 1050; // exact, in mils

batt = [17.0, 53.0, 26.0]; // 
pcb = [80.0, 58.0, 1.5]; // lcd/keypad shield, net (dwg is 80x58 mm)
pcb2floor = 17.0;
pcb2roof = 10.8;
lcdpcb2roof = 7.0;
pcb2lower = 12.8; // distance between main pcbs (top to top)
lcdpcbdx = 0.0;
lcdpcbdy = (14.0 - 7.5)/2 + 0.5; // 0.5 is fudge, don't ask
lcdpcb = [80.0, 36.0, 1.5]; // size (dwg is 80x36mm)
lcdframe = [71.3, 26.3, 3.8]; // net size (dwg is 71.3 x 26.3)
window = [64.0, 14.0]; // size (dwg 64.5 x 16.4, not critical)
windowdx = (4.2 - 4.6)/2;
windowdy = (19.6 - 14.0)/2 + 0.5; // 0.5 is fudge, don't ask
pcbmntdia = 3.1; // lcd mounting holes (dwg is 2.5)
pcbmntdx = 75.0/2; // distance between lcd mounting holes (dwg is 75.00)
pcbmntdy = 31.0/2; // (dwg is 31.00) 
pcbmnt2dia = 3.5; // uno mounting holes (dwg is 3.2)
pcbmnt2dx = (600-DATUMX)*mil2mm; // 
pcbmnt2dy = (2000-DATUMY)*mil2mm;
pcbmnt2adx = (550-DATUMX)*mil2mm;
pcbmnt3dx = (2600-DATUMX)*mil2mm;  // 
pcbmnt3dy = (300-DATUMY)*mil2mm;
pcbmnt3ady = (1400-DATUMY)*mil2mm;
pcbmnthead = 6.2; // countersunk
pcbmntthreads = 2.5;
breakaway = 0.3; // have hidden hole for screw, 0 for no extra pegs 

button = [-(pcb[0]/2-25.8+6.0/2), -(pcb[1]/2-3.6-6.0/2), 5.3]; // coordinates, and total height from pcb
button_dia = 4.6;
button_dy1 = 4.7;
button_dy2 = -2.0;
button_dx1 = 15.2 - 6.0;
button_dx2 = 23.2 - 6.0;
trimpot = [9.5, 4.4]; // trimpot size, no margin
trimpotdx = -(pcb[0]/2  - 3.9 - 9.5/2);
trimpotdy = pcb[1]/2 - 0.9 - 4.4/2; 
trimmer_dia = 2.8; // 2.3 with no margin
trimmer = [-(pcb[0]/2-4.8-trimmer_dia/2), pcb[1]/2-0.7-trimmer_dia/2, 0]; // coordinates of trimmer hole
lowerpcbrx = 9.5; // room at contacts, with margin 
powersy = 8.9; // power contact width, dwg is 8.9
powerdy = ((475+125)/2-DATUMY)*mil2mm;
usbsy = 12.3;
usbdy = ((1725+1275)/2-DATUMY)*mil2mm;

plugrow1 = [(1800-DATUMX)*mil2mm, (pcb[1]/2-0.5-2.56/2)]; // coordinates D7 pin
plugrow2 = [(1300-DATUMX)*mil2mm, -(pcb[1]/2-0.5-2.56/2)]; // coordinates RST pin

frame_w = 2.5; // assembly frame width
snap_dia = 1.8; // snap lock ridge diameter
snap_len = 20.0; // snap lock length
tol = 0.5; // general tolerance
swtol = 0.35; // tolerance for switch
wall = 1.2; // general wall thickness
thinwall = 0.4;
corner_r = wall; // casing corner radius
corner2_r = wall+tol+wall; // corners of top casing
d = 0.01;

echo("X datum ref:",-13.2,(600-DATUMX)*mil2mm);
echo(pcbmnt2dy-pcbmnt3ady, (2000-1400)*mil2mm); // 15.325, dwg is 15.24
echo(pcbmnt3dy+pcbmnt2dy, (300-100)*mil2mm); // 5.075, dwg is 5.08
echo(pcbmnt2dy, (1050-100)*mil2mm); // 24.125, dwg is 24.13
echo(powerdy+pcbmnt2dy, ((475+125)/2-100)*mil2mm); // 5.575 dwg is 5.08
echo("USBDY",pcbmnt2dy - usbdy, (2000-(1725+1275)/2)*mil2mm); // 13.025 dwg is 12.7
//echo(plugrow1[1]+pcbmnt2dy, (1050-100)*mil2mm); // 5.02 dwg is 5.08
echo(pcbmnt3dx-pcbmnt2dx, (2600-600)*mil2mm); // 50.2, dwg is 50.8 
echo(pcbmnt2dx-pcbmnt2adx, (600-550)*mil2mm); // 1.3, dwg is 1.27
echo("p1",plugrow1[0]-pcbmnt2dx, (1800-600)*mil2mm); // upper, 30.48 dwg is 30.08
echo(plugrow2[0]-pcbmnt2adx, (1300-550)*mil2mm); // lower, 19.18 dwg is 19.05
echo(pcbmnt2dia, 125*mil2mm); // 3.5, dwg is 3.175

extra_y = (extra_room>0 ? extra_room+wall : 0) + (with_battery ? batt[0]+wall+2*tol : 0); // extra space in y

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


switchneck = 6.0; // neck of toggle switch
switchbody = 15.0; // height of switch body, including contacts
module tswitch(extra) { // standard toggle switch
	if (have_power_switch) translate([-pcb[0]/2, -3.5, wall + pcb2floor/2 + 4.0]) rotate([90, 0, 0])  rotate([0, -90, 0]) {
		cylinder(r=switchneck/2+extra, h=9.0, $fn=30);
		cylinder(r=2.0/2, h=19.0, $fn=10);
		rotate([180, 0, 0]) c_cube(13.2+2*extra, 8.0+2*extra, 10.5+2*extra);
		for (dx = [-5.08, 0, 5.08]) rotate([180, 0, 0]) translate([dx, 0, 0]) cylinder(r=1.1, h=switchbody, $fn=16);
	}
}

module switchguard() { 
	r = 3.0;
	w = 11.5;
	len = 15.0;
	h = wall + pcb2floor/2 + 1.5;

	if (have_power_switch) translate([-pcb[0]/2-tol, -3.5, 0]) {
		rotate ([0, 0, 90]) difference () {
			union () {
				translate([0, r/2, 0]) c_cube(len, r, h);
				translate([0, w/2+wall, 0]) cr_cube(len, w+2*wall, h, r);
			}
			union () {
				translate([0, wall/2, -d]) c_cube(len, wall+2*d, h+2*d);
				translate([0, w/2+wall, -d]) cr_cube(len-2*wall, w, h+2*d, r*0.8);
			}
		}
	}
}

module bottom() {
	module snap2(ex) {
		translate([pcb[0]/2+tol+wall+ex, -snap_len/2, wall+pcb2floor+pcb[2]-frame_w/2]) rotate([-90, 0, 0]) cylinder(r=snap_dia/2, h=snap_len, $fs=0.3);
		translate([-snap_len/2, pcb[1]/2+tol+wall, wall+pcb2floor+pcb[2]-frame_w/2]) rotate([0, 90, 0]) cylinder(r=snap_dia/2, h=snap_len, $fs=0.3);
	}
    module power_usb(extra) { 
       if (have_power_plug) 
			translate([-pcb[0]/2, powerdy, wall+4.0+(pcb2floor-pcb2lower-pcb[2])-2*extra]) 
				c_cube(2*(lowerpcbrx-tol), powersy+2*extra, pcb[2]+pcb2lower+2*extra-4.0);
        if (have_usb_plug) 
			translate([-pcb[0]/2, usbdy, wall+4.0+(pcb2floor-pcb2lower-pcb[2])-2*extra]) 
				c_cube(2*(lowerpcbrx-tol), usbsy+2*extra, pcb[2]+pcb2lower+2*extra-4.0);
    }
	module add() {
		hull () for (x = [-1, 1]) for (y = [-1, 1])
			translate([x*(pcb[0]/2+tol+wall-corner_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner_r), corner_r]) {
				sphere(r = corner_r, $fs=0.3);
				cylinder(r = corner_r, h = wall+pcb2floor+pcb[2]-corner_r, $fs=0.3);
		}
		snap2(with_battery ? batt[0]+wall+2*tol : 0);
        rotate([0, 0, 180]) snap2(0);
	}
	module sub() {
        module pedestal(dx, dy, hg, dia) {
            translate([dx, dy, wall]) {
				cylinder(r = dia/2+wall, h = hg, $fs=0.2);
                // pegs through pcb mount holes
                if (breakaway > 0) translate([0, 0, hg]) 
                        cylinder(r = dia/2 - tol, h = pcb[2], $fs=0.2);
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
			// less pcb mount pedestals to lcd shield pcb]) 
            difference ( ){
                pedestal(lcdpcbdx-pcbmntdx, lcdpcbdy-pcbmntdy, pcb2floor, pcbmntdia);   
                tswitch(tol);
            }    
            pedestal(lcdpcbdx-pcbmntdx, lcdpcbdy+pcbmntdy, pcb2floor, pcbmntdia); 
            color("red") pedestal(pcbmnt2dx, pcbmnt2dy, pcb2floor-pcb2lower, pcbmnt2dia);
            pedestal(pcbmnt2adx, -pcbmnt2dy, pcb2floor-pcb2lower, pcbmnt2dia);
            pedestal(pcbmnt3dx, pcbmnt3dy, pcb2floor-pcb2lower, pcbmnt2dia);
            pedestal(pcbmnt3dx, pcbmnt3ady, pcb2floor-pcb2lower, pcbmnt2dia);
            // walls for contacts
            difference () {
                union () {
                    translate([0, wall, -tol]) power_usb(tol);
                    translate([0, -wall, -tol]) power_usb(tol);
                    translate([0, wall, -(wall+pcb2floor-pcb2lower-pcb[2]-tol)-4.0]) power_usb(tol);
                    translate([0, -wall, -(wall+pcb2floor-pcb2lower-pcb[2]-tol)-4.0]) power_usb(tol);
                }
                translate([d, 0, 0]) power_usb(tol);
            }
		}
		// hole for countersunk pcb mounting screws, hidden (can be broken away)
		//for (dx = [-pcbmntdx]) for (dy = [-pcbmntdy, pcbmntdy]) pedestal_hole(lcdpcbdx + dx, lcdpcbdy + dy, pcb2floor, pcbmntdia);
        pedestal_hole(pcbmnt2dx, pcbmnt2dy, pcb2floor-pcb2lower, pcbmnt2dia);
        pedestal_hole(pcbmnt3dx, pcbmnt3dy, pcb2floor-pcb2lower, pcbmnt2dia);
        // hole for usb and power
        power_usb(tol);
        // hole for switch
        tswitch(tol);
        // extra room
        if (extra_room > 0) translate([pcb[0]/2+tol+wall+extra_room/2, 0, wall]) {
            translate([0, pcb[1]/2 - 7.0/2, pcb2floor*.8]) rotate([0, -90, 0]) cylinder(r=7.0/2, h=extra_room); // hole in internal wall
            for (dx = [-5.0, 5.0]) translate([dx, pcb[1]/2 - 6.0/2, pcb2floor*.5]) rotate([0, -90, -90]) cylinder(r=6.0/2, h=extra_room, $fn=24); // holes in external wall
            difference () {
                c_cube(extra_room, pcb[1]+2*tol, batt[2]+2*tol);
                for (dy = [0, 20]) translate([0, dy, 0]) rotate([45, 0, 0]) {
                    for (dx = [(extra_room/2-wall/2), -(extra_room/2-wall/2)]) { 
                        translate([dx, 0, 0]) c_cube(wall, wall, 30);
                        translate([dx, pcb[2] + 2*tol + wall, 0]) c_cube(wall, wall, 30);
                    }
                }
            }
        }
        // room for battery
        if (with_battery) translate([pcb[0]/2+2*tol+wall+batt[0]/2+(extra_room>0 ? extra_room+wall : 0), 0, wall]) {
            c_cube(batt[0]+2*tol, pcb[1]+2*tol, batt[2]+2*tol);
            translate([0, pcb[1]/2 - 4.0/2, pcb2floor*.8]) rotate([0, -90, 0]) cylinder(r=4.0/2, h=batt[0]); // hole in internal wall
        }
	}
	difference () {
		add();
		sub();
	}
    switchguard();
    //power_usb(0);
    //tswitch(0);
}

module top() {
	module snap2(ex) {
		translate([pcb[0]/2+tol+wall+ex, -snap_len/2-tol, -frame_w/2]) rotate([-90, 0, 0]) cylinder(r=snap_dia/2, h=snap_len+2*tol, $fs=0.3);
		translate([-snap_len/2-tol, pcb[1]/2+tol+wall, -frame_w/2]) rotate([0, 90, 0]) cylinder(r=snap_dia/2, h=snap_len+2*tol, $fs=0.3);
	}
	module add() {
		hull () for (x = [-1, 1]) for (y = [-1, 1]) {
			translate([x*(pcb[0]/2+tol+wall-corner_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner_r), -frame_w]) 
				cylinder(r = corner_r+tol+wall, h = d, $fs=0.3); // include frame
			translate([x*(pcb[0]/2+tol+wall-corner2_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner2_r), pcb2roof+wall-corner2_r]) 
					sphere(r = corner2_r, $fs=0.3);	
		}
	}

	module sub() {
		module button_frame(dx, dy) {
          // less button frame pluss one wall
			translate(button) translate([dx, dy, wall+swtol]) 
				cylinder(r = button_dia/2 + swtol+wall, h=pcb2roof, $fn=32);
       }  
       module button_hole(dx, dy, en) {  
           translate([button[0]+dx, button[1]+dy, 0]) 
                cylinder(r = button_dia/2 + swtol, h=pcb2roof+wall+(en ? d : -breakaway), $fn=32);
       }
		module button_room(dx, dy) {
          // room required for button collar
			translate(button) translate([dx, dy, -10]) 
				cylinder(r = button_dia/2 + swtol+wall, h=10+wall+swtol, $fn=32);
       } 
		module plugrow_frame(xy, start, pins) {
			frmheight = 3.0;
			translate([xy[0]+(start+(pins-1)/2)*2.56, xy[1], wall+swtol+frmheight]) 
				c_cube(pins*2.56+2*tol+2*wall, 2.56+2*tol+2*wall, pcb2roof-frmheight);
       }
		module plugrow_hole(xy, start, pins) {
			translate([xy[0]+(start+(pins-1)/2)*2.56, xy[1], 0]) 
				c_cube(pins*2.56+2*tol, 2.56+2*tol, pcb2roof+wall);
       }
		// room for bottom case within frame 
		hull () for (x = [-1, 1]) for (y = [-1, 1])
			translate([x*(pcb[0]/2+tol+wall-corner_r) + (x>0 ? extra_y : 0), y*(pcb[1]/2+tol+wall-corner_r), -frame_w-d]) 
                cylinder(r = corner_r+tol, h = d+frame_w, $fs=0.3); 
		// snap lock
		snap2(with_battery ? batt[0]+wall+2*tol : 0);
		rotate([0, 0, 180]) snap2(0);
		difference() { 
			// room for pcb
			translate([0, 0, -d]) cr_cube(2*tol+pcb[0], 2*tol+pcb[1], d+pcb2roof, 1.0);
			union () {
				// less lcd frame 
				translate([windowdx, windowdy, pcb2roof-lcdframe[2]]) 
					c_cube(lcdframe[0]+2*wall+2*tol, lcdframe[1]+2*wall+2*tol, lcdframe[2]);
              // buttons
				 button_frame(0, button_dy1);
              button_frame(0, button_dy2);
              button_frame(button_dx2, 0); // reset
              button_frame(button_dx1, 0);
              button_frame(-button_dx2, 0);
              button_frame(-button_dx1, 0);
				// plug rows
				if (have_plugrow_upper) 
					plugrow_frame(plugrow1, 0, 7);
				if (have_plugrow_lower) {
					difference () {
						plugrow_frame(plugrow2, 0, 6);
			          button_room(button_dx2, 0); // reset
					}
					plugrow_frame(plugrow2, 6+2, 5);
				}
			}

		}
		// lcd module, adding margin within frame only
		translate([windowdx, windowdy, pcb2roof-lcdframe[2]-d]) 
			c_cube(lcdframe[0], lcdframe[1], lcdframe[2]+tol);
		// lcd window
		translate([windowdx, windowdy, 0])
			c_cube(window[0], window[1], pcb2roof+tol+wall+d);
		// trimpot body
		translate([trimpotdx, trimpotdy, pcb2roof-lcdframe[2]-d]) 
			c_cube(trimpot[0]+2.0, trimpot[1]+2.0, lcdframe[2]+tol);
		// button hole
       button_hole(0, button_dy1, have_up_key); // up
       button_hole(0, button_dy2, have_down_key); // down
       button_hole(button_dx2, 0, have_reset_key); // reset
       button_hole(button_dx1, 0, have_right_key); // right
       button_hole(-button_dx2, 0, have_select_key); // select
       button_hole(-button_dx1, 0, have_left_key); // left
		// plug rows
		if (have_plugrow_upper) 
			plugrow_hole(plugrow1, 0, 7);
		if (have_plugrow_lower) {
			plugrow_hole(plugrow2, 0, 6);
			plugrow_hole(plugrow2, 6+2, 5);
		}
		// trimmer hole for screw
		translate(trimmer) {
			cylinder(r = trimmer_dia/2 + tol, h=pcb2roof+tol+wall+d, $fn=16);
		}
       // extra room 
       if (extra_room > 0) translate([pcb[0]/2+tol+wall+extra_room/2, 0, -d]) {
            cr_cube(extra_room, pcb[1]+2*tol, pcb2roof, 1.0);
       }
       // room for battery
       if (with_battery) translate([pcb[0]/2+2*tol+wall+batt[0]/2+(extra_room>0 ? extra_room+wall : 0), 0, -d]) {
            cr_cube(batt[0]+2*tol, pcb[1]+2*tol, pcb2roof, 1.0);
       }
	}
	difference () {
		add();
		sub();
	}
   
	// pcb support pegs
	for (dx = [-pcbmntdx, pcbmntdx]) for (dy = [-pcbmntdy, pcbmntdy])
		translate([lcdpcbdx + dx, lcdpcbdy + dy, pcb2roof-lcdpcb2roof]) {
            cylinder(r = pcbmntdia/2 +wall, h = lcdpcb2roof, $fs=0.2);
            translate([0, 0, -pcb[2]]) cylinder(r = pcbmntdia/2 - tol, h = pcb[2]+d, $fs=0.2); // pegs
         }	
    difference () {
        translate([pcbmnt2dx, pcbmnt2dy, 0]) {
            cylinder(r = pcbmnt2dia/2 +wall, h = pcb2roof, $fs=0.2);
            translate([0, 0, -pcb[2]]) cylinder(r = pcbmnt2dia/2 - tol, h = pcb[2]+d, $fs=0.2); // pegs
            translate([0, (pcb[1]/2-pcbmnt2dy)/2 + wall, 0]) c_cube(wall, pcb[1]/2-pcbmnt2dy, pcb2roof); // support
         }  
         // lcd/keypad pcb plus margin of 2.0 
         translate([lcdpcbdx, lcdpcbdy, -d]) 
			c_cube(lcdpcb[0], lcdpcb[1] + 2*tol, d + 2.0 + pcb2roof-lcdpcb2roof); 
     }   
        
    translate([pcbmnt3dx, pcbmnt3dy, 0]) {
        cylinder(r = pcbmnt2dia/2 +wall, h = pcb2roof, $fs=0.2);
        translate([0, 0, -pcb[2]]) cylinder(r = pcbmnt2dia/2 - tol, h = pcb[2]+d, $fs=0.2); // pegs
        translate([(pcb[0]/2-pcbmnt3dx)/2+wall, 0, 0]) c_cube(pcb[0]/2-pcbmnt3dx, wall, pcb2roof); // support
    }
} 

module button() {
    hh = 0.7 + pcb2roof+wall-button[2];
    cylinder(r=button_dia/2 + wall*0.5, h=wall, $fs=0.3); // collar is wall*0.5
    cylinder(r=button_dia/2, h=hh, $fs=0.3);
    translate([0, 0, hh-button_dia*sin(60)]) intersection () {
        sphere(r=button_dia, $fs=0.1);
        cylinder(r=button_dia/2, h=10, $fs=0.1);
    }
}

module buttonbar(x0, y0, x1, y1) {
    translate([x0-wall/2, y0-wall/2, 0]) cube([wall+x1-x0, wall+y1-y0, wall]);   
}

//
// comment out the various pieces here
//

if (part == "button") button();

bardist = 9.0;
if (part == "buttons") { // with bar that connects

	buttonbar(-button_dx2, bardist, button_dx2, bardist);  
    if (have_select_key) translate([-button_dx2, 0, 0]) {
		buttonbar(0, 0, 0, bardist);
		button();
	}
    if (have_left_key) translate([-button_dx1, 0, 0]) {
		buttonbar(0, 0, 0, bardist);
		 button();
	}
    if (have_up_key) translate([0, button_dy1, 0])  {
		buttonbar(-button_dx1/2, 0, -button_dx1/2, bardist-button_dy1);
		buttonbar(-button_dx1/2, 0, 0, 0);
		button();
	}
    if (have_down_key) translate([0, button_dy2, 0]) {
		buttonbar(button_dx1/2, 0, button_dx1/2, bardist-button_dy2);
		buttonbar(0, 0, button_dx1/2, 0);
		button();
	}
    if (have_right_key) translate([button_dx1, 0, 0])  {
		buttonbar(0, 0, 0, bardist);
		button();
	}
    if (have_reset_key) translate([button_dx2, 0, 0])  {
		buttonbar(0, 0, 0, bardist);
		button();
	}
}
if (part=="bottom" || part=="all") translate([0, -35, 0]) bottom();
if (part=="top" || part=="all") translate([-0, 35, pcb2roof+tol+wall]) rotate([180,0,0]) top();

	