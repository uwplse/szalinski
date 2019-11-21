// preview[view:south, tilt:top]

//Radius of the inner elements
element_radius = 15; // [10:20] 

// Y shift of the inner elements
y_shift = 10; // [1:20]

//Number of symmetries
symmetries = 6; // [1:12]


//outside ring
rotate_extrude(convexity = 10, $fn=60) translate([20-1.5, 0, 0]) circle(r = 1.5, $fn=60);

//loophole for chain
translate([0,20+3,0]) rotate([0,90,0]) scale([1,1.5,2]) rotate_extrude(convexity = 10, , $fn=60) translate([3, 0, 0]) circle(r = 1, $fn=60);


//pattern
intersection(){
	cylinder(r=20-1.5, h=1.5*2, center=true);
	for(i = [0:symmetries ]){
		rotate([0,0, i* 360/symmetries]) translate([ 0, y_shift , 0]) 
			rotate_extrude(convexity = 10, $fn=60) translate([ element_radius, 0, 0]) circle(r = 1, $fn=60);
	}
}


