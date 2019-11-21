
/* [main] */

// Overall length (inches)
length=6;

// Overall width (inches)
width=0.5;

// How thick the slab under the teeth is. (inches) If 0, same as tooth height.
spine_height=0;

/* [teeth] */

// How many teeth per inch
tpi=16;
	
// Tilt the teeth to achieve a ratchet effect (100% is a 90 degree angle) 
ratchet_percent=0; // [-150..150]
	
// How tall the teeth are. (inches) If 0, will be the same as width, giving avg 45 degree angles.
tooth_height=0;

// Percent of tooth tip to clip off (prevent sharp edge and allow for dirt)
clip_percent=15; // [0..100]

/* screw holes */

// Turn screw holes on/off
use_screws=1; // [0:off,1:on]

// How big around the screw is (millimeters)
screw_dia=3.5;

// How big the screw head is (millimeters)
screw_head_dia=6;

// How far the screws are in from the ends (inches)
screw_inset=0.5;

// How many screws. If 0, will calculate based on screw_spacing
num_screws=0;

// Distance between screws (inches)
screw_spacing=1;

/* hidden */

function in2mm(in)=25.4*in;

module frustum(x,y,x2,y2,z) {
	halfx=x/2;
	halfy=y/2;
	halfx2=x2/2;
	halfy2=y2/2;
	polyhedron(points=[
		[ halfx,halfy,0],
		[-halfx,halfy,0],
		[-halfx,-halfy,0],
		[ halfx,-halfy,0],
		[ halfx2,halfy2,z],
		[-halfx2,halfy2,z],
		[-halfx2,-halfy2,z],
		[ halfx2,-halfy2,z]
	], faces=[
		[0,2,1],[0,3,2], // top
		[0,4,3],[3,4,7], // east
		[0,5,4],[0,1,5], // north
		[1,6,5],[1,2,6], // west
		[2,7,6],[2,3,7], // south
		[4,5,6],[4,6,7] // bottom
	]);
}

module tooth(height,bottom_width,top_width=0.001,ratchet_percent=0){
	tw2=top_width/2;
	bw2=bottom_width/2;
	twr=bw2*ratchet_percent;
	polygon(points=[[height,twr-tw2],[height,twr+tw2],[0,bw2],[0,-bw2]],paths=[[0,1,2,3]]);
}

module screwHole(dia=3.5,head_dia=6,len=20,outset=0,$fn=32){
	head_height=(head_dia-dia)/2; // 45 degrees makes things simple
	cylinder(r=dia/2,h=len);
	translate([0,0,len-head_height]) cylinder(r2=head_dia/2,r1=dia/2,h=head_height);
	if(outset>0){
		translate([0,0,len]) cylinder(r=head_dia/2,h=outset);
	}
}

module teeth(spine_height,tpi,height,length,thickness,clip_percent=0.1,ratchet_percent=0){
	length=in2mm(length);
	spine_height=in2mm(spine_height);
	height=in2mm(height);
	thickness=in2mm(thickness);
	tooth_width=in2mm(1/tpi);
	rotate([0,0,-90]) rotate([0,-90,0]) linear_extrude(thickness){
		for(i=[0:tooth_width:length-0.001]){
			translate([spine_height,i+tooth_width/2,0]) tooth(height,tooth_width,tooth_width*clip_percent,ratchet_percent);
		}
		square([spine_height,length]);
	}
}

module incramental(clip_percent=10,ratchet_percent=100,screw_head_dia=6,screw_dia=3.5,tpi=16,tooth_height=0,spine_height=0,length=6,width=1/2,screw_inset=1/2,screw_spacing=1,num_screws=0,use_screws=1){
	clip_percent=clip_percent/100;
	ratchet_percent=ratchet_percent/100;
	tooth_height=tooth_height<=0?1/tpi:tooth_height;
	tooth_heightmm=in2mm(tooth_height);
	spine_height=spine_height<=0?tooth_height:spine_height;
	spine_heightmm=in2mm(spine_height);
	lengthmm=in2mm(length);
	widthmm=in2mm(width);
	screw_inset=screw_inset<=0?0.001:in2mm(screw_inset);
	screw_spacing=num_screws>0?(lengthmm-screw_inset*2)/(num_screws-1):in2mm(screw_spacing);
	num_screws=num_screws<=0?(lengthmm-screw_inset*2)/screw_spacing:num_screws;
	difference(){
		teeth(spine_height,tpi,tooth_height,length,width,clip_percent,ratchet_percent);
		if(use_screws) for(i=[screw_inset:screw_spacing:lengthmm-screw_inset]){
			translate([i,widthmm/2,0]) screwHole(screw_dia,screw_head_dia,spine_heightmm,tooth_heightmm);
		}
	}
}

incramental(clip_percent,ratchet_percent,screw_head_dia,screw_dia,tpi,tooth_height,spine_height,length,width,screw_inset,screw_spacing,num_screws,use_screws);