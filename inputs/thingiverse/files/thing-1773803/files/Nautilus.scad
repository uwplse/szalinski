// Minimalistic nautilus shell by Tycho
// thing:1773803
// To render, best use command line or be very patient. This SCAD is simple but hard to render.

// Thingiverse will crash if this value is too high.
$fn=12; // [8:42]
// More steps is smoother surface
stepspercircle = 19; // [2:24]
// Up to 6 should work. After this you have te replace the position of the opening.
windings = 3; // [2:6] 
// This is a factor of the size of the spheres
outer=2.5; 
inner=3; 
// preview[view:"north east", tilt:"top diagonal"]

module snailhouse(scale=1.75){
    for (i = [0.5:1/stepspercircle:windings]){
        rotate(i*360)
        translate([0,(pow(2,i)-1.2)])
            sphere((pow(2,i)/scale));
        
    }
}

difference(){
    snailhouse(outer);
    union(){
        snailhouse(inner);
        // For an opening:
            translate([-1,pow(2,windings)-1.2])
                cylinder(d=pow(2,windings)/1.5, h=pow(2,windings), center=true);
//        // Cut in half:
//        translate([0,0,25])
//            cube([200,200,50], center=true);
    }
}