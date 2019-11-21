//hollow pumpkin and stem


//eye size customizations
left_eye = 7; //[0:7]
right_eye = 7; //[0:7]



difference(){

union(){

//		hollow center start
difference(){
translate([0,0,-22])
	cylinder (h=40, r=22);

translate([0,0,-23])
	cylinder (h=42, r=21);
}
//		hollow center end

//		left side
 difference(){
 scale([1.15, 1, 1.25])
 translate([9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		right side
 difference(){
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }


//		left side front
 difference(){
 rotate([0,0,55])
 scale([1.15, 1, 1.25])
 translate([9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
}
 

//		left side back
 difference(){
 rotate([0,0,-50])
 scale([1.15, 1, 1.25])
 translate([9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		back
 difference(){
 rotate([0,0,-100])
 scale([1.15, 1, 1.25])
 translate([9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		front
 difference(){
 rotate([0,0,-80])
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		right front
 difference(){
 rotate([0,0,-35])
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }


//		right back
 difference(){
 rotate([0,0,45])
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		stem
difference(){
linear_extrude(height = 32, convexity = 2, twist = -400)
translate([1, -1, 0])
	circle(r = 3.5);

translate([0,0,-26])
	cylinder (h=40, r=22);
}

}


//		left eye
translate([11,35,9])
rotate([90,0,0])
	cylinder(23, left_eye, left_eye); 


//		right eye
translate([-11,35,9])
rotate([90,0,0])
	cylinder(23, right_eye, right_eye);
}



