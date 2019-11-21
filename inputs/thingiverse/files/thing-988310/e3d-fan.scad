// E3D Fan adapter v1.1 (21/09/2015)

/* [Main] */
$fn=100; 
// (fan heatbreak height)
heatbreak_h=0; // [0:0.5:5]
// (fan size in mm)
fansize=40; //  [30:5:60]
// (fan hole diameter in mm)
fanhole_d=38; //  [25:1:60]
// (fan angle curve, radius in mm)
fancurve=3; // [0:0.5:6]
// (fan screw length in mm)
fanscrew=32; // [25:1:60]
// (fan screw diameter in mm)
fanscrew_d=3.3; // [2:1:5]
// (length adapter in mm)
length=10; // [0:1:40]
// (heatsink diameter + gap in mm)
e3d_d=22.7; // [15:0.5:30]
// (heatsink height in mm)
e3d_h=26; // [20:0.5:30]
// (shift x in mm)
e3d_shiftx=0; // [0:1:20]
// (shift y in mm)
e3d_shifty=0; // [0:1:20]

// V my ?
//e3d_d=25;
//e3d_h=32;
// V6
//e3d_d=22.5;
//e3d_h=26;


difference(){
	union(){
		hull(){
			translate([fancurve,fancurve,0]) minkowski()
			{
				cube([fansize-fancurve*2,fansize-fancurve*2,2]);
				cylinder(h=2, r=fancurve);
			}
			translate([(fansize-e3d_d)/2-3+e3d_shiftx,(fansize-e3d_h-1)/2+e3d_shifty,length]) cube([e3d_d+6,e3d_h+1,.01]);
		
		}
		hull(){
			translate([(fansize-e3d_d)/2-3+e3d_shiftx,(fansize-e3d_h-1)/2+e3d_shifty,length]) cube([e3d_d+6,e3d_h+1,.01]);
			rotate([90,0,0]) translate([fansize/2+e3d_shiftx,length+e3d_d/2,-fansize/2-e3d_shifty]) cylinder(h=e3d_h+1, d=e3d_d+4, center=true);
		}
		if (heatbreak_h > 0){
			hull(){
				translate([fansize/2-6+e3d_shiftx/2,fansize/2+e3d_shifty/2,0]) cube([12,heatbreak_h+1,4]);
				translate([fansize/2+e3d_shiftx-6,fansize/2+(e3d_h+1)/2+e3d_shifty-1-.02,length-4]) cube([12,heatbreak_h+1,4]);
			}
		}
	}
// heatbreak cooling
	if (heatbreak_h > 0){
		hull(){
			translate([fansize/2-5+e3d_shiftx/2,fansize/2+e3d_shifty/2,0]) cube([10,heatbreak_h,4]);
			translate([fansize/2+e3d_shiftx-5,fansize/2+(e3d_h+1)/2+e3d_shifty-1,length-4]) cube([10,heatbreak_h,5]);
		}
	}
// heatsink
	rotate([90,0,0]) translate([fansize/2+e3d_shiftx,length+e3d_d/2,-fansize/2-(e3d_h+1)/2-e3d_shifty-.01]) cylinder(h=e3d_h, d=e3d_d);
	rotate([90,0,0]) translate([fansize/2+e3d_shiftx,length+e3d_d/2,-fansize/2+(e3d_h+1)/2-e3d_shifty-1-.02]) cylinder(h=1+.03, d=e3d_d-3);
// fan hole
	translate([fansize/2,fansize/2,-.01]) cylinder(h=2, d=fanhole_d);
// fan screw 
	translate([(fansize-fanscrew)/2,(fansize-fanscrew)/2,-.01]) cylinder(h=10, d=fanscrew_d);
	translate([(fansize-fanscrew)/2,fansize-(fansize-fanscrew)/2,-.01]) cylinder(h=10, d=fanscrew_d);
	translate([fansize-(fansize-fanscrew)/2,(fansize-fanscrew)/2,-.01]) cylinder(h=10, d=fanscrew_d);
	translate([fansize-(fansize-fanscrew)/2,fansize-(fansize-fanscrew)/2,-.01]) cylinder(h=10, d=fanscrew_d);
//
	translate([-1+e3d_shiftx,-1+e3d_shifty,length-2+e3d_d*0.8]) cube([fansize+e3d_shifty+10,fansize+e3d_shifty+10,20]);
//
	hull(){
		translate([fansize/2,fansize/2,2-.02]) cylinder(h=0.01, d=fanhole_d, center=true);
		translate([(fansize-e3d_d)/2-3+2+e3d_shiftx,(fansize-e3d_h-1)/2+2+e3d_shifty,length]) cube([e3d_d+6-4,e3d_h-2+.01,.01]);
	}
	hull(){
		translate([(fansize-e3d_d)/2-3+2+e3d_shiftx,(fansize-e3d_h-1)/2+2+e3d_shifty,length]) cube([e3d_d+6-4,e3d_h-2+.01,.01]);
		translate([(fansize-e3d_d)/2+e3d_shiftx+1,(fansize-e3d_h-1)/2+2+e3d_shifty,length]) cube([e3d_d-2,e3d_h-2+.01,e3d_d/3]);
	}
}
