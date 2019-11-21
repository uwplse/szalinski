//
//  case for "pixie" 2 transistor 40 m band transceiver
//
//  design by Egil Kvaleberg, 8 Jun 2015
//
//  note:
//  design origin is center of pcb, underside of top cover surface

part = "bottom"; // [ demo, all, top, bottom, key, ring ]
with_battery = 1; // [ 1:true, 0:false ] 
with_key = 1; // [ 1:true, 0:false ] 

uswitch_width = 5.8; // microswitch case width
uswitch_depth = 12.8; // microswitch case depth
uswitch_height = 6.6; // microswitch case height
key_travel = 1.0; // microswitch switch travel, with some margin

/* [Hidden] */
batt = [26.0, 53.0, 17.0]; // 

pcb = [51.1, 51.1, 1.6];

pcbmntdia = 3.8; // net
pcbmntdx = 40.5 + pcbmntdia;
pcbmntdy = 40.5 + pcbmntdia;

pcb2bot = 3.0; // room from bottom pcb to bottom cover
pcb2top = 13.5; // room from top pcb to top cover

bncdia = 12.0;
bncpos = (7.5+14.6/2)-pcb[0]/2; // from lower r corner 
bncheight = 12.0/2 + 0.3; // height of centre from top PCB

jackdia = 6.0;
jack1pos = (9.4+11.5/2)-pcb[0]/2; 
jack2pos = pcb[0]/2-(9.3+11.5/2); 
jackheight = 6.6/2 + 0.15; // height of centre from top PCB

powerpos = pcb[0]/2-(10.6+8.9/2); 
powerdx = 1*9.0;
powerdz = 1*11.0;

trimpos = [pcb[0]/2-21.8, pcb[1]/2-21.0];
trimdia = 5.5;
trimhgt = 8.0;

snap_dia = 1.8; // snap lock ridge diameter
snap_len_y = pcb[1]*0.3; // snap lock length
snap_len_x = pcb[0]*0.3;

key_x = 12;
key_y = 25;
uswitch = [uswitch_width, uswitch_depth, uswitch_height];

wall = 1.2;
caser = wall;
twall = 1.2; // wall size of top 
bwall = 3.6; // wall size of bottom 

tol = 0.5;
d = 0.01;


extra_x = (with_battery ? batt[0]+wall+2*tol : 0) + (with_key ? key_x+wall+8*tol : 0); // extra space in X

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

module snap2(adia, alen) {
		translate([pcb[0]/2+tol, -(snap_len_y+alen)/2, -(pcb2top+pcb[2]+pcb2bot+bwall/2)]) rotate([-90, 0, 0]) cylinder(r=(snap_dia+adia)/2, h=snap_len_y+alen, $fs=0.3);
		//translate([-(snap_len_x+alen)/2, pcb[1]/2+tol, -(pcb2top+pcb[2]+pcb2bot+bwall/2)]) rotate([0, 90, 0]) cylinder(r=(snap_dia+adia)/2, h=snap_len_x+alen, $fs=0.3);
}

//uswitch = [5.8, 12.8, 6.6]
module uswitch_bed() { // microswitch bed 
	h = d+pcb2bot+pcb[2]+pcb2top-tol-twall;
	if (with_key) {
		translate([pcb[0]/2+tol+(with_battery ? wall+batt[0]+2*tol : 0)+wall+4*tol+key_x/2, pcb[1]/2 - uswitch[1]/2-wall, -(d+pcb2bot+pcb[2]+pcb2top)])
			difference () {
				c_cube(uswitch[0]+tol+2*wall, uswitch[1]+tol+2*wall, h); // mounting bed outer
				union () {
					c_cube(uswitch[0]-2*wall, uswitch[1]+tol+2*wall+2*d, h-uswitch[2]); // room for contacts and wires
					translate([0, 0, h-uswitch[2]-tol/4]) c_cube(uswitch[0]+tol, uswitch[1]+tol, uswitch[2]+tol); // mounting hole
				}
			}
	}
}

peglen = 3* wall; // length beyond key 
pegsiz = pcb[1]*0.1; // BUG: subst

module ring() { // lock ring
	flex = 2.0;
	difference () {
		union () {
			cylinder(h=wall, r=pegsiz/2 + wall, $fn=32);
			translate([pegsiz/2+wall*0.3, (pegsiz-flex)/2+1.5*wall, 0]) cylinder(h=wall, r=1.5*wall, $fn=16);
			translate([pegsiz/2+wall*0.3, -(pegsiz-flex)/2-1.5*wall, 0]) cylinder(h=wall, r=1.5*wall, $fn=16);
		}
		translate([0, 0, -d]) {
			cylinder(h=wall+2*d, r=pegsiz/2, $fn=32);
			translate([pegsiz/2, 0, 0]) c_cube(pegsiz, pegsiz-flex, wall+2*d);
			translate([pegsiz/2+wall*0.3, (pegsiz-flex)/2+1.5*wall, 0]) cylinder(h=wall+2*d, r=0.7*wall, $fn=16);
			translate([pegsiz/2+wall*0.3, -(pegsiz-flex)/2-1.5*wall, 0]) cylinder(h=wall+2*d, r=0.7*wall, $fn=16);
		}
	}
}

module mkey_peg(air) { // morse key mounting peg
	if (with_key) {
		translate([pcb[0]/2+tol+(with_battery ? wall+batt[0]+2*tol : 0)+wall+4*tol+key_x/2, -pcb[1]*0.4, -air-wall-peglen-tol]) {
			if (air != 0) {
				c_cube(pcb[1]*0.1+air, pcb[1]*0.1+air, air+peglen+wall+tol+d); // mounting hole
			} else {
				cylinder(r=pegsiz/2, h=air+peglen+wall+tol+d, $fn=32); // mounting hole
				c_cube(pcb[1]*0.1+air, pcb[1]*0.1+air, air+peglen-wall-tol); // mounting hole
				translate([0, 0, air+peglen]) c_cube(pcb[1]*0.1+air, pcb[1]*0.1+air, wall+tol+d); // mounting hole
			}
		}
	}
}

module mkey_support() { // morse key support (towards mounting peg) 
	if (with_key) difference () {
		translate([pcb[0]/2+tol+(with_battery ? wall+batt[0]+2*tol : 0)+wall+4*tol+key_x/2, -pcb[1]*0.4, -(d+pcb2bot+pcb[2]+pcb2top)])
				c_cube(pcb[1]*0.1+2*tol+2*wall, pcb[1]*0.1+2*tol*2*wall, d+pcb2bot+pcb[2]+pcb2top-tol-twall); // mounting hole
		mkey_peg(tol);
	}
}

module mkey(air) { // morse key
	module curve() {
		r = 25.0 / 2; // a bit more than a typical human finger
		if (air == 0) translate([0, key_y/2 + d, twall+tol+twall+sqrt(pow(r,2) - pow(key_x/2-wall,2))]) rotate([90, 0, 0]) {
			cylinder(r=r, h=d+key_y-key_x/2, $fn=80);
			translate([0, 0, d+key_y-key_x/2]) sphere(r=r, $fn=80);
		}
	}
	if (with_key) {
		translate([pcb[0]/2+tol+(with_battery ? wall+batt[0]+2*tol : 0)+wall+4*tol+key_x/2, pcb[1]/2+tol+wall - key_y/2, -twall-tol]) {
			translate([0, -(wall+tol), 0]) 
				c_cube(key_x+6*tol, key_y, twall); // base frame, covering air gap on sides
			difference() {
				union () {
					translate([0, -(wall+tol)/2, 0])	c_cube(key_x, key_y-(wall+tol), twall+tol+twall); // body
					translate([0, 0, key_travel]) c_cube(key_x+2*air, key_y+2*air, twall+tol+twall-key_travel); //top, extending to edge of case BUG: build issues
				}
				curve();
			}
			if (air != 0) c_cube(key_x+2*air, key_y+2*air, twall+tol+twall+d); // opening in front
			
		}
		if (air == 0) difference () { // arm
			translate([pcb[0]/2+tol+(with_battery ? wall+batt[0]+2*tol : 0)+wall+4*tol+key_x/2, 0, -twall-tol])c_cube(key_x*0.8, pcb[1], twall); // arm
			mkey_peg(tol); // mounting hole
		}
	}
}

module top() {
	sidewalls();

	difference() {
		union() {
			// lid
			translate([extra_x/2, 0, 0]) 
				cr_cube(pcb[0]+2*wall+2*tol+extra_x, pcb[1]+2*wall+2*tol, twall, caser);

			// PCB upper supports
			for (dx=[pcbmntdx/2, -pcbmntdx/2]) for (dy=[pcbmntdy/2, -pcbmntdy/2]) {
				// 
				translate([dx, dy, -(pcb2top-tol)]) {
					cylinder(r1=pcbmntdia/2+wall, r2=pcbmntdia/2+2.5*wall, h=pcb2top, $fn=20);
				}
			}
			// trimmer access tube 
			translate([trimpos[0], trimpos[1], -(pcb2top-trimhgt-tol)]) 
				cylinder(r=trimdia/2+tol/2+wall, r2=trimdia/2+tol/2+2*wall, h=(pcb2top-trimhgt-tol)+d, $fn=20);
			// morse key mounting peg, if applicable
			mkey_peg(0);  

		}
		union () { // subtract:
			// hole for trimmer 
			translate([trimpos[0], trimpos[1], -pcb2top]) {
				cylinder(r=trimdia/2+tol/2, h=pcb2top+twall+d, $fn=20);
			}
			translate([trimpos[0], trimpos[1], 0]) {
				cylinder(r1=trimdia/2+tol/2, r2=trimdia/2+tol/2+wall, h=twall+d, $fn=20);
			}
			// hole for key
			mkey(tol);
		}
	}

	//color("red") mkey(0);	 
}

module sidewalls() {
	difference() {
		union () { // add:
			translate([extra_x/2, 0, /*-(bwall+pcb2bot+pcb[2]+pcb2top)*/twall]) {
				rotate([180, 0, 0]) 
				cr2_cube(pcb[0]+2*wall+2*tol+extra_x, pcb[1]+2*wall+2*tol, (bwall+pcb2bot+pcb[2]+pcb2top+twall), caser, caser+wall);
			}
		}
		union() { // subtract:
			translate([extra_x, 0, 0]) snap2(tol/2, 2*tol);
			rotate([0,0,180]) snap2(tol/2, 2*tol);
			// room for bottom lid
			translate([extra_x/2, 0, -pcb2bot-pcb[2]-pcb2top-bwall-d]) cr_cube(pcb[0]+2*tol+extra_x, pcb[1]+2*tol, d+bwall+tol, caser/2); 
			// room for everything in top wall
			translate([extra_x/2, 0, -d]) cr_cube(pcb[0]+2*wall+4*tol+extra_x, pcb[1]+2*wall+4*tol, twall+2*d, caser+tol);
			// room for pcb
			translate([0, 0, -pcb2bot-pcb[2]-pcb2top]) c_cube(pcb[0]+2*tol, pcb[1]+2*tol, pcb2bot+pcb[2]+pcb2top+d); 
			// room for battery
			if (with_battery) translate([pcb[0]/2+tol+wall+batt[0]/2+tol, 0, -pcb2bot-pcb[2]-pcb2top]) c_cube(batt[0]+2*tol, pcb[1]+2*tol, pcb2bot+pcb[2]+pcb2top+d); 
			// room for key mechanism and key
			if (with_key) translate([pcb[0]/2+tol+(with_battery ? wall+batt[0]+2*tol : 0)+wall+4*tol+key_x/2, 0, -pcb2bot-pcb[2]-pcb2top]) c_cube(key_x+8*tol, pcb[1]+2*tol, pcb2bot+pcb[2]+pcb2top+d);
			mkey(tol);

			// BNC hole
			translate([bncpos, -pcb[1]/2, -pcb2top+bncheight]) rotate([90,0,0]) {
				cylinder(r=bncdia/2+tol, h=tol+2*wall, $fn=60); 
				// also cut out bottom...
				translate([0, -20.0/2, 0]) c_cube(bncdia+2*tol, 20.0, tol+2*wall);
			}
			// jack holes
			for (dx = [jack1pos, jack2pos]) translate([dx, pcb[1]/2, -pcb2top+jackheight]) rotate([-90,0,0]) {
				cylinder(r=jackdia/2+tol, h=tol+2*wall, $fn=60); 
				// also cut out bottom...
				translate([0, 20.0/2, 0]) c_cube(jackdia+2*tol, 20.0, tol+2*wall);
			}

			// hole for power plug
			translate([powerpos, -pcb[1]/2, -pcb2top+powerdz/2]) rotate([90,0,0]) c_cube(powerdx+2*tol, powerdz+2*tol, tol+2*wall);

			// holes for wires through inner wall
			for (dy= [pcb[1]/2+tol-7.0/2, -(pcb[1]/2+tol-7.0/2)]) {
				if (with_battery) translate([pcb[0]/2, dy, -pcb2top+1.5]) rotate([0, 90, 0]) cylinder(r=7.0/2, h = 2*tol+wall); 
				if (with_key) translate([pcb[0]/2+(with_battery ? batt[0]+wall+2*tol : 0), dy, -pcb2top+1.5]) rotate([0, 90, 0]) cylinder(r=7.0/2, h = 2*tol+wall);
			}
			// hole for power switch
			if (with_key && with_battery) translate([pcb[0]/2+batt[0]+2*wall+7*tol+key_x/2, -pcb[1]/2, -pcb2top+0.0]) rotate([90, 0, 0]) cylinder(r=7.0/2, h = tol+2*wall, $fn=30);
		}
	}

}

module bottom() {
	module support(dx, dy) {
		translate([dx, dy, -(d+pcb2bot+pcb[2]+pcb2top)]) {
			cylinder(r=pcbmntdia/2+wall, h=d+pcb2bot, $fn=20);
			cylinder(r=pcbmntdia/2-tol, h=d+pcb2bot+pcb[2]-tol/2, $fn=20);
		}
	}

	// bottom lid
	translate([extra_x/2, 0, -(bwall+pcb2bot+pcb[2]+pcb2top)]) {
		cr_cube(pcb[0]+extra_x, pcb[1], bwall, caser/2);
	}
	translate([extra_x, 0, 0]) snap2(0, 0);
	rotate([0,0,180]) snap2(0, 0);
	intersection () {
		translate([0, 0, -(pcb2bot+pcb[2]+pcb2top)]) {
			cr_cube(pcb[0], pcb[1], pcb2bot+pcb[2], caser/2);
		}
		union () {	
			for (dx=[pcbmntdx/2, -pcbmntdx/2]) for (dy=[pcbmntdy/2, -pcbmntdy/2]) {
				support(dx, dy);	
			}
		}
	}

	// BNC lower part, minus hole
	translate([bncpos, -pcb[1]/2, -pcb2top-pcb[2]-pcb2bot-bwall]) c_cube(bncdia, 2*(tol+wall), bwall);
	difference () {
		translate([bncpos, -pcb[1]/2-tol, -pcb2top-pcb[2]-pcb2bot-bwall+(pcb2bot+bwall+bncheight)/2]) rotate([90,0,0]) c_cube(bncdia, (pcb2bot+bwall+bncheight), 2*wall); 
		translate([bncpos, -pcb[1]/2, -pcb2top+bncheight]) rotate([90,0,0]) cylinder(r=bncdia/2+tol, h=tol+2*wall+d, $fn=60); 
	}
   // jack lower part, minus hole
	for (dx = [jack1pos, jack2pos]) {
		translate([dx, pcb[1]/2, -pcb2top-pcb[2]-pcb2bot-bwall]) c_cube(jackdia, 2*(tol+wall), bwall);
		difference () {
			translate([dx, pcb[1]/2+tol, -pcb2top-pcb[2]-pcb2bot-bwall+(pcb2bot+bwall+jackheight)/2]) rotate([-90,0,0]) c_cube(jackdia, (pcb2bot+bwall+jackheight), 2*wall); 
			translate([dx, pcb[1]/2, -pcb2top+jackheight]) rotate([-90,0,0]) cylinder(r=jackdia/2+tol, h=tol+2*wall+d, $fn=60);
		} 
	}
	// morse key support peg, replaced by lock ring 
	if (false) mkey_support();
   // microswitch bed
	uswitch_bed();
}


if (part=="demo") {
	color("red") mkey(0);
	top();
}
if (part=="top") rotate([180, 0, 0]) top();

if (part=="demo" || part=="bottom") bottom();

if (part=="demo") color("green") {
	translate([-pcb[0]/2, -pcb[1]/2, -pcb2top-pcb[2]]) cube(pcb); 
}

if (part=="key") mkey(0);
if (part=="ring") ring(0);

if (part=="all") {
	translate([-pcb[0]/2-wall-4, 0, bwall]) rotate([0, 180, 0]) top();
	translate([pcb[0]/2+wall+4, 0, pcb2top+pcb[2]+pcb2bot+wall+tol]) bottom();
}


