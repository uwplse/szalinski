
//******* change this to fit to your bottle ***********
// Pitch of the bottle thread in mm
thread_pitch = 4; 
// Outer diameter of bottle thread in mm
outer_d = 28.25;

//**************************************************

num = floor(outer_d/thread_pitch)+2;// number of teeth drawn.
pos = num*thread_pitch/2; //displacement of center of cylinder

delta = 0.05; //adjust for "zero walls"

difference() {
union(){    
translate([0,-num*thread_pitch+delta,-1])cube([num*thread_pitch,num*thread_pitch,2]);
for (i=[0:num-1])
translate([i*thread_pitch,0,0])linear_extrude(height = 2, center = true, convexity = 10,  slices = 20,  $fn = 16)
 polygon(points=[[0,0],[thread_pitch,0],[thread_pitch*2/3,thread_pitch*2/3],[thread_pitch*1/3,thread_pitch*2/3]]);
}
//cylinder 
 translate([pos,-pos,-1.5]) cylinder(d=outer_d,h=3,$fn=90);
}