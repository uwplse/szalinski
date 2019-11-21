//parametric ›soda bottle opener and closer wrench
//John Finch 12/6/13


cap_dia = 30.5;
cap_height = 15;
interference = .01;  //fraction the spine protruding into cap diameter
handle_length = 100;
handle = "yes";  // yes or no

outer_dia = 45;
inner_dia = cap_dia * (1-interference);
wall_thickness = 2;
spine_angle = 15;
spine_thickness = 1;
num_spines = 36;

spine_length = (outer_dia/2-wall_thickness-inner_dia/2)/cos(spine_angle);

fa=0.1;
fs=0.5;

module roundedCube(size, radius)  //Using hull() and spheres
{
x = size[0];
y = size[1];
z = size[2];
fn=20;

//Set bounds on the radius 
radius=max(0.1,radius);
radius=min(radius,min(x,min(y,z))/2);
//echo ("Radius= ",radius);

//echo (x, y, z, radius);


hull()
	{
	translate([radius,radius,radius])
	sphere(r=radius,$fn=fn);

	translate([radius,radius,z-radius])
	sphere(r=radius,$fn=fn);

	translate([x-radius,radius,radius])
	sphere(r=radius,$fn=fn);

	translate([x-radius,radius,z-radius])
	sphere(r=radius,$fn=fn);

	translate([radius,y-radius,radius])
	sphere(r=radius,$fn=fn);

	translate([radius,y-radius,z-radius])
	sphere(r=radius,$fn=fn);

	translate([x-radius,y-radius,radius])
	sphere(r=radius,$fn=fn);

	translate([x-radius,y-radius,z-radius])
	sphere(r=radius,$fn=fn);

	
	

	}
}
module spine(){
//echo(outer_dia/2-wall_thickness-spine_length);
//echo(-spine_thickness/2);
difference(){
	
		translate ([outer_dia/2-wall_thickness-spine_length*cos(spine_angle),-spine_thickness/2-spine_length*sin(spine_angle),0])
		rotate([0,0,spine_angle])
		cube([spine_length+.5,spine_thickness,cap_height/2]);
	

	translate([outer_dia/2-wall_thickness-spine_length,spine_length/2,0])
	rotate([90,0,0])
	cylinder(h=spine_length,r1=spine_length, r2=spine_length,$fn=3);
	}

	difference(){
	
	translate ([outer_dia/2-wall_thickness-spine_length*cos(spine_angle),-spine_thickness/2+spine_length*sin(spine_angle),cap_height/2])
	rotate([0,0,-spine_angle])
	cube([spine_length+.5,spine_thickness,cap_height/2]);

	translate([outer_dia/2-wall_thickness-spine_length,spine_length/2,cap_height/2])
	rotate([90,0,0])
	cylinder(h=spine_length,r1=spine_length, r2=spine_length,$fn=3);
	}




}


translate([0,0,2])
difference(){
	union(){
		cylinder(h = cap_height, r1 = outer_dia/2, r2 = outer_dia/2, $fn=12);
		//Insert handle
		if (handle == "yes"){
		translate([0,-15,-2])
		roundedCube([handle_length+outer_dia/2,30,10],5);
		}
	}
	
	cylinder(h = cap_height, r1 = outer_dia/2-wall_thickness, r2 = outer_dia/2-wall_thickness, $fn=100); // $fa=fa, $fs=fs);

	}
rot_angle = 360/num_spines;
translate([0,0,2])
for ( i = [ 1 : num_spines ] )
	{
	rotate([0,0,i*rot_angle])
	spine();
	}

translate([0,0,0])
cylinder(h = 2, r1 = outer_dia/2-2, r2 = outer_dia/2, $fn=12);



//spine();






