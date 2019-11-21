// based on :

//	Thingiverse Customizer Template v1.2 by MakerBlock
//	http://www.thingiverse.com/thing:44090
//	v1.2 now includes the Build Plate library as well


//  by JoeTinker 
//  KJJ
// v0.3 

include <utils/build_plate.scad>
include <write/Write.scad>

use <Write.scad>

//CUSTOMIZER VARIABLES
 
line1="line1";
line2="line2";
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
 // Text Height
 textT=5;//[1:15]
 // tag length
length = 100 ; // [30:200] 

// tag width
width = 50 ;  // [30:200] 

// corner radius
radius = 15 ;// [1:15] 

// tag thickness
tagThickness = 10 ;//[4:15]

// Name Plate Indent Thickness
indent=5; //[1:15]
// Tag height
tagH=20 ;//[10:50]

// edge thickness
edge=5 ;//[1:10]

// hole radius
holeRad=5 ;//[3:13]

//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// shape functions
module tag(length,width,radius,thickness, tagH) {
       
		hull(){
			translate(v = [length/2-radius,width/2-radius ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
			translate(v = [-(length/2-radius),width/2-radius ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
			translate(v = [-(length/2-radius),-(width/2-radius) ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
			translate(v = [length/2-radius,-(width/2-radius) ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
			translate(v = [length/2+tagH-radius,0 ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true);  }
		} 
	   }
	   
module RRect(length,width,radius,thickness) {
       
		hull(){
			translate(v = [length/2-radius,width/2-radius ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
			translate(v = [-(length/2-radius),width/2-radius ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
			translate(v = [-(length/2-radius),-(width/2-radius) ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
			translate(v = [length/2-radius,-(width/2-radius) ,0 ]) { cylinder(h = thickness, r1 =radius , r2 =radius , center = true); }
		} 
	   }

	

// create object
bottomOfIndent=(tagThickness/2)-indent;
module makeTag(){
difference() {    
	tag(length,width,radius, tagThickness,tagH);

	union() {
	translate(v = [length/2+tagH-radius,0 ,0 ]) { cylinder(h = tagThickness*2, r1 =holeRad , r2 =holeRad , center = true);  }    
	
	translate(v = [0,0 , bottomOfIndent+indent/2+.5]) {  
	RRect(length-2*edge,width-2*edge,radius-edge/2,indent+1);
	}}}}
	





// write text
module WriteText(){
indentWidth=width - (edge * 2) ;
textH=indentWidth/4;

translate([0,(textH/2) +1/8*indentWidth   ,bottomOfIndent+textT/2-.5])
write(line1,t=textT+1,h=textH+1,center=true,font=Font);
translate([0,-((textH/2) +1/8*indentWidth)   ,bottomOfIndent+textT/2-.5])
write(line2,t=textT+1,h=textH+1,center=true,font=Font);
}

translate ([0,0,tagThickness/2]) makeTag();
translate ([0,0,tagThickness/2])	WriteText();
