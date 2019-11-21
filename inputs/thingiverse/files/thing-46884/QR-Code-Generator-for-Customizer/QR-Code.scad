//////////VARIABLE DECLARATIONS//////////

//preview[view:north east, tilt: top diagonal]

//QR Code Data Display Method
add_sub = 2; //[1:Subtract QR Geometry,2:Add QR Geometry]

//QR Code Mirroring. No: QR code is scanable from top of object. Yes: QR code is scanable from bottom of object. NOTE: Code is already flipped for iPhone cases so it will be scanable from back of iPhone case.
code_flip = 0; //[0:No,1:Yes]

//Select Main Object
obj = 1; //[0:QR data only,1:Rectangle,2:iPhone 4,3:iPhone 5,4:Rectangle with hole]

//Thickness option for iPhone cases
case_thickness = 1.8; //[1.8:Slim,2.4:Sturdy]

//For rectangles only (will also round perimeters)
round_corner = 1; //[1:No,2:Yes]

//Two opposite corners or all four corners
corner_num = 0; //[0:Two,1:Four]

//For rectangles and perimeters only (will also round perimeters) (mm)
corner_radius = 10; 

//Width of object (mm)
tag_width = 80;

//Height of object (mm)
tag_height = 80;

//Thickness of object (mm)
tag_thickness = 3;

//X Location of hole center (for rectangle with hole) (mm)
hole_x = 30;

//Y Location of hole center (for rectanlge with hole) (mm)
hole_y = 0;

//Radius of hole (for rectanlge with hole) (mm)
hole_r = 10;

//Distance from tag edge. "-1000" for none. (works with all models, but uses tag_width, tag_height plus perimeter dimensions for size) (mm)
perimeter = -1000;

//Wall thickness of perimeter (mm)
per_w = 3;

//Wall height of perimeter (mm)
per_h = 10;

//Scale multiplier for code (base size: 1mm cubes make each code block) (multiplier)
qr_scale = 1.6;

//(DO NOT PUT IN 0 customizer won't generate stl, instead put in a very small value like 0.001 for no tolerance) Use for making a positive and negative assembly (+val makes code blocks bigger) (mm)
qr_tolerance = 0.001;

//X location of QR code center (mm)
qr_x = 0;

//Y location of QR code center (mm)
qr_y = 0;

//Z location of bottom of QR code gemometry (mm)
qr_bottom = 1;

//Thickness of QR code (mm)
qr_thickness = 5;

//Rotate QR code around z-axis (deg)
qr_rotate = 0;

//Input from data generator for dimention of QR code (copy and paste from QR SIZE.txt)
qr_size = 41;

//Input raw QR data matrix here (copy and paste from QR DATA.txt) ("5" will make a rectangle the size of the QR code bounding box driven by qr_size value entered above. NOTE: rectangle will be slightly larger than actual code data due to "white" pixels around QR code in image)
qr_data = 5;

qr_num = qr_size*qr_size;


//////////GEOMETRY MANIPULATION//////////

//Just qr data
if (obj == 0)
{
	qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
	if (perimeter != -1000)
	{
		perimeter();
	}
}

//Basic rectangle tag
if (obj == 1)
{
	if (add_sub == 1)
	{
		difference()
		{
			rec_tag(tag_width, tag_height, tag_thickness);
			qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
		}
	}
	if (add_sub == 2)
	{
		union()
		{
			rec_tag(tag_width, tag_height, tag_thickness);
			qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
		}
	}
	if (perimeter != -1000)
	{
		perimeter();
	}
}

//iPhone 4
if(obj == 2)
{
	if (add_sub == 1)
	{
		difference()
		{
			iPhone4Case();
			translate([0,0,qr_thickness-.1])
			rotate([180,0,0])
			qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
		}
	}
	if (add_sub == 2)
	{
		union()
		{
			iPhone4Case();
			translate([0,0,qr_thickness-.1])
			rotate([180,0,0])
			qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
		}
	}
}


//iPhone 5
if(obj == 3)
{
	if (add_sub == 1)
	{
		difference()
		{
			iPhone5Case();
			translate([0,0,qr_thickness-.1])
			rotate([180,0,0])
			qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
		}
	}
	if (add_sub == 2)
	{
		union()
		{
			iPhone5Case();
			translate([0,0,qr_thickness-.1])
			rotate([180,0,0])
			qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
		}
	}
}


//Rectangle with hole
if (obj == 4)
{
	if (add_sub == 1)
	{
		difference()
		{
			rec_tag(tag_width, tag_height, tag_thickness);
			qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
			translate([hole_x, hole_y, 1])
			cylinder(h=(2*tag_thickness), r=hole_r, center=true);
		}
	}
	if (add_sub == 2)
	{
		difference()
		{
			union()
			{
				rec_tag(tag_width, tag_height, tag_thickness);
				qr_mover(qr_x, qr_y, qr_bottom, qr_rotate, qr_scale);
			}
			translate([hole_x, hole_y, 1])
			cylinder(h=(2*tag_thickness), r=hole_r, center=true);
		}
	}
	if (perimeter != -1000)
	{
		perimeter();
	}
}


//////////MODULE DEFINITIONS//////////

module qr_volume(size, num, data, thickness, tol)
{
	if (qr_data == 5)
	{
		color("Snow")
		translate([0, 0, thickness/2])
		cube([size, size, thickness], center=true);
	}
	else
	{
		color("DarkGrey")
		union()
		{
			for(i = [1:1:num])
			{
				if(data[i-1] == 1)
				{
					translate([(floor(i/size)-(qr_size/2)),(i-(size*floor(i/size))-1-(qr_size/2)), 0])
					cube([1+tol, 1+tol, thickness],center=[.5,.5,0]);
				}
			}
		}
	}
}

module qr_mover(x, y, z, rotate, scale)
{
	translate([x,y,z])
	rotate([0, 0, rotate])
	scale([scale, scale, 1])
	mirror([0, code_flip, 0])
	qr_volume(qr_size, qr_num, qr_data, qr_thickness, qr_tolerance);
}

module corner_rounder(w, h, t)
{
	for (c = [0:1:corner_num])
	{
		union()
		{
			mirror([0, c, 0])
			difference()
			{
				translate([w/2, h/2, t/2])
				cylinder(h=t*2, r=corner_radius, center=true);
				translate([(w/2)-corner_radius, (h/2)-corner_radius, t/2])
				cylinder(h=t*3, r=corner_radius, center=true);
			}
			mirror([0, c, 0])
			difference()
			{
				translate([-w/2, -h/2, t/2])
				cylinder(h=t*2, r=corner_radius, center=true);
				translate([-(w/2)+corner_radius, -(h/2)+corner_radius, t/2])
				cylinder(h=t*3, r=corner_radius, center=true);
			}
		}
	}
}

module rec_tag(t_w, t_h, t_t)
{
	difference()
	{
		translate([0, 0, (t_t/2)])
		cube([t_w, t_h, t_t], center=true);
		if (round_corner == 2)
		{
			corner_rounder(t_w, t_h, t_t);
		}
	}
}

module perimeter()
{
	difference()
	{
		rec_tag(tag_width+perimeter+per_w, tag_height+perimeter+per_w, per_h);
		translate([0, 0, -1])
		rec_tag(tag_width+perimeter, tag_height+perimeter, per_h+2);
	}
}




//////////MAKERBOT IPHONE CASE//////////


/*Non customizer variables*/
caseThickness = case_thickness;
caseTolerance = .2/1;

4width=58.55/1;	
4length=115.15/1;
4height=9.34/1;
4cornerR = 8.77/1;
4swidth=6.17/1;
4sthick=.6/1;

5width = 57.57/1;
5length = 122.83/1;
5height = 7.6/1;
5cornerR = 9.28/1;
5sthick = 1.44/1;
5swidth = 5height - 5sthick*1.5;

heightvar=.24/1;

homebuttonR = 5.6/1;
homebuttonD = homebuttonR*2;

top_bottom_opening_width = 50/1;
leftholelength = 25.43/1;
leftholeR = 2.4/1;
topholelength = 38.57/1;
topholeR = 2.5/1;
bottomholelength1 = 43.97/1;
bottomholelength2 = 26.05/1;
bottombigR = 1.53/1;
bottomsmallR = 1.15/1;

corner_resolution = 6/1;
circle_resolution = corner_resolution*4;

fudge = .05/1;


//MODULES

module iPhoneGlass(w, l, h, r)
{
	union(){
		cube([w,l-r*2,h],center = true);
		cube([w-r*2,l,h],center = true);
		//top right corner
		translate([w/2-r,l/2-r,0])
			cylinder(	h = h,
						r = r,
						center = true,
						$fn = circle_resolution);
		//top left corner
		translate([-(w/2-r),l/2-r,0])
			cylinder(	h = h,
						r = r,
						center = true,
						$fn = circle_resolution);
		//bottom right corner
		translate([w/2-r,-(l/2-r),0])
			cylinder(	h = h,
					 	r = r,
						center = true,
						$fn = circle_resolution);
		//bottom left corner
		translate([-(w/2-r),-(l/2-r),0])
			cylinder(	h = h,
						r = r,
						center = true, 
						$fn = circle_resolution);
	}
}

module iPhoneStrip(	w, l, h, r, sw, st)
{
	union(){
		cube([w+st*2,l-r*2,sw],center = true);
		cube([w-r*2,l+st*2,sw],center = true);
		//top right corner
		translate([w/2-r,l/2-r,0])
			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
		//top left corner
		translate([-(w/2-r),l/2-r,0])
			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
		//bottom right corner
		translate([w/2-r,-(l/2-r),0])
			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
		//bottom left corner
		translate([-(w/2-r),-(l/2-r),0])
			cylinder(	h = sw,
						r = r+st,
						center = true,
						$fn = circle_resolution);
	}
}

module iPhoneCameraHole(w,h,r){
	hull(){
		translate([w/2,0,0])
			cylinder(h = h,r = r,center = true, $fn = circle_resolution);
		translate([-w/2,0,0])
			cylinder(h = h,r = r,center = true, $fn = circle_resolution);
	}
}


module iPhone5(w,l,h,cR,sw,st){
	hull(){
		iPhoneGlass(w,l,h,cR);
		iPhoneStrip(w,l,h,cR,sw,st);
	}
}


module iPhone4(w,l,h,cR,sw,st){
	union(){
		hull(){
			iPhoneGlass(w,l,sw+st,cR);
			iPhoneStrip(w,l,h,cR,sw,st);
		}
		iPhoneGlass(w,l,h,cR);
	}
}

module iPhone5Case(){
	translate([0,0,(5height+caseThickness)/2]){
		difference(){
			hull(){
				iPhoneGlass(5width+caseThickness*2,5length+caseThickness*2,5height+caseThickness,5cornerR+caseThickness);
				iPhoneStrip(5width+caseThickness*2,5length+caseThickness*2,5height+caseThickness*2,5cornerR+caseThickness,5swidth,5sthick);
			}
			iPhone5(5width-caseTolerance*3,5length-caseTolerance*2,5height+caseTolerance,5cornerR,5swidth+caseTolerance*2,5sthick+caseTolerance);
			translate([0,0,-5height*.5])
				iPhoneGlass(5width-caseThickness*2,5length-caseThickness*2,5height,5cornerR);
			translate([0,0,5height*.5])
				iPhoneGlass(5width-caseTolerance*3,5length-caseTolerance*2,5height+caseTolerance,5cornerR);
			translate([0,0,caseThickness/2])
			cube([44,5length+20,5height+caseThickness/2],center = true);
			translate([-5width/2-caseThickness*.8,30,4.5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(30,caseThickness*2,8);
		}
		difference(){
			union(){
				intersection(){
					translate([0,0,-(5height/2 + caseThickness/4 + caseTolerance/4)])
						iPhoneGlass(5width-caseThickness*2+fudge,5length-caseThickness*2+fudge,caseThickness/2-caseTolerance/2,5cornerR-fudge);
				}
				translate([15,52.4,-(5height/2 + caseThickness/4)])
					iPhoneCameraHole(7.8,caseThickness/2,7.8+1.6);
			}
			translate([15,52.4,-(5height/2 + caseThickness/4)])
				scale([1,1,2])
				iPhoneCameraHole(7.8,caseThickness/2,7.8);
		}
	}	
}

module iPhone4Case(){
	translate([0,0,(4height+caseThickness)/2]){
		difference(){
			hull(){
				iPhoneGlass(4width+caseThickness*2,4length+caseThickness*2,4height+caseThickness,4cornerR+caseThickness);
				iPhoneStrip(4width+caseThickness*2,4length+caseThickness*2,4height+caseThickness*2,4cornerR+caseThickness,4swidth,4sthick);
			}
			iPhone4(4width-caseTolerance*3,4length-caseTolerance*2,4height+caseTolerance,4cornerR,4swidth+caseTolerance*2,4sthick+caseTolerance);
			translate([0,0,4height*.5])
				iPhoneGlass(4width-caseTolerance*3,4length-caseTolerance*2,4height,4cornerR);
			translate([0,0,-4height*.5])
				iPhoneGlass(4width-caseThickness*2,4length-caseThickness*2,4height,4cornerR);
			translate([0,0,caseThickness/2])
			cube([44,4length+20,4height+caseThickness/2],center = true);
			translate([-4width/2-caseThickness*.8,30,5])
				rotate([90,0,90])
				scale([1,1,2])
				iPhoneCameraHole(24,caseThickness*2,8);
		}
		difference(){
			union(){
				intersection(){
					translate([0,0,-(4height/2 + caseThickness/4 + caseTolerance/4)])
						iPhoneGlass(4width-caseThickness*2+fudge,4length-caseThickness*2+fudge,caseThickness/2-caseTolerance/2,4cornerR+fudge);	
				}
				translate([15,48.2,-(4height/2 + caseThickness/4)])
					iPhoneCameraHole(7.8,caseThickness/2,7.8+1.6);
			}
			translate([15,48.2,-(4height/2 + caseThickness/4)])
				scale([1,1,2])
				iPhoneCameraHole(7.8,caseThickness/2,7.8);
		}
	}	
}