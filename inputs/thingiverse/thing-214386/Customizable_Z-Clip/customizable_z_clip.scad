//CUSTOMIZER VARIABLES
//	Width of the clip
width = 20;

//	Height of the clip
height = 50;

//	Thickness of the clip
thickness = 3.5;

//	Width of the first gap on the clip
gap1 = 30;

//	Width of the second gap on the clip
gap2 = 5;
//CUSTOMIZER VARIABLES END

//Z-CLIP
module zclip(w,h,t,d1,d2) {
	cube([t,h,w]);
	translate([t,h-t,0]) cube([d1+t,t,w]);
	translate([d1+t,0,0]) cube([t,h-t,w]);
	translate([d1+t+t,0,0]) cube([d2+t,t,w]);
	translate([d1+t+t+d2,t,0]) cube([t,h-t,w]);
}
zclip(width,height,thickness,gap1,gap2);
//Z-CLIP END