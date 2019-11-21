include<..\thread\Thread.scad>

diam = 56.3;

difference(){
union(){
thread_in_ring(14.1,10,2);				// make a ring to enclose an M8 x 10 ISO thread with thickness 2 mm
thread_in_pitch(14.5,12,2.1);			// make an M8 x 10 thread with 1mm pitch

cylinder(h = 2,r = diam/2);
}
cylinder(h = 2.6,r = 10/2);
translate([-20,-20,9])
cube([40,40,10]);
}

//outside lip
difference(){
    cylinder(h = 8,r = diam/2);
    cylinder(h = 8+1,r = diam/2 - 1);
}