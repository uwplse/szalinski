/*!
@brief Ellipse intersection
@details This OpenSCAD script will generate a 2D shape based on two partially overlapping ellipses
The radii of both ellipses are controlled by specifying the final width and height of the created shape as well of the ratio of the depths of each side
there is also an option for rounding the shape while preserving it's dimensions with controllable radius

@author Mark Gaffney
@version 1.3
@date 2013-03-19

@todo
Make suitable for use with "Customizer"

@warning
None

@note
Changes from previous versions:
v1-3
 - 	added abilty to optionally create 3d lienar/rotate extrusion
v1-2
 - 	Some more control over centre and rounding in preparation for integration into ring creation script
 - 	Fixed some alignment issues
 - 	Made compatible with "Customizer"
v1-1
 - 	uses formula for an arc taken from here http://www.mathopenref.com/arcradius.html

v1-0
 - 	uses intersection of somewhat arbitrarily sized circles minkowski using a smaller circle for rounding off to prove concept
*/

//*************includes********
use <write/write.scad>//http://www.thingiverse.com/thing:16193  writecylinder("Text on Cylinder",[translatex,translatey,translatez],cylinderr=20,cylinderh=40,rotate=45,center=true)


//v1-2
/* [Global] */
//Band Width: How wide you would like the created shape to be in the X-direction
band_width=5;//[0:100]
//Band Depth: How deep you would like the created shape to be in the Y-direction
band_depth=3;//[0:100]
//Rounding: Radius of the circle used to smooth the connection between the 2 sides
rounding_rad=0.5;//[0:10]
//Percent of depth of the inside overlapping ellipse part to band width
inner_depth_ratio_percent=10;//[0:100]
//where on the shape will be aligned to (0,0) default is along the line connecting the two points of overlap of the ellipses
centre_type="inner";//[half_depth, inner, outer, default] 
//Do you want to leave it as a flat 2d shape or make a rotate(ring) or lienar(prism) extrusion
part="rotate";// [first:linear Only,second:rotate Only]

/* [linear] */
//Extrude Thickness: How thick the extrusion of the 2d shape will be (this is just to aid viewing in customiser)
extrude_thickness=0;//[0:100]

/* [rotate] */
//internal diameter of the ring you want to make usign this cross section
ring_inner_r=8;//[1:100]

/* [Hidden] */
//Number of facets determines smoothness of the created shape
$fn=20;//[10:100]

inner_depth_ratio=inner_depth_ratio_percent/100.0;
echo("inner_depth_ratio",inner_depth_ratio);
//inner_outer_ratio=;

if(part=="linear"){
	linear_extrude(height=extrude_thickness){
		ellipse_intersection_centred (band_width, band_depth, rounding_rad, inner_depth_ratio, centre_type);
	}
}else if (part=="rotate"){
	difference(){
		translate (v=[0,0,band_width/2]) rotate_extrude (convexity = 10){
			translate(v=[ring_inner_r,0])rotate(a=-90)ellipse_intersection_centred (band_width, band_depth, rounding_rad, inner_depth_ratio, centre_type);
		}
		mirror(1,0,0)writecylinder("THE",[0,0,0],ring_inner_r,band_width,rotate=0,t=1,h=2,space=1.2,font="write/orbitron.dxf");
	}
	
}else{//just leave it as a flat 2d shape
	ellipse_intersection_centred (band_width, band_depth, rounding_rad, inner_depth_ratio, centre_type);
}


module ellipse_intersection_centred (band_width, band_depth, rounding_rad, inner_depth_ratio, centre="none"){
	//inner_height=(band_depth-2*rounding_rad)*inner_depth_ratio;
	//outer_height=(band_depth-2*rounding_rad)-inner_height;

	//inner_rad=(inner_height/2) + (band_width-2*rounding_rad)*(band_width-2*rounding_rad)/(8*inner_height);
	//outer_rad=(outer_height/2) + (band_width-2*rounding_rad)*(band_width-2*rounding_rad)/(8*outer_height);

	//echo("inner_rad height",inner_rad,inner_height);
	//echo("outer_rad height",outer_rad,outer_height);
	//echo("inner_depth_ratio",inner_depth_ratio);
	//echo("band_depth*inner_depth_ratio",band_depth*inner_depth_ratio);
	
	if (centre=="half_depth"){
		//echo("half_depth centred");
		translate(v=[0,(band_depth-2*rounding_rad)*inner_depth_ratio+rounding_rad - 0.5*band_depth ]) ellipse_intersection_rounded(band_width, band_depth, rounding_rad, inner_depth_ratio);
	}else if(centre=="inner"){//inner surface centred
		//echo("inner centred");
		translate(v=[0, (band_depth-2*rounding_rad)*inner_depth_ratio+rounding_rad ]) ellipse_intersection_rounded(band_width, band_depth, rounding_rad, inner_depth_ratio);
	}else if(centre=="outer"){//outer surface centred
		//echo("outer centred");
		translate(v=[0, (band_depth-2*rounding_rad)*(inner_depth_ratio-1)-rounding_rad ]) ellipse_intersection_rounded(band_width, band_depth, rounding_rad, inner_depth_ratio);
	}else{
		//echo("split centred");
		ellipse_intersection_rounded(band_width, band_depth, rounding_rad, inner_depth_ratio);
	}
	//echo("band_depth*inner_depth_ratio",band_depth*inner_depth_ratio);
}

module ellipse_intersection_rounded (band_width_l, band_depth_l, rounding_rad_l, inner_depth_ratio_l){
//else{//default aligns (0,0) with the line separating the 2 sides determiend by inner_depth_ratio
	//inner_height_l=(band_depth_l-2*rounding_rad_l)*inner_depth_ratio_l;
	//outer_height_l=(band_depth_l-2*rounding_rad_l)-inner_height_l;

	//inner_rad_l=(inner_height_l/2) + (band_width_l-2*rounding_rad_l)*(band_width_l-2*rounding_rad_l)/(8*inner_height_l);
	//outer_rad_l=(outer_height_l/2) + (band_width_l-2*rounding_rad_l)*(band_width_l-2*rounding_rad_l)/(8*outer_height_l);
	//echo("band depth check",inner_height_l+outer_height_l,inner_height_l+outer_height_l+2*rounding_rad_l);
	//new_inner_depth_ratio_l=inner_height_l/(inner_height_l+ outer_height_l);
	if (rounding_rad_l>0) minkowski(){
		//echo("rounding r=",rounding_rad_l);
		circle(r=rounding_rad_l);
		ellipse_intersection (band_width_l-2*rounding_rad_l, band_depth_l-2*rounding_rad_l, inner_depth_ratio_l);
	}else{
		//echo("no rounding");
		ellipse_intersection (band_width_l, band_depth_l, inner_depth_ratio_l);
	}
}

module ellipse_intersection (band_width_m, band_depth_m, inner_depth_ratio_m){
//else{//default aligns (0,0) with the line separating the 2 sides determiend by inner_depth_ratio
	//echo("band_width_m, band_depth_m, inner_depth_ratio_m",band_width_m, band_depth_m, inner_depth_ratio_m);
	inner_height_m=(band_depth_m)*inner_depth_ratio_m;
	outer_height_m=(band_depth_m)-inner_height_m;

	inner_rad_m=(inner_height_m/2) + (band_width_m)*(band_width_m)/(8*inner_height_m);
	outer_rad_m=(outer_height_m/2) + (band_width_m)*(band_width_m)/(8*outer_height_m);
	//echo("herp inner_depth_ratio_m",inner_depth_ratio_m);

	intersection(){
		translate(v=[0,inner_rad_m-inner_height_m]) circle(r=inner_rad_m);
		translate(v=[0,-(outer_rad_m-outer_height_m)]) circle(r=outer_rad_m);
	}
}

//ellipse_intersection(4, 4, 1, 0.5, "none");

//translate(v=[0,-outer_height/2+inner_height/2])//centred
//translate(v=[0,+outer_height/2-inner_height/2])//inner surface centred

/*
//v1-1
translate(v=[0,+outer_height/2-inner_height/2 + band_depth])//outer surface centred
minkowski(){
	circle(r=rounding_rad);
	intersection(){
		translate(v=[0,inner_rad-inner_height]) circle(r=inner_rad);
		translate(v=[0,-(outer_rad-outer_height)]) circle(r=outer_rad);
	}
}
%square(size=[band_width,band_depth],center=true);
*/

//v1-0
//band_width=4.4;
//band_depth=5;
//inner_depth_ratio=0.5;
//
//inner_rad=6;//as band width increases so should the radii
//outer_rad=25;
//
//$fn=100;
//
//minkowski(){
//	circle(r=1);
//	intersection(){
//		translate(v=[0,inner_rad-band_depth/2]) circle(r=inner_rad);
//		translate(v=[0,-(outer_rad-band_depth/2)]) circle(r=outer_rad);
//	}
//}
////%square(size=[12,band_depth],center=true);