/*
A printable selector valve for diverting fluid to different directions.  

This was designed with aquaponics / hydroponics in mind but may have many other uses.  
Its all customizable too, so there are lots of options, for example:  
* Valve can be servo controlled, or manual.  
* Any size + number of outlets you want, as well as multiple inlets so it can tee into the middle of a line. 
 
This is a work-in-progress and has not been physically tested yet.  See the instructions tab for details.

This is licensed under Creative Commons - Attribution - Share alike.  
For the Attribution requirement, you may simply reference:
	http://www.thingiverse.com/thing:436659


TODO:
	1) Improve maths to get diameter from number of selections and hole size
	2) Add o-rings (and std o-ring chooser?)
	3) Account for servo angle range (much less than 180, and what I have now would require 360)
	4) Is the off position even necessary?  In between any two selections is off!
Future improvements:
	1) gearing?
	2) Possibly make more printable somehow?
	3) A mounting bracket to affix it to something
	4) Spring-loaded?

*/

/* [main] */
control_via=0; // [0:servo (from the servo tab), 1:handle (from the handle tab)]
case_thickness=2;

exploded_view=true;
show_control=true;
show_top=true;
show_selector=true;
show_bottom=true;

/* [inlets] */
num_inlets=2; // Higher numbers are used to tee into lines (can be 0)
inlet_dia=10;
inlet_len=25;
inlet_angle=0; // Usually you'd want 0 (0=straight out .. 90=straight up)
inlet_pipe_thickness=1;
inlet_pipe_num_barbs=4; // Use 0 to turn off barbs
inlet_pipe_barb_height=1;
inlet_pipe_barb_width=3;

/* [outlets] */
num_outlets=3;
offPosition=true; // include an off position in addition to num_outlets
outlet_dia=7;
outlet_len=20;
outlet_angle=0; // Usually you'd want 0 (0=straight out .. 90=straight down)
outlet_pipe_thickness=0.5;
outlet_pipe_num_barbs=4; // Use 0 to turn off barbs
outlet_pipe_barb_height=0.5;
outlet_pipe_barb_width=2;

/* [attachment] */
num_screws=6; // can be 0
screw_od=2;
screw_pilot=1.5;
screw_countersink=5; // can be 0

/* [handle] */
handle_width=15;
handle_thickness=4;
handle_length=75;
handle_shaft_dia=7.5;
handle_shaft_height=10;

/* [servo] */
servo_hole_pilot=3;
servo_hole_spaing=10;
spline_id=4;
spline_od=5;
num_splines=50;
spline_height=4;
spline_distance_to_screw_surface=10;
top_screws_distance_to_spline=17;
bottom_screws_distance_to_spline=30;

/* [advanced] */
selector_margin=3;
selector_fit=0.3;
inner_cavity_height=5;
selector_thickness=3;

/* [hidden] */
pi=3.14159265358979323846264338327950288419716939937510582;
scoche=0.001;
halfscoche=scoche/2;

shaft_dia=control_via==0?spline_od+case_thickness:handle_shaft_dia;
shaft_length=spline_height-spline_height/10+case_thickness+inner_cavity_height;
total_selections=offPosition?num_outlets+1:num_outlets;
outlet_center_dia=shaft_dia+2*selector_margin+outlet_dia; // This may need to be adjusted for if we have more outlet diameters than circumference
selector_dia=outlet_center_dia+outlet_dia+2*selector_margin;
servo_rotation=180/num_screws;
handle_shaft_sides=4;


module case_bottom() {
	pipe_angle=90+outlet_angle;
	translate([0,0,-case_thickness]) difference() {
		union() {
			for(i=[0:num_outlets-1]){ // outlet pipes outside
				rotate([0,180,i*360/total_selections-servo_rotation]) translate([outlet_center_dia/2,0,outlet_dia/2]) rotate([0,90,0]) pipe_elbow(0,outlet_dia+outlet_pipe_thickness*2,0,outlet_len,false,true,pipe_angle,num_barbs=outlet_pipe_num_barbs,barb_height=outlet_pipe_barb_height,barb_width=outlet_pipe_barb_width); // the outside
			}
			cylinder(r=selector_dia/2+selector_fit+case_thickness,h=case_thickness+selector_thickness); // the outside of the case
			for(i=[0:num_screws-1]){
				rotate([0,0,i*360/num_screws]) translate([selector_dia/2+selector_fit+case_thickness+screw_od/2,0,0]) { // screw bodies
					cylinder(r=screw_od/2+case_thickness,h=case_thickness+selector_thickness,$fn=max($fn,12));
				}
			}
		}
		for(i=[0:num_screws-1]){
			rotate([0,0,i*360/num_screws]) translate([selector_dia/2+selector_fit+case_thickness+screw_od/2,0,0]) { // screw pilot holes
				translate([0,0,case_thickness]) cylinder(r=screw_pilot,h=case_thickness+selector_thickness,$fn=max($fn,12));
			}
		}
		for(i=[0:num_outlets-1]){ // outlet_pipes_inside
			rotate([0,180,i*360/total_selections-servo_rotation]) translate([outlet_center_dia/2,0,outlet_dia/2]) rotate([0,90,0]) pipe_elbow(outlet_dia,0,outlet_dia+case_thickness+scoche,outlet_len,true,false,pipe_angle); // the outside
		}
		translate([0,0,case_thickness]) cylinder(r=selector_dia/2+selector_fit,h=selector_thickness+scoche); // cut out the inside of the cup
	}
}

module selector() {
	if(control_via==0){
		difference() { // servo shaft
			cylinder(r=shaft_dia/2,h=shaft_length+selector_thickness,$fn=max($fn,16)); // servo shaft
			translate([0,0,shaft_length+selector_thickness-spline_height]) servo_spline();
		}
	}else{
		union(){
			translate([0,0,-halfscoche]) cylinder(r=handle_shaft_dia/2,h=handle_shaft_height+selector_thickness+handle_thickness,$fn=handle_shaft_sides);
			cylinder(r=handle_shaft_dia/2,h=handle_shaft_height+selector_thickness,$fn=max($fn,16)); // servo shaft
		}
		
	}
	difference() {
		cylinder(r=selector_dia/2,h=selector_thickness); // the selector
		translate([outlet_center_dia/2,0,-halfscoche]) cylinder(r2=inlet_dia/2,r1=outlet_dia/2,h=selector_thickness+scoche); // the hole
	}
}

module case_top(pipe_angle=90){
	countersink_height=screw_countersink>screw_od?(screw_countersink-screw_od)/2:0;
	pipe_angle=90+inlet_angle;
	translate([0,0,selector_thickness]) difference() {
		union() {
			for(i=[0:num_inlets-1]){
				rotate([0,0,i*360/num_inlets-servo_rotation]) translate([selector_dia/2-inlet_dia/2,0,inlet_dia/2]) rotate([0,90,0]) pipe_elbow(0,inlet_dia,0,inlet_len,false,true,pipe_angle,num_barbs=inlet_pipe_num_barbs,barb_height=inlet_pipe_barb_height,barb_width=inlet_pipe_barb_width); // the outside
			}
			if(control_via==0){
				servo_screw_posts(extra=case_thickness+inner_cavity_height);
			}
			cylinder(r=selector_dia/2+selector_fit+case_thickness,h=case_thickness+inner_cavity_height); // the outside of the case
			for(i=[0:num_screws-1]){ // screw bodies
				rotate([0,0,i*360/num_screws]) translate([selector_dia/2+selector_fit+case_thickness+screw_od/2,0,0]) {
					cylinder(r=screw_od/2+case_thickness,h=case_thickness+inner_cavity_height+countersink_height,$fn=max($fn,12));
				}
			}
		}
		for(i=[0:num_screws-1]){ // screw holes
			rotate([0,0,i*360/num_screws]) translate([selector_dia/2+selector_fit+case_thickness+screw_od/2,0,0]) {
				cylinder(r=screw_od,h=case_thickness+inner_cavity_height+scoche,$fn=max($fn,12));
				if(screw_countersink>screw_od) translate([0,0,inner_cavity_height+case_thickness]) cylinder(r2=screw_countersink,r1=screw_od,h=countersink_height,$fn=max($fn,12));
			}
		}
		for(i=[0:num_inlets-1]){
			rotate([0,0,i*360/num_inlets-servo_rotation]) translate([selector_dia/2-inlet_dia/2,0,inlet_dia/2]) rotate([0,90,0]) pipe_elbow(inlet_dia-inlet_pipe_thickness*2,0,0,inlet_len,true,false,pipe_angle); // the inside
		}
		translate([0,0,-scoche]) cylinder(r=selector_dia/2+selector_fit,h=case_thickness+scoche); // the inside cup
		translate([0,0,-halfscoche]) cylinder(r=shaft_dia/2+selector_fit,h=case_thickness+inner_cavity_height+scoche,$fn=max($fn,16)); // the shaft hole
	}
}

module servo_spline() {
	spline_tooth_radius=(spline_od/2-spline_id/2);
	spline_center_radius=(spline_od+spline_id)/4;
	circumference_per_spline=spline_id*pi/num_splines;
	spline_vertical_squish=(spline_tooth_radius/circumference_per_spline)*3/4;
	/*
	// alignment helpers
	difference(){
		cylinder(r=spline_od/2+0.1,h=spline_height,$fn=32);
		cylinder(r=spline_od/2,h=spline_height,$fn=32);
	}
	difference(){
		cylinder(r=spline_id/2,h=spline_height,$fn=32);
		cylinder(r=spline_id/2-0.1,h=spline_height,$fn=32);
	}*/
	cylinder(r=spline_id/2+0.01,h=spline_height,$fn=32);
	for(i=[0:num_splines-1]){
		rotate([0,0,i*360/num_splines]) translate([spline_center_radius-spline_tooth_radius/pi+0.1,0,0]) scale([1,0.5/spline_vertical_squish,1]) cylinder(r=spline_tooth_radius*3/4,h=spline_height,$fn=3);
	}
}

module handle() {
	fit=0.2;
	difference() {
		union() {
			translate([0,0,handle_shaft_height]) hull() {
				cylinder(r=handle_width/2,h=handle_thickness);
				translate([-handle_length,0,0]) cylinder(r=handle_width/2,h=handle_thickness);
			}
			cylinder(r=handle_shaft_dia/2+case_thickness,h=handle_shaft_height);
		}
		translate([0,0,-halfscoche]) cylinder(r=handle_shaft_dia/2+fit,h=handle_shaft_height+handle_thickness+scoche,handle_thickness+scoche,$fn=handle_shaft_sides);
	}
}

module servo() {
	screw_hole_od=servo_hole_pilot*3/2;
	screw_margin=2;
	screw_mount_x=top_screws_distance_to_spline+bottom_screws_distance_to_spline-screw_hole_od-screw_margin*2;
	screw_mount_y=servo_hole_spaing+screw_countersink-screw_od+screw_margin*2;
	screw_mount_z=screw_margin;
	body_x=screw_mount_x-(screw_hole_od+screw_margin)*2;
	body_y=screw_mount_y;
	body_z=body_x;
	//
	rotate([0,0,servo_rotation]) translate([top_screws_distance_to_spline/2-bottom_screws_distance_to_spline/2,0,0]) color([0.2,0.2,0.2]){
		translate([-body_x/2,-body_y/2,spline_height]) cube([body_x,body_y,body_z]);
		translate([0,0,spline_distance_to_screw_surface]) difference() {
			translate([-screw_mount_x/2,-screw_mount_y/2,0]) cube([screw_mount_x,screw_mount_y,screw_mount_z]);
			translate([-screw_mount_x/2+screw_hole_od/2+screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=screw_hole_od/2,h=screw_mount_z+scoche);
			translate([-screw_mount_x/2+screw_hole_od/2+screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=screw_hole_od/2,h=screw_mount_z+scoche);
			translate([ screw_mount_x/2-screw_hole_od/2-screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=screw_hole_od/2,h=screw_mount_z+scoche);
			translate([ screw_mount_x/2-screw_hole_od/2-screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=screw_hole_od/2,h=screw_mount_z+scoche);
		}
	}
	color([1,1,1]) servo_spline();
}

module servo_screw_posts(full_body=true,extra=0,$fn=16){
	screw_hole_od=servo_hole_pilot*3/2;
	screw_margin=2;
	screw_mount_x=top_screws_distance_to_spline+bottom_screws_distance_to_spline-screw_hole_od-screw_margin*2;
	screw_mount_y=servo_hole_spaing+screw_countersink-screw_od+screw_margin*2;
	screw_mount_z=screw_margin;
	body_x=screw_mount_x-(screw_hole_od+screw_margin)*2;
	body_y=screw_mount_y;
	body_z=body_x;
	//
	rotate([0,0,servo_rotation]) translate([top_screws_distance_to_spline/2-bottom_screws_distance_to_spline/2,0,0]) difference() {
		if(full_body) union(){
			hull() { // the stand-offs
				translate([-screw_mount_x/2+screw_hole_od/2+screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
				translate([-screw_mount_x/2+screw_hole_od/2+screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
			}
			hull() {
				translate([ screw_mount_x/2-screw_hole_od/2-screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
				translate([ screw_mount_x/2-screw_hole_od/2-screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
			}
			hull() { // make sure they are attached to the other thing
				translate([-screw_mount_x/2+screw_hole_od/2+screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra);
				translate([-screw_mount_x/2+screw_hole_od/2+screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra);
				translate([ screw_mount_x/2-screw_hole_od/2-screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra);
				translate([ screw_mount_x/2-screw_hole_od/2-screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra);
			}
		}else union() { // the stand-offs
			translate([-screw_mount_x/2+screw_hole_od/2+screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
			translate([-screw_mount_x/2+screw_hole_od/2+screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
			translate([ screw_mount_x/2-screw_hole_od/2-screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
			translate([ screw_mount_x/2-screw_hole_od/2-screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2+case_thickness/2,h=extra+spline_distance_to_screw_surface);
		}
		union() { // the screw holes
			translate([-screw_mount_x/2+screw_hole_od/2+screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2,h=extra+spline_distance_to_screw_surface+scoche);
			translate([-screw_mount_x/2+screw_hole_od/2+screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2,h=extra+spline_distance_to_screw_surface+scoche);
			translate([ screw_mount_x/2-screw_hole_od/2-screw_margin,-screw_mount_y/2+screw_hole_od/2+screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2,h=extra+spline_distance_to_screw_surface+scoche);
			translate([ screw_mount_x/2-screw_hole_od/2-screw_margin, screw_mount_y/2-screw_hole_od/2-screw_margin,-scoche]) cylinder(r=servo_hole_pilot/2,h=extra+spline_distance_to_screw_surface+scoche);
		}
	}
}

module pipe_elbow(id,od,lead_in=0,lead_out=0,do_inside=true,do_outside=true,angle=90,num_barbs=3,barb_height=1,barb_width=2.5,barbs_on_inlet=false,barbs_on_outlet=true)
{
	lead_in=max(lead_in,inlet_dia/2);
	lead_out=max(lead_out,inlet_dia/2);
	if(do_inside&&do_outside) difference(){
		pipe_elbow(id,od,lead_in,lead_out,false,true,angle);
		pipe_elbow(id,od,lead_in,lead_out,true,false,angle);
	} else if(do_inside) union() {
		rotate([0,90,0])cylinder(r=id/2,h=lead_in+scoche);
		sphere(r=id/2);
		rotate([0,90-angle,0]) cylinder(r=id/2,h=lead_out+scoche);
	} else if(do_outside) union() {
		rotate([0,90,0])cylinder(r=od/2,h=lead_in);
		sphere(r=od/2);
		rotate([0,90-angle,0]) union() {
			cylinder(r=od/2,h=lead_out);
			if(num_barbs>0&&barbs_on_outlet) for(i=[0:num_barbs-1]) {
				translate([0,0,lead_out-barb_width*(i+1)]) cylinder(r2=od/2,r1=od/2+barb_height,h=barb_width);
			}
		}
	}
}

if (exploded_view){
	if(show_control) translate([0,0,40+case_thickness+inner_cavity_height]) if(control_via==0){
			servo();
		}else{
			handle();
		}
	if(show_top) translate([0,0,20]) case_top();
	if(show_selector) selector();
	if(show_bottom) translate([0,0,-20]) case_bottom();
}
else{
	if(show_control) translate([0,0,case_thickness+inner_cavity_height+selector_thickness]) if(control_via==0){
			translate([0,0,selector_thickness]) servo();
		}else{
			translate([0,0,handle_shaft_height-handle_thickness]) handle();
		}
	if(show_top) case_top();
	if(show_selector) selector();
	if(show_bottom) case_bottom();
}
