use <write/Write.scad>;

/* [Personalize] */

//Your text for the Red panel first line
text_line_1_side1="Magic Wallet v2.1"; 
//Your text for the Red panel second line
text_line_2_side1="w/ Dualstrusion";
//Your text for the Red panel third line
text_line_3_side1="Designed for 3D Printing"; 
//The position of the text. Y-Axis only
text_position_side1=10; //[1:25]

//is side 2 (Green Panel) text or an image?
side2="text"; //[text,image]

//Your high contrast logo
side2_image="image_surface.dat"; //[image_surface:100x100]

//Image Scale
img_scale=.5; //[.1,.2,.3,.4,.5,.6,.7,.8,.9,1]

//The position of the text or image. Y-Axis only
text_position_side2y=0; //[-25:25]
//The position of the text or image. x-Axis only
text_postion_side2x=0; //[-25:25]
//Your text for the Green panel first line
text_line_1_side2="By: Tim Chandler"; 
//Your text for the Green panel second line
text_line_2_side2="A.K.A. 2n2r5"; 
//Your text for the Green panel third line
text_line_3_side2="------------"; 



//Text Size
text_size=5; //[0,1,2,3,4,5,6,7,8,9,10]
//How far should the text extrude?
text_height=1.5; //[1,1.5,2,2.5]
//Select your font
text_font="write/orbitron.dxf"; //[write/letters.dxf,write/BlackRose.dxf,write/braille.dxf,write/knewave.dxf,write/orbitron.dxf]



/* [Size and Shape] */


//Thickness of each side
mw_height=1.5; //[1.5:thin,2:medium,2.5:thick]
//Y-Axis Dimensions 
mw_width=60; //[50:150]
//X-Axis Dimensions 
mw_length=100; //[50:150]
//Left side hole heights
mw_strap_small=15; //[2:20]
//Right side hole heights
mw_strap_big=15; //[2:20]
//Strap hole widths
mw_strap_w=2; //[1,2,3]
//Up this when making strap holes wider
strap_dfe=3; //[2,3,4]


/* [Advanced] */

//What should we print out? (Use individual sides for portait or larger wallets)
part = "all" ; //[sides:Sides Only,straps:Straps Only,all:Straps and Sides,side1:Red Side,side2:Green Side,text:text and images only]

//strap thickness
strap_thk=.3; //probably don't want to mess with this

//tolerance for fit. subtracted from straps only
fit_tol=.2; //[0,.1,.2,.3,.4,.5,.6,.7,.8]

/* [Hidden] */

//size as defined above
size=[mw_width,mw_length,mw_height];


//Features waiting to be fixed
//Adjustable text rotation
text_rot=90;
//2x2 holes or 2x1 holes
hole_count=0; //[0:2x1,1:2x2]



image_file = "image-surface.dat"; // [image_surface:100x100]


//z shift for print of straps
zshift=(strap_thk)*-1;

//---Don't mess with anything down here unless you know whats going on---//



//PART BEGIN: Side 1 (red side)

module magicWallet_side1()
{
	difference()
	{
		union() //All the parts that we want to add
		{
			
			
			color("red")
			cube(size, center=true);

		if(print=="text")
		{
		
		}
		else
		{	
		//text line 1 	
			translate([text_position_side1*-1,0,size[2]-1])
			color("black")
			rotate(text_rot)
			write(text_line_1_side1,h=text_size,t=text_height,font=text_font,
				center=true);
		//text line 2
			translate([(text_size+2+(text_position_side1*-1)),0,size[2]-1])
			color("black")
			rotate(text_rot)
			write(text_line_2_side1,h=text_size,t=text_height,font=text_font,
				center=true);
		//text line 3
			translate([(2*(text_size+2)+(text_position_side1*-1)),0,size[2]-1])
			color("black")
			rotate(text_rot)
			write(text_line_3_side1,h=text_size,t=text_height,font=text_font,
				center=true);
		}

			
		}
		
		union() //All the parts that we want to remove
		{

//Makes sure the bottom has nothing protruding (problem with adding images)
			translate([0,0,-size[2]])
			cube(size, center=true);

// making the holes for the small straps

//bottom
			translate([size[0]/3,(size[1]/2-strap_dfe)*-1,-size[2]])
			cube([mw_strap_small,mw_strap_w,20],center=true);

//top			
			translate([(size[0]/3*-1),(size[1]/2-strap_dfe)*-1,-size[2]])
			cube([mw_strap_small,mw_strap_w,20],center=true);

// making the holes for the big straps (1/2 of height and right side)
			translate([0,(size[1]/2-strap_dfe),-size[2]])
			cube([mw_strap_big,mw_strap_w,20],center=true);

// Pretty edges to be added

	
	
		}

	}
	
}
//PART END: Side 1 

//PART BEGIN: Side 2 (Green Side)

module magicWallet_side2()
{

	difference()
	{
		union() //All the parts that we want to add
		{
			color("green")
			cube(size, center=true);
		if(part=="text")
		{
		
		}
		else
		{	

			if(side2=="image")
			{

		
				translate([text_position_side2y*-1,text_postion_side2x,size[2]-.8])
				color("black")
				scale([img_scale,img_scale,text_height]) 
				rotate(90)
				surface(file=side2_image, center=true, convexity=5);
		
			}
				else
			{
			//text line 1 	
				translate([text_position_side2y*-1,text_postion_side2x,size[2]-1])
				color("black")
				rotate(text_rot)
				write(text_line_1_side2,h=text_size,t=text_height,font=text_font,
				center=true);
			//text line 2
				translate([(text_size+2+(text_position_side2y*-1)),text_postion_side2x,size[2]-1])
				color("black")
				rotate(text_rot)
				write(text_line_2_side2,h=text_size,t=text_height,font=text_font,
				center=true);
			//text line 3
				translate([(2*(text_size+2)+(text_position_side2y*-1)),text_postion_side2x,size[2]-1])
				color("black")
				rotate(text_rot)
				write(text_line_3_side2,h=text_size,t=text_height,font=text_font,
				center=true);
			}
			}
		}
		
		union() //All the parts that we want to remove
		{
	
			//Makes sure the bottom has nothing protruding (problem with adding images)
			translate([0,0,-size[2]])
			cube(size, center=true);

			// making the holes for the small straps

			//bottom
			translate([size[0]/3, (size[1]/2-strap_dfe)*-1,-size[2]])
			cube([mw_strap_small,mw_strap_w,20],center=true);

			//top			
			translate([(size[0]/3*-1),(size[1]/2-strap_dfe)*-1,-size[2]])
			cube([mw_strap_small,mw_strap_w,20],center=true);

			// making the holes for the big straps
			translate([0,(size[1]/2-strap_dfe),-size[2]])
			cube([mw_strap_big,mw_strap_w,20],center=true);

// Pretty edges to be added


	
		}

	}
	
}

//PART END: Side 2

//PART BEGIN: STRAPS

module smallStraps()
{
	difference()
	{
		union()
		{
			translate([0,0,0])
			cube([mw_strap_small-fit_tol,size[1]+size[2]*2,mw_strap_w-fit_tol],center=true);
			
			translate([-mw_strap_small*1.1,0,0])
			cube([mw_strap_small-fit_tol,size[1]+size[2]*2,mw_strap_w-fit_tol],center=true);
		}

		union()
		{
			translate([0,0,zshift])
			cube([mw_strap_small,size[1],mw_strap_w-strap_thk],center=true);
			
			translate([-mw_strap_small*1.1,0,zshift])
			cube([mw_strap_small,size[1],mw_strap_w-strap_thk],center=true);
		}
	}

}

module bigStraps()
{
	difference()
	{
		union()
		{
			translate([0,0,0])
			cube([mw_strap_big-fit_tol,size[1]+size[2]*2,mw_strap_w-fit_tol],center=true);
			
		}

		union()
		{
			translate([0,0,zshift])
			cube([mw_strap_big,size[1],mw_strap_w-strap_thk],center=true);
			
		}
	}

}

//END PART: Straps

//BEGIN PART: Text (for when print=="text")


module textOnly()

{	
if(part=="text")
{

		difference()	
		{
			union()
			{

translate([0,0,size[2]/2])
{
		//text line 1 	
			translate([text_position_side1*-1,0,size[2]-1])
			color("black")
			rotate(text_rot)
			write(text_line_1_side1,h=text_size,t=text_height,font=text_font,
				center=true);
		//text line 2
			translate([(text_size+2+(text_position_side1*-1)),0,size[2]-1])
			color("black")
			rotate(text_rot)
			write(text_line_2_side1,h=text_size,t=text_height,font=text_font,
				center=true);
		//text line 3
			translate([(2*(text_size+2)+(text_position_side1*-1)),0,size[2]-1])
			color("black")
			rotate(text_rot)
			write(text_line_3_side1,h=text_size,t=text_height,font=text_font,
				center=true);

}

translate([size[0]+4,0,size[2]/2])
{
			if(side2=="image")
				{

		
				translate([text_position_side2y*-1,text_postion_side2x,size[2]-1])
				color("black")
				scale([img_scale,img_scale,text_height]) 
				rotate(90)
				surface(file=side2_image, center=true, convexity=5);
		
				}
				else
				{
			//text line 1 	
				translate([text_position_side2y*-1,text_postion_side2x,size[2]-1])
				color("black")
				rotate(text_rot)
				write(text_line_1_side2,h=text_size,t=text_height,font=text_font,
				center=true);
			//text line 2
				translate([(text_size+2+(text_position_side2y*-1)),text_postion_side2x,size[2]-1])
				color("black")
				rotate(text_rot)
				write(text_line_2_side2,h=text_size,t=text_height,font=text_font,
				center=true);
			//text line 3
				translate([(2*(text_size+2)+(text_position_side2y*-1)),text_postion_side2x,size[2]-1])
				color("black")
				rotate(text_rot)
				write(text_line_3_side2,h=text_size,t=text_height,font=text_font,
				center=true);
				}
}

			}
			union()
			{
			translate([0,0,size[2]/2])
			cube(size,center=true);
			
			translate([size[0]+4,0,size[2]/2])	
			cube(size, center=true);
			}
		}
	}
		

		else
		{	
		}
}

//Print Parts

print_part();

module print_part() {
	if (part == "sides") {
		sides();
	} else if (part == "straps") {
		straps();
	} else if (part == "all") {
		all();
	} else if (part == "side1") {
		side1();
	} else if (part == "side2") {
		side2();
	} else if (part == "text") {
		justtext();
	} else {
		all();
	}
}

module all()
{
	translate([0,0,size[2]/2])
	magicWallet_side1();

	//move side 2 down 1 width + 4
	translate([size[0]+4,0,size[2]/2])
	magicWallet_side2();

	
		//move small straps to right of design by 1 length + 4 and rotate 90
		color("gray")
		translate([size[0]*.5,size[1]/2+1.1*mw_strap_small,(mw_strap_w-fit_tol)/2])
		rotate([0,180,90])
		smallStraps();

	
		//move big straps to left of design by 1.1 length and rotate 90
		color("gray")
		translate([size[0]*.5,(size[1]/2+1.1*mw_strap_big)*-1,(mw_strap_w-fit_tol)/2])
		rotate([0,180,90])
		bigStraps();
}

module sides()
{
	translate([0,0,size[2]/2])
	magicWallet_side1();

	//move side 2 down 1 width + 4
	translate([size[0]+4,0,size[2]/2])
	magicWallet_side2();
}

module straps()
{
		//move small straps to right of design by 1 length + 4 and rotate 90
		color("gray")
		translate([size[0]*.5,0,(mw_strap_w-fit_tol)/2])
		rotate([0,180,90])
		smallStraps();

	
		//move big straps to left of design by 1.1 length and rotate 90
		color("gray")
		translate([size[0]*.5, -(mw_strap_big+mw_strap_small),(mw_strap_w-fit_tol)/2])
		rotate([0,180,90])
		bigStraps();

}

module side1()
{
		magicWallet_side1();
}

module side2()
{
		magicWallet_side2();
}

module justtext()
{
	textOnly();
}
