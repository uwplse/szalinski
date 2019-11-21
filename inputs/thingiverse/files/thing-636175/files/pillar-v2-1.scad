// 'Pillar Set for Märklin H0 C-Track' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// Version 2.1 (c) March 2017
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcoe

use <write/Write.scad>

/* [Basic] */

// Which part would you like to see?
part = "ramp"; // [top:only top level pillar,ramp:complete set for one ramp]

//number of pillars for one ramp. default=12
pillar_count=12;

//top level height. default=78mm
max_height = 78;

//Text on top level pillar. default=RepRap
top_level_text="RepRap";

/* [Expert] */
//adjust this value if the track does not fit, should be tight! default=46mm
tie_width = 46;

//Track segment lenght between two pillars 172..188 should be perfect. default=188mm
segment_length=188;

//default=true
make_groove_for_7224_on_top_level_pillar=1; //[1:true, 0:false]

/* [Hidden] */

degree = asin(max_height/segment_length/pillar_count);
echo("degree: ", degree);

first=1;
last=pillar_count;

if(part == "top")
render(top_level_text, max_height, tie_width, 0, 0, make_groove_for_7224_on_top_level_pillar, top=true);
else
render_set(false);


module render_set(groove_for_7224) {
	pillar_delta=max_height/pillar_count;

	for(i=[first:last])	
	assign(height=i*pillar_delta)
	assign(x=25*(floor((i-1) % (pillar_count / 2) + 1)))
	assign(y=70*(floor((i-1) / (pillar_count / 2))))
	translate([x,y,0])
	render(str(i),height, tie_width, degree, i == pillar_count ? 0 : degree, groove_for_7224);
}

label_thickness = 0.6;
label_height = 7;
label_font="orbitron.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf,braille.dxf]

module pillar(height = 4, scale_x = 1, scale_y = 0.6) {
	rad = 5;
	plate = 2;

	top_diameter = 2*rad;
	bottom_diameter = 2*rad+height/10;
	plate_diameter = bottom_diameter + 2*rad + 2*plate;
	wall_thick = 1.55;

	difference()
	{
		union() 
		{
			scale([scale_x,scale_y,1]) 
			{
				cylinder(h=plate, r=plate_diameter/2);
				translate([0,0,plate])
					cylinder(h=plate/2, r1=plate_diameter/2, r2=(bottom_diameter+plate)/2);
			}
			scale([scale_x,scale_y,1]) hull() 
			{
					translate([0,0,height-1.5])
						resize([top_diameter, top_diameter, 0])
						cylinder(h=.1, r=bottom_diameter/2);
					translate([0,0,0.5])
						cylinder(h=.1, r=bottom_diameter/2);	
			}
		}
	}
}

module tie(width = 77.5, groove = 1, degree1 = 0, degree2 = 0, groove_for_7224 = false) 
{
	 rad = 7.5;
	 thick = 1;
	 bedwidth = 40;
	 
	 difference()
	 {
		 union()
		 {
				 difference()
				 {
						hull()
						{
							translate([0,0,-rad]) 
							cylinder(rad,thick/2,rad);

							translate([0,width,-rad])
							cylinder(rad,thick/2,rad);
						}
						translate([0,width/2,thick+rad]) 
						cube([width,2*width,2*thick+2*rad],center=true);
				 }

				// halter
				difference() {
					translate([0,width/2,3/2]) 
					cube([2*rad, bedwidth+2*3, 3], center=true);

					if(groove_for_7224)
					translate([0,width/2,0]) 
					cube([2, 65, 10],center=true);
				 }
		 }
		 trackbed(width, bedwidth, groove, degree1, 1); 
		 trackbed(width, bedwidth, groove, degree2, -1); 

	 } 
}

module trackbed(width = 77.5, bedwidth = 40, groove = 1, degree1 = 0, factor = -1) 
// Trackbed
translate([0,(width-bedwidth)/2,-groove])
rotate([0,-90-degree1,0])
translate([0,0,factor*9.5])
linear_extrude(height=20, center=true, convexity=10) 
polygon(points = [ [0, 0], [bedwidth/2*tan(60), bedwidth/2], [0,bedwidth] ], faces = [ [0, 1, 2] ]);

module helper(width = 77.5, height) 
{
	rotate([0,-90,0])
	linear_extrude(height=1, center=true, convexity=10)
		polygon(points = [[0, 0], [2, 0], [2, width], [0, width], [-width/3,width/2] ]);
}

module noarch(height = 4, width = 77.5) {
	 rad = 7.5; //from module tie
	 thick = 3;

	 translate([0,0,height-rad])
	 helper(width);
}

module render(text, height = 72, width = 46, degree1 = 0, degree2 = 0, groove_for_7224 = false, top = false) {
	difference() {
		union() {
			translate([0,width/2,0])
			rotate([0,0,90])
			pillar(height,1.5,.5);
 

			translate([0,0,height])
			difference()
			{
				tie(width, 0, degree1, degree2, groove_for_7224);

				if(!top)
				for(a=[-tie_width/4,tie_width/4])		
				translate([0,width/2+a,-label_thickness]) 
				rotate([degree,0,60])
				cylinder(r=4,h=5,$fn=3);

				translate([0,width/2,-label_thickness+2/2]) 
				rotate([degree,0,-90])
				write(text, h=label_height, t=2, font=label_font, center=true);
			}

			noarch(height,width);
		}
		translate([0,width/2,-width])
		cube([20,2*width,2*width],center=true);

		translate([0,width/2,0])
		rotate([180,0,-90])
		write(str(round(10*height)/10), h=label_height, t=label_thickness*2, font=label_font, center=true);
	}
}

