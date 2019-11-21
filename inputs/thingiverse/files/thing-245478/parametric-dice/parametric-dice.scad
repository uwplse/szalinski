
quality = 60; // [20:test,60:prod]
$fn=quality*1;

// size of the cube
size = 20; // [0:1000]

difference(){

	color("green")
	intersection(){
		//minkowski(){
//			cube(size-2*cornerRadius, center=true);
//			sphere(cornerRadius);
//		}
		cube(size, center=true);
		rotate([0,0,0]) cylinder(h=size+2, r=.665*size, center=true);
		rotate([0,90,0]) cylinder(h=size+2, r=.665*size, center=true);
		rotate([90,0,0]) cylinder(h=size+2, r=.665*size, center=true);
		sphere(size*75/100);
	}


//1
	translate([0,0,size/2])
	#sphere(size*8/100);
	//#cylinder(depth+1,size*8/100,size*8/100);

//6
	for (b=[-size/5,size/5]){
		for (a=[-size/4,0,size/4]){
			translate([b,a,-size/2])
			#sphere(size*8/100);
		}
	}

//4 
	for (b=[-size/5,size/5]){
		for (a=[-size/5,size/5]){
			rotate([0,90,0])
			translate([b,a,size/2])
			#sphere(size*8/100);
		}
	}

//3
	for (a=[-size/5,0,size/5]){
		rotate([0,-90,0])
		translate([a,a,size/2])
		#sphere(size*8/100);
	}

//5
	rotate([90,0,0])
	translate([0,0,size/2])
	#sphere(size*8/100);

	for (b=[-size/5,size/5]){
		for (a=[-size/5,size/5]){
			rotate([90,0,0])
			translate([b,a,size/2])
			#sphere(size*8/100);
		}
	}

// 2
	for (a=[-size/5,size/5]){
		rotate([-90,0,0])
		translate([a,a,size/2])
		#sphere(size*8/100);
	}
}