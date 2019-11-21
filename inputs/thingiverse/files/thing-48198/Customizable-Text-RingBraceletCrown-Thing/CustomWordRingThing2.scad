use <write/Write.scad>


/* [Text] */
text = "TEXT";
rounded_text = "yes";//[yes,no]
letters_inside = "no";//[yes,no]
text_font = "write/Letters.dxf";//[write/Letters.dxf,write/orbitron.dxf,write/knewave.dxf,write.braille.dxf,write/Blackrose.dxf]

/* [Text Size] */

font_Width = 3;//[1:20]
text_percent_of_height = 70;//[1:100]
letter_spacing = 22;//[1:40]

/* [Ring Size] */

inside_diameter = 20;//[1:200]
Width = 5;//[1:50]
Height = 10;//[1:100]
band_OD_percent = 70;//[1:100]
band_ID_percent = 100;//[1:100]

/* [Style] */

band_type = "rounded";//[tube,rounded,sharp]
split_band = "no";//[yes,no]
split_angle = 70;//[10:130]

ID = inside_diameter;
band_OD_scalar = band_OD_percent/100;
band_ID_scalar = band_ID_percent/100;
Text_Height_Scalar = text_percent_of_height/100;
Spacing = letter_spacing/20;
OD = ID+(2*Width);
Text_Width = 10*Height/font_Width;

// preview[view:south west, tilt:top diagonal]
rotate([0,0,-225])
if (split_band == "yes")
{
	difference()
	{
		ring();
		difference()
		{
			difference()
			{
			linear_extrude(height = Height*2,center = true,convexity = 10)
			polygon(points=[[0,0],
						 	    [(ID+Width)*sin(split_angle),-(ID+Width)*cos(split_angle)],
					  	 		 [(ID+Width),-(ID+Width)],
						 		 [-(ID+Width),-(ID+Width)], 
	                		 [-(ID+Width)*sin(split_angle),-(ID+Width)*cos(split_angle)]],
	              paths = [[0,1,2,3,4]]);
	
			rotate([0,0,-split_angle])
			translate([0,-((OD+ID)/2-(OD-ID)/2*band_ID_scalar+(OD+ID)/2+(OD-ID)/2*band_OD_scalar)/4,0])
			scale([(Width+Height)/1,Width,Height])
			sphere(r=band_type=="sharp" ? 0.7:0.55,$fn = 30);
			}
		rotate([0,0,split_angle])
		translate([0,-((OD+ID)/2-(OD-ID)/2*band_ID_scalar+(OD+ID)/2+(OD-ID)/2*band_OD_scalar)/4,0])
		scale([(Width+Height)/1,Width,Height])
		sphere(r=band_type=="sharp" ? 0.7:0.55,$fn = 30);
		}
	}
}
else
{
	ring();
}

module ring()
{
	union()
	{
		color("MediumBlue")
		difference()
		{
			difference()
			{
				scale([OD/Text_Width/2,OD/Text_Width/2,1*Text_Height_Scalar])
				writecylinder(text,[0,0,0],Text_Width,0,space=Spacing,rotate=0,east=180,h=Height*0.9,t=Text_Width*2,font = text_font);
				
				if (letters_inside == "yes")
				{
					cylinder(r=ID/2,h=Height*2,center=true,$fn=50);
				}
				else
				{
					cylinder(r=(ID+OD)/4,h=Height*2,center=true,$fn=50);
				}
			}
			if (rounded_text == "yes")
			{
		   	difference()
				{
					difference()
					{
						cylinder(r=OD*2,h=Height*2,center = true,$fn = 50);
						cylinder(r=(ID+OD)/4,h=Height*3,center=true,$fn = 50);
					}
					donut(ID,OD,Height);
				}
			}
			else
			{
				difference()
				{
					cylinder(r=OD*2,h=2*Height,center = true,$fn=50);
					cylinder(r=OD/2,h=3*Height,center = true,$fn=50);
				}
			}
		}
		if (band_type == "rounded")
		{
			donut((OD+ID)/2-(OD-ID)/2*band_ID_scalar,(OD+ID)/2+(OD-ID)/2*band_OD_scalar,Height);
		}
		if (band_type == "sharp")
		{
			tube((OD+ID)/2-(OD-ID)/2*band_ID_scalar,(OD+ID)/2+(OD-ID)/2*band_OD_scalar,Height); //tube, flat ID
		}
		if (band_type == "tube")
		{
			donut((OD+ID)/2-(OD-ID)/2*band_ID_scalar,(OD+ID)/2+(OD-ID)/2*band_OD_scalar,(OD-ID)/4*(band_ID_scalar+band_OD_scalar));
		}
	}	
}
module donut(ID,OD,height)
{
	//translate([0,0,0])
	scale([1,1,height/((OD-ID)/2)])
	rotate_extrude(convexity = 10,$fn = 50)
	translate([(ID+OD)/4,0,0])
	rotate(r=[0,90,0])
	circle(r=((OD-ID)/2)*0.5,$fn = 20);	
}

module tube(ID,OD,height)
{
	difference()
	{
		cylinder(r=OD/2,h=height,center = true,$fn=50);
		cylinder(r=ID/2,h=height+1,center=true,$fn=50);
	}
}
































