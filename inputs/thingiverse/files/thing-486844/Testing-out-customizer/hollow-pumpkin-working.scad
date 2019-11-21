//hollow pumpkin and stem


//left eye size
left_eye = 7; //[0:7]

//right eye size 
right_eye = 7; //[0:7]

//nose size 
nose_circle = 4; //[0:4]

//nose size 
nose_square = 7; //[0:7]


nose_shape = "nose_square"; //[nose_circle:Circle Nose,nose_square:Square Nose]


//mouth size 
mouth = 6; //[0:6]

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
translate([11,0,11])
rotate([90,0,0])
	cylinder(35, left_eye, left_eye); 


//		right eye
translate([-11,0,11])
rotate([90,0,0])
	cylinder(35, right_eye, right_eye);




if (nose_shape=="nose_circle")
{
//	nose_circle
translate([0,-15,1])
rotate([90,0,0])
	cylinder(23, nose_circle, nose_circle);
}

else if (nose_shape=="nose_square")
{
	//nose_square
	translate([-3.5,-26,-2.5])
	rotate([90,0,0])
		cube(7, nose_square, nose_square);

}

//		circle mouth
translate([0,-15,-12])
rotate([90,0,0])
	cylinder(23, mouth, mouth);


//sphere to hollow out
translate([0,0,-3.75])
sphere(r=26);

//sphere to hollow out face
translate([0,2,2])
scale([0,1.5,0])
sphere(r=21);

//sphere to hollow out face
translate([0,1,3])
scale([1.3, 1.4, .85])
sphere(r=21);
}






//		oval mouth with teeth -start of
	//translate([0,35,-12])
	//rotate([90,0,0])
	//scale([1.7,1,1])
		//cylinder(23,6,6);



//		oval mouth
	//translate([0,35,-12])
	//rotate([90,0,0])
	//scale([1.7,1,1])
		//cylinder(23, mouth, mouth);

//triangle eyes
	//translate([0,30,30])
	//rotate([90, 90, 0])
	//linear_extrude(height = 50)
	//polygon([[10,12.5],[15,10],[15,15]]);

	//translate([0,10,30])
	//rotate([0, 90, 90])
	//linear_extrude(height = 20)
	//polygon([[10,12.5],[15,10],[15,15]]);

