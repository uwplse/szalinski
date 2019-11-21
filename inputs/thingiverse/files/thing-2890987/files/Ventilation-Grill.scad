// Overall grill width 
width = 60;         // [1:1:200]

// Overall grill height
height = 60;        // [1:1:200]

// General thickness of plate
thickness = 2;      // [1:0.2:10]

// Width of the gap between vertical and each slat at it's base
opening = 5;        // [1:1:50]

// Number of slats
slats = 5;          // [1:1:20]

// Perimeter width (Min recommended >= 2*metric)
flange = 5;         // [1:1:10]

// Screw diameter (0 = no screw)
metric = 2.5;         // [0:0.5:8]

/* [Hidden] */

$fn = 36;
slat_height = (height-2*flange)/slats;

    centers = [ [ (width/2-flange+metric/2),0,flange-metric/2],
                [-(width/2-flange+metric/2),0,flange-metric/2],
                [ (width/2-flange+metric/2),0,height-flange+metric/2],
                [-(width/2-flange+metric/2),0,height-flange+metric/2]];
difference () {
    
    union () {
        translate ([-width/2,0,0]) cube ([width, thickness, height]);   // base cube
        slats_maker();                                                  // outer slats wall
    }
    slats_maker(offset=thickness);                                      // inner slats wall to substract
    translate ([-width/2,thickness,0]) cube ([width, opening*2, height*2]); //Back large cube to substract remainings
    //screw drills
    if ( metric > 0 ) {
        translate ([0,1.5*thickness,0]) for (i=centers) { translate (i) rotate ([90,0,0]) cylinder (r=metric/2+0.3, h=2*thickness);}
        for (i=centers) { translate (i) rotate ([90,0,0]) cylinder (r=metric, h=2*opening);}
    }
}

// makes 2 cones hull several times, one over another
module slats_maker (offset=0) {
    for (i=[0:slats-1]) {
        translate ([0,0,flange+slat_height*i]) {
            hull () {
                translate ([-width/2+opening+flange+offset,offset,0]) cylinder (r1=opening, r2=0, h=slat_height);
                translate ([+width/2-opening-flange-offset,offset,0]) cylinder (r1=opening, r2=0, h=slat_height);
            }          
        }
    } 
}
//makes 4 cylinders in simetric given coordinates
module pillars (px=70, py=40, pr=6, pr2="undef", ph=15) {
    rr2 = (pr2 == "undef") ? pr : pr2 ;
    centers = [[ px, py, 0],[-px, py, 0],[-px,-py, 0],[ px,-py, 0]];
    for (i=centers) { translate (i) cylinder (r1=pr, r2=rr2, h=ph); }
}
/*

VENTILATION GRILL BY DANEBAE (2018-05-03)

This work is licensed under a Creative Commons Attribution-ShareAlike 2.5 License - https://creativecommons.org/licenses/by-sa/2.5

Revision history:

V 1.0
    - Intended to be a ventilation grill for projects that need heat evacuation with outdoor enclosures
    - Glue it to your project wall instead of using screws to make the joint waterproof.

V 1.1 (2018-06-21)
    - Added corner drills for srews

*/