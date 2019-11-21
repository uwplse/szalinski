use <../MCAD/regular_shapes.scad>;
use <../MCAD/shapes.scad>;
include <../3D-PCB/3D-PCB.scad>;

curvature_radius=40;
angle_rotation=90;

numberx=5;
numbery=2;

track_radius=10;
$fn=100;

track_width=15;			//25
track_height=12;		// 10
track_depth=1;		// dono
track_length=100; // 100

thickness_ring=2;
peg_radius=3.5;

module curve()
{
translate([0,0,track_width/2])
union()
{
partial_rotate_extrude(angle_rotation, curvature_radius, 10)
{
rotate([0,0,180])
difference()
{
translate([-track_height/2,0])
square([track_height,track_width], center=true);


translate([track_radius-5,0])
circle(r=track_radius);
    
    

    
    
    }}

translate([curvature_radius+track_height+peg_radius,peg_radius+thickness_ring,-track_width/2])
support();

rotate([0,0,angle_rotation])
translate([curvature_radius+track_height+peg_radius,-(peg_radius+thickness_ring),-track_width/2])
support();
}}



for (i=[0:numberx-1], j=[0:numbery-1])
{
    translate([curvature_radius*0.9*i, curvature_radius*1.7*j,0])
    curve();
}



module pie_slice(radius, angle, step) {
	for(theta = [0:step:angle-step]) {
		rotate([0,0,0])
		linear_extrude(height = radius*2, center=true)
		polygon( 
			points = [
				[0,0],
				[radius * cos(theta+step) ,radius * sin(theta+step)],
				[radius*cos(theta),radius*sin(theta)]
			] 
		);
	}
}

module partial_rotate_extrude(angle, radius, convex) {
	intersection () {
		rotate_extrude(convexity=convex) translate([radius,0,0]) child(0);
		pie_slice(radius*2, angle, angle/5);
	}
}




//--------------------------------------------------------------------------


module track_straight()
{

difference()
{

linear_extrude(height=track_length)
{

difference()
{
translate([-track_height/2,0])
square([track_height,25], center=true);


translate([track_radius-5,0])
circle(r=track_radius);



}
}

translate([-track_height,track_width/2+1,5*track_length/6])
rotate([90,0,0])
cylinder(r=peg_radius, h=track_width*2);

translate([-track_height,track_width/2+1,track_length/6])
rotate([90,0,0])
cylinder(r=peg_radius, h=track_width*2);

}
module support()
{
rotate([90,0,0])
difference()
{

cylinder(r=peg_radius+thickness_ring, h=track_width);
translate([0,0,-1])
cylinder(r=peg_radius, h=track_width*2+2);



}
}

translate([-track_height,track_width/2,5*track_length/6])
support();

translate([-track_height,track_width/2,track_length/6])
support();

}


// MARBLE
//sphere(r=7.5);
//


//track_straight();

module support()
{
rotate([0,0,90])
difference()
{

hull()
{
cylinder(r=peg_radius+thickness_ring, h=track_width);
translate([-(peg_radius+thickness_ring),peg_radius+thickness_ring,0])
cube([(peg_radius+thickness_ring)*2,1,track_width]);
    
}
translate([0,0,-1])
cylinder(r=peg_radius, h=track_width*2+2);



}
}

