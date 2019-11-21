/*
 * Customizable Phone Stand
 * By Nelson Downs - https://www.thingiverse.com/thing:3577763
 * Remix of https://www.thingiverse.com/thing:2120591
 * updated 2019-04-21
 * created 2019-04-20
 * version v1.1
 *
 * Changelog
 * --------------
 * v1.1:
 *      - Fixed cube cutout
 * v1.0:
 *      - Final design
 * --------------
 *
 * This work is licensed under the Creative Commons - Attribution - Non-Commercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */
 
 
 // Parameter Section //
//-------------------//

// Width of the phone in mm (including the case if applicable).
Phone_width = 9; //[6:0.2:20]

// Length of the front face. Reduce this value to make the phone sit higher on the stand and provide more room for a charger cable. Increase this value to make the phone sit lower on the stand.
Front_face_length = 50; //[36:70]


/* [Hidden] */

l = Front_face_length;
w = Phone_width + 3.5;
$fn = 100;


 // Point Definitions //
//-------------------//

S1 = [7.5,0];
S2 = [5.725978,8.423497];
S3 = [38.048381,70.514256];
R1 = [S3[0]+l*sin(25),S3[1]-l*cos(25)];
S4 = [R1[0]+3.32231512,R1[1]-1.20922381];
S5 = [R1[0]+3.89751154,R1[1]+3.47245299];
R2 = [S4[0]+w*cos(25),S4[1]+w*sin(25)];
S6 = [R2[0]-2.17416257,R2[1]+2.2963051];
S7 = [R2[0]-4.40939641,R2[1]+2.35737636];
C1 = [7.5,7.5];
C2 = [77.5,2.75];
C3 = [R1[0]+2.26576947,R1[1]+1.05654565];
C4 = [R2[0]-1.26785479,R2[1]+2.71892336];
C5 = [R2[0]-1.73505635,R2[1]+6.08704193];
C6 = [28.923333,20.499992];
C7 = [37.456509,43.389112];
C8 = [R1[0]+5.34868012,R1[1]+7.45933114];
T1 = [[20.681418,49.063873],[38.028646,82.387587],[53.905802,48.338914]];
T2 = [[4.204098,5.499992],[15.61817,27.426222],[28.923333,5.499992]];


 // Draw Section //
//--------------//

//preview[view:south west, tilt:top diagonal]

rotate([90,0,-90])
difference() {
    extrude_stand();
    cut_center();
}

module draw_primitives() {
    translate(S1) square([70,5.5]);
    translate(S2) rotate(62.5) square([70,5.5]);
    translate(S3) rotate(-65) square([l,5]);
    translate(S4) rotate(25) square([w,4]);
    translate(S5) rotate(25) square([3,3]);
    translate(S6) rotate(25) square([4,3.25]);
    
    translate(C1) circle(d=15);
    translate(C2) circle(d=5.5);
    translate(C3) circle(d=5);
    translate(C4) circle(d=6);
    translate(C5) circle(d=4);
    
    polygon(T1);
    polygon(T2);
}

module draw_fillets() {
    translate(S7) rotate(25) square([2,2.5]);
    
    translate(C6) circle(d=30);
    translate(C7) circle(d=24);
    translate(C8) circle(d=6);
}

module extrude_stand() {
    linear_extrude(70, convexity=10)
    difference() {
        draw_primitives();
        draw_fillets();
    }
}

module cut_center() {
    translate([0,5.5,20]) cube([85,32,30]);
    translate(concat(S5,20)) rotate(25) translate([0,-4,0]) cube([25,10,30]);
    translate([0,37,35]) rotate([0,90,0]) cylinder(85, d=30);
}