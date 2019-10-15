use<write/Write.scad>;
//Volume
volume=5;
units = 0; //[0:ml,1:tsp,2:Tbsp,3:Cup,4:Fl.Oz]
wall_thickness = 3; //[0:20]
handle_length = 20; //[0:100]
//Depth Offset(100%=cube)
depth_offset = 100; //[75:200]
aspect_ratio = 100; //[0:1000]
text_margins = 10; //[0:25]
/* [Hidden] */
depthoffset=depth_offset/100;
names=["ml","tsp","Tbsp","Cup","FlOz"];
conv=[1000,4928.92159,14786.7648,236588.236,29573.5296];
cubicmm = volume*conv[units];
sideq = pow(cubicmm,(1/3));
w=sideq*depthoffset*aspect_ratio/100;
d=sideq*depthoffset/aspect_ratio*100;
h=cubicmm/(w*d);
hlen=handle_length+wall_thickness;
text_aspect_ratio=handle_length/h+wall_thickness;
union()
{
	difference()
	{
		cube([w+2*wall_thickness,d+2*wall_thickness,h+wall_thickness], center=true);
		translate([0,0,wall_thickness])
		{
			cube([w,d,h+1], center=true);
		}
	}
	translate([0,d/2+hlen/2,0])
	{
		cube([wall_thickness,hlen,h+wall_thickness],center=true);
	}
	writecube(str(floor(cubicmm/100)/10),[0,d/2+hlen/2,0],[wall_thickness,hlen,h+wall_thickness], face="left", up=(h+wall_thickness)/4, h=min((h+wall_thickness-text_margins)/2,handle_length/4));
	writecube("ml",[0,d/2+hlen/2,0],[wall_thickness,hlen,h+wall_thickness], face="left", down=(h+wall_thickness)/4, h=min((h+wall_thickness-text_margins)/2,handle_length/4));
	writecube(str(floor(volume*16)/16),[0,d/2+hlen/2,0],[wall_thickness,hlen,h+wall_thickness], face="right", up=(h+wall_thickness)/4, h=min((h+wall_thickness-text_margins)/2,handle_length/4));
	writecube(names[units],[0,d/2+hlen/2,0],[wall_thickness,hlen,h+wall_thickness], face="right", down=(h+wall_thickness)/4, h=min((h+wall_thickness-text_margins)/2,handle_length/4));
}