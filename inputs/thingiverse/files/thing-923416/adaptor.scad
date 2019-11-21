include<..\thread\Thread.scad>


module bottom(){
//bottom
thread_in_ring(14.1,10,2);				// make a ring to enclose an M8 x 10 ISO thread with thickness 2 mm
difference(){
translate([0,0,-1.5])
thread_in_pitch(14.5,12,2.1);			// make an M8 x 10 thread with 1mm pitch
    translate([-20,-20,-10])
    cube([40,40,10]);
}
    
}


module topbody(){

//interface

cylinder(h = 2, r =17/2);

//top
thread_out_centre(14.4,16);				// make a centre for an M8 x 16ISO thread
thread_out_pitch(14,16,1.5);


}

//top with cutouts
module top(){
    difference(){
        topbody();
        translate([-20,-20,10])cube([40,40,40]);
        translate([0,0,0.5])cylinder(h = 30, r = 5);
    }
}



translate([0,0,10-2])top();

bottom();
////support
*cylinder (h = 0.5, r = 5 + 0.5);
*difference(){
    cylinder (h = 8, r = 5 + 0.1);
    cylinder (h = 10, r = 5 -0.5 );

}


//nut
difference(){
    cylinder (h = 5, r = 11.5, $fn = 6);
    cylinder (h = 11, r = 9 );

}
