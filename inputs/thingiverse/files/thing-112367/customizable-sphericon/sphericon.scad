sphericon_order = 2; //[2,3,4,5,6,7,8,9,10,11,12,13,14,15]
sphericon_diameter = 50.0; // [20.0:100.0]
full_sphericon = "no";// [yes,no]
sphericon_angular_offset = 1; //[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]

pin_height = 6;
pin_diameter = 1.7 ;



//pr = 0.5;

$fn = 64;

angle = 180/sphericon_order;
radius = sphericon_diameter/2; 
pin_radius = pin_diameter /2; 

module half_sphericon(side)  // side : 1 ==> top,  0 ==> bottom
{
	difference(){
	rotate([90,0,0]) 
	union(){
		for (i = [0:sphericon_order-1]) {
			translate([0, 0, sin((i)*angle-90)*1*radius ])
			cylinder(h = (sin((i+1)*angle-90)- sin(i*angle-90))*radius, r1 = cos(i*angle-90)*radius, r2 = cos((i+1)*angle-90)*radius, center = false);
		}

			/* translate ([0,0,radius])sphere(r=pr);
			translate ([0,0,-radius])sphere(r=pr);	
			for ( i = [1 : sphericon_order-1] )
			{
				rotate_extrude()rotate([90,0,0])  translate ([ cos(i*angle-90)*radius,sin(i*angle-90)*radius, 0])cercle(r = pr);
			} */
	} 
	translate([-radius,-radius,-radius*side]) cube ([2*radius,2*radius,radius]);
}
}

difference()
{
union() {
	half_sphericon(1); // 1rst half sphericon
	if (full_sphericon == "yes") //2nd half sphericon
		{
			rotate ([0,0,sphericon_angular_offset*angle]) 
			half_sphericon(0);
		}
	}

//drilling the pins holes
for (i = [0:2*(sphericon_order-1)+1]) {
	translate([0.75*radius*cos((i+(sphericon_order - 2*floor(sphericon_order/2))/2)*angle),0.75*radius*sin((i+(sphericon_order - 2*floor(sphericon_order/2))/2)*angle),-pin_height/2]) cylinder(h=pin_height,r=pin_radius, center = false);
}

//suppression of the internal sphere
sphere (r = 0.6*radius);
}