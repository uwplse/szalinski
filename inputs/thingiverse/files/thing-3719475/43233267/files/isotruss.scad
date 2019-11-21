/*
This is a tool for creating planar and cylindrical models of isotruss structures.

It is licensed under creative commons+attribution license
To fulfill  the attribution requirement, please provide a link back to:
	https://theheadlesssourceman.wordpress.com/2019/06/28/isotruss/
	
In addition, isoTruss is the property of IsoTruss industries.  For any kind of official use,
they should be contacted! 
	IsoTruss industries
	1394 N Freedom Blvd 
	Provo, Utah 84604
	Info@IsoTruss.com
	1.385.325.2009
*/

/* [main] */

// Decide what kind of isotruss you want
create=0; // [0:cylindrical_isotruss,1:isotruss_panel,2:single_pyramid]

// resolution 1=low(aka 1x) 2=mid 3=high
resfactor=2;

// diameter of the isotruss members
member_dia=1.5;

// diameter of the supports
support_dia=2.5;

// always 4... but, you know...
num_pyramid_sides=4;


/* [cylinder settings] */

// for cylindrical isotruss
cylindrical_inner_dia=24;

// for cylindrical isotruss
cylindrical_outer_dia=35;

cylinder_length=80;

// traditionally, either 6 or 8
num_cylinder_sides=6;


/* [panel settings] */

panel_x=60;

panel_y=69;

panel_z=15;

panel_pyramid_dia=15;

/* [pyramid only settings] */

pyramid_dia=15;

pyramid_h=10;


/* [hidden] */

// make $fn more automatic
function myfn(r)=max(3*r*resfactor,12);
module cyl(r=undef,h=undef,r1=undef,r2=undef){cylinder(r=r,h=h,r1=r1,r2=r2,$fn=myfn(r!=undef?r:max(r1,r2)));}
module circ(r=undef){circle(r=r,$fn=myfn(r));}
module ball(r=undef){sphere(r=r,$fn=myfn(r));}
module rotExt(r=undef){rotate_extrude(r,$fn=myfn(r)) children();}

function angle_of_polygon_sides(num_sides)=180/num_sides;
function inner_diameter(outer_dia,num_sides)=outer_dia*cos(angle_of_polygon_sides(num_sides)); // aka inradius
function outer_diameter(inner_dia,num_sides)=inner_dia/cos(angle_of_polygon_sides(num_sides)); // aka circumradius
function inner_dia_by_side_length(side_length,num_sides)=side_length/(2*tan(angle_of_polygon_sides(num_sides)));
function side_len_by_inner_dia(inner_dia,num_sides)=inner_dia*tan(angle_of_polygon_sides(num_sides));


// create a pyramid that fits within a given conic volume
module pyramid(member_dia,base_dia,h=undef,nLegs=4){
	h=h==undef?base_dia:h;
	r=base_dia/2;
	mr=member_dia/2;
	leg_len=sqrt(pow(h,2)+pow(base_dia/2,2));
	angle=asin(r/(leg_len-member_dia));
	union() {
		for(a=[0:360/nLegs:359.99]) hull() {
			rotate([0,0,a]) translate([base_dia/2,0,member_dia/2]) ball(r=member_dia/2);
			translate([0,0,h]) ball(r=member_dia/2);
		}
	}
}


// create an isoTruss panel of a given size
// (resulting location is compatible with the cube() function)
//
// Official example image:
//    http://jur.byu.edu/wp-content/uploads/2013/09/a54-300x188.png
module isoTrussPanel(size,member_dia,support_dia=2,pyramid_dia=undef,num_pyramid_sides=4){
	pyramid_dia=pyramid_dia==undef?size[2]:pyramid_dia;
	span=inner_diameter(pyramid_dia,num_pyramid_sides);
	nx=ceil(size[0]/span);
	ny=ceil(size[1]/span);
	for(x=[0:span:size[0]-0.001]){
		for(y=[0:span:size[1]-0.001]){
			translate([x+span/2+member_dia/2,y+span/2+member_dia/2]) rotate([0,0,45]) pyramid(member_dia,pyramid_dia-member_dia/2,nLegs=num_pyramid_sides);
		}
	}
	// x bottom cross-members
	for(x=[0:nx]){
		translate([x*span+support_dia/2,support_dia/2,support_dia/2]) rotate([-90,0,0]) cyl(r=support_dia/2,h=ny*span);
	}
	// y bottom cross-members
	for(y=[0:ny]){
		translate([support_dia/2,y*span+support_dia/2,support_dia/2]) rotate([0,90,0]) cyl(r=support_dia/2,h=nx*span);
	}
	// x top cross-members
	for(x=[0:nx-1]){
		translate([(x+0.5)*span+support_dia/2,span/2+support_dia/2,size[2]-support_dia/2]) rotate([-90,0,0]) cyl(r=support_dia/2,h=(ny-1)*span);
	}
	// y top cross-members
	for(y=[0:ny-1]){
		translate([span/2+support_dia/2,(y+0.5)*span+support_dia/2,size[2]-support_dia/2]) rotate([0,90,0]) cyl(r=support_dia/2,h=(nx-1)*span);
	}
}


// cylindrical isoTruss
// good description here:
//    https://forums.sketchup.com/t/steps-to-make-an-6-node-hexagonal-isotruss/24159/3
module isoTrussCylinder(length,inner_dia,outer_dia,member_dia=1,support_dia=2,num_sides=6,num_pyramid_sides=4){
	inner_dia_id=inner_diameter(inner_dia,num_sides);
	pyramid_dia=outer_diameter(side_len_by_inner_dia(inner_dia,num_sides),num_pyramid_sides);
	span=inner_diameter(pyramid_dia,num_pyramid_sides);
	pyramid_h=(outer_dia-inner_dia)/2;
	nRows=ceil(length/span);
	for(z=[0:span:length-0.001])
	for(a=[0:360/num_sides:359.99]) rotate([0,0,a]) {
		translate([0,inner_dia_id/2,z+span/2]) rotate([-90,0,0]) rotate([0,0,45]) pyramid(member_dia,pyramid_dia,pyramid_h,nLegs=num_pyramid_sides);
	}
	// support posts
	for(a=[0:360/num_sides:359.99]) rotate([0,0,a]) {
		translate([inner_dia/2,0,0]) cyl(r=support_dia/2,h=nRows*span);
	}
	// test cylinder
	if(false) 
	color([1,0,0,0.25]) linear_extrude(length) difference(){
		circle(r=outer_dia/2,$fn=num_sides);
		circle(r=inner_dia/2,$fn=num_sides);
	}
}


if(create==0){
	isoTrussCylinder(cylinder_length,cylindrical_inner_dia,cylindrical_outer_dia,member_dia,support_dia,num_cylinder_sides,num_pyramid_sides);
}else if(create==1){
	isoTrussPanel([panel_x,panel_y,panel_z],member_dia,support_dia,panel_pyramid_dia,num_pyramid_sides);
}else if(create==2){
	pyramid(member_dia,pyramid_dia,pyramid_h,num_pyramid_sides);
}