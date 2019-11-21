// preview[view:south east, tilt:top diagonal]

/* [Lozenge] */

Width = 68; // [25:200]
Length = 108;// [50:200]
Height = 6;//[4:10]
//*********Declaration of customization variables************
/* [Hidden] */

	//Parameters
	//diameter of the circle, or side of the square
meshscreen_d=Width;
//length of lozenge or rectangle dish
meshscreen_l=Length-Width;
	//width of the solid border around the mesh.
meshscreen_borderwidth=3;
	//thickness of the screen. should be a multiple of your layer height for best results.
meshscreen_h=Height/2; 
	//print layer height
layer_h=0.3;
	//meshthread width. Please keep this a multiple of the width of the thread of 
	//your printer. Use multiple shells in your slicing settings if necessary.
meshthread_w=2;
	//spacing in between mesh threads
mesh_space=5;
default_height=10;
default_border_w=1;
default_width=60;
default_length=160;

meshscreen_lozenge(
h=meshscreen_h,
border_w=meshscreen_borderwidth,
mesh_w=meshthread_w,
mesh_space=mesh_space,
width=meshscreen_d,
length=meshscreen_l,
layer_h=layer_h);
/**********************************/

module meshscreen_lozenge(h=2,border_w=meshscreen_borderwidth,mesh_w=1,mesh_space=2,width=60,length=60,layer_h=0.3){
union(){
	intersection(){
		translate([0,0,h/2])lozenge(height=h,width=width,length=length);
		mesh_raw(h=h,mesh_w=mesh_w,mesh_space=mesh_space,width=2*max(width,length),layer_height=0.3);
	}
translate([0,0,h]) 
difference(){
//union(){
lozenge(height=h*2,width=width,length=length);
lozenge(height=h*4,width=width-2*border_w,length=length);
}
}
}

module lozenge(height=default_height,width=default_width,length=default_length){
union(){
cube([width,length,height],center=true);
translate([0,length/2,-height/2])cylinder(r=width/2,height);
translate([0,-length/2,-height/2])cylinder(r=width/2,height);
}
}

/**********************************/

module meshscreen_square(h=2,border_w=meshscreen_borderwidth,mesh_w=1,mesh_space=2,width=60,layer_h=0.3){
	intersection(){
		translate([0,0,h/2])cube([width,width,h],center=true);
		mesh_raw(h=h,mesh_w=mesh_w,mesh_space=mesh_space,width=width,layer_height=0.3);
	}
	difference(){
		translate([0,0,h/2])cube([width,width,h],center=true);	translate([0,0,h/2])cube([width-border_w*2,width-border_w*2,h*1.1],center=true);
	}
}

/**********************************/

module meshscreen_circle(h=2,border_w=meshscreen_borderwidth,mesh_w=1,mesh_space=2,width=60,layer_h=0.3){
	intersection(){
		cylinder(r=width/2,h);
		mesh_raw(h=h,mesh_w=mesh_w,mesh_space=mesh_space,width=width,layer_height=0.3);
	}
	difference(){
		cylinder(r=width/2,h);
		translate([0,0,-h*0.05])cylinder(r=width/2-border_w,h=h*1.1);
	}
}
module mesh_raw(h=2,mesh_w=1,mesh_space=2,width=50,layer_h=0.3){
	for ( j = [0 :(mesh_w+mesh_space): width] )
	{
	   //	translate([0,0,0.01])translate([-width/2+j, 0, h/4])cube([mesh_w,width,h/2-layer_h/10],center=true);
		translate([0,0,0.01])translate([0, -width/2+j, h/4])cube([width,mesh_w,h/2],center=true);
	}

}