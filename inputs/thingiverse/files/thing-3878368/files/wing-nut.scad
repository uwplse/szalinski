
/*
My other designs can be found here.....
https://www.thingiverse.com/Ken_Applications/designs
If you find any of them helpfull please leave me a like :)

Ken applications .... OpenSCAD version used 2019.05 
*/

/* [The parameters are here] */

//The outside diameter of the thread.
dia=6.0;//[0:0.1:20]

// The pitch of the thread.. 
pitch=1;//[0.5:0.1:5]

// Thread length 
thread_length=9;//[5:1:50]

// Wing length 
wing_length=14;//[6:1:50]

// Wing thickness
wing_thk=3;//[1:1:10]

// Boss thickness factor .. minimum value 2
boss_thk=2.2;//[2:0.1:4]



module half_wing(){
wing_nut_angle=45;
rotate([90,0,0]){
translate([0,0,-wing_thk/2]){
linear_extrude(height=wing_thk){
round2d(OR=thread_length/2-0.5,IR=dia/2){
square([dia/2,thread_length]);
translate([dia/2+1,0,0]) rotate([0,0,wing_nut_angle]) square([wing_length,thread_length]);
}
}
}
}
}

module wing_nut(){
    $fn=100;
difference(){
union(){
mirror([90,0,0])half_wing(); 
half_wing();
cylinder(h=thread_length, d1=dia*boss_thk, d2=dia*(boss_thk/2*1.6), center=false);
}
translate([0,0,thread_length-.01]) cylinder(h=16, d1=dia, d2=dia*2.6, center=false);
}

}



//////""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}


complete_thing();//combines all the modules


module thread(){
//echo(pitch*0.614/2);
$fn=34;    
tolerance=0.4;    
dia_plus=dia+tolerance;    
depth_ratio=(pitch*0.614/2);
linear_extrude(twist=-360*(thread_length/pitch),height=thread_length*1.5)
translate([depth_ratio,0,0])
circle(d=dia_plus-pitch/2);
cylinder(  thread_length, d1=dia_plus-pitch,  d2=dia_plus-pitch ,$fn=100 );
}



module complete_thing(){
difference(){
wing_nut();  
thread();
//below chamfer bottom of thread
translate([0,0,-2]) cylinder(  4, d1=dia/0.7,  d2=dia*.7 ,$fn=100 );
}
}



/*
Standard coarse pitch
M3  	0.5	
M3.5    0.6	
M4	    0.7	
M5	    0.8	
M6	    1	
M7	    1	
M8	    1.25	
M9	    1.25	
M10	    1.5	
M11	    1.5	
M12	    1.75	
M14	    2	
M16	    2	
M18	    2.5	
M20	    2.5	
M22	    2.5	
M24	    3	
M27	    3	
M30	    3.5	
*/





