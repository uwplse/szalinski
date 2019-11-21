// Creates an essential oil diffuser necklace charm
//
// Licence is Creative Commons - Attribution - Non-Commercial
// For attribution, simply link to: 
//    https://www.thingiverse.com/thing:2357083

// preview[view:west, tilt:top]

/* [main] */

// which part to generate
part=3; // [1:top STL,2:bottom STL,3:assembled view,4:just the center design]

// your design for the holes
center_shape=[[[-10,10],[10,10],[10,-10],[-10,-10]],[[0,1,2,3]]];  //[draw_polygon:100x100]

// invert the image (set to true if cut-out area of image is black)
im_invert=0; // [0:false,1:true]

// rotate the image
im_rot=0;

// scale up/down the image slightly
im_oversize=0.25;

/* [upload image] */

// the image to cut out WARNING: this feature can be SLOW!
im=""; // [image_surface:100x100]

// trim the bottom (can cause slowness and certain values may cause customizer to time out)
im_trim_bottom_percent=1; // [0:100]

// trim the top (can cause slowness and certain values may cause customizer to time out)
im_trim_top_percent=-1; // [0:100]

/* [geometry] */

// wall thickness (bottom and sides)
thick=1.5;

// top thickness
top_thick=2;

// how big the inside is
inside_dia=30;

// how high the inside is
inside_h=2.5;

// how wide the fastener clips are
clip_width=7.5;

// don't overdo it or the inside corner could cut through
bevel_size=1;

// spread snaps a little for better fit -- related to material shrinkage (this is a dia)
snap_adj=0.45;

// EXPERIMENTAL! attempt to correct for material changes and get exact size
attempt_size_correction=0; // [0:false,1:true]

/* [holes for hanging] */

// how big the mounting hole is
hole_dia=1.25;

// how big around the mounting ring is
ring_dia=7;

/* [hidden] */

// use this to manually load an stl
importStl=""; // Auryn.stl celtic.stl (can be blank)

// clean up some variable interpretations
ring_gauge=hole_dia;
id=inside_dia;
im_w=99; // does nothing
od=id+thick*2;
im_h=inside_h+thick*2;
ring_inset=thick+ring_gauge/2; // how deep into the body (from center) -- default is just enough so entire ring breaks through to the inside

if(attempt_size_correction==1){
	id=id+0.4; // correction factor
	thick=thick-0.07; // correction factor
	top_thick=top_thick-0.17; //correction factor
}

module roundContainerShape(id,od,h,bevel,thick,top_thick){
	difference(){
		union(){ // outside
			translate([0,0,h-bevel]) cylinder(r2=od/2-bevel,r1=od/2,h=bevel);
			translate([0,0,bevel]) cylinder(r=od/2,h=h-bevel*2);
			cylinder(r1=od/2-bevel,r2=od/2,h=bevel);
		}
		translate([0,0,thick]) cylinder(r=id/2,h=h-thick-top_thick+0.02);
	}
}

module roundclip(dia,thick,h,w,numclips,isPositive){
	margin=0.2; // extra space on the sides
	extra=thick/2; // extra size for cut-out (avoid same value error and allow room for mechanics to work)
	if(isPositive){
		intersection(){
			rotate_extrude() translate([dia/2-thick/2,thick/2]) {
				square([thick/2,h-thick/2]);
				circle(r=thick/2,$fn=20);
			}
			for(a=[0:360/numclips:359.99]){
				rotate([0,0,a]) translate([-(w-margin*2)/2,0,-0.5]) cube([w-margin*2,dia+1,h+1]);
			}
		}
	}else{
		intersection(){
			rotate_extrude() translate([dia/2-thick/2,thick/2]) {
				square([thick/2+extra,h-thick/2]);
				circle(r=thick/2,$fn=20);
				translate([-thick/2,-thick/2-margin]) square([thick+extra,thick/2+margin]);
			}
			for(a=[0:360/numclips:359.99]){
				rotate([0,0,a]) translate([-w/2,0,-0.5]) cube([w,dia+extra+1,h+1]);
			}
		}
	}
}


// usePolygon is a [[points],[paths]]
module loadShape(resultSize,importImage="",importStl="",usePolygon=undef){
	resize(resultSize){
		if(importStl!=""){
			import(importStl);
		}else if(importImage!=""){
			surface(file=importImage,center=true);
		}else if(usePolygon!=undef&&usePolygon[1]!=undef&&usePolygon[1][0]!=undef){
			echo(usePolygon[0][0]);
			linear_extrude(1) polygon(points=usePolygon[0],paths=usePolygon[1]);
		}else{
			echo("No shape!");
			cylinder(r=resultSize[0],h=resultSize[1]);
		}
	}	
}

// you can import an stl or image and make sure it comes out a given size
// clipping top and bottom takes some time
module cutout(resultSize,importImage="",importStl="",usePolygon=undef,trim_bottom_percent=-1,trim_top_percent=-1,invert_cyl=false){
	trim_bottom_percent=trim_bottom_percent<0?(importImage!=""?0.1:0.0):trim_bottom_percent;
	trim_top_percent=0.1;//trim_top_percent<0?0.0:trim_top_percent;
	trim_thickness=resultSize[2]-(resultSize[2]*(trim_bottom_percent+trim_top_percent));
	trim_offs=resultSize[2]*trim_bottom_percent;
	resize([resultSize[0],resultSize[1],invert_cyl?resultSize[2]+1:resultSize[2]])difference(){
		// if we want to cut a shape out of a cylinder, then start with a cylinder
		if(invert_cyl){
			resize(resultSize) cylinder(r=max(resultSize[0],resultSize[1]),h=resultSize[2]);
		}
		// the shape
		// determine whether it is faster to just load, intersect, or difference
		if(trim_bottom_percent<=0&&trim_top_percent<=0){ // just load it
			loadShape(resultSize,importImage,importStl,usePolygon);
		}else if(false){ // intersect is the best way
			translate([0,0,(invert_cyl?-0.5:0)-trim_offs]) intersection(){
				loadShape(resultSize,importImage,importStl,usePolygon);
				translate([-(resultSize[0]+1)/2,-(resultSize[1]+1)/2,trim_offs]) cube([resultSize[0]+1,resultSize[1]+1,trim_thickness]);
			}
		}else{ // cheaper to just cut off the top/bottom
			translate([0,0,(invert_cyl?-0.5:0)-trim_offs]) difference(){
				loadShape(resultSize,importImage,importStl,usePolygon);
				if(trim_bottom_percent>0){
					translate([-(resultSize[0]+1)/2,-(resultSize[1]+1)/2,trim_offs-resultSize[2]]) cube([resultSize[0]+1,resultSize[1]+1,resultSize[2]]);
				}
				if(trim_top_percent>0){
					translate([-(resultSize[0]+1)/2,-(resultSize[1]+1)/2,trim_offs+trim_thickness]) cube([resultSize[0]+1,resultSize[1]+1,resultSize[2]]);
				}
			}
		}
		// square with a hole in it
		if(invert_cyl==false){
			difference(){
				translate([-(resultSize[0]+1)/2,-(resultSize[1]+1)/2,-0.5]) cube([resultSize[0]+1,resultSize[1]+1,resultSize[2]+1]);
				translate([0,0,-1]) resize([resultSize[0],resultSize[1],resultSize[2]+2]) cylinder(r=max(resultSize[0],resultSize[1]),h=resultSize[2]);
			}
		}
	}
}

module lid_center(){
	rotate([0,0,im_rot]) cutout([id+im_oversize,id+im_oversize,top_thick],importImage=im,importStl=importStl,usePolygon=center_shape,trim_bottom_percent=im_trim_bottom_percent/100.0,trim_bottom_percent=im_trim_bottom_percent/100.0,invert_cyl=im_invert==1);
}

module top(flip=false){
	// the decorative center
	translate([0,0,flip?0:inside_h+thick]) lid_center();
	translate([0,0,flip?inside_h+thick+top_thick:0]) rotate([flip?180:0,0,0]){
		// the clips
		roundclip(od+snap_adj,thick,inside_h+thick+top_thick-bevel_size,clip_width,2,true,$fn=64);
		// the top
		intersection(){
			roundContainerShape(id,od,inside_h+thick+top_thick,bevel_size,thick,top_thick,$fn=64);
			translate([0,0,inside_h+thick]) difference(){
				cylinder(r=od/2,h=top_thick+1); // cut off top
				translate([0,0,-1]) cylinder(r=id/2,h=top_thick+2,$fn=64); // leave a center hole
			}
		}
	}
}

module bottom(){
	difference(){
	roundContainerShape(id,od,inside_h+thick+top_thick,bevel_size,thick,top_thick,$fn=64);
		translate([0,0,inside_h+thick]) cylinder(r=id,h=top_thick*2); // cut off top
		roundclip(od,thick,inside_h+thick,clip_width,2,false,$fn=64); // clip hole	translate([od/2+ring_dia/2-ring_inset,0,inside_h/2+thick]) rotate_extrude($fn=64) translate([ring_dia/2,0]) circle(r=ring_gauge/2,$fn=20);
		// hole for the ring
		translate([od/2+ring_dia/2-ring_inset,0,inside_h/2+thick]) rotate_extrude($fn=64) translate([ring_dia/2,0]) circle(r=ring_gauge/2,$fn=20);
	}
}


// ---- main

if(part==1){ // top
	top(flip=true);
}else if(part==2){// base
	bottom();
}else if(part==3){// entire assembly
	difference(){
		union(){
			bottom();
			top(flip=false);
		}
		//cube([100,100,100]); // cutaway
	}
} else if(part==4) {
	lid_center();
}