$fn = 100;

// size of the cube
size = 20; // [0:1000]

difference(){

	color("green")
	intersection(){
		cube([1,1,1]*size, true);
		rotate([0,0,0]) cylinder(size+2,.67*size, .67*size, true);
		rotate([0,90,0]) cylinder(size+2,.67*size, .67*size, true);
		rotate([90,0,0]) cylinder(size+2,.67*size, .67*size, true);
		sphere(size*80/100);
	}


//.5
	translate([0,0,size/2])
	rotate([0,0,45])
	difference(){
		sphere(3);
		translate([0,-size*4/50,0])
		cube([size*16/50,size*8/50,size*16/50], center=true);
	}
//6
	for (b=[-size/5,size/5]){
		for (a=[-size/4,0,size/4]){
			translate([b,a,-size/2])
			sphere(2,size*8/100,size*8/100);
		}
	}
	
	for (a=[-size/7,size/7]){
			//rotate([90,0,0])
			translate([0,a,-size/2])
			sphere(2,size*8/100,size*8/100);
	}

//3 
	for (a=[-size/5,0,size/5]){
		rotate([0,90,0])
		translate([a,a,size/2])
		sphere(2,size*8/100,size*8/100);
	}

//2
	for (a=[-size/5,size/5]){
		rotate([0,-90,0])
		translate([a,a,size/2])
		sphere(2,size*8/100,size*8/100);
	}

//5
	rotate([90,0,0])
	translate([0,0,size/2])
	sphere(2,size*8/100,size*8/100);

	for (b=[-size/5,size/5]){
		for (a=[-size/5,size/5]){
			rotate([90,0,0])
			translate([b,a,size/2])
			sphere(2,size*8/100,size*8/100);
		}
	}

// 1
		rotate([-90,0,0])
		translate([0,0,size/2])
		sphere(2,size*8/100,size*8/100);
}