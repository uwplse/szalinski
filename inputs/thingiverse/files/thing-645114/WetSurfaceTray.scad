
//Length of tray
length=65; //[10:250]

//Width of tray
width=50; //[10:150]

//Height of sides
side_height=2.5; //[1.5:5.0]

//Thickness of base mesh
mesh_width=1.2; //[1.0:3.0]

//Width of mesh gaps
gap_width=7; //[2:10]

//Height of tray feet
foot_height=3; //[2:5]

//cube([width,length,mesh_width], center=true);
//base();

rotate([0,0,90])
union()
{
	basket();
 	feet();
}

//Middle leg perhaps.. Needs work
//	rotate([0,0,-45]) leg();
//	rotate([0,0,135]) leg();


module feet()
{
	translate([width/2-foot_height,-length/2+foot_height,-mesh_width/2]) rotate([0,0,0]) leg();
	translate([-width/2+foot_height,-length/2+foot_height,-mesh_width/2])  rotate([0,0,-90])  leg();

	translate([-width/2+foot_height,length/2-foot_height,-mesh_width/2]) rotate([0,0,180])  leg();
	translate([width/2-foot_height,length/2-foot_height,-mesh_width/2])  rotate([0,0,90])  leg();
	
}


module leg()
{
	rotate([180,0,0])
	polyhedron(
		points=[ [foot_height,foot_height,0],[foot_height,-foot_height,0],[-foot_height,-foot_height,0],[-foot_height,foot_height,0], // the four points at base
         	[0,0,foot_height]  ],                                 // the apex point 
  		faces=[ [0,1,4],[1,3,4],[3,0,4], //[2,3,4],[3,0,4],              // each triangle side
         	[1,0,3]]//,[2,1,3] ]                         // two triangles for square base
	 );

}


module wall(length, zangle)
{

	rotate([90,0,zangle])
	linear_extrude(height = length, center = true, convexity = 10)
	{
		polygon(
		points=[ [side_height,side_height],[side_height,0],[0,0]],
		paths=[[0,1,2]]
		);
	}

}


module basket()
{

	difference()
	{
		base();

		difference()
		{

			cube([length*width,length*width,mesh_width*2], center=true);
			cube([width,length,mesh_width*3], center=true);
		}
	}

	//Walls
	translate([width/2-side_height,0,-mesh_width/2]) wall(length,0);
	translate([-width/2+side_height,0,-mesh_width/2]) wall(length,180);

	translate([0,-length/2+side_height,-mesh_width/2]) wall(width,270);
	translate([0,length/2-side_height,-mesh_width/2]) wall(width,90);

}


module base()
{
	greaterLength=length>width?length:width;

	intersection()
	{
		cube([width,length,mesh_width], center=true);
		union()
		{
			for(i=[-pt(greaterLength):gap_width:pt(greaterLength)])
			{
				translate([i-mesh_width,mesh_width*1.5-gap_width/2,0]) 
					rotate([0,0,-45])  cube([mesh_width,length*2,mesh_width], center=true);
				translate([i+mesh_width,0,0]) 
					rotate([0,0,45])   cube([mesh_width,length*2,mesh_width], center=true);
			}
		}
	}


}


function pt(a) = sqrt(a*a + a*a)/2;

