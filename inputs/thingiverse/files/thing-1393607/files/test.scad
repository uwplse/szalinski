//type the name you want on the plaque here
name = "name here";
//How wide do you want it (in inches)
plaque_Width=3;
//How tall do you want it (in inches)
plaque_Height=1;

//The size the letters are
font_size = 12;//[1:50]

//Note: not all fonts may work
text_font = "Arial";

inch = 25.4*1;//my favorite variable

plaque_width = plaque_Width*inch;
plaque_height = plaque_Height*inch;
cube([plaque_width,plaque_height,2], center = true);
linear_extrude(height = 2, convexity = 10){
	translate([-(len(name)+.75)*font_size/3,-font_size/3,.75]){
		text(name, font = text_font, size = font_size);
	}
}