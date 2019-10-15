/*
 Minimalistic nautilus shell by Tycho
 thing:1773803 Version 2

 More side is better but it will take ages to render.
 Thingyverse will crash if this value is too high.
*/

// [Details]
// number of side to make a circle
circle_fraction=12;// [6:60]
// More steps is smoother surface
stepspercircle = 19; // [2:24]
// Up to 6 should work. After this you have te replace the position of the opening.
windings = 6; // [2:10]
// This is a fraction of the size of the spheres
outer=1.75;
// Shell thickness
thickness=1.22;
/* [Hidden] */
// preview[view:"north east", tilt:"top diagonal"]

$fn=circle_fraction; 

$vpt=[-12, 0, 77 ];
$vpr=[ 40, 0.00, 92.0 ];


module snailhouse(scale=1.75, thickness=0){
    for (i = [0.5:1/stepspercircle:windings]){
        rotate(-i*360)
        translate([0,(pow(2.1,i)-2),(pow(2,i)/2)-2])
            sphere( ((pow(2,i)/scale)-thickness), center=true);

    }
}


difference(){
    snailhouse(outer);
    union(){
        snailhouse(scale=outer, thickness=thickness);
        // For an opening:
            translate([+0.5,pow(2.1,windings)-1,(pow(2,windings)*0.5)])
                sphere(d=pow(2,windings)/1, center=true);
//        // Cut in half:
//        translate([0,0,40])
//            cube([100,100,50], center=true);
    }
}