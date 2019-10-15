//Customizable tilt LCD mount
//by Khairulmizam Samsudin, Sept 2016
//xource@gmail.com
//"customizable_tilt_lcd_mount" is licenced under Creative Commons :
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//http://creativecommons.org/licenses/by-nc-sa/4.0/

//UPDATES:
//2/9/16 - Added option to disable screw and nut hole
//1/9/16 - Released

/* [Options] */
// preview[view:south, tilt:top]
// Sheet plate thickness
Sheet_thickness=6; // [3:10]
// Mount plate thickness
Mount_thickness=5; // [5:10]
// LCD tilt angle
Tilt_angle=45; // [0:90]
// Add screw and nut hole
Screw_nut=1; // [0:No,1:Yes]

/* [Hidden] */

thick=Mount_thickness;
angle=Tilt_angle;
snO=Screw_nut;
//config
epsilon=0.1;
$fn=40;
//lcd mount plate
pcbT=1.8;
pcbW=56;
screwR=3/2;
screwOffset=1;
nutT=3;
acrylicT=Sheet_thickness;
//sd card slot
sdL=5;
sdW=35;

//calculated
screwY=pcbW/2-screwR-screwOffset;
arcW=pcbW-5*2;
arcH=pcbW*1.1;
p1R=radius_of_arc(arcW,arcH);
p1T=thick;

translate([p1R*1.5,0,0]) mount();
translate([-p1R*1.5,0,0]) mount(sd=1);

module mount(sd=0) {
    difference() {
        rotate([0,0,-angle]) difference() {
            cylinder(r=p1R,h=thick,center=true);
            //front cutout
            translate([-p1R/2-(arcH-p1R)+12+epsilon,0,0])  cube([p1R,arcW,p1T+epsilon],center=true);
            translate([-p1R/2-(arcH-p1R)+5+epsilon,0,0])  cube([p1R,p1R*2,p1T+epsilon],center=true);
            //cutout for pcb, screw and nut
            translate([-arcH+p1R+12,0,0])  psn();
        
            //sd card
            if (sd) {
                translate([sdL/2+pcbT/2+p1R-arcH+12,sdW/2-pcbW/2+5,0]) cube([sdL+epsilon,sdW,thick+epsilon],center=true);
            }
        }
        //slit
        translate ([acrylicT/2,-p1R,0]) cube([acrylicT,p1R*2,thick+epsilon],center=true);
        }
}
//lcd pcb
module psn() {
        cube([pcbT,pcbW,p1T*2],center=true);
        if (snO) {
            translate([6,screwY,0]) rotate([0,-90,0]) sn(); 
            translate([6,-screwY,0]) rotate([0,-90,0]) sn();
        }
}

//screw and nut
module sn() {
    translate([0,0,5]) cylinder(r=screwR,h=30,center=true);
    translate([0,0,-nutT]) cube([thick*2,5.4,nutT],center=true);
}
//radius of an arc
function radius_of_arc (w,h) =h/2+(pow(w,2)/(8*h));
