// This generates stars of various kinds (stars, compass roses, sheriff badges, googie-style designs, southwestern, etc)
// Licensed under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:399428

use<write/Write.scad>

/* [star] */

// The outside diameter
star_dia=18;

// How thick the star is. (NOTE: If half=true, this number will be cut in half)
star_thickness=2;

// You usually only one one half of the star, but you can generate the back too if you want 
half=true;

// If you want to say something in the middle of the star
middle_text="";

// how thick the characters will be (negative=cut out)
middle_text_height=2.5;

// The number of rays/points the star will have/
num_rays=6;

// How wide the rays will be
ray_width=3.5;

// The number of sides of each ray. (NOTE: if half=true then half of these may be cut off)
ray_polys=4;

// Rotate the ray along its axis.
ray_rot=0;

// If you want round bullets on the star points
bullet_dia=1.5;

// To rotate the whole thing
star_rot=0;

/* [secondary star] */

// The outside diameter
star_dia_2=0;

// How thick the star is. (NOTE: If half=true, this number will be cut in half)
star_thickness_2=2;

// You usually only one one half of the star, but you can generate the back too if you want 
half_2=true;

// If you want to say something in the middle of the star
middle_text_2="";

// how thick the characters will be (negative=cut out)
middle_text_height_2=0;

// The number of rays/points the star will have/
num_rays_2=4;

// How wide the rays will be
ray_width_2=1;

// The number of sides of each ray. (NOTE: if half=true then half of these may be cut off)
ray_polys_2=4;

// Rotate the ray along its axis.
ray_rot_2=0;

// If you want round bullets on the star points
bullet_dia_2=0;

// To rotate the whole thing
star_rot_2=45;

/* [third star] */

// The outside diameter
star_dia_3=0;

// How thick the star is. (NOTE: If half=true, this number will be cut in half)
star_thickness_3=2;

// You usually only one one half of the star, but you can generate the back too if you want 
half_3=true;

// If you want to say something in the middle of the star
middle_text_3="";

// how thick the characters will be (negative=cut out)
middle_text_height_3=0;

// The number of rays/points the star will have/
num_rays_3=8;

// How wide the rays will be
ray_width_3=0.75;

// The number of sides of each ray. (NOTE: if half=true then half of these may be cut off)
ray_polys_3=4;

// Rotate the ray along its axis.
ray_rot_3=0;

// If you want round bullets on the star points
bullet_dia_3=0;

// To rotate the whole thing
star_rot_3=22.5;

/* [ring 1] */

// the inside diameter (can be 0)
ring_1_id=11;

// the outside diameter
ring_1_od=15;

// how thick the ring will be
ring_1_thick=0.1;

// if you want it to say something
ring_1_text="";

// how thick the characters will be (negative=cut out)
ring_1_text_height=0;

/* [ring 2] */

// the inside diameter (can be 0)
ring_2_id=0;

// the outside diameter
ring_2_od=0;

// how thick the ring will be
ring_2_thick=0.1;

// if you want it to say something
ring_2_text="";

// how thick the characters will be (negative=cut out)
ring_2_text_height=0;

/* [ring 3] */

// the inside diameter (can be 0)
ring_3_id=0;

// the outside diameter
ring_3_od=0;

// how thick the ring will be
ring_3_thick=0.1;

// if you want it to say something
ring_3_text="";

// how thick the characters will be (negative=cut out)
ring_3_text_height=0;

/* [hidden] */
scoche=0.001;


module ring(id,od,thick,text,text_height) {
	textheight=((od-id)/2)*0.5;
	difference() {
		cylinder(r=od/2,h=thick,$fn=45);
		if(id>0) {
			translate([0,0,-scoche/2]) cylinder(r=id/2,h=thick+scoche,$fn=45);
		}
		if(text_height<0&&text!="") {
			writecylinder(radius=od/2,text,height=thick+text_height,h=textheight,face="top");
		}
	}
	if(text_height>0&&text!="") {
		writecylinder(radius=od/2,text,height=thick+text_height,h=textheight,face="top");
	}
}

module star(star_dia=20,num_rays=5,star_thickness=3,bullet_dia=1.5,ray_width=3,ray_polys=4,half=true,ray_rot=0) {
	difference() {
		rotate([90,0,0]) for(i=[0:num_rays]) {
			rotate([0,i*(360/num_rays),0]) {
				scale([1,star_thickness/ray_width,1]) rotate([0,0,ray_rot]) cylinder(r1=ray_width,r2=scoche,h=star_dia/2,$fn=ray_polys);
				if(bullet_dia>0){
					translate([0,0,star_dia/2]) sphere(r=bullet_dia/2,$fn=max($fn,24));
				}
			}
		}
		if(half){
			translate([-(star_dia+scoche),-(star_dia+scoche),-star_thickness*2]) cube([(star_dia+scoche)*2,(star_dia+scoche)*2,star_thickness*2]);
		}
	}
}

if(star_dia>0&&num_rays>1&&star_thickness>0&&ray_width>0&&ray_polys>3) {
	difference() {
		rotate([0,0,star_rot]) star(star_dia,num_rays,star_thickness,bullet_dia,ray_width,ray_polys,half,ray_rot);
		if(middle_text_height<0&&middle_text!="") {
			translate([-star_dia/2,(-(3*star_dia)/(2*len(middle_text)))/2,0]) scale([1,1,-middle_text_height]) write(middle_text,face="top",size=[star_dia,star_dia,0],h=(3*star_dia)/(2*len(middle_text)));
		}
	}
	if(middle_text_height>0&&middle_text!="") {
		translate([-star_dia/2,(-(3*star_dia)/(2*len(middle_text)))/2,0]) scale([1,1,middle_text_height]) write(middle_text,face="top",size=[star_dia,star_dia,0],h=(3*star_dia)/(2*len(middle_text)));
	}
}
if(star_dia_2>0&&num_rays_2>1&&star_thickness_2>0&&ray_width_2>0&&ray_polys_2>3) {
	difference() {
		rotate([0,0,star_rot_2]) star(star_dia_2,num_rays_2,star_thickness_2,bullet_dia_2,ray_width_2,ray_polys_2,half,ray_rot_2);
		if(middle_text_height_2<0&&middle_text_2!="") {
			translate([-star_dia_2/2,(-(3*star_dia_2)/(2*len(middle_text_2)))/2,0]) scale([1,1,-middle_text_height_2]) write(middle_text_2,face="top",size=[star_dia_2,star_dia_2,0],h=(3*star_dia_2)/(2*len(middle_text_2)));
		}
	}
	if(middle_text_height_2>0&&middle_text_2!="") {
		translate([-star_dia_2/2,(-(3*star_dia_2)/(2*len(middle_text_2)))/2,0]) scale([1,1,middle_text_height_2]) write(middle_text_2,face="top",size=[star_dia_2,star_dia_2,0],h=(3*star_dia_2)/(2*len(middle_text_2)));
	}
}
if(star_dia_3>0&&num_rays_3>1&&star_thickness_3>0&&ray_width_3>0&&ray_polys_3>3) {
	difference() {
		rotate([0,0,star_rot_3]) star(star_dia_3,num_rays_3,star_thickness_3,bullet_dia_3,ray_width_3,ray_polys_3,half,ray_rot_3);
		if(middle_text_height_3<0&&middle_text_3!="") {
			translate([-star_dia_3/2,(-(3*star_dia_3)/(2*len(middle_text_3)))/2,0]) scale([1,1,-middle_text_height_3]) write(middle_text_3,face="top",size=[star_dia_3,star_dia_3,0],h=(3*star_dia_3)/(2*len(middle_text_3)));
		}
	}
	if(middle_text_height_3>0&&middle_text_3!="") {
		translate([-star_dia_3/2,(-(3*star_dia_3)/(2*len(middle_text_3)))/2,0]) scale([1,1,middle_text_height_3]) write(middle_text_3,face="top",size=[star_dia_3,star_dia_3,0],h=(3*star_dia_3)/(2*len(middle_text_3)));
	}
}
if(ring_1_od>0&&ring_1_thick>0) {
	 ring(ring_1_id,ring_1_od,ring_1_thick,ring_1_text,ring_1_text_height);
}
if(ring_2_od>0&&ring_2_thick>0) {
	 ring(ring_2_id,ring_2_od,ring_2_thick,ring_2_text,ring_2_text_height);
}
if(ring_3_od>0&&ring_3_thick>0) {
	 ring(ring_3_id,ring_3_od,ring_3_thick,ring_3_text,ring_3_text_height);
}
