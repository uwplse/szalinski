//
//  case for M12864 Transistor Tester 
//
//  design by Egil Kvaleberg, May 2016
//
//  the bottom needs four M3x15 (10..??) countersunk screws for assembly
//  the four holes in the top should be treaded using an M3 tap
//
//  origo is top of lower left corner of PCB
//

part = "demo"; // [ demo, top, bot, knob, int ]

// general wall thickness
wall = 1.5;

// general tolerance
tol = 0.5;

// fine tune for perfect friction fit of knob
knob_inner_dia = 5.6; 

/* [Hidden] */
d = 0.01;
i2m = 25.4;
pi = 3.1415926;

batt = [54.0, 26.0, 17.0]; // 9 V battery with contact

slant = 4.5; // section at top of case 

pcb_x = 2.48*i2m; // net, probably 2.5
pcb_y = 2.97*i2m; // net, probably 3.0 
pcb_z = 0.065*i2m;
pcb_below = 4.0;

mnt_dia = 3.25;
mnt_x1 = 0.075*i2m + mnt_dia/2; // symmetrical
mnt_y1 = pcb_y - 0.078*i2m - mnt_dia/2;
mnt_y2 = 0.43*i2m + mnt_dia/2; 
mnt_dx = 2.08*i2m + mnt_dia; // control
mnt_dy = 2.205*i2m;
mnts_thr = 2.5; // thread
mnt_head = 7.2; // screw head

lcdpcb_x = 2.02*i2m; // 20 pins symmtrical, pin 1 @right
lcdpcb_y = 1.76*i2m;
lcdpcb_z = 0.060*i2m;
lcd_spacer = 0.400*i2m;
lcdwin_x = 1.80*i2m; // max
lcdwin_y = 0.92*i2m;
lcdwin_z = 0.175*i2m;
lcdpcb_y0 = pcb_y-(0.31-0.055)*i2m-lcdpcb_y + 1.2; // lower side of y lcdpcb
lcdwin_dy = 0.45*i2m; // from lower left corner, x is symmetrical
lcdmnt_x = 10.3; // symmetrical
lcdmnt_y = 24.8;
lcdmnt_d = 5.3;

zif_x = 1.305*i2m;
zif_y = 0.585*i2m;
zif_z = 0.46*i2m;
zif_x0 = 0.85*i2m + zif_x/2; // lower left corner
zif_y0 = 0.25*i2m + zif_y/2;
zif_r = 1.5; // corner radius
zif_r2 = 3*zif_r;

sw_x0 = (0.315+0.440/2)*i2m; // centre
sw_y0 = (0.285+0.122/2)*i2m;
sw_dia = 0.272*i2m; // threads
sw_z0 = 8.5; // bot of threads
sw_z1 = 13.6; // top of threads
sw_z2 = 26.3; // end of shank
sw_knurl_d = 6.0; // external dia
sw_knurl_n = 16;
sw_knurl_z = 8.0;

knob_height = 7.8;
knob_knurls = 18;

led_dia = 3.0;
led_dia2 = 4.0; // with rim
led_x0 = (0.576-0.085/2)*i2m; // BUG: same as sw_x0
led_y0 = 0.790*i2m;

// frequency measurement contact
frq_y = pcb_y - 2.0;
frq_x1 = pcb_x - 15.1;
frq_x2 = pcb_x - 9.8;
frq_d = 3.0;
frq_d2 = 1.7;

batt = [54.0, 26.0, 17.0]; // 9 V battery with contact

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

module lever(part,extra,rot) {
    d1 = 1.6;
    d2 = 4.65;
    l1 = 13.5; // entire
    l2 = 4.0; // knob
    translate([zif_x0+zif_x/2 - 2.0, zif_y0+zif_y/2 - d1/2, zif_z/2]) rotate([0,rot,0]) rotate([-3,0,0]) {
        if (part==1 || part==1+2) cylinder(d = d1+2*extra, h = l1, $fn=12); 
        if (part==2 || part==1+2)
            hull () for (dz = [0,l2]) translate([0,0, l1-dz]) sphere(d = d2+2*extra, $fn=12);
        // slot for finger:
        if (part==4) translate([0,0, 11.0]) cylinder(r1=0, r2=16.0, h=10.0, $fn=24);
    }
}

module lever_travel(extra) {
    // room for zif handle in all directions
    dr = 10.0; // step
    render (4) for (r0 = [0:dr:90-dr]) {
        for (part = [1,2,4]) 
            hull () for (r = [r0,r0+dr]) lever(part, extra, r);
    }
}
    
module internals(t)
{
    difference () {
        translate([0,0,-pcb_z]) cube([pcb_x, pcb_y, pcb_z]);
        for (dx = [mnt_x1, pcb_x-mnt_x1]) for (dy = [mnt_y1, mnt_y2]) {
            translate([dx,dy,-pcb_z-d]) cylinder(d=mnt_dia, h=pcb_z+2*d, $fn=20); 
         for (dx = [frq_x1, frq_x2]) translate([dx, frq_y, -pcb_z-d]) cylinder(d=1.0, h=pcb_z+2*d, $fn=8);    
        }    
    }    
        
    translate([(pcb_x-lcdpcb_x)/2-t,lcdpcb_y0-t,(t==0 ? lcd_spacer : 0)]) 
        cube([lcdpcb_x+2*t, lcdpcb_y+t*t, lcdpcb_z+(t==0 ? 0 : lcd_spacer+t)]);
    translate([(pcb_x-lcdpcb_x)/2,lcdpcb_y0+4.0,lcd_spacer+lcdpcb_z]) 
        cube([lcdpcb_x, 36.0, lcdwin_z]);
    for (dx = [lcdmnt_x,pcb_x-lcdmnt_x]) translate([dx,lcdmnt_y,0]) 
        cylinder(d=lcdmnt_d+2*t, h=lcd_spacer+lcdpcb_z+2.7+t, $fn=6);
    
    translate([zif_x0,zif_y0,-t]) 
        cr_cube(zif_x+2*t, zif_y+2*t, zif_z+2*t, zif_r); 
    lever(1+2,0,0);
    
    translate([led_x0,led_y0,0]) 
        cylinder(d=led_dia+2*t, h=20.0, $fn=20);
    
    translate([sw_x0,sw_y0,0]) {
        cylinder(d=sw_dia, h=sw_z1, $fn=40);
        cylinder(d=4.6, h=sw_z2, $fn=40);
        translate([0,0,sw_z2-sw_knurl_z]) cylinder(d=sw_knurl_d, h=sw_knurl_z, $fn=40);
        // switch body
        translate([-12.5/2,-12.5/2,0]) cube([12.5,12.5,7.0]);
        // add room for power wire 
        if (t>0) rotate([0,0,40]) translate([-12.5/2,-12.5/2,0]) cube([8.5,12.5,7.0+4.0]);
    }
    translate([59.2,26.5,0]) 
        cylinder(d=5.0+2*t, h=7.0+t, $fn=12);
    
    translate([(pcb_x-batt[0])/2,pcb_y+tol,tol-pcb_z-pcb_below]) 
        cube([batt[0],batt[1],batt[2]]);
}

module top_r()
{
    difference () {
        union () { // add:
            // top and side walls:
            translate([pcb_x/2,(pcb_y+batt[1]+tol)/2,-pcb_z-pcb_below-wall]) {
                difference () {
                    // case rough outline:
                    c_cube(pcb_x+2*tol+2*wall+2*d, pcb_y+2*tol+2*wall+tol+batt[1]+2*d, wall+pcb_below+pcb_z+lcd_spacer+lcdpcb_z+lcdwin_z+tol+wall+0.5*d);
                    // case internals:
                    translate ([0,0,-d]) hull () {
                        c_cube(pcb_x+2*tol, pcb_y+2*tol+tol+batt[1], d+wall+pcb_below+pcb_z+lcd_spacer+lcdpcb_z+lcdwin_z+tol-(slant+0.4*wall));
                        c_cube(pcb_x+2*tol-2*(slant+0.4*wall), pcb_y+2*tol+tol+batt[1]-2*(slant+0.4*wall), d+wall+pcb_below+pcb_z+lcd_spacer+lcdpcb_z+lcdwin_z+tol);
                    }
                }
            }
            // pcb mounts:
            for (dx = [mnt_x1, pcb_x-mnt_x1]) for (dy = [mnt_y1, mnt_y2]) {
                translate([dx,dy,tol]) {
                    cylinder(d=mnt_dia+2*tol+2*wall, h=lcd_spacer+lcdpcb_z+lcdwin_z+tol, $fn=20);    
                }
            }
            // mount support walls:
            for (dx = [0, pcb_x]) for (dy = [mnt_y1, mnt_y2]) {
                translate([dx,dy,tol]) {
                    c_cube(2*tol+2*wall, wall, lcd_spacer+lcdpcb_z+lcdwin_z+tol);    
                }
            }
            // support for led:
            translate([led_x0,led_y0,tol]) {
                cylinder(d=led_dia2+2*tol+2*wall, h=lcd_spacer+lcdpcb_z+lcdwin_z+tol-tol, $fn=20); 
            } 
            // support for switch:
            translate([sw_x0,sw_y0,sw_z0]) {
                cylinder(d=sw_dia+2*tol+2*wall, h=lcd_spacer+lcdpcb_z+lcdwin_z+tol-sw_z0, $fn=40); 
            }
            // frame for zif:
            translate([zif_x0,zif_y0,tol]) {
                cr_cube(zif_x+2*tol+2*wall, zif_y+2*tol+2*wall, lcd_spacer+lcdpcb_z+lcdwin_z+d, zif_r);
                translate([0,0,zif_z])
                    cr2_cube(zif_x+2*tol+2*wall, zif_y+2*tol+2*wall, lcd_spacer+lcdpcb_z+lcdwin_z+d-zif_z, zif_r, zif_r2);
                // pins 1-1-1-2-3-3-3
            }
            // frame for zif handle:
            intersection () {
                lever_travel(tol+wall);
                cube([pcb_x+tol+wall, pcb_y, lcd_spacer+lcdpcb_z+lcdwin_z+tol+wall]); 
            }
            // dividing wall towards battery    
            translate([pcb_x+tol+wall/2-(batt[0]-5.0),pcb_y-wall,tol]) 
                cube([batt[0]-5.0,wall,-tol+lcd_spacer+lcdpcb_z+lcdwin_z+tol+d]);
            // frq contact
            for (dx = [frq_x1, frq_x2]) translate([dx, frq_y, tol]) cylinder(d=frq_d+2*tol+2*wall, h=lcd_spacer+lcdpcb_z+lcdwin_z+tol-tol, $fn=12); 
        }
        union () { // sub:
            // mounts:
            for (dx = [mnt_x1, pcb_x-mnt_x1]) for (dy = [mnt_y1, mnt_y2]) {
                translate([dx,dy,0]) cylinder(d=mnts_thr, h=lcd_spacer+lcdpcb_z+lcdwin_z-wall-2.0, $fn=12);    
            }
            // lcd window
            translate([(pcb_x-lcdwin_x)/2,lcdpcb_y0+lcdwin_dy,0]) {
                cube([lcdwin_x, lcdwin_y, lcd_spacer+lcdpcb_z+lcdwin_z+tol+wall+d]);
                // add frame?
            }
            // led
            translate([led_x0,led_y0,0]) {
                cylinder(d=led_dia+2*tol, h=20.0, $fn=20);
                 cylinder(d=led_dia2+2*tol, h=lcd_spacer+lcdpcb_z+lcdwin_z+tol, $fn=20); // frame
            }
            // switch
            translate([sw_x0,sw_y0,0]) {
                cylinder(d=sw_knurl_d+2*tol, h=20.0, $fn=40); 
                cylinder(d=sw_dia+2*tol, h=lcd_spacer+lcdpcb_z+lcdwin_z+tol-sw_z0, $fn=40); // frame
                c_cube(9.0+2*tol, 9.0+2*tol, sw_z0-d); 
            }
            // zif socket
            translate([zif_x0,zif_y0,0]) {
                translate([0,0,zif_z]) 
                    cr2_cube(zif_x+2*tol, zif_y+2*tol, lcd_spacer+lcdpcb_z+lcdwin_z+tol+wall+d-zif_z, zif_r, zif_r2); // recess
                // BUG: frame
                
            }
            // room for zif handle in all directions
            lever_travel(tol);
            // frq contact
            for (dx = [frq_x1, frq_x2]) translate([dx, frq_y, 0]) {
                cylinder(d=frq_d2, h=20.0, $fn=12); 
                cylinder(d=frq_d+2*tol, h=lcd_spacer+lcdpcb_z+lcdwin_z+tol, $fn=12);  
            }
            // pin numbering 
            translate([20.2, 26.7, lcd_spacer+lcdpcb_z+lcdwin_z+tol+0.5*wall]) 
            linear_extrude(height=wall) text(text="1112333", size=7.0, font="Helvetica"); 
            
            // internals in general
            internals(tol); 

        }    
    }  

}   

module top() {
    intersection () {
        // rough exterior
        top_r();
        // case real exterior
        translate([pcb_x/2,(pcb_y+batt[1]+tol)/2,-pcb_z-pcb_below-wall])hull() { 
            cr_cube(pcb_x+2*tol+2*wall, pcb_y+2*tol+2*wall+tol+batt[1], wall+pcb_below+pcb_z+lcd_spacer+lcdpcb_z+lcdwin_z+tol+wall-slant, wall);
            cr_cube(pcb_x+2*tol+2*wall-2*slant, pcb_y+2*tol+2*wall+tol+batt[1]-2*slant, wall+pcb_below+pcb_z+lcd_spacer+lcdpcb_z+lcdwin_z+tol+wall, wall);
        }
    }
}

module bot()
{
    difference () {
        union () { // add:
            // bottom wall:
            translate([pcb_x/2,(pcb_y+tol+batt[1])/2,-pcb_z-pcb_below-wall]) {
                c_cube(pcb_x, pcb_y+tol+batt[1], wall);
            }

            // pcb mounts:
            for (dx = [mnt_x1, pcb_x-mnt_x1]) for (dy = [mnt_y1, mnt_y2]) {
                translate([dx,dy,-pcb_z-pcb_below]) {
                    cylinder(d=mnt_dia+2*tol+2*wall, h=pcb_below-tol, $fn=20);    
                }
            }
            // strengthening bars around circumference:
            for (dx = [0, pcb_x-wall]) translate([dx,0,-pcb_z-pcb_below]) 
                cube([wall,pcb_y+tol+batt[1],wall]);
            translate([0,0,-pcb_z-pcb_below]) 
                cube([pcb_x,wall,wall]);            
            // strengthening bars under battery:
            for (dx = [0, pcb_x-wall]) translate([dx,mnt_y1,-pcb_z-pcb_below]) 
                cube([wall,pcb_y+tol+batt[1]-mnt_y1,pcb_below-tol]);
            translate([0,pcb_y+tol+batt[1]-wall,-pcb_z-pcb_below]) 
                cube([pcb_x,wall,pcb_below-tol]);
        }
        union () { // sub:
            // mounts:
            for (dx = [mnt_x1, pcb_x-mnt_x1]) for (dy = [mnt_y1, mnt_y2])
                translate([dx,dy,-pcb_z-pcb_below-wall-d]) {
                cylinder(d=mnt_dia+2*tol, h=d+wall+pcb_below, $fn=20);  
                cylinder(d1=mnt_head, d2=0, h=mnt_head/2, $fn=20);   
            }
        }    
    }    
}        

module knob_int()
{
	w = pi * knob_inner_dia / knob_knurls;
	cylinder(r=knob_inner_dia/2, h=knob_height, $fn=knob_knurls);
	for (a = [0:360/knob_knurls:360-d]) {
		rotate([0, 0, a])
			translate([knob_inner_dia/2, 0, 0]) 
				cylinder(r=w/2, h=knob_height);
	}
}

module knob()
{   rx=wall+(knob_inner_dia+0.8)/2;
	difference () {
		union () {
			cylinder(r=rx, h=knob_height, $fn=12);
            translate([0, 0, knob_height-d]) cylinder(r1=rx, r2=rx-wall, h=wall+d, $fn=12);
		}
		union () {
			translate([0, 0, -d]) knob_int();
		}
	}
}

if (part == "demo" || part == "int") color("green") internals(0);  
if (part == "demo") top();
if (part == "top") rotate([180,0,0]) top();
if (part == "demo" || part == "bot") bot();
if (part == "knob") rotate([180,0,0]) knob();
if (part == "demo") translate([sw_x0,sw_y0,sw_z2-knob_height]) knob();