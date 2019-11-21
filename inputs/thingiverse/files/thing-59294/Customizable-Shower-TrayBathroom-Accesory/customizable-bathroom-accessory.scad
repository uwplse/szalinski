use <utils/build_plate.scad>

//preview[view:east,tilt:top]

/*Customizer Variables*/

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic]

your_thing = 3; // [1:Clip,2:Soap Tray/Bowl,3:Shower Tray]
tray_width_corners = 1; // [1:YES,2:NO]
//Width of the tray in cm   min:3  max:50
tray_width=7.5;
//Length of the tray in cm  min:3 max:50
tray_length=4;
//Height of the tray in cm min:0.225
tray_height=1.75;
//Diameter of your bar in mm min:5 max:50 
diameter_bar=19.25;
//Height of the main part of the clip in cm
height_clip=1.75;
//Height of the two cylinders in cm
height_cylinders=2.15;

pattern_shape = 6; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]
//in mm:
pattern_radius = 8; //[4:22]
pattern_overlap = 15; //[0:100]
//in degrees:
pattern_rotation = 0; //[0:180]
//in .4 mm increments:
pattern_thickness = 4; //[2:30]



/*Non customizer variables*/

honeycomb_radius = pattern_radius;
honeycomb_radius_modifier = pattern_overlap;

honeycomb_sides = pattern_shape;


honeycomb_rotation = pattern_rotation;

line_thickness = pattern_thickness;
honeycomb_thickness = line_thickness*.4;


//Constants
cm_faktor=10;
wall_thickness=0.4*cm_faktor;
r_c=2.02; // radian of the two small cylinders

// Variables for shower tray
w=tray_width*cm_faktor;
l=tray_length*cm_faktor;
h_t=tray_height*cm_faktor;
corner=tray_width_corners; //if 0 then cube else cube_rounded
pattern_width=w*4;	
pattern_length=l*4;
pattern_height=9.34/1;

//Variables for bar_clip
h_e1=height_clip*cm_faktor; // height of the main cylinder
h_e2=height_cylinders*cm_faktor; // height of the two small cylinders
d=diameter_bar/2; //diameter of the bar in mm



build_plate(build_plate_selector);

if (your_thing==1) 
{
 bar_clip(h_e1,h_e2,d,r_c);
} 
else if (your_thing==2)
{
 union()
{
tray(w,l,h_t);
pattern();
}

}
else if (your_thing==3)
{
union(){
 union()
{
bar_clip(h_e1,h_e2,d,r_c);
tray(w,l,h_t);
}
pattern();
}

}








module bar_clip(h1,h2,r1,r2)
{
translate([0,r1+0.2,0])union()
{
	difference()
	{
		difference()
		{
			cylinder(h1,r1+2.5,r1+2.5);
			translate([0,0,-1])cylinder(h1+2,r1,r1);
		}
	
		translate([-r1*2,r1*0.6,-1])cube([r1*4,r1*2,h1+2]);
	}
	
	rotate([0,0,35])translate([r1+1.25,0,0])cylinder(h2,r2,r2);
	rotate([0,0,145])translate([r1+1.25,0,0])cylinder(h2,r2,r2);
}
}


module roundedrectangle(width,length,height,r1)
{

module cross()
{
	union()
	{
	translate([0,r1,0])cube([width,length-(r1*2),height]);
	translate([r1,0,0])cube([width-(r1*2),length,height]);
	}
}

union()
{
cross();
translate([r1,r1,0])cylinder(height,r1,r1);
translate([width-r1,r1,0])cylinder(height,r1,r1);
translate([r1,length-r1,0])cylinder(height,r1,r1);
translate([width-r1,length-r1,0])cylinder(height,r1,r1);
}
}

module tray(width,length,height)
{
difference()
{

if (corner==2) 
{  
	translate([-(width+wall_thickness*2)/2,-(length+wall_thickness*2),0])cube([width+wall_thickness*2,length+wall_thickness*2,height]);
} else { 
	translate([-(width+wall_thickness*2)/2,-(length+wall_thickness*2),0])roundedrectangle(width+wall_thickness*2,length+wall_thickness*2,height,1.75);
}


translate([-width/2,-length-wall_thickness,-1])cube([width,length,height+2]);






}
}






module honeycomb(w,l,h,r,rmod,th,sides){
	
	columns = l/(r*3)+1;
	rows = w/(r*sqrt(3)/2*2);

	translate([-w/2,l/2,0])
		rotate([0,0,-90])
			for(i = [0:rows]){
				
				translate([0,r*sqrt(3)/2*i*2,0])
				//scale([1*(1+(i/10)),1,1])
					for(i = [0:columns]){
						translate([r*i*3,0,0])
							for(i = [0:1]){
								translate([r*1.5*i,r*sqrt(3)/2*i,0])
									rotate([0,0,honeycomb_rotation])
									difference(){
										if(sides < 5){
											cylinder(height = h, r = r+th+(r*rmod/50), center = true, $fn = sides);
										} else {
											cylinder(height = h, r = r+(r*rmod/50), center = true, $fn = sides);
										}
										cylinder(height = h+1, r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
							}
					}
			}
}










module pattern(){

translate([0,0,-2.4])difference()
{
union()
{
	intersection()
		{
		translate([-(w+wall_thickness)/2,-(l+wall_thickness+0.5*wall_thickness),0])cube([w+wall_thickness,l+wall_thickness,4.8]);
		scale([1,1,10])honeycomb(pattern_width,pattern_length,pattern_height,honeycomb_radius,honeycomb_radius_modifier,honeycomb_thickness,honeycomb_sides);
		}
}
translate([-(w+wall_thickness+0.1)/2,-(l+wall_thickness+0.5*wall_thickness)-0.05,-0.1])cube([w+wall_thickness+0.1,l+wall_thickness+0.1,2.5]);
}



}

