/*name plate*/

// increase the visual detail
$fn = 35;

// the main body :
// a cylinder
rocket_d = 30; 				// 3 cm wide
rocket_r = rocket_d / 2;
rocket_h = 100; 			// 12 cm tall
cylinder(d = rocket_d, h = rocket_h);

//text :
radius = 15;// [10,20]
height = 30;// [10,50]
slices = 20;// [10,25]

txt = "Your text";
text_depth = 4;

circumference = 2 * 3.14159 * radius;
slice_width = circumference / slices;

circular_text ();

module circular_text () {
   
    union () {
   
        for (i = [0:1:slices]) {
           
            rotate ([0,0,i*(360/slices)]) translate ([0,-radius,40]) intersection () {
               
                translate ([-slice_width/2 - (i*slice_width) ,0 ,0]) rotate ([90,0,0])
                linear_extrude(text_depth, center = true, convexity = 10)
                text(txt);
               
                cube ([slice_width+0.1, text_depth+3, height], true);
            }
        }
    }
}


// the head :
// a cone
head_d = 40;  				// 5 cm wide
head_r = head_d / 2;
head_h = 40;  				// 5 cm tall
// prepare a triangle
tri_base = head_r;
tri_height = head_h;
tri_points = [[0,			 0],
			  [tri_base,	 0],
			  [0,	tri_height]];
// rotation around X-axis and then 360° around Z-axis
// put it on top of rocket's body
translate([0,0,rocket_h])
rotate_extrude(angle = 360)
	polygon(tri_points);

// the wings :
// 3x triangles
wing_w = 2;					// 2 mm thick
many = 3;					// 3x wings
wing_l = 40;				// length
wing_h = 40;				// height
wing_points = [[0,0],[wing_l,0],[0,wing_h]];

/* [Text] */
//height above base
textHeight = 2; // [1,2,3,5]
//text size 
textSize = 7.5; // [3:35]
// font for text
myFont = "Liberation Sans";
// text to put on plate
textInput= "Example";

module wing() {
	// let it a bit inside the main body
	in_by = 1;				// 1 mm
	// set it up on the rocket's perimeter
	translate([rocket_r - in_by,0,0])
	// set it upright by rotating around X-axis
	rotate([90,0,0])
	// set some width and center it
	linear_extrude(height = wing_w,center = true)
	// make a triangle
		polygon(wing_points);
}

for (i = [0: many - 1])
	rotate([0, 0, 360 / many * i])
	wing();
   