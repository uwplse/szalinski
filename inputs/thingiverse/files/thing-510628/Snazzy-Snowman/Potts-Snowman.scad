//BEGIN CUSTOMIZER

// Draft for preview, production for final
Render_Quality = 24;  //[24:Draft,60:production]

scale_factor = 1;//[.5,1,1.5,2,2.5,3]

// mm
text_height=7; // [6:15]

text_font = "write/orbitron.dxf";//[write/Letters.dxf,write/orbitron.dxf,write/knewave.dxf,write.braille.dxf,write/Blackrose.dxf]

// top line of text
text1 = "Do you wanna";
//bottom line of text
text2 = "build a snowman?";
//move the text up by this much, mm
text_shift = 0; // [-10:10]

//END CUSTOMIZER

snowman ();

emboss_depth = 3*1;
$fn=Render_Quality;

module snowman(){
scale([scale_factor,scale_factor,scale_factor]){
scale([2,2,2]){
	//head
	translate([0,0,35])sphere(5);
	//middle
	translate([0,0,24])sphere(7);
	//bottom
	translate([0,0,10])sphere(10);

	//add text
	writesphere(text1,[0,0,0],radius=10,height=17,t=3,up=text_shift+1.2*text_height/2,h=text_height,font=text_font);
			writesphere(text2,[0,0,0],radius=10,height=17,down=0-text_shift+1.2*text_height/2,t=3,h=text_height,font=text_font);


	//nose
	rotate([-90,0,0])
		translate([0,-35,-7])cylinder(h=3,r1=0,r2=1);

	//hat bottom
	translate([0,0,39])cylinder(.5,6,6);
	//hat top
	translate([0,0,39.5])cylinder(h=3,r=4.5);

	//left eye
	translate([-2,-4.2,36])cube(1,center=true);
	//right eye
	translate([2,-4.2,36])cube(1,center=true);

	//mouth 1
	translate([-3,-3.6,33.5])cube(.7,center=true);
	//mouth 2
	translate([-2,-4,33])cube(.7,center=true);
	//mouth 3
	translate([-1,-4.3,32.7])cube(.7,center=true);
	//mouth 4
	translate([0,-4.45,32.5])cube(.7,center=true);
	//mouth 5
	translate([1,-4.3,32.7])cube(.7,center=true);
	//mouth 6
	translate([2,-4,33])cube(.7,center=true);
	//mouth 7
	translate([3,-3.6,33.5])cube(.7,center=true);

	//top button
	translate([0,-5.2,28])sphere(1.3);
	//middle button
	translate([0,-6.5,25.5])sphere(1.3);
	//bottom button
	translate([0,-6.3,22.5])sphere(1.3);

	//left arm
	translate([-10,0,28])
		rotate([0,-45,0])cylinder(h=10,r=.7,center=true);
	//right arm
	translate([10,0,28])
		rotate([0,45,0])cylinder(h=10,r=.7,center=true);
}
}
}