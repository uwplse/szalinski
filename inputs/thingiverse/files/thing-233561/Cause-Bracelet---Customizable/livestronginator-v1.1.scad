// This generates a cause bracelet - like a "livestrong" bracelet.
// Based on my o-ring generator:
//		http://www.thingiverse.com/thing:225603
// Licenced under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:233561

// ================ includes
// http://www.thingiverse.com/thing:16193
use<write/Write.scad>

// ================ variables

//CUSTOMIZER VARIABLES

/* [Main] */

// What do you want it to say?
//(For best results, try and keep it under about 20 characters.)
text="Save The ROBOTS!";

// Upload an icon image of what you want. (TODO: not yet implemented)
image_file = "image-surface.dat"; // [image_surface:40x40]

// What do you want to create?
goal=0; // [0:"the bracelet itsself",1:"bracelet mold bottom",2:"bracelet mold top"]

// What units your measurements are in (experimental)
units=0; // [0:"mm",1:"cm",2:"in",3:"thou"]

// How big around is your wrist in selected units
//(exact measurement plus about 1.5cm or 1/2in)
wrist_circumference=200; // [50:500]

// How tall should it be in selected units?
// NOTE:  Currently doesn't work right.  Leave it at 1cm.
text_height=10;

// How thick should the band be in selected units? (Be careful. Too thick and it won't streach enough to get on!)
cross_sectional_diameter=2.5;

/* [Mold settings] */

// How thick(mm) the walls arount the part are.
mold_perimeter=5;

// The size(mm) of the mold fill/vent holes.
mold_hole_size=4;

// The height(mm) of the inlet riser for the top mold.
riser_height=15;

// The inlet size(mm). Increase for more viscous rubber, decrease for less cleanup.
sprue_thickness=0.5;

/* [Advanced] */

// (in mm) Be careful to keep this small enough.  Too deep and it may not come out of your mold!
engrave_depth=0.25;

// Resolution of the model.  Crank it up for smoother circles, but be careful.  It can make things really slow!
$fn=75; // [30:150]

//CUSTOMIZER VARIABLES END
module dummy() {};

// =============== program

// ---- Data
units_names=["mm","cm","in","thou"];
units_conversion=[1.0,10.0,25.4,0.0254];
twopi=6.283185307179586;
pi=3.141592653589793238;

//---- Functions

// converts using the global "units" value or whatever is specified
function tomm(u,t_units=-1) = u*units_conversion[t_units<0?units:t_units];
function fn_inside_diameter(inside_diameter,outside_diameter,cross_sectional_diameter) = ((inside_diameter>0)?(inside_diameter):(outside_diameter-(cross_sectional_diameter/2)));
function fn_cross_sectional_diameter(inside_diameter,outside_diameter,cross_sectional_diameter) = ((inside_diameter>0)?((outside_diameter-inside_diameter)*2):(cross_sectional_diameter));
function circ2dia(circ) = (circ/pi);
function circ2radius(circ) = (circ2dia(circ)/2);

/////////////////////////////////////////////////////////
// module _o_ring_B()
// actually generates the geometry
// use create_o_ring instead.  This is just a helper.
/////////////////////////////////////////////////////////
module _o_ring_B (outside_diameter=40,cross_sectional_diameter=3,minionizing_cross_section=0) {
	echo("//////////////////////// o-ring");
	echo(str("outside_diameter=",outside_diameter));
	echo(str("cross_sectional_diameter=",cross_sectional_diameter));
	echo(str("minionizing_cross_section=",minionizing_cross_section));
	rotate_extrude() translate([(outside_diameter-(cross_sectional_diameter/2))/2,0,0]) if (minionizing_cross_section>0) {
		union() {
			translate([0,minionizing_cross_section/2,0]) circle(r=cross_sectional_diameter/2);
			square([cross_sectional_diameter,minionizing_cross_section],center=true);
			translate([0,-minionizing_cross_section/2,0]) circle(r=cross_sectional_diameter/2);
		}
	} else {
		circle(r=cross_sectional_diameter/2);
	}
};

/////////////////////////////////////////////////////////
// module _o_ring_A()
// accounts for undersizing using delta-volume between stretched and relaxed state
// use create_o_ring instead.  This is just a helper.
/////////////////////////////////////////////////////////
module _o_ring_A (outside_diameter=40,cross_sectional_diameter=3,minionizing_cross_section=0,undersizing=0) {
		if(undersizing>0) {
			// Hint: volume of a torus is 2*PI^2*R*r^2
			// So for the same volume, that means: R1*r1^2=R2*r2^2
			// or, r2=sqrt(R1*r1^2/R2)
			echo(str("cross_sectional_diameter=",cross_sectional_diameter));
			_o_ring_B(outside_diameter-undersizing,
				2*sqrt(
					(((outside_diameter-(cross_sectional_diameter)/2)/2)
					*
					pow(cross_sectional_diameter/2,2))
					/
					(((outside_diameter-undersizing)-(cross_sectional_diameter)/2)/2)
				),minionizing_cross_section);
		}else{
			_o_ring_B(outside_diameter,cross_sectional_diameter,minionizing_cross_section);
		}
};

/////////////////////////////////////////////////////////
// module create_o_ring()
// units - Whether you are measuring is mm or .thou
// outside_diameter - Please specify this and cross sectional diameter OR inside diameter NOT BOTH
// cross_sectional_diameter - Please specify this OR inside diameter NOT BOTH
// inside_diameter - Please specify this OR cross sectional diameter NOT BOTH
// minionizing_cross_section - This is used for widening the o ring along the z axis to prevent twisting
// undersizing - Make the o-ring diameter this much undersize (this is different than changing the id/od because it also accounts for streach volume)
/////////////////////////////////////////////////////////
module create_o_ring (units=0,outside_diameter=40,cross_sectional_diameter=3,inside_diameter=-1,minionizing_cross_section=0,undersizing=0) {
		if(inside_diameter>0) {
			_o_ring_A(tomm(outside_diameter,units),tomm((outside_diameter-inside_diameter)/2,units),tomm(minionizing_cross_section,units),tomm(undersizing,units));
		}else{
			_o_ring_A(tomm(outside_diameter,units),tomm(cross_sectional_diameter,units),tomm(minionizing_cross_section,units),tomm(undersizing,units));
		}
};

/////////////////////////////////////////////////////////
// module create_relief()
// creates a text engrave_depth for a cylinder
// height - how tall the text is
// depth - how deep the engrave_depth is
// radius - the radius of the cylinder
// text - what you want to say
// image - if you want an image icon with this (TODO: not implemented)
/////////////////////////////////////////////////////////
module create_relief(height=10,depth=0.25,radius=20,text="",image=false){
	echo ("========================",text);
	echo (str("text_height=",height));
	if(text!=""){
		resize([0,0,height/2]) writecylinder(text=text,where=[0,0,0],radius=radius,height=height);
	}
}

/////////////////////////////////////////////////////////
// module livestonginator()
// same as create_o_ring() but adds the ability to create molds and add text engrave_depths 
// goal - [0:"the bracelet itsself",1:"bracelet mold bottom",2:"bracelet mold top"]
// units - Whether you are measuring is mm or .thou
// text_height - how tall the letters are
// engrave_depth - how deep the letters are engraved (in mm)
// text - what the text should say
// image - include an image/icon
// wrist_circumference - How big around the wrist is
// cross_sectional_diameter - How thick the band is
// mold_perimeter - How thick(mm) the walls arount the part are.
// mold_hole_size - The size(mm) of the mold fill/vent holes.
// riser_height - The height(mm) of the inlet riser for the top mold.
// sprue_thickness - The inlet size(mm). Increase for more viscous rubber, decrease for less cleanup.
/////////////////////////////////////////////////////////
module livestonginator(goal=0,units=0,text_height=15,engrave_depth=0.25,message_text="TEST",image=false,wrist_circumference=200,cross_sectional_diameter=3,mold_perimeter=5,mold_hole_size=4,riser_height=15,sprue_thickness=0.5)
{
	if(goal==0){
		difference() {
			create_o_ring(units,circ2dia(wrist_circumference),cross_sectional_diameter,-1,text_height,0);
			translate([0,0,(-tomm(text_height,units))+(-tomm(cross_sectional_diameter,units)*1.5)]) create_relief(tomm(text_height,units)+(tomm(cross_sectional_diameter,units)*2),engrave_depth,tomm(circ2radius(wrist_circumference)+1,units),message_text,image);
		}
	}else if(goal==1){ // mold bottom half
		difference(){
			translate([0,0,-tomm(text_height,units)]) union() {
				translate([
					-(tomm(wrist_circumference,units)+mold_perimeter)/2,
					-(tomm(wrist_circumference,units)+mold_perimeter)/2,
					(-cross_sectional_diameter/2)-(cross_sectional_diameter/2+(mold_perimeter/2))
					]) 
					cube([tomm(wrist_circumference,units)+mold_perimeter,tomm(wrist_circumference,units)+mold_perimeter,cross_sectional_diameter+(mold_perimeter/2)+tomm(text_height,units)]);
				// key
				translate([0,0,tomm(text_height,units)]) sphere ([mold_perimeter*4,mold_perimeter*4,mold_perimeter*4]);
			}
			difference() {
				create_o_ring(units,circ2dia(wrist_circumference),cross_sectional_diameter,-1,text_height,0);
				translate([0,0,-tomm(text_height,units)/2]) create_relief(tomm(text_height,units)+(tomm(cross_sectional_diameter,units)*2),engrave_depth,tomm(circ2radius(wrist_circumference)+1,units),message_text,image);
			}		
		}
	}else{ // mold top half
		rotate([180,0,0]) difference(){ 
			union() {
				translate([
					-(tomm(wrist_circumference,units)+mold_perimeter)/2,
					-(tomm(wrist_circumference,units)+mold_perimeter)/2,
					(-cross_sectional_diameter/2)+(-cross_sectional_diameter/2+(mold_perimeter/2))
					])
					//cylinder(d=tomm(wrist_circumference,units)+mold_perimeter,$fs=6);
					cube([tomm(wrist_circumference,units)+mold_perimeter,tomm(wrist_circumference,units)+mold_perimeter,cross_sectional_diameter+(mold_perimeter/2)]);
				// inlet riser
				translate([(fn_inside_diameter(-1,wrist_circumference,cross_sectional_diameter)/2-((mold_hole_size+cross_sectional_diameter)/2))-(mold_hole_size/2)+(mold_perimeter/2),0,0]) cylinder(r=(mold_hole_size+mold_perimeter)/2,h=riser_height);
			}
			// key hole
			sphere ([mold_perimeter*4,mold_perimeter*4,mold_perimeter*4]);
			// o-ring
			// NOTE: not necessary to subtract text or minionize since this covers just the top radius of the ring 
			create_o_ring(units,circ2dia(wrist_circumference),cross_sectional_diameter,-1,0,0);
			// inlet hole
			translate([(fn_inside_diameter(-1,wrist_circumference,cross_sectional_diameter)/2-((mold_hole_size+cross_sectional_diameter)/2)),0,-50]) cylinder(r=mold_hole_size/2,h=100);
			translate([(fn_inside_diameter(-1,wrist_circumference,cross_sectional_diameter)/2-((mold_hole_size+cross_sectional_diameter)/2)),0,-sprue_thickness]) cylinder(r=(mold_hole_size+cross_sectional_diameter)/2,h=sprue_thickness);
			// vent hole
			translate([-(fn_inside_diameter(-1,wrist_circumference,cross_sectional_diameter)/2-((mold_hole_size+cross_sectional_diameter)/2)),0,-50]) cylinder(r=mold_hole_size/2,h=100);
			translate([-(fn_inside_diameter(-1,wrist_circumference,cross_sectional_diameter)/2-((mold_hole_size+cross_sectional_diameter)/2)),0,-sprue_thickness]) cylinder(r=(mold_hole_size+cross_sectional_diameter)/2,h=sprue_thickness);
		}
	}
}

//---- The program
livestonginator(goal,units,text_height,engrave_depth,text,image_file,wrist_circumference,cross_sectional_diameter,mold_perimeter,mold_hole_size,riser_height,sprue_thickness);