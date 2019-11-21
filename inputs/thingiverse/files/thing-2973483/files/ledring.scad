// Create a custom light ring for photography, tools, microscope... whatever.
//
// Licensed under Creative Commons+Attribution
//
// To fulfill the attribution requirement, please link to:
// https://theheadlesssourceman.wordpress.com/2018/06/22/customizeable-light-ring
// or
// https://www.thingiverse.com/thing:2973483


// tool to visualize LED's -- set to 0 for printing!
show_leds=1; // [0:yes,1:no]

// tool to show where the LED's are shining -- set to 0 for printing!
show_beams=1; // [0:yes,1:no]

// how many LED's
num_leds=12;

// the diameter of LED you are using
led_dia=5;

// oversize the led holes slightly so they fit properly
led_fit=0.3;

// the diameter of the center hole (can be 0, in which clamp_thick becomes radius of a post -- set that to 0 as well to turn it off)
inner_dia=40;

// the diameter of where the LED's are placed
led_location_dia=70;

// make sure to have at least this much material around LED's
led_wall_thick=0.2;

// a shade around the ring (0 to disable)
shade_thickness=0.5; 

// height of the shade
shade_height=5;

// vertical distance to what led is pointing at
focus_min=50;

// set to something other than focus_min point at a range of distances
focus_max=60;

// how many leds to focus on a given point of the focus range (should be evenly-divisible by num_leds)
focus_symmetry_points=3;

// the base plate
plate_thick=0.5;

// how thick the walls of the clamp collar are
clamp_thick=1.5;

// how long the clamp collar is (can be 0)
clamp_len=10;

// how far out the clamp collar's tab extends (can be 0)
clamp_tab=8;

// 1 is usually fine, but if you don't have access to the end, may want more than one piece
num_clamp_tabs=1;

// put a hole in the clamp collar tab (can be 0)
clamp_hole_dia=3;

// automatically limited by the led spacing, so for max available spacing, set to a large number
clamp_gap=2;

// flip the clamp to the back side -- will require support material to print
clamp_direction=0; // [0:front side,1:back side]

// resolution 1=low(aka 1x) 2=mid 3=high
resfactor=2;

/* [hidden] */
focus_avg=(focus_min+focus_max)/2;
focus_delta=focus_max-focus_min;

// make $fn more automatic
function myfn(r)=max(3*r,12)*resfactor;
module cyl(r=undef,h=undef,r1=undef,r2=undef){cylinder(r=r,h=h,r1=r1,r2=r2,$fn=myfn(r!=undef?r:max(r1,r2)));}
module circ(r=undef){circle(r=r,$fn=myfn(r));}
module ball(r=undef){sphere(r=r,$fn=myfn(r));}

function widthOfPieslice(od,endangle,startangle=0)=od*sin((max(startangle,endangle)-min(startangle,endangle)));
function angleOfWidth(od,width)=asin(width/od);

// if h=0, generate a 2d shape
// if an id is given, will cut that out
// angles are clock-face rotation
module pieslice(od,endangle,startangle=0,id=0,h=0){
	angle=max(startangle,endangle)-min(startangle,endangle);
	rotate([0,0,90-min(startangle,endangle)]){
		if(h>0){
			linear_extrude(h) difference(){
				if(endangle<startangle)circ(r=od/2);
				difference(){
					circ(r=od/(endangle<startangle?1:2));
					translate([-od/2,0]) square([od,od]);
					rotate([0,0,180-angle]) translate([-od/2,0]) square([od,od]);
				}
				if(id>0){
					circ(r=id/2);
				}
			}
		}else{
			difference(){
				if(endangle<startangle)circ(r=od/2);
				difference(){
					circ(r=od/(endangle<startangle?1:2));
					translate([-od/2,0]) square([od,od]);
					rotate([0,0,180-angle]) translate([-od/2,0]) square([od,od]);
				}
				if(id>0){
					circ(r=id/2);
				}
			}
		}
	}
}

// calculate what tilt angle an led should be
function percent2tilt(percent)=atan((led_location_dia/2)/(focus_min+percent%1*focus_delta));

// draw the leds
module leds(vectors=false){
	step=360/num_leds;
	rotate([0,0,180/num_leds]) for(a=[0:step:359.99]){
		rotate([0,0,a]) translate([led_location_dia/2,0,0]) rotate([0,-percent2tilt(a/(360/focus_symmetry_points)),0]){
			color([1,1,1,0.7]) union(){
				cyl(r=led_dia/2,h=led_dia);
				translate([0,0,led_dia]) ball(r=led_dia/2);
			}
			if(vectors){
				color([1,0,0]) cylinder(r=0.1,h=500);
			}
		}
	}
}

module _ring(){
	sqsz=led_dia+led_wall_thick*2;
	avg_tilt=-percent2tilt(0.5);
	led_gap=0.13;
	difference(){
		union(){
			translate([0,0,plate_thick]) difference(){
				rotate_extrude($fn=myfn(led_location_dia/2)) translate([led_location_dia/2,0,0]) rotate([0,0,-avg_tilt]) square([sqsz,sqsz],center=true);
				translate([0,0,-sqsz*2]) cyl(r=led_location_dia/2+sqsz,h=sqsz*2);
			}
			// the bottom plate
			linear_extrude(plate_thick) difference(){
				circ(r=led_location_dia/2+sqsz);
				circ(r=inner_dia/2+0.3);
			}
			// shade
			if(shade_thickness>0){
				linear_extrude(shade_height) difference(){
					circ(r=led_location_dia/2+sqsz+shade_thickness);
					circ(r=led_location_dia/2+sqsz);
				}
			}
		}
		// cut holes for leds
		rotate([0,0,180/num_leds]) for(a=[0:360/num_leds:359.99]){
			rotate([0,0,a]) translate([led_location_dia/2,0,0]) rotate([0,-percent2tilt(a/(360/focus_symmetry_points)),0]){
				translate([0,0,-sqsz/2]) cyl(r=led_dia/2+led_fit,h=sqsz*2);
			}
		}
	}
}

module ledRing(showLeds=true,showBeams=false){
	sqsz=led_dia+led_wall_thick*2;
	outer_dia=led_location_dia+sqsz*2;
	_sa1=angleOfWidth(inner_dia,clamp_gap);
	_sa2=360/num_leds-angleOfWidth(led_location_dia,led_dia*2+led_wall_thick*2);
	slice_angle=min(_sa1<=1||_sa1>1?_sa1:_sa2,_sa2);
	clamp_wall_r1=inner_dia/2;
	clamp_wall_r2=inner_dia/2+clamp_tab;
	clamp_wall_measurement_r=(clamp_wall_r1+clamp_wall_r2)/2; // at what point the clamper tabs measure clamp_thick
	clamp_wall_angle=slice_angle+angleOfWidth(clamp_wall_measurement_r*2,clamp_thick*2);
	difference(){
		union(){
			_ring();
			// clamp
			translate([0,0,-(clamp_direction==0?0:clamp_len-plate_thick)]) {
				linear_extrude(clamp_len) difference(){
					circ(r=inner_dia/2+clamp_thick);
					circ(r=inner_dia/2+0.3);
				}
				if(clamp_gap>0&&clamp_thick>0&&inner_dia>0&&num_clamp_tabs>0) {
					// clamp tabs
					for(a=[0:360/num_clamp_tabs:359.99]) rotate([0,0,a]) difference() {
						// tab
					rotate([0,0,clamp_wall_angle/2-90]) pieslice(clamp_wall_r2*2,clamp_wall_angle,id=clamp_wall_r1*2,h=clamp_len);
					// cut out the clamp tab hole
					translate([(clamp_wall_r1+clamp_wall_r2)/2+clamp_thick/2,0,clamp_len/2]) rotate([90,0,0]) translate([0,0,-clamp_gap/2-1]) cyl(r=clamp_hole_dia/2,h=clamp_gap+2);
				}
			}
		}
		}
		// cut out the slot
		if(clamp_gap>0&&inner_dia&&num_clamp_tabs>0){
			for(a=[0:360/num_clamp_tabs:359.99]) rotate([0,0,a]) {
				rotate([0,0,slice_angle/2-90]) translate([0,0,-1-(clamp_direction==0?0:clamp_len-plate_thick)]) pieslice(outer_dia+shade_thickness+1,slice_angle,h=max(plate_thick,clamp_len)+2);
			}
		}
	}
	if(showLeds){
		leds(showBeams);
	}
}

ledRing(show_leds==1,show_beams==1);