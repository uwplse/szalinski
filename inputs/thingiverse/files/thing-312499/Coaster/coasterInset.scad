
//CUSTOMIZER VARIABLES

// width of coaster
coaster_size_x=90;

// length of coaster
coaster_size_y=90;

// height of coaster
coaster_height=15;

// radius of coaster corner
coaster_corner_r=6;

// widith of hole
inset_size_x=74.5;

// length of hole
inset_size_y=75.5;

// height of hole
inset_height=3.8;

// make little holes in bottom for inserting rubber feet or cork circles
do_feet = 0; // [0:no, 1:yes]

// height of foot hole divided by two
feet_height_div2=3.2;

// radius of foot hole
feet_radius=3.5;

//CUSTOMIZER VARIABLES END


module roundedRect(size, radius)
{
x = size[0];
y = size[1];
z = size[2];

linear_extrude(height=z)
//union()
hull()
{
// place 4 circles in the corners, with the given radius
translate([(-x/2)+(radius), (-y/2)+(radius), 0])
circle(r=radius,$fn=50);

translate([(x/2)-(radius), (-y/2)+(radius), 0])
circle(r=radius,$fn=50);

translate([(-x/2)+(radius), (y/2)-(radius), 0])
circle(r=radius,$fn=50);

translate([(x/2)-(radius), (y/2)-(radius), 0])
circle(r=radius,$fn=50);
}
}

difference() {
roundedRect([coaster_size_x,coaster_size_y,coaster_height],coaster_corner_r);
translate([-inset_size_x/2,-inset_size_y/2,inset_height]) cube(size=[inset_size_x,inset_size_y,coaster_height]);

if (do_feet) {
translate([coaster_size_x*3.4/8,coaster_size_y*3.4/8,-0.1]) cylinder(r=feet_radius,h=feet_height_div2,$fn=50);
translate([-coaster_size_x*3.4/8,coaster_size_y*3.4/8,-0.1]) cylinder(r=feet_radius,h=feet_height_div2,$fn=50);
translate([coaster_size_x*3.4/8,-coaster_size_y*3.4/8,-0.1]) cylinder(r=feet_radius,h=feet_height_div2,$fn=50);
translate([-coaster_size_x*3.4/8,-coaster_size_y*3.4/8,-0.1]) cylinder(r=feet_radius,h=feet_height_div2,$fn=50);
}
}
