
translate([0,0,11]){

//cylinders
difference () {
    cylinder(29,d=29, true);
    cylinder(30,d=17, true);
    }
translate([0,9.3,29/2])
    cube([17,5,29], true);
translate([0,-9.3,29/2])
    cube([17,5,29], true);
rotate(180, [0,0,1])  ergot1() ;
ergot1();
 difference(){
    translate([-65,0,0]) rotate(90,[0,1,0]) hull() roundedRect([17, 25, 100], 5, $fn=20);
    cylinder(30,d=17, true);
}
}
module ergot1(){
    intersection(){
    translate([0,0,29]) {
        difference () {
            cylinder(5,d=29, true);
            cylinder(6,d=17, true);
            }
        }
    hull()polyhedron( points = [ 
    [0,8.5,29],[0,16,29],[12.79,15.06,29],[5.6,6.4,29],
    [0,8.5,34],[0,16,34],[12.79,15.06,34],[5.6,6.4,34] ], faces = [
    [0,4,7,3],[1,5,6,2],[3,7,6,2],[0,1,5,4] ] );
}
}

// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}

