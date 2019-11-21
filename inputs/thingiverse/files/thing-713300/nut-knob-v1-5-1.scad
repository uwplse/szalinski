// 'Ultimate Nut Knob Generator' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// Version 1.5 (c) April 2015
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcoe
//
// V1.1: some smaller improvements and new parameter "supportless_friendly" and "screw_hole_length"
// V1.2: flip very long knobs (miniature hex handle) and new hex shape
// V1.5: new support of tetragon up to octagon nuts
//       new wing shape
//       error in calulation of nuts fixed (relevant on bigger ones)
// V1.5.1: Global fix for latest Customizer

// preview[view:west, tilt:top diagonal]

//to show in Customizer - you get always all parts!
part = "cylindrical"; // [hex,simple,cylindrical,clamp,rounded,wing]

//across flats (M3 = 5.42, Allen = 6.35)
nut_width = 5.42;
nut_thickness = 2.5;

//of knob
height=10;

// in percent of knob height
knurled_height=50; //[10:100]

/*[Advanced]*/
echo("nut_diameter",nut_diameter);

// calculated relative to hex nut diameter
diameter_1=150; //[100:300]
function get_diameter_1()=hex_nut_diameter*diameter_1/100;

// in percent of Diameter 1 
diameter_2=125; //[100:200]
function get_diameter_2()=get_diameter_1()*diameter_2/100;

// in percent of nut diameter
screw_hole_diameter = 55; //[0:100]
function get_screw_hole_diameter()=nut_diameter*screw_hole_diameter/100;

// in percent of knob height
screw_hole_length = 100; //[0:100]
function get_screw_hole_length()=height*screw_hole_length/100;

// should be multiple of layer thickness (0.6 should be perfect for 0.1, 0.2, 0.3mm layer thickness). Use 0 for open bottom like the screwdriver handle
bottom_thickness = 0.6;

/*[Knurled]*/
//no effect on wing style
knurled_density=50; //[0:100]

knurled_strong=5;//[1:20]

/*[Expert]*/

//- tetragon=4, pentagon=5, hexagon=6, octagon=8
nut_sides=6;//[4,5,6,8]

// prevented some extreme overhangs
supportless_friendly=1; //[0:false,1:true]

//increase if it fits to tight
backlash=0.1;

cross_section=0; //[0:false,1:true]

/*[Hidden]*/
function get_knurled_n()= (
    part=="hex" ? 6 : (
    part=="wing" ? 2 : (
    round(sqrt(10*get_diameter_2())*get_knurled_density_factor()))));
    
function get_knurled_density_factor()=pow(10,knurled_density/50-1);
echo("get_knurled_density_factor()", get_knurled_density_factor());

nut_diameter = nut_width/cos(360/nut_sides/2);
hex_nut_diameter = nut_width/cos(360/6/2);

knurled_r=sqrt(10*get_diameter_2())/40*knurled_strong;

h1=height-height*knurled_height/100;
hlist=[0,h1/5,h1*2/5,h1*3/5,h1*4/5,h1,height];
rstep=[0,pow(0.2,2),pow(0.4,2),pow(0.6,2),pow(0.8,2),pow(1.0,2),pow(1.0,2)];
rlist=rstep*(get_diameter_2()-get_diameter_1());

if(height-h1-2.1*knurled_r>0||part!="rounded")
rotate(nut_width*5<height?[0,90,0]:(bottom_thickness==0.0?[180,0,0]:[0,0,0]))
union()
{
	difference()
	{
		union()
		{
			create_knurled();
	
			for(n=[0:5])
			translate([0,0,hlist[n]])
			cylinder(r1=(get_diameter_1()+rlist[n])/2,r2=(get_diameter_1()+rlist[n+1])/2,h=hlist[n+1]-hlist[n],$fn=60);
		}
	
		if(get_screw_hole_diameter()>0&&screw_hole_length>0)
		translate([0,0,-.1])
		cylinder(r=get_screw_hole_diameter()/2+backlash,h=get_screw_hole_length()+.11,$fn=20);

		assign(r1=1.0*nut_diameter/2+backlash)
		assign(r2=0.95*nut_diameter/2+backlash)
		assign(r3=1.05*nut_diameter/2+backlash)
		assign(h1=bottom_thickness)
		assign(h2=h1+nut_thickness-0.04*nut_diameter)
		assign(h3=h1+nut_thickness-0.01*nut_diameter)
		assign(h30=h1+nut_thickness)
		assign(h4=h1+nut_thickness+.1*nut_diameter)
		assign(h5=h4+.2*nut_diameter)
		assign(h6=max(h5,height))
        rotate([0,0,360/nut_sides/2])
		rotate_extrude($fn=nut_sides)
		if(bottom_thickness>0)
		polygon(points=[[r1,h1],[r1,h2],[r2,h3],[r2,h4],[r3,h5],[r3,h6+.1],[0,h6+.1],[0,h1]]);
		else
		polygon(points=[[r1,h1-.1],[r1,h30],[0,h30],[0,h1]]);
	
		if(cross_section)
		translate([-1000/2,0,-.1])
		cube([1000,1000,100]);
	}
}
else
for(a=[-45,45])
rotate([0,0,a])
cube([1,10,0.2],center=true);

module create_knurled()
translate([0,0,h1])
difference()
{
	if(part=="simple")
	create_simple_knurled();
	else if(part=="hex")
    hull()
	create_shaped_knurled();
	else if(part=="clamp")
	create_knurled_clamp();
    else if(part=="wing")
    create_wings();
	else
	create_shaped_knurled();

	assign(points=[[get_diameter_2()/2,-.01],[get_diameter_2()/2+1000,1000/2],[get_diameter_2()/2+1000,-.01]])
	if(part!="rounded"&&bottom_thickness!=0.0&&supportless_friendly==1)
	rotate_extrude($fn=60)
	polygon(points);
}

module create_knurled_clamp()
difference()
{
	cylinder(r=(2*knurled_r+get_diameter_2())/2,h=height-h1,$fn=60);

	for(a=[0:get_knurled_n()-1])
	rotate(360/get_knurled_n()*a)
	translate([get_diameter_2()/2+knurled_r,0,-.1])
	cylinder(r=knurled_r,h=height-h1+.2,$fn=30);
}

module create_simple_knurled(fn=4)
assign(n=round(get_knurled_n()/2))
for(a=[0:n-1])
rotate(360/fn/n*(a+.5))
cylinder(r=(2*knurled_r+get_diameter_2())/2,h=height-h1,$fn=fn);

module create_shaped_knurled()
for(a=[0:get_knurled_n()-1])
rotate(360/get_knurled_n()*(a+.5))
translate([get_diameter_2()/2,0,0])
if(part=="rounded"||part=="hex")
hull()
create_knurled_rounded();
else if(part=="cylindrical")
create_knurled_cylindrical();

module create_knurled_rounded()
for(z=[knurled_r,height-h1-knurled_r])
translate([0,0,z])
sphere(r=knurled_r,$fn=20);

module create_knurled_cylindrical()
cylinder(r=knurled_r,h=height-h1,$fn=20);

module create_wings()
assign(len=knurled_r*get_diameter_2()*.7)
linear_extrude(height=height-h1,convexity=20)
hull()
{
    circle(r=get_diameter_2()/2,$fn=60);
        
    for(a=[0:1])
    rotate(360/get_knurled_n()*(a+.5))
    translate([len,0,0])
    circle(r=get_diameter_2()/4,$fn=30);
}
