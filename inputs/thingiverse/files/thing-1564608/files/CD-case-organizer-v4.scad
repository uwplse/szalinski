
/* [Basic] */
wallThickness = 1.2;
//number of horizontal bars
horizontalBars = 3; //[0,1,2,3,4,5,6]
//number of vertical bars
verticalBars = 2; //[0,1,2,3,4,5,6]

//offset of each bar, can be positive or negative nuber. Example [5,-5,0,0,0,0] moves the first bar 5mm to the right and the second bar 5mm to the left.
horizontalBarOffset = [0,0,0,0,0,0];
verticalBarOffset = [0,0,0,0,0,0];

textTag = "My Organizer Box";
//you can select font name from here https://www.google.com/fonts
textFont = "Open Sans";
textStyle = "Bold";
textSize = 6;
//text extrusion
textHeight = 1;

/* [Advanced] */
box_width=138.4;
box_length=118.4;
box_height = 7;
ridge_width = 11;
ridge_height = 8.5;
//ridge chamfer size
chamfer = 1.5;
cleft_height = 4;
//stabilization arc diameter
stabilizer_diameter = 40;
//stabilization arc width
stabilizer_width = 8;

/* [Hidden] */
$fn=100;

difference() {
	base();	
	upperLockHoles();
	lock_clefts();
    //front edge lower
    translate([box_width/2 - wallThickness+1 , 0 , box_height -0.5 ])
        cube([wallThickness*2,box_length-10*wallThickness,1.1], center = true);
}
locks();
difference() {
	ridge();
	chamfer();
}

stabilizers();
difference() {
	bars();
	if (horizontalBars > 0) {
		translate([-box_width/2 + 13, 0 , box_height - 1.25 ])
			cube([4.01,box_length+3*wallThickness,3.5], center = true);
            translate([box_width/2 - wallThickness - 1.5 , 0 , box_height - 1.25 ])
                cube([3.01,box_length-3*wallThickness,3.5], center = true);
            translate([box_width/2 - wallThickness+1 , 0 , box_height -0.5 ])
                cube([wallThickness*2,box_length-10*wallThickness,1.1], center = true);
	}
	if (verticalBars > 0) {
		upperLockHoles();
	}
}



module ridge() {
	translate([-box_width/2 + ridge_width/2, 0, ridge_height/2])
		cube([ridge_width, box_length, ridge_height], center = true);
    translate([-box_width/2 + ridge_width/2 , 0, ridge_height-0.01])
        rotate([0,0,90]) 
                linear_extrude (height=textHeight)
                    text(text=textTag, font=str(textFont,":style=",textStyle), size=textSize, halign="center", valign="center"); 
}

module upperLockHoles() {
		translate([-box_width/2 +32.5, -box_length/2 + wallThickness/2 , 5.5])
			//cube([10,wallThickness+0.2,4], center = true);
			lockHole();
		translate([-box_width/2 +32.5, box_length/2 - wallThickness/2 , 5.5])
			//cube([10,wallThickness+0.2,4], center = true);
			lockHole();
		translate([box_width/2 -23, -box_length/2 + wallThickness/2 , 5.5])
			//cube([10,wallThickness+0.2,4], center = true);
			lockHole();
		translate([box_width/2 -23, box_length/2 - wallThickness/2 , 5.5])
			//cube([10,wallThickness+0.2,4], center = true);
			lockHole();
		translate([3.5, box_length/2 - wallThickness/2 , 5.5])
			cube([10,14,4], center = true);
		translate([3.5, - box_length/2 + wallThickness/2 , 5.5])
			cube([10,14,4], center = true);

}

module lockHole() {
	rotate([90,0,0])
		linear_extrude(height=14, center = true)
			polygon([[-5.5,-2],[-4.9,0],[-5.5,2],[5.5,2],[4.9,0],[5.5,-2]]);
}


module base() {
	translate([0,0,box_height/2])
		difference() {
			cube([box_width,box_length,box_height], center = true);
			//translate([0,0,wallThickness])
				cube([box_width-2*wallThickness,box_length-2* wallThickness,box_height+2* wallThickness], center = true);
		}
}

module locks() {
	translate([-box_width/2 +14.5, -box_length/2 - wallThickness/2 + 0.5,2])
		rotate([90,0,0])
			cylinder(d=1.5,h=1.5, center=true);
	translate([-box_width/2 +14.5, box_length/2 + wallThickness/2 - 0.5,2])
		rotate([90,0,0])
			cylinder(d=1.5,h=1.5, center=true);
	translate([box_width/2 -7.5, -box_length/2 - wallThickness/2 + 0.5,2])
		rotate([90,0,0])
			cylinder(d=1.5,h=1.5, center=true);
	translate([box_width/2 -7.5,  box_length/2 + wallThickness/2 - 0.5,2])
		rotate([90,0,0])
			cylinder(d=1.5,h=1.5, center=true);
}

module lock_clefts() {
	translate([-box_width/2 + 11, -box_length/2 + wallThickness/2 , box_height/2 - 0.1])
			cube([2,wallThickness+0.2,box_height+0.3], center = true);
	translate([-box_width/2 + 13, -box_length/2 + wallThickness/2 , box_height - 1.25 ])
			cube([5,wallThickness+0.2,3.5], center = true);

	translate([-box_width/2 + 11, box_length/2 - wallThickness/2 , box_height/2 - 0.1])
			cube([2,wallThickness+0.2,box_height+0.3], center = true);
	translate([-box_width/2 + 13, box_length/2 - wallThickness/2 , box_height - 1.25 ])
			cube([5,wallThickness+0.2,3.5], center = true);

	translate([box_width/2 - 8.5, -box_length/2 + wallThickness/2 , cleft_height ])
			cube([6,wallThickness+0.2,1], center = true);
	translate([box_width/2 - 11, -box_length/2 + wallThickness/2 , cleft_height/2 - 0.1])
			cube([1,wallThickness+0.2,cleft_height], center = true);

	translate([box_width/2 - 8.5, box_length/2 - wallThickness/2 , cleft_height])
			cube([6,wallThickness+0.2,1], center = true);
	translate([box_width/2 - 11, box_length/2 - wallThickness/2 , cleft_height/2 - 0.1])
			cube([1,wallThickness+0.2,cleft_height], center = true);
}

module stabilizers() {
	translate([-box_width/2 +ridge_width -0.1 , -box_length/2,wallThickness/2])
		stabilizer (10,10);
	translate([-box_width/2 +ridge_width -0.1 ,  box_length/2,wallThickness/2])
		stabilizer (10,-10);
	translate([box_width/2 , -box_length/2,wallThickness/2])
		stabilizer (-10,10);
	translate([box_width/2 , box_length/2,wallThickness/2])
		stabilizer (-10,-10);
}
//stabilizer_diameter/2
//ridge_width

module stabilizer(x,y) {
	intersection() {
		difference() {
			cylinder(d=stabilizer_diameter,h=wallThickness, center = true);
			translate([0,0,-0.1])
				cylinder(d=stabilizer_diameter-stabilizer_width*2,h=wallThickness+0.3, center = true);
		}
	translate([x,y,0])
		cube(20, center=true);
	}	
}

module bars() {
	if (horizontalBars>0) {
		for (x = [1 : horizontalBars]) {
			translate([-box_width/2,x*box_length/(horizontalBars+1)-box_length/2 + horizontalBarOffset[x-1],0])
			cube([box_width, wallThickness, box_height]);	
		}
	}
	if (verticalBars>0) {
		for (y = [1 : verticalBars]) {
			translate([y*(box_width-ridge_width)/(verticalBars+1) -box_width/2 + ridge_width + verticalBarOffset[y-1],-box_length/2,0])
			cube([wallThickness, box_length, box_height]);	
		}
	}
}

module chamfer() {
	translate([-box_width/2 + ridge_width +0.1,0,box_height+1.51])
	rotate([90,0,0])
		linear_extrude(height=box_length+1, center = true)
			polygon([[0,0],[0,-chamfer],[-chamfer,0]]);

}




