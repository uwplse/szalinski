//
// Knick's finger v3.0E, (c) Nicholas Brookins, http://www.thingiverse.com/thing:904304
//

//Choose which item to build, or preview the full finger (with less accuracy).  Options include the Socket (rubber), the Base, Segment 1 (middle), Segment 2 (tip), Tip cover (rubber), Bumper (rubber) for the middle section, Hinge plugs to cover the nuts (rubber), and the linkage for back of hand
build_item = 0; //[0:Preview All, 1:Finger Socket, 2:Base Hinge, 3:Middle Section, 4:Tip Section, 5:Tip for 1 segment, 6:Tip Cover, 7:Middle Bumper, 8:Hinge Plugs, 9: Wrist Linkage]
//How many digit segments/hinges to create.  Currently only 2, but 1 will be supported soon..  
segments = 2; // [1,2]

//build parts more crudely, but much more quickly - for twiddling.  print mode automatically turns this off
fast = 1* 1;

// rotate the base and tip parts, to see how the hinges interact with the middle section.  Only relevant when previewing.  0 for straight, and up to 95 for fully bent.
rotatetest = 0; //[0:95]
//explode parts apart to see them individually better.  Only relevant when previewing.
explode = 0;
//print mode - puts items into print orientation, disables fast mode, and other tweaks to make proper exportable models.  
print = 0;

//height of the base section, which connects to the socket and has the first hinge.  Set to zero for minimum height.
base_height = 0;
//width of the base section
base_width = 17;
//multiplier for rounding of the hinges.  larger numbers make for less rounding. set to 0 to disable.
base_hingerounding = 1.4;

//length of the 1st segment, often the middle part.  
middle_length = 20;
//height of the middle part.  The hinges depend on this variable too.
middle_height = 10;
//width of segment 1, and generally the width between the hinges
middle_width = 7;
//Which form of sides to use for the middle section.  
middle_sides = 2;//[0:Plain sides, 1:Built-in bumper, 2:Slots for rubber bumper]
//width of the hinges
hinge_width = 14.5;

hinge_bulge = 1* 0;
//Diameter of the clearance hole around the hinge pin nuts
hinge_pinclearance = 7;
//clearance between hinge and middle section on sides
hinge_sideclearance = .25;
//vertical clearance for the curve between middle section and hinges, where tendon/elastic pass
hinge_clearance = 1;
hinge_diameter = middle_height + hinge_clearance;
//the thickness of the hinge in between the middle section and nut.  
hinge_offset = 1;
//Depth of the indent in the center of the middle part of hinge, allowing clearnce for the elastic or tendon
hinge_indent_depth = .5;
//the width of the hinge indent
hinge_indent_width = middle_width/2;
//width of the nut for the plug cutout
hinge_nutwidth = 4.05;
//thickness of the nut for the plug cutout
hinge_nutthickness = 2.2;
//radius of the hinge pin/axle  
hinge_pinradius = 1.075;
//extra clearance for the hinge plugs
hinge_plugclearance = 1*.25;
//how much curved bulge to put on the plugs
hinge_plugbulge = 1;

tip_corelength = middle_height/2 - hinge_clearance;
//length of the overall tip
tip_length = 16;
//width of the post ridge
tip_corewidth = 11.5;
//width of the tip cyninder near the hinge
tip_width = 15.25;
//amount of rounding on the tip hinges
tip_hingerounding = 1.3;
//width of the post conencting tip to tip cover
tip_postwidth = 10;
//width at the base of the rubber tip cover
tip_cover_width = 13.75;
//the percentage of the tip cover length which the fingernail covers
tip_fingernail_ratio = .55;

//diameter of the top of socket, roughly the diameter/width of the finger stump nearer the top
socket_width = 17;
//diameter of the bottom of socket, roughly the diameter/width of the finger stump bottom
socket_bottomwidth = 18;
//Depth of the socket, roughly equates to the length of the stump
socket_depth = 27;
//thickness of the rubber socket
socket_thickness = 2;
//width of the post connecting the socket to the base
socket_postwidth = 13;
//width of the post ridge
socket_corewidth = 16;
//Include extra clearance for hinge to close into a fist
socket_hingeclearance = 1;
//include extra clearance for tendon string
socket_stringclearance = 1;

washer_depth_inside = 1*0;
//how thick to make the built-in washers on the hinges
washer_depth_outside = .4;
//how wide to make the washers
washer_radius = 1.5;

//The height of any elastic/tendon tunnels 
tunnel_height = 2.1;

//tunnel_rounded = .25;
//clearance for the tunnels to the side
tunnel_clearance = .6;
//radius of the elastic and tendon tunnels
tunnel_radius = 1.2;

//The radius for a scallop on the left side of the socket, to make room for webbing for the next finger.
scallop_left = 0;
//The radius for a scallop on the right side of the socket, to make room for webbing for the next finger.
scallop_right = 10;
//The vertical offset of the scallop
scallop_offset = 5;

//length of the back-of-hand linkage
linkage_length = 65;
//width of the linkage
linkage_width = 6;
//height of the linkage
linkage_height = 4.5;
//which end style to use for end1
linkage_end1 = 1; //[0:Plain,1:Hole,2:Peg,3:Loop,4:Cup, 5:Hook ]
//which end style to use for end2
linkage_end2 = 5; //[0:Plain,1:Hole,2:Peg,3:Loop,4:Cup,5:Hook ]

//advanced, width of the peg mode on linkage
linkage_pegwidth = 2.8;
//advanced, length of the peg mode on linkage
linkage_peglength = 6;
//advanced, length of the hole mode on linkage
linkage_holelength = 9;
//advanced, radius of the peg mode on linkage
linkage_holeradius = 1.44;
//advanced, width of the cup mode on linkage
linkage_cupwidth = 4.8;
linkage_cupthickness = 1* 1;
//advanced, width of the loop mode on linkage
linkage_loopwidth = 7;
//advanced, length of the loop mode on linkage
linkage_looplength = 8;
//advanced, offset of the loop mode on linkage
linkage_loopoffset = .2;
//advanced, height of the loop mode on linkage
linkage_loopheight = 3.5;
//advanced, thickness of the loop mode on linkage
linkage_loopthickness = 2;

linkage_loopextrusion = 2.5 * 1;
//advanced, height of the hook mode on linkage
linkage_hookheight = 6;
//advanced, length of the hook mode on linkage
linkage_hooklength = 13;
//advanced, width of the hook mode on linkage
linkage_hookwidth = 6;
//advanced, thickness of the hook mode on linkage
linkage_hookthickness = 2;
//advanced, offset of the hook mode on linkage
linkage_hookoffset = 0.25;
linkage_hookopening_offset = .25 *1;
linkage_hookvertical_offset = -.4 *1;
//how much rounding to apply to end 1
linkage_round_end1 = .5;
//how much rounding to apply to end 2
linkage_round_end2 = 1;

tip_clearance = 1*.5;
tip_postheight = 1*2;
tip_postridgeheight = 1*1.5;
socket_ridgeheight = 1* 1.5;
socket_postheight = 1* 2;
socket_ridgehold =1* 2;

fn_fast = 30 * 1;
fn_accurate = 1* 120;

//length of tip in 1 segment mode, must be a minimum of middle_height
tip_mid_length = 6; //minimum of hinge width

//auto variables
//how far to explode
fnv = (fast==1 && print==0) ? fn_fast : fn_accurate;
explode_distance = explode ? 12 : 0;
//stump indent, offset for sphere
stump_indent = socket_postwidth*2;
//length of bottom part
tunnel_bottomlen = middle_length/2 - middle_height/2 + hinge_clearance*2 +.02;			

//tip_length = 12;
tip_fingernail_rot = 1 * -3;
tip_fingernail_offset = 1 * 2.5;
tip_cuticle_rot = 1* 20;

tip_min_bottom = tip_postheight + tip_postridgeheight+hinge_clearance*3;
fn_temp = tip_fingernail_ratio * tip_length;
tip_fn_length = (tip_length-fn_temp >= tip_min_bottom) ?fn_temp : tip_length-tip_min_bottom;

//make magic happen
main();

module main(){
	//Base section
	if (build_item == 2  || build_item == 0){
		//We always have a base, so this is our reference position / in the center
		make_base();
	}
	
	//Base hinge Plugs
	if (build_item == 8  || build_item == 0){
		offset = middle_width/2 + hinge_sideclearance*2 + hinge_plugclearance*2+ hinge_offset+ (explode_distance);
		rot = print ? 90 : 0;
		
		rotate([0,90,0])
		union(){
			translate([0,0,offset])			
			rotate([0,rot,0])
			make_plug();

			rotate([0,180 + rot*3,0])
			translate([0,0,offset])
			make_plug();
			
		}
	}
	
	//1 segment tip
	if (segments == 1 && (build_item == 5 || build_item == 0)){
		translate([0,0,middle_height/2 - hinge_clearance*1.5+ (explode_distance) ])
		rotate([-(rotatetest>0?rotatetest:0) + (print ? 180 : 0),0,0])
		make_mid_tip();
	}

	//Middle section for 2 segments
	if (segments == 2 && (build_item == 3 || build_item == 0)){
		rotate([rotatetest>0 ? -rotatetest : 0, print ? -90 : 0,0])
		//mid section
		translate([0, 0, middle_length/2 + (explode_distance)])
		make_middle();
	}
	
	//Bumper for middle section
	if (segments == 2 && (build_item == 7  || build_item == 0 )){
		rotate([rotatetest>0 ? -rotatetest : 0, 0, 0])
		translate ([0, (explode_distance*2), middle_length/2  + (explode_distance)])
		make_bumper();
	}
	
	//Socket
	if (build_item == 1  || build_item == 0){
		rotate([0,(print? 180 : 0),0])
		translate([0,0, -middle_height/2 - base_height -socket_postheight+.5 - (explode_distance) ])
		make_socket();
	}

	//2 Segment Tip with hinge
	if (segments == 2 && (build_item == 4 || build_item == 0)){
		rotate([-(rotatetest>0? rotatetest :0) + (print ? 180 : 0),0,0])
		translate([0,0,middle_length + (explode_distance*2) ])
		rotate([-(rotatetest>0? rotatetest :0),0,0])
		make_tip();
	}
	
	//Tip hinge Plugs
	if (segments == 2 && (build_item == 8  || build_item == 0)){
		offset = middle_width/2 + hinge_sideclearance*2 + hinge_plugclearance*2+ hinge_offset+ (explode_distance);
		rot = print ? 90 : 0;

		rotate([-(rotatetest>0? rotatetest :0),0,0])
		translate([0,0,middle_length + (explode_distance*2)])

		rotate([0,90,0])
		union(){
			translate([0,0,offset])			
			rotate([0,rot,0])
			make_plug();

			rotate([0,180 + rot*3,0])
			translate([0,0,offset])
			make_plug();
			
		}
	}
	
	//Tip cover
	if (build_item == 6 || build_item == 0){
		rot = (rotatetest>0) ? -rotatetest : 0;
		pad = (rotatetest>0) ? rotatetest/100*middle_height/2:0;
		//middle_height/2 : 0;
		trans = (segments == 2 ? middle_length+ tip_corelength + (explode_distance*3):
		 tip_mid_length - .75 + (explode_distance*2)) - .5 + hinge_sideclearance + middle_height/2 -tip_postheight - tip_postridgeheight;
		 trans2 = (segments == 1 ? -1.8:-1); //TODO need to calculate this?
		rotate([rot,0,0])
		translate([0,trans2,trans])
		rotate([rot,0,0])
		translate([0,pad+1,pad])		//TODO - fix rotation test here
		make_tipcover();
	}

	//Linkage
	if (build_item == 9  || build_item == 0){
		rotate([(print) ? linkage_printrotate : 0,0,0])
		translate([0,-20,-40])
		make_linkage();
	}
}

//functions and model sections -- modify at own risk!
module make_tipcover (){
	difference(){
		intersection(){
			//plain rounded tip
			hull(){
				translate([0,0,tip_length-middle_height/2])
				resize ([tip_cover_width,0,0])
				sphere(tip_cover_width/2, $fn=fnv);
				translate([0,0,0.1])
				cylinder (h=tip_length - tip_cover_width/2, d=tip_cover_width, $fn=fnv);					
			}

			//cut out fingernail - 
			union(){
				rotate([tip_fingernail_rot,0,0])
				translate([0,tip_fingernail_offset,tip_length-middle_height+1])
				resize ([0, tip_cover_width*1.2, tip_cover_width*2.1])
				sphere(tip_cover_width*.8, $fn=fnv);

				rotate([tip_cuticle_rot,0,0])
				translate([0,0,-tip_cover_width + tip_length - tip_fn_length])
				cube([tip_cover_width*2,tip_cover_width*2,tip_cover_width*2], center=true);	
			}	
			//round fingerprint surface	
			translate([0,-1.5,tip_length/2-2])
			resize ([0, tip_cover_width*1.2, tip_length*2])
			sphere(tip_cover_width*.8, $fn=fnv);
		}
		//cut out post area
		union(){
			cylinder (h=tip_postheight+1, d=tip_postwidth, $fn=fnv);

			translate([0,0, tip_postheight])
			cylinder (h=tip_postridgeheight+hinge_clearance, d=tip_corewidth, $fn=fnv);	

		}
	}
}

module make_mid_tip(){
	difference () {
		//mainsection
		union(){
			//main section
			cube([middle_width,middle_height,tip_mid_length], center=true);

			//hinge circles
			rotate([0,90,0]) 
			translate([tip_mid_length/2,0,0]) 
			cylinder (d=middle_height, h=middle_width, center=true, $fn=fnv);	
			
			//post
			translate([0,0,tip_mid_length/2 +tip_postheight/2 ])
			cylinder (h=tip_postheight, d=tip_postwidth-tip_clearance, center=true, $fn=fnv);
			//ridge
			translate([0,0,tip_mid_length/2 + tip_postheight + tip_postridgeheight/2])
			cylinder (h=tip_postridgeheight, d=tip_corewidth-tip_clearance, center=true, $fn=fnv);
			
			resize ([base_width-2,0,0])
			cylinder (h=tip_mid_length, d=middle_height+tunnel_height*2.5, $fn=fnv, center=true);
			
		}
		
		//trim out bottom
		translate ([-middle_width/2-.05, middle_height/2-.01, -tip_mid_length/2-.01])
		cube([middle_width +.1, middle_width, tip_mid_length+.02]);		
		
		//trim SIDES
		translate([middle_width/2+.01, -middle_height, -tip_mid_length/2-.01])
		cube([middle_width, middle_height*2, tip_mid_length+.02], center=false);
		translate([-middle_width*1.5+.01, -middle_height, -tip_mid_length/2-.01])
		cube([middle_width, middle_height*2, tip_mid_length+.02], center=false);	
		

		//elastic hole
		hull(){
			translate([-tunnel_radius-tunnel_clearance, -middle_height/2 - tunnel_radius/2, -3]) 
			sphere(tunnel_radius, $fn=fnv);

			translate([0,-2,tip_mid_length]) 
			sphere(tunnel_radius, $fn=fnv);
		}	
		//enlarge
		translate([0,-2,tip_mid_length]) 
		sphere(tunnel_radius*1.75, $fn=fnv);
		//enlarge base side
		translate([-tunnel_radius-tunnel_clearance/2,-(middle_height/2 + tunnel_radius - tunnel_clearance*1.5),-tip_mid_length/2 + tunnel_radius*2 - tunnel_radius*6]) 	
		cylinder (r2=tunnel_radius, r1=tunnel_radius*1.5, h=tunnel_radius*6, $fn=fnv);
				
		//tendon hole
		hull(){
			translate([0, middle_height/2 + tunnel_radius/2, -3]) 
			sphere(tunnel_radius, $fn=fnv);

			translate([0,1.5,tip_mid_length]) 
			sphere(tunnel_radius, $fn=fnv);
		}	
		//enlarge
		translate([0,1.5,tip_mid_length]) 
		sphere(tunnel_radius*1.75, $fn=fnv);
		
		rotate([0,90,0]){
			//hinge pins
			translate([tip_mid_length/2,0,0]) 
			cylinder (r=hinge_pinradius, h=middle_width*2, center=true, $fn=fnv);
			
			//hinge indent
			translate([tip_mid_length/2,0,-tunnel_clearance]) {
				difference(){
					cylinder (r=middle_height/2+.1, h=hinge_indent_width, center=true, $fn=fnv);
					union(){
						cylinder (r=middle_height/2-hinge_indent_depth, h=hinge_indent_width+.1, center=true, $fn=fnv);												
						translate ([-middle_width/2 ,0,0])
						cube ([middle_width, middle_height,hinge_indent_width], center=true);
					}
				}
			}
		}
	}
}

module make_tip(){
	hinge_diam=hinge_diameter;
	union(){
		//cut center 
		difference () {
			//mainsection
			union(){
				intersection(){
					//hinge circles
					rotate([0,90,0]) 
					hull(){
						//hinge circle
						cylinder (d=hinge_diam, h=hinge_width, center=true, $fn=fnv);
						//nut hole ridges
						cylinder(h = hinge_width+hinge_bulge*2, d=hinge_pinclearance+1, center=true, $fn=fnv);
					}
					if(tip_hingerounding>0){
						resize([0,middle_height*tip_hingerounding,middle_height*tip_hingerounding])
						sphere(middle_height, $fn=fnv);
					}
				}
				difference(){
					//body 
					translate([0,0,.1])
					cylinder (h=tip_corelength+middle_height/2 +.2-tip_postheight - tip_postridgeheight, r1=tip_width/2, r2=tip_cover_width/2, $fn=fnv);
			
					//bottom trim
					translate ([0, hinge_diam/2 +middle_height/4 - tip_clearance, 0])
					cube ([ middle_width*2, middle_height/2, middle_height*2 ],true);	
				}
				//post
				translate([0,0,tip_corelength+middle_height/2 -tip_postheight - tip_postridgeheight])
				cylinder (h=tip_postheight, d=tip_postwidth-tip_clearance, $fn=fnv);
				//ridge
				translate([0,0,tip_corelength+middle_height/2 - tip_postridgeheight])
				cylinder (h=tip_postridgeheight, d=tip_corewidth-tip_clearance, $fn=fnv);

			}
			//area to cut
			union(){
				hull(){	
					//back cut
					rotate([0,90,0]) {
						cylinder (d=middle_height+hinge_clearance*2, h=middle_width+hinge_sideclearance*2, center=true, $fn=fnv);	
						//upper back cut						
						translate([middle_height/4,0,0]) 
						cylinder (d=middle_height, h=middle_width+hinge_sideclearance*2, center=true, $fn=fnv);	
					}
				}
				
				//front cut
				translate ([0, middle_height/2, 0])//-hinge_clearance])
				cube ([ middle_width+hinge_sideclearance*2, middle_height/2, middle_height +hinge_clearance],true);

				//back flat cut
				translate ([0, -middle_height/2 , -middle_height/4])
				cube([middle_width+hinge_sideclearance*2 , 5, middle_height/2], true);		

				rotate([0,90,0]){
					//nut hole
					cylinder (r=hinge_pinradius, h=middle_width*3, center=true, $fn=fnv);
					// cut dips around hole for axle nuts
					for (i=[-1:2:1])
					translate([0,0,i * (middle_width/2+hinge_sideclearance*2 + hinge_offset +5)])
					cylinder(h = 10, d=hinge_pinclearance, center=true, $fn=fnv);
				}

				//angle elastic hole
				hull(){
					translate([0,-(middle_height/2 + tunnel_radius/2),0]) 
					sphere(tunnel_radius, $fn=fnv);

					translate([0, -tunnel_radius-tunnel_clearance -.5, tip_corelength + middle_height/2]) 
					sphere(tunnel_radius, $fn=fnv);
				}	
				//enlarge
				translate([0,-(middle_height/2 + tunnel_radius/2) +tunnel_clearance*2,-0.1]) 
				//sphere(hole*1.5, $fn=fnv);
				cylinder (r1=tunnel_radius*2, r2=tunnel_radius, h=tunnel_radius*2.5, $fn=fnv);
				
				translate([0,-tunnel_radius*2-tunnel_clearance, tip_corelength + middle_height/2 ]) 
				sphere(tunnel_radius*1.75, $fn=fnv);

				//tendon hole
				hull(){
					translate([0,middle_height/2 + tunnel_radius, middle_height/2 - tunnel_radius]) 
					sphere(tunnel_radius, $fn=fnv);

					translate([0,1.5,tip_corelength + middle_height/2]) 
					sphere(tunnel_radius, $fn=fnv);
				}	
				//enlarge end
				translate([0,middle_height/2+tunnel_radius/2,middle_height/2 - tunnel_radius]) 
				sphere(tunnel_radius*1.5, $fn=fnv);
				
				translate([0,1.5,tip_corelength + middle_height/2]) 
				sphere(tunnel_radius*1.75, $fn=fnv);
			}
		}
		if(washer_depth_outside>0)
		rotate([0,90,0]){
			//washers
			difference(){
				cylinder (r=hinge_pinradius+washer_radius, h=middle_width+hinge_sideclearance*2, center=true, $fn=fnv);
				union(){
					cylinder(h = middle_width*2, r=hinge_pinradius, center=true, $fn=fnv);
					cylinder(h = middle_width + hinge_sideclearance*2 - washer_depth_outside*2, r=hinge_pinradius + washer_radius*2, center=true, $fn=fnv);						
				}
			}
		}
	}
}

module make_middle(){
	difference(){
		union(){
			difference(){
				union(){
					//main section
					cube([middle_width,middle_height,middle_length], center=true);

					//hinge circles
					rotate([0,90,0]) {
						for (i=[-1:2:1])
						translate([i*middle_length/2,0,0]) 
						cylinder (d=middle_height, h=middle_width, center=true, $fn=fnv);	
					}
					resize ([base_width-2,0,0])
					cylinder (h=middle_length, d=middle_height+tunnel_height*2.5, $fn=fnv, center=true);
				}
				
				//trim bottom hinge area			
				translate ([-middle_width/2-.05, middle_height/2, tunnel_bottomlen/2 + hinge_sideclearance])
				cube([middle_width +.1, middle_width, tunnel_bottomlen]);		
			
				translate ([-middle_width/2-.05, middle_height/2, -tunnel_bottomlen - tunnel_bottomlen/2 - hinge_sideclearance])
				cube([middle_width +.1, middle_width, tunnel_bottomlen]);		
			
				if(middle_sides == 2){		 
					//trim out bottom
					translate ([-middle_width/2-.05, middle_height/2,-tunnel_bottomlen - tunnel_bottomlen/2 - hinge_sideclearance])
					cube([middle_width +.1, middle_width, middle_length]);		
				
					translate ([-middle_width/2-.05, middle_height/2 - tunnel_radius , -tunnel_bottomlen/2 ])
					cube([middle_width +.1, middle_width, tunnel_bottomlen]);		
			
					//top
					translate ([-middle_width/2-.05, -middle_height/2 - middle_width + tunnel_clearance, 	-tunnel_bottomlen/2 ])
					cube([middle_width +.1, middle_width, tunnel_bottomlen]);		
			
					//sides
					translate ([middle_width/2 - 1, -middle_height/2, -tunnel_bottomlen/2 ])
					cube([middle_width +.1, middle_height, tunnel_bottomlen]);	

					translate ([-middle_width - middle_width/2 + 1,	-middle_height/2,	-tunnel_bottomlen/2 ])
					cube([middle_width +.1, middle_height, tunnel_bottomlen]);					
				}
			
				if(middle_sides == 1){
					//trim SIDES
					translate([middle_width/2+.01, -middle_height, -middle_length/2-.01 ])
					cube([middle_width, middle_height*2, tunnel_bottomlen], center=false);
					translate([middle_width/2+.01, -middle_height, middle_length/2+.01-len])
					cube([middle_width, middle_height*2, tunnel_bottomlen], center=false);
					translate([-middle_width*1.5+.01, -middle_height, middle_length/2+.01 - len])
					cube([middle_width, middle_height*2, tunnel_bottomlen], center=false);
					translate([-middle_width*1.5+.01, -middle_height, -middle_length/2-.01])
					cube([middle_width, middle_height*2, tunnel_bottomlen], center=false);
				}else{
					//trim SIDES
					translate([middle_width/2+.01, -middle_height, -middle_length/2-.01])
					cube([middle_width, middle_height*2, middle_length+.02], center=false);
					translate([-middle_width*1.5+.01, -middle_height, -middle_length/2-.01])
					cube([middle_width, middle_height*2, middle_length+.02], center=false);							
				}					

				//bottom tendon hole				
				translate([0,middle_height/2 + tunnel_radius - tunnel_clearance,0]) 
				cylinder (r=tunnel_radius, h=middle_length+middle_height, center=true, $fn=fnv);

				//top elastic holefrom base			
				translate([-tunnel_radius-tunnel_clearance,-(middle_height/2 + tunnel_radius - tunnel_clearance),0]) 
				cylinder (r=tunnel_radius, h=middle_length+middle_height, center=true, $fn=fnv);
				//enlarge tip side for knot
				translate([-tunnel_radius-tunnel_clearance/2, -(middle_height/2 + tunnel_radius - tunnel_clearance*1.8), middle_length/2-tunnel_radius*3]) 	
				cylinder (r1=tunnel_radius*1.3, r2=tunnel_radius, h=tunnel_radius*6, $fn=fnv);
				//enlarge base side
				translate([-tunnel_radius-tunnel_clearance,-(middle_height/2 + tunnel_radius - tunnel_clearance*1.5),-middle_length/2 + tunnel_radius*2 - tunnel_radius*6]) 	
				cylinder (r2=tunnel_radius/2, r1=tunnel_radius*1.5, h=tunnel_radius*6, $fn=fnv);

				//enlarge top angled elastic hole, tip side 
				translate([tunnel_radius+tunnel_clearance/2, -(middle_height/2 + tunnel_radius - tunnel_clearance*1.5), middle_length/2-tunnel_radius*2]) 	
				cylinder (r1=tunnel_radius, r2=tunnel_radius*1.5, h=tunnel_radius*6, $fn=fnv);
				//bottom knot flare
				translate([0,middle_height/2 -.5,-middle_length/2+middle_height/3+1.6])
				sphere (tunnel_radius*1.8, $fn=fnv);			

				//top tunnel down
				hull(){
					translate([ tunnel_radius+tunnel_clearance/2 ,-middle_height/2 - tunnel_radius*.6, middle_length/2])		
					sphere (tunnel_radius, $fn=fnv);			

					translate([0,middle_height/2 + tunnel_radius*.8,-middle_length/3 - tunnel_radius])
					sphere (tunnel_radius, $fn=fnv);		
				}	

				//hinge indent
				rotate([0,90,0]) {
					translate([-middle_length/2,0,0]) {
						difference(){
							cylinder (r=middle_height/2+.1, h=hinge_indent_width, center=true, $fn=fnv);
							cylinder (r=middle_height/2-hinge_indent_depth, h=hinge_indent_width+.1, center=true, $fn=fnv);
							translate ([middle_width/2 ,0,0])
							cube ([middle_width, middle_height ,hinge_indent_width], center=true);
						}
					}
					
					translate([middle_length/2,0,-tunnel_clearance]) {
						difference(){
							cylinder (r=middle_height/2+.1, h=hinge_indent_width, center=true, $fn=fnv);
							union(){
								cylinder (r=middle_height/2-hinge_indent_depth, h=hinge_indent_width+.1, center=true, $fn=fnv);												
								translate ([-middle_width/2 ,0,0])
								cube ([middle_width, middle_height,hinge_indent_width], center=true);
							}
						}
					}
					
					//flat indent for bottom
					translate([0,middle_height/2,0])// + tunnel_radius - tunnel_clearance,0]) 
					cube ([middle_length+6,hinge_indent_depth*2,hinge_indent_width], center=true);
				}
			}
			rotate([0,90,0]){
				//washers
				for (i=[-1:2:1])
				translate([i*middle_length/2,0,0]) 
				cylinder (r=hinge_pinradius+washer_radius, h=middle_width+washer_depth_inside*2, center=true, $fn=fnv);
			}
		}
		
		//hinge pins
		rotate([0,90,0]) {
			for (i=[-1:2:1])
			translate([i*middle_length/2,0,0]) 
			cylinder (r=hinge_pinradius, h=middle_width*2, center=true, $fn=fnv);
		}
	}
}

module make_bumper(){
	union(){
		intersection(){
			difference(){
				resize ([base_width-2,0,0])
				cylinder (h=tunnel_bottomlen, d=middle_height+tunnel_height*2.5, $fn=fnv, center=true);
		
				//cut middle
				sideslotdim = [ middle_width-2, middle_height - tunnel_clearance - tunnel_radius, tunnel_bottomlen +.1];
				cube(sideslotdim, center=true);

				//bottom tendon hole				
				translate([0,middle_height/2 + tunnel_radius - tunnel_clearance*1.3,0]) {
					cylinder (r=tunnel_radius*1.25, h=middle_length+middle_height, center=true, $fn=fnv);
					translate ([0,-tunnel_radius*1.26/2,0])
					cube ([tunnel_radius*2.5, tunnel_radius*1.25, middle_length+middle_height], center=true);
				}
				//top elastic holefrom base			
				translate([-tunnel_radius-tunnel_clearance,-(middle_height/2 + tunnel_radius - tunnel_clearance*1.3),0]) {
					cylinder (r=tunnel_radius*1.25, h=middle_length+middle_height, center=true, $fn=fnv);
					translate ([0,tunnel_radius*1.26/2,0])
					cube ([tunnel_radius*2.5, tunnel_radius*1.25, middle_length+middle_height], center=true);
				}
			}
			
			hull(){
				translate([0,.5,0])
				sphere(	middle_height/2 + tunnel_height*1.1,$fn=fnv, center=true);
				difference(){
					resize ([base_width-2,0,0])
					cylinder (h=tunnel_bottomlen, d=middle_height+tunnel_height*2.5, $fn=fnv, center=true);
						
					translate([0,middle_height/2-1.5,0])
					cube([middle_height*2,middle_height*2,tunnel_bottomlen +.1], center=true);
				}
			}
		}
	}
}

module make_plug(){ //end_mod = 1, side_mod = 1) {
	hh=(hinge_width - middle_width - hinge_sideclearance*2 - hinge_offset*2 - hinge_plugclearance*2) /2;
	//translate([ hinge_sideclearance/2, 0, (middle_width/2 + hinge_sideclearance + hinge_plugclearance + hinge_offset +.1 + hh/2) * side_mod])		
	union(){
		difference(){
			cylinder(d=hinge_pinclearance, h= hh, $fn=fnv, center=true);
			translate([0,0, ( -hinge_nutthickness/2 - hinge_plugclearance/2 -.1) ])//* side_mod])
			cylinder(d=hinge_nutwidth+hinge_plugclearance, h= hinge_nutthickness+hinge_plugclearance, $fn=6, center=true);
		}
		if(hinge_plugbulge > 0){
			translate([0,0,hh/2 ])//* side_mod])
			resize([0,0,hinge_plugbulge])
			sphere(hinge_pinclearance/2, $fn=fnv);
		}
	}
}

module make_base(){
	union(){
		//cut center 
		difference (){
			//mainsection
			union(){
				intersection(){
					rotate([0,90,0]) 
					hull(){
						//hinge circle  middle_height+hinge_clearance*3
						cylinder (d=hinge_diameter, h=hinge_width, center=true, $fn=fnv);
						//nut hole ridges
						cylinder(h = hinge_width+hinge_bulge*2, d=hinge_pinclearance+1, center=true, $fn=fnv);
					}
					if(tip_hingerounding>0){
						sphere(hinge_diameter*base_hingerounding/2, $fn=fnv);
					}
				}
				//base circles
				translate([0,0,-middle_height/2 - base_height+.01]) 
				cylinder (d=base_width, h=base_height, center=false, $fn=fnv);

				//post
				translate([0,0,-middle_height/2 - base_height - socket_postheight-hinge_sideclearance-hinge_clearance]) 
				cylinder (d=socket_postwidth-hinge_sideclearance*2, h=socket_postheight+hinge_sideclearance+hinge_clearance, center=false, $fn=fnv);

				//post ridge
				translate([0,0,-middle_height/2 - base_height - socket_postheight -hinge_sideclearance- socket_ridgeheight -hinge_clearance]) 
				cylinder (d=socket_corewidth-hinge_sideclearance*2, h=socket_ridgeheight, center=false, $fn=fnv);

				//post filler
				translate([0,0,-middle_height/2]) 
				cylinder (d=socket_postwidth-hinge_sideclearance*2, h=middle_height/2, center=false, $fn=fnv);


				hull(){
					//back tunnel
					translate ([0,-middle_height/3 , 0])
					resize([middle_width+2 + 2,0,0])
					cylinder(d=middle_width+2, h=1.1, center=true, $fn=fnv);//sloppy constant 2

					translate ([0,-socket_width/2/2 - socket_thickness/2 - tunnel_clearance,-middle_height/2 - base_height - socket_postheight - socket_ridgeheight - hinge_clearance - hinge_sideclearance*2 +1])	
					cube([middle_width, socket_width/2, socket_ridgeheight], center=true);		
				}
			}
			
			//area to cut
			union(){
				hull(){
					rotate([0,90,0]){
						//back cut
						cylinder (d=middle_height+hinge_clearance*2, h=middle_width+hinge_sideclearance*2, center=true, $fn=fnv);	
						//upper back cut						
						translate([-middle_height/4,0,0]) 
						cylinder (d=middle_height+hinge_clearance*2, h=middle_width+hinge_sideclearance*2, center=true, $fn=fnv);	
						//front cut
						translate([hinge_clearance*2,middle_height,0]) //add 1 to drop it a bit
						cylinder (d=middle_height, h=middle_width+hinge_sideclearance*2, center=true, $fn=fnv);	
					}		
				}
				//flat interface
				translate ([0,-middle_height/2 , 2.5 ])
				cube([middle_width+hinge_sideclearance*2+.001, 5, 4], true);		
			}

			//pin
			rotate([0,90,0]){
				cylinder(h = middle_width*3, r=hinge_pinradius, center=true, $fn=fnv);
				// cut dips around hole for axle nuts
				for (i=[-1:2:1])
				translate([0,0,i*(middle_width/2+hinge_sideclearance*2 + hinge_offset + 5)])
				cylinder(h = 10, d=hinge_pinclearance, center=true, $fn=fnv);

			}
	
			hull(){		
				translate([-(tunnel_radius+tunnel_clearance*2), -(middle_height/2 + tunnel_radius - tunnel_clearance),0]) 
				sphere (tunnel_radius, $fn=fnv);

				translate([-(tunnel_radius+tunnel_clearance),-base_width/2 - tunnel_radius/2 +tunnel_clearance*2,-middle_height/2 - base_height - socket_postheight - socket_ridgeheight- hinge_clearance - hinge_sideclearance*2]) 
				sphere (tunnel_radius, $fn=fnv);
			}			

			//tendon hole
			hull(){
				translate([(tunnel_radius/2),-(middle_height/2 + tunnel_radius - tunnel_clearance*2) +1,-middle_height/2 + hinge_clearance]) 
				sphere (tunnel_radius, $fn=fnv);

				translate([tunnel_radius,-socket_width/2-socket_thickness+tunnel_clearance,-middle_height/2 - base_height - socket_postheight -socket_ridgeheight/2]) 
				sphere (tunnel_radius, $fn=fnv);
			}

			//widen elastic openings
			translate([-(tunnel_radius+tunnel_clearance*2), 
			-(middle_height/2 + tunnel_radius - tunnel_clearance*2 ),-2.5]) 
			cylinder (r1=tunnel_radius*1, r2=tunnel_radius*1.5, h=3.5, center=false, $fn=fnv);
			//sphere (tunnel_radius*1.5, $fn=fnv);
				
			//widen elastic bottom hole
			translate([-(tunnel_radius+tunnel_clearance),-base_width/2 - tunnel_radius/2 +hinge_clearance*2,
			-middle_height/2 - base_height - socket_postheight - socket_ridgeheight - hinge_clearance - hinge_sideclearance*2+ tunnel_radius/2] ) 
			sphere (tunnel_radius*1.6, $fn=fnv);
			
			//widen tendon opening
			translate([ tunnel_radius/2, -(middle_height/2 + tunnel_radius - tunnel_clearance*2) +1, -middle_height/2 + hinge_clearance]) 
			rotate([-90,0,0])
			cylinder (r1=tunnel_radius*1, r2=tunnel_radius*1.5, h=3, center=false, $fn=fnv);
			//sphere (tunnel_radius*1.75, $fn=fnv);
			
			//stump indent
			translate ([0,0,-middle_length/2 - middle_height/2 - stump_indent/2 - socket_postheight - socket_ridgeheight*2 - hinge_clearance*1.5]) 
			sphere (stump_indent, $fn=fast?80:fn_accurate);
			
		}
		if(washer_depth_outside>0)
		rotate([0,90,0]){
			//washers
			difference(){
				cylinder (r=hinge_pinradius+washer_radius, h=middle_width+hinge_sideclearance*2, center=true, $fn=fnv);
				union(){
					cylinder(h = middle_width*2, r=hinge_pinradius, center=true, $fn=fnv);
					cylinder(h = middle_width+hinge_sideclearance*2-washer_depth_outside*2, r=hinge_pinradius+washer_radius*2, center=true, $fn=fnv);						
				}
			}
		}
	}
}

module make_socket(){
	union(){
			difference(){
				//main socket body
				hull(){		
					//top ridge
					translate ([0,0,-socket_ridgeheight/2]) 
					cylinder(h = socket_ridgeheight, d=base_width+2, center=true, $fn=fnv);

					translate ([0,0,-socket_ridgeheight/2 - socket_ridgeheight - socket_postheight - socket_depth/2]) 
					cylinder(h = socket_depth-hinge_sideclearance, r2=socket_width/2 + socket_thickness +.5, r1=socket_bottomwidth/2+socket_thickness, center=true, $fn=fnv);			
					
				}
				//cut interface points out at top - post section
				translate ([0,0,-socket_postheight +.01])
				cylinder(h = socket_postheight+.01, d=socket_postwidth, center=false, $fn=fnv);			
				//ridge section
				translate ([0,0,-socket_postheight - socket_ridgeheight -.23])	
				cylinder(h = socket_ridgeheight+hinge_sideclearance, d=socket_corewidth, center=false, $fn=fnv);			

				//cut center of socket
				translate ([0,0,-socket_ridgeheight - socket_postheight - socket_depth +.03 -socket_ridgehold]) 
				cylinder(h = socket_depth, r2=socket_width/2, r1=socket_bottomwidth/2, center=false, $fn=fnv);		
				//ridge hold
				translate ([0,0,-socket_ridgeheight - socket_postheight -socket_width/4 + socket_ridgeheight  ]) 
				resize([0,0,10])
				sphere(socket_width/2, $fn=fnv);			
				
				//tunnel
				translate ([0,-socket_width/2,-(socket_ridgeheight + socket_postheight)/2 +.01])
				cube([middle_width+hinge_sideclearance*2, socket_width, socket_ridgeheight + socket_postheight], center=true);
				
				//string clearance, some hacky contstans here to work out out make variables	
				if(socket_stringclearance){
					hull(){
						translate ([0,-socket_width/2-1.5,-(socket_ridgeheight + socket_postheight)/2 +.01])
						cube([middle_width+hinge_sideclearance*2, 1, 1], center=true);
						translate ([0,-socket_width/2 - 4,-(socket_ridgeheight + socket_postheight)*2 -4+.01])
						cube([middle_width*2, 1, 1], center=true);
					}
				}
				//knuckle clearance, some hacky contstans here to work out out make variables	
				if(socket_hingeclearance){
					hull(){
						translate ([0,socket_width/2, 1])
						cube([middle_width*2, 1, 1], center=true);
						translate ([0,+socket_width/2 + 4,-(socket_ridgeheight + socket_postheight)*2 -2+.01])
						cube([middle_width*2, 1, 1], center=true);
					}
				}
				//scallops
				translate ([socket_width/4,0,-(socket_depth + socket_ridgeheight + scallop_offset)])
				sphere (scallop_right, $fn=fnv);
				translate ([-socket_width/4,0,-(socket_depth + socket_ridgeheight + scallop_offset)])
				sphere (scallop_left, $fn=fnv);
			}
		}
}

module make_loop(){
	rotate([90,0,0])
	resize([linkage_loopwidth,linkage_looplength,linkage_loopheight])
	rotate_extrude(convexity = 3, $fn = fnv)
	translate([linkage_loopextrusion, 0, 0])
	circle(d = linkage_loopthickness, $fn = fnv);
}

module make_cup(mod=1){
	difference(){
		hull(){
			sphere(linkage_cupwidth/2+linkage_cupthickness, $fn=fnv);
			resize([linkage_width,linkage_height,0])
			translate([0,0,mod*linkage_cupwidth/2])
			cylinder(h = 1, d=linkage_width, center=true, $fn=fnv);	
		}
		union(){
			sphere(linkage_cupwidth/2, $fn=fnv);
			translate([0,linkage_cupwidth-linkage_cupthickness/3,0])
			sphere(linkage_cupwidth/2+linkage_cupthickness, $fn=fnv);
		}
	}
}

module make_hook(){
	translate([0,linkage_hookvertical_offset,0])
	rotate([90,0,90])
	difference(){
		resize([linkage_hookwidth,linkage_hooklength,linkage_hookheight])
		rotate_extrude(convexity = 3, $fn = fnv)
		translate([linkage_loopextrusion, 0, 0])
		circle(d = linkage_hookthickness, $fn = fnv);
		
		translate([linkage_hookwidth/2,linkage_hooklength/4 + linkage_hookopening_offset,0])
		rotate([0,0,15])
		difference(){
			cube([linkage_hookwidth,5,linkage_hookheight], center=true);
	
			translate([-1.5,-2.5,0])		
			resize([3,2,linkage_hookheight])
			sphere(1.5, $fn=fnv);
		}
	}
}

module make_linkage(){
	//[0:Plain,1:Hole,2:Peg,3:Loop,4:Cup ]
	union(){
		difference(){
			union(){
			translate([0,0,+linkage_round_end2/2 -linkage_round_end1/2])
			resize([linkage_width,linkage_height,0])
			cylinder(h = linkage_length - linkage_round_end1 - linkage_round_end2, d=linkage_width, center=true, $fn=fnv);	
			
			if(linkage_round_end2>0){
				translate ([0,0,-linkage_length/2 + linkage_round_end2  ])
				resize([linkage_width,linkage_height,linkage_round_end2*2])
				sphere(10, $fn=fnv);
			}
			if(linkage_round_end1>0){
				translate ([0,0,linkage_length/2 - linkage_round_end1 ])
				resize([linkage_width,linkage_height,linkage_round_end1*2])
				sphere(10, $fn=fnv);
			}
		}
	
			//holes	
			if (linkage_end2 == 1){
				translate ([0,0,-linkage_length/2 - .1])
				cylinder(h = linkage_holelength, r=linkage_holeradius, center=true, $fn=fnv);			
			}
			if (linkage_end1 == 1){
				translate ([0,0,linkage_length/2 + .1])
				cylinder(h = linkage_holelength, r=linkage_holeradius, center=true, $fn=fnv);			
			}				
		}
		
		//pegs
		if (linkage_end2 == 2){
			translate ([0,0,-linkage_length/2 - linkage_peglength/2])
			cylinder(h = linkage_peglength, d=linkage_pegwidth, center=true, $fn=fnv);	
		}
		if (linkage_end1 == 2){
			translate ([0,0,linkage_length/2 + linkage_peglength/2])
			cylinder(h = linkage_peglength, d=linkage_pegwidth, center=true, $fn=fnv);	
		}

		//loops
		if (linkage_end2 == 3){
			translate ([0,0,-linkage_length/2 - linkage_looplength/2 + linkage_loopthickness - linkage_loopoffset])
			make_loop();
		}
		if (linkage_end1 == 3){
			translate ([0,0,linkage_length/2 + linkage_looplength/2  - linkage_loopthickness + linkage_loopoffset ])
			make_loop();
		}

		//cups
		if (linkage_end2 == 4){
			translate ([0,0,-linkage_length/2  - linkage_cupwidth/2 - linkage_cupthickness])
			make_cup();
		}
		if (linkage_end1 == 4){
			translate ([0,0,linkage_length/2  + linkage_cupwidth/2 + linkage_cupthickness])
			make_cup(-1);
		}
		
		//hooks
		if (linkage_end2 == 5){
			translate ([0,0,-linkage_length/2 + linkage_round_end2/2 + linkage_hookthickness*1.5- linkage_hooklength/2 + linkage_hookoffset])
			make_hook();
		}
		if (linkage_end1 == 5){
			translate ([0,0,linkage_length/2 - linkage_round_end2/2 - linkage_hookthickness*1.5 + linkage_hooklength/2 -linkage_hookoffset])
			make_hook(-1);
		}
	}
}
