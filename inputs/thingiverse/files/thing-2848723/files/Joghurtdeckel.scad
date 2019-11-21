/* This file is free software and comes with NO WARRANTY -
 * --- GPL-v2 --- read the file
 * COPYING for details  
 * 04/2018 T. Kanese crated this little piece of software 

/* TODO: 
   * make the border more robust so that it does not tear off.
   * Customize for different sizes.
*/

/* [Main Dimensions] */

// Outer Diameter (mm)
dia=96;  // [40:120]



/* [Hidden] */
idia=dia-5;
$fn=64;
// Tolerance (smallest value) (mm)
eps=0.1;         // [0.1:0.3]

difference() {
  rotate_extrude() polygon( 
    points=[[0,0],[dia/2,0],[dia/2,4],[dia/2-3,4],[dia/2-1,2],[dia/2-1,1],
            [idia/2,1],[idia/2,0.5],[0,0.5]] );
  translate([dia,0,1]) cylinder(r=60,h=4);
  translate([-dia,0,1]) cylinder(r=60,h=4);    
}