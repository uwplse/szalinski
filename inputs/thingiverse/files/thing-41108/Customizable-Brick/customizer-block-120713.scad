/*Customizer Variables*/
width = 3; //[1:99]
length = 3; //[1:99]
thickness = 3; //[1:9]



/*Non customizer variables*/
knob_diameter=4.8+0;		//knobs on top of blocks
knob_height=2+0;
knob_spacing=8.0+0;
wall_thickness=1.45+0;
roof_thickness=1.05+0;
block_height=9.5+0;
pin_diameter=3+0;		//pin for bottom blocks with width or length of 1
post_diameter=6.5+0;
reinforcing_width=1.5+0;
axle_spline_width=2.0+0;
axle_diameter=5+0;
cylinder_precision=0.1+0;

block(length,width,thickness/3,axle_hole=false,reinforcement=true);

module block(width,length,height,axle_hole,reinforcement) {
	overall_length=(length-1)*knob_spacing+knob_diameter+wall_thickness*2;
	overall_width=(width-1)*knob_spacing+knob_diameter+wall_thickness*2;
	start=(knob_diameter/2+knob_spacing/2+wall_thickness);
	translate([-overall_length/2,-overall_width/2,0])
		union() {
			difference() {
				union() {
					cube([overall_length,overall_width,height*block_height]);
					translate([knob_diameter/2+wall_thickness,knob_diameter/2+wall_thickness,0]) 
						for (ycount=[0:width-1])
							for (xcount=[0:length-1]) {
								translate([xcount*knob_spacing,ycount*knob_spacing,0])
									cylinder(r=knob_diameter/2,h=block_height*height+knob_height,$fs=cylinder_precision);
						}
				}
				translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*height]);
				if (axle_hole==true)
					if (width>1 && length>1) for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-block_height/2])  axle(height+1);
			}
	
			if (reinforcement==true && width>1 && length>1)
				difference() {
					for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) reinforcement(height);
					for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-0.5]) cylinder(r=post_diameter/2-0.1, h=height*block_height+0.5, $fs=cylinder_precision);
				}
	
			if (width>1 && length>1) for (ycount=[1:width-1])
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) post(height,axle_hole);
	
			if (width==1 && length!=1)
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,overall_width/2,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
	
			if (length==1 && width!=1)
				for (ycount=[1:width-1])
					translate([overall_length/2,(ycount-1)*knob_spacing+start,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
		}
}

module post(height,axle_hole=false) {
	difference() {
		cylinder(r=post_diameter/2, h=height*block_height,$fs=cylinder_precision);
		if (axle_hole==true) {
			translate([0,0,-block_height/2])
				axle(height+1);
		} else {
			translate([0,0,-0.5])
				cylinder(r=knob_diameter/2, h=height*block_height+1,$fs=cylinder_precision);
		}
	}
}

module reinforcement(height) {
	union() {
		translate([0,0,height*block_height/2]) union() {
			cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height],center=true);
			rotate(v=[0,0,1],a=90) cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height], center=true);
		}
	}
}

module axle(height) {
	translate([0,0,height*block_height/2]) union() {
		cube([axle_diameter,axle_spline_width,height*block_height],center=true);
		cube([axle_spline_width,axle_diameter,height*block_height],center=true);
	}
}
			