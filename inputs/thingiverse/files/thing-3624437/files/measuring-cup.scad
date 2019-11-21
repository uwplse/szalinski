// 'Measuring Cup' Version 1.0 by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// (c) December 2014 
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode

//Modified 5/11/2019 to make Customizer work without errors (I hope) by J.P. Cuzzourt
//I renamed 'wall_thickness_' to 'wall_thickness'
//& renamed 'wall_thickness' to 'wall_thickness_adjusted'
//The effect of the word 'thickness' enclosed in underscore characters on the Thingiverse site is to italicize 'thickness'!
//I also edited the code to eliminate the use of the deprecated assign() function calls and replaced them with direct assignments
//While Customizer still times out, it does create the customized item now.

/*Update - later that night (5/11/2019)- JPC
    In further testing I noticed that
    if user entered a number for the label1_text or label2_text in Customizer, it changes the data type from string
    and fails to place the text on handle.
    Since the variable are only used in one place in the code, I just wrapped the assignment with a call to str() as follows:
    labels=[
        [0,str(label1_text),label1_font,label1_height,label_thickness],
        [1,str(label2_text),label2_font,label2_height,label_thickness],
        ];
*/


use <write/Write.scad>

/* [Size] */
// unit of measurement 
unit=1.0; // [1.0:ml, 16.387064:cubic inch (international inch), 28.4130625:imperial fluid ounce (Imp.fl.oz.), 29.5735295625: US fluid ounce (US fl.oz.)]

// capacity of the cup
volume=62.5;


label1_text="";
label2_text="";

/* [Font] */

// default: 1.5
label_thickness = 1.5;

//default: 8.0
label1_height = 8.0;

//default: orbitron.dxf
label1_font="orbitron.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf,braille.dxf]

//default: 8.0
label2_height = 8.0;

//default: orbitron.dxf
label2_font="orbitron.dxf"; //[orbitron.dxf,Letters.dxf,knewave.dxf,BlackRose.dxf,braille.dxf]


/* [Advanced] */

// If the printed size does to much differ, you can adjust here. It is easy to calculate: [desired volume] / [printed volume] -> adjust.
adjust=1;

// default: 1.0 (should be enough up to 100ml)
wall_thickness=1.0; 


/* [Hidden] */

// set to true, to get a model of the content volume. This can be measure with MeshLab or other tools
build_measure_volume_reference=0; // [1:true, 0:false]

// this is the unscaled cup volume (calculated with MeshLab) 
ref_volume=137.2013;


r_fn=12;  // used for $fn


labels=[
[0,str(label1_text),label1_font,label1_height,label_thickness],
[1,str(label2_text),label2_font,label2_height,label_thickness],
];

volume_ml=volume*unit;
echo("capacity in ml:", volume_ml);

// calculate correct scale to get the exact volume 
factor=pow(volume_ml/ref_volume*adjust,1/3);
wall_thickness_adjusted=wall_thickness/factor;
echo("factor: ",factor);

r1=1;
r2=r1+wall_thickness_adjusted;

y0=-35;
y1=0;
y3=45;

y4=68;

x0=0;
x1=19;
x2=29;
x3=30;
x5=16;

z0=0;
z1=-45;
z2=-5;

y2=-z1+y0;
y01=y0+(r2-r1);
y31=y4+(y3-y4)*2/3;

x4=(y1-y0)/(y2-y0)*(x3-x5)+x5;
x11=x1+(x2-x1)/2;

z3=-(r2-r1);
z4=y0;

bottom_factor=0.7;
handle_factor=0.9;

// cup points
cup_points=[
[x1,y4,z0],
[x2,y3,z0],
[x3,y2,z0],
[x4,y1,z0],
[-x4,y1,z0],
[-x3,y2,z0],
[-x2,y3,z0],
[-x1,y4,z0],
[x11*bottom_factor,y31,z1],
[x2*bottom_factor,y3-2,z1],
[x3*bottom_factor,y2,z1],
[x4*bottom_factor,y1+3,z4-3],
[-x4*bottom_factor,y1+3,z4-3],
[-x3*bottom_factor,y2,z1],
[-x2*bottom_factor,y3-2,z1],
[-x11*bottom_factor,y31,z1],
];

// handle points
handle_points=[
[x4*handle_factor,y1,z2],
[x4,y1,z0],
[x5,y0,z0],
[x5*handle_factor,y01,z3],
[-x5*handle_factor,y01,z3],
[-x5,y0,z0],
[-x4,y1,z0],
[-x4*handle_factor,y1,z2],
];

//build cup
rotate([45,0,0])
scale([1,1,1]*factor)
build_cup(cup_points);

module build_cup(points)
intersection()
{
	translate([0,0,z1-r2])
	linear_extrude(height=abs(z1)+r2,convexity=10)
	polygon([
	[-x3-r2-.1,y0-r2-.1],
	[x3+r2+.1,y0-r2-.1],
	[x3+r2+.1,y4+r2+.1],
	[-x3-r2-.1,y4+r2+.1],
	]);

	difference()
	{
		if(!build_measure_volume_reference)
		union()
		{
			build_handle(handle_points);

			handle_outline(points, r=r2);
		}

		handle_outline(points, r=r1);
	}
}



module build_handle(points){
a=-atan((z3-z2)/(y1-y01));
difference()
{
	union()
	{
		translate([0,y0,0])
		rotate([-45,0,0])
		translate([-(y1-y0)/2/2,0,-r2])
		cube([(y1-y0)/2,(y1-y0)/3,y1-y0],center=0);

		handle_outline(points, r=r2);
	}
	
	difference()
	{
		handle_outline(points, r=r1);

		for(label=labels)
		build_label(label[0],label[1],label[2],label[3],label[4]);
	}
}
}

module build_label(idx, text, font, height, thickness){
n=4;
xd=(x4-x5)/(n+1); yd=(y1-y01)/(n+1); zd=(z2-z3)/(n+1);
r=yd/4;
if(len(text)>0)
{
	// write label
	rotate([-atan((z3-z2)/(y1-y01)),0,0])
	translate([0,-11.5-idx*2*yd,z2-r1-.1])
	minkowski()
	{
		write(text, h=height, t=.1, font=font, center=true);
	
		cylinder(r1=wall_thickness_adjusted/4,r2=0,h=thickness,$fn=4);
	}
}
else
{
	// no labe? Then build riffle
	for(a=[0.7+(1-idx)*2:n-idx*2])
	hull()
	for(m=[0,1])
	mirror([m,0,0])
	translate([x5+xd*a-yd,y01+yd*a,z3+zd*a-r/2])
	sphere(r=r,$fn=r_fn);
}
}

module handle_outline(points, r) {
hull()
for(p=points)
translate(p)
sphere(r=r,$fn=r_fn);
}
