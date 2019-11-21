track_radius=9;
$fn=100;
number=12;

track_width=15;			//25
track_height=11;		// 10
track_depth=1;		// dono
track_length=130; // 100

thickness_ring=2;
peg_radius=3.5;

module track_straight()
{

difference()
{

linear_extrude(height=track_length)
{


difference()
{
translate([-track_height/2,0])
square([track_height,track_width], center=true);


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


for( i=[0:number-1])
{

translate([i*(track_height+peg_radius*2),0,track_width/2])
rotate([90,0,0])
track_straight();


}

// MARBLE
//sphere(r=7.5);
//


// Cut-out slot

cube([]);
