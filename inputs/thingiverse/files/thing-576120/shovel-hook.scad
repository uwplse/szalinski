//Snow Shovel Wall Hook
//John Finch 12/2/14

handle_dia = 33;
mount_height = 100;
wall = 8;
drop = 10;
tab_thickness = 8;
hole_dia = 5;
hole_inset = 8;



wedge_height = 60;
wedge_width = handle_dia+2*wall;
wedge_depth = handle_dia+wall;
fn=100;

module wedge(){

polyhedron(
	points = [ [0,-wedge_width/2,wedge_height-drop],[0,wedge_width/2,wedge_height-drop],[wedge_depth,-wedge_width/2,wedge_height],[wedge_depth,wedge_width/2,wedge_height],[0,wedge_width/2,0],[0,-wedge_width/2,0] ],
 
triangles=[ [5,0,2],[5,1,0],[5,4,1],[0,1,2],[1,3,2],[4,3,1],[5,2,4],[2,3,4] ]
);


}


module hook(){
	difference(){
	wedge();
	translate([handle_dia/2,0,0])
	cylinder(r=handle_dia/2,h=wedge_height,$fn=fn);
	translate([handle_dia/2,-handle_dia/2,0])
	cube([handle_dia,handle_dia,wedge_height]);
	
	}
}

//hook();
module assembly(){
difference()
	{
	union()
		{
		translate([0,-wedge_width/2,0])
		cube([tab_thickness,wedge_width,mount_height]);
		translate([tab_thickness,0,(mount_height-wedge_height)/2])
		hook();
		}
	//cut screw holes
	translate([0,0,mount_height-hole_inset])
	rotate([0,90,0])
	cylinder(h=tab_thickness,r=hole_dia/2,$fn=fn);

	translate([0,0,hole_inset])
	rotate([0,90,0])
	cylinder(h=tab_thickness,r=hole_dia/2,$fn=fn);

	//cut backside relief pocket
	translate([0,0,mount_height-hole_inset])
	rotate([0,90,0])
	cylinder(h=2,r=6,$fn=fn);

	translate([0,0,hole_inset])
	rotate([0,90,0])
	cylinder(h=2,r=6,$fn=fn);

	//cut front side counter bore
	translate([tab_thickness-2.5,0,mount_height-hole_inset])
	rotate([0,90,0])
	cylinder(h=10,r=4,$fn=fn);

	translate([tab_thickness-2.5,0,hole_inset])
	rotate([0,90,0])
	cylinder(h=10,r=4,$fn=fn);


	}

}

translate([mount_height/2,0,0])
rotate([0,-90,0])
assembly();