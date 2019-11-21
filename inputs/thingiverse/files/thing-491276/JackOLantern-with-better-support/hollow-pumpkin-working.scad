//hollow pumpkin and stem
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/* [Shapes] */
eye_shape = "eye_oval"; //[eye_circle: Circle Eyes, eye_triangle: Triangle Eyes, eye_oval: Oval Eyes, eye_square: Square Eyes]
nose_shape = "nose_circle"; //[nose_circle:Circle Nose, nose_triangle:Triangle Nose, nose_oval:Oval Nose, nose_square:Square Nose]
mouth_shape = "mouth_circle"; //[mouth_circle: Circle Mouth, mouth_triangle:Triangle Mouth, mouth_rectangle:Rectangle Mouth, mouth_oval:Oval Mouth]

//**works best with large mouth sizes selected** 
snaggle_tooth = "yes"; //[no, yes]

//Carve completely through?
carved = "no"; //[no, yes]

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/* [Sizes (Triangle Shapes not adjustable)] */

left_eye = 7; //[0:7]

right_eye = 7; //[0:7]

nose_size = 4; //[0:4] 

mouth_size = 6; //[0:6]


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
	sphere(r=20, $fn=52);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		right side
 difference(){
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20,$fn=52);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }


//		left side front
 difference(){
 rotate([0,0,55])
 scale([1.15, 1, 1.25])
 translate([9, 0, 0])
	sphere(r=20, $fn=52);

 translate([0,0,-26])
	cylinder (h=40, r=22);
}
 

//		left side back
 difference(){
 rotate([0,0,-50])
 scale([1.15, 1, 1.25])
 translate([9, 0, 0])
	sphere(r=20, $fn=52);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		back
 difference(){
 rotate([0,0,-100])
 scale([1.15, 1, 1.25])
 translate([9, 0, 0])
	sphere(r=20, $fn=52);

translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		front
 difference(){
 rotate([0,0,-80])
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20, $fn=52);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }

//		right front
 difference(){
 rotate([0,0,-35])
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20, $fn=52);

 translate([0,0,-26])
	cylinder (h=40, r=22);
 }


//		right back
 difference(){
 rotate([0,0,45])
 scale([1.15, 1, 1.25])
 translate([-9, 0, 0])
	sphere(r=20, $fn=52);

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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



//~~~Eyes~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~***

if (eye_shape=="eye_triangle")
		{
	//triangle eyes
		translate([0,-10,27])
		rotate([90, 90, 0])
		linear_extrude(height = 25)
		polygon([[10,10.5],[20,5],[20,15]]);

	//triangle eyes
		translate([0,-35,27])
		rotate([0, 90, 90])
		linear_extrude(height = 25)
		polygon([[10,10.5],[20,5],[20,15]]);
		}

else if (eye_shape=="eye_circle")
	{
	//		left eye
	translate([11,0,11])
	rotate([90,0,0])
		cylinder(35, left_eye, left_eye); 

	//		right eye
	translate([-11,0,11])
	rotate([90,0,0])
		cylinder(35, right_eye, right_eye);
	}

else if (eye_shape=="eye_oval")
	{
	//	left eye oval
	translate([11,0,11])
	rotate([90,0,0])
	scale([.8,1.1,1])
		cylinder(35, left_eye, left_eye); 

	//	right eye oval
	translate([-11,0,11])
	rotate([90,0,0])
	scale([.8,1.1,1])
		cylinder(35, right_eye, right_eye);
	}

else if (eye_shape=="eye_square")
	{
	//	left eye square
	translate([6,-15,7])
	rotate([90,0,0])
		cube([9, left_eye, 19]); 

	//	right eye square
	translate([-15,-15,7])
	rotate([90,0,0])
		cube([9, right_eye, 19]);
	}
	

//~~~Nose~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~***
//Customizable Nose Shapes
	if (nose_shape=="nose_circle")
	{
	//	nose_circle
	translate([0,-15,1])
	rotate([90,0,0])
		cylinder(23, nose_size, nose_size);
	}
	else if (nose_shape=="nose_square")
	{
		//nose_square
		translate([-3.5,-20,-2.5])
		rotate([90,0,0])
			cube([7,nose_size,17]);
	}
	else if (nose_shape=="nose_triangle")
	{
		//triangle nose
		translate([-10.5,-15,17])
		rotate([90, 90, 0])
		linear_extrude(height = 25)
		polygon([[10,10.5],[20,5],[20,15]]);
	}
	else if (nose_shape=="nose_oval")
	{
	//	nose_oval
	translate([0,-15,1])
	rotate([90,0,0])
	scale([.8,1.2,1])
		cylinder(23, nose_size, nose_size);
	}


//~~~Mouth~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~***
//Customizable Mouth Shapes
	if (mouth_shape=="mouth_circle")
	{
	//		circle mouth
	translate([0,-15,-12])
	rotate([90,0,0])
		cylinder(23, mouth_size, mouth_size);
	}
	else if (mouth_shape=="mouth_oval")
	{
	//		oval mouth
	translate([0,-10,-12])
	rotate([90,0,0])
	scale([1.7,1,1])
		cylinder(23, mouth_size, mouth_size);
	}
	else if (mouth_shape=="mouth_rectangle")
	{
		//		rectangle mouth
	translate([-9,-20,-15])
	rotate([90,0,0])
	scale([1.7,1.5,1])
		cube([11, mouth_size, 14]);
	}
	else if (mouth_shape=="mouth_triangle")
	{
		//triangle mouth
		translate([10,-15,-27])
		rotate([90, 270, 0])
		linear_extrude(height = 25)
		polygon([[12,10.5],[20,0],[20,20]]);
	}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Guts
	//sphere to hollow out
	translate([0,0,-3.75])
	sphere(r=26, $fn=52);

	//sphere to hollow out face
	translate([0,2,2])
	scale([0,1.5,0])
	sphere(r=21, $fn=52);

	//sphere to hollow out face
	translate([0,1,3])
	scale([1.3, 1.4, .85])
	sphere(r=21, $fn=52);
	}



//~~~Teeth~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~***
//tooth
	if (snaggle_tooth=="yes") 
	{
		translate([-6.5,-27,-10.5])
		rotate([80,-8,0])
			cube([5,6,4]);
	}
	else if (snaggle_tooth=="no"){
	}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//partially or completely carved
	
	if (carved=="no")
	{
	difference(){
//thin layer for face negative
	translate([0,-5,-1])
	scale([1.3, 1.2, 1.2])
	sphere(r=21, $fn=52);	

//thin layer for face positve
	translate([0,-4,-2])
	scale([1.3, 1.2, 1.2])
	sphere(r=21, $fn=52);
	
//thin layer for face negative
	translate([0,-3,-2])
	scale([1.3, 1.2, 1.2])
	 sphere(r=21, $fn=52);	
	}
	}
	else if (carved=="yes")
	{
	}

//~~~To Play~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





	
