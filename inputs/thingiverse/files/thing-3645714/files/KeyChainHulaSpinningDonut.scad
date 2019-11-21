/*
 * Key Chain Hula spinning Donut
 *
 * (C) 2019 Guido Berning
 *
 * Source code:
 *   https://github.com/sajatogu/KeyChainHulaSpinningDonut
 *
 * Project page on Thingiverse:
 *   https://www.thingiverse.com/thing:?
 *
 *
 * licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.
 * http://creativecommons.org/licenses/by-nc-sa/3.0/
 */
 
// 0 = no ball, 20 = smale ball, 25 = big ball
 BALL_ON_TOP_SPHERE_SIZE = 20;//[0, 20, 25]
 
//  37.5 = Middle (support needed), 31 = lower position (may be no support needed but difficult)
HULA_SPINNING_DONUT_POSITION = 31;//[31, 35.0, 37.5]
 
//  hole diameter 
HOLE_DIAMETER = 3.5;//[3.0, 3.5, 4.0]
 
//  second donut
SECOND_DONUT = 1;//[1, 0]
 
 difference() {
     union() { // merge core with ball on top
         // core
        rotate_extrude($fn=200) polygon( 
         points=[[0,0],[7.5/2,0],[10/2,4],[10/2,8],[22/2,13],[22/2,15],[18/2,20],[17/2,24],[15/2,26],[10/2,30],[10/2,45],[18/2,50],[2/2,75],[0,75]] );
         if(BALL_ON_TOP_SPHERE_SIZE > 0){
         // ball on top
        translate([0, 0, 70])
        sphere(d = BALL_ON_TOP_SPHERE_SIZE, $fn = 100);
         }
    }
    { // hole for key ring
        translate([0, 0, 4]) 
        rotate([0, 90, 0]) 
        cylinder(d=3, h=20, center=true, $fn = 100);
    }
}
// Hula spinning Donut ring around core (to slave them all ;-)
// donut ring in the middle (support needed)
// donut ring lower position (no support but difficult)
rotate_extrude(convexity = 110, $fn = 100)
translate([17.5/2, HULA_SPINNING_DONUT_POSITION, 0])
circle(r = 7/2, $fn = 100);
if(SECOND_DONUT){
    rotate_extrude(convexity = 110, $fn = 100)
    translate([17.5/2, HULA_SPINNING_DONUT_POSITION + 7.15, 0])
    circle(r = 7/2, $fn = 100);
}
