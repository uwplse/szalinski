/* [text] */
//type the name you want on the plaque here
name = "name here";

//The size the letters are
font_size = 12;//[1:50]

//Note: not all fonts may work
text_font = "Arial";

/* [plaque] */

//How wide do you want it (in inches), if you just want the letters put 0
plaque_Width=4;

//How tall do you want it (in inches)
plaque_Height=1.5;

//What angle do you want it at?
plaque_interior_angle = 30;//[0:360]

inch = 25.4*1;//my favorite variable


plaque_width = plaque_Width*inch;
plaque_height = plaque_Height*inch;
rotate([90,90,0]){
	translate([-plaque_width/2,0,0]){	
		translate([0,.5*(plaque_height-plaque_height*cos(plaque_interior_angle)),-.5*plaque_height*sin(plaque_interior_angle)]) {
			rotate([plaque_interior_angle,0,0]) {
				cube([plaque_width,plaque_height,2], center = true);
				}
		}
		cube([plaque_width,plaque_height,2], center = true);
		
		linear_extrude(height = 2, convexity = 10){
			translate([-(len(name)+.75)*font_size/3,-font_size/3,.75]){
				text(name, font = text_font, size = font_size);
			}
		}
	}
}