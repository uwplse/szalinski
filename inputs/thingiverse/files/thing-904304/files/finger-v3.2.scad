/*
// Knick's finger v3.2, (c) Nicholas Brookins, http://www.thingiverse.com/thing:904304
// 
// fixed many variables and hid some that shouldn't be changed often
// added tensioners, carved inside of tip cover, made wire holes, improved some parametrics, added post clearance
// improved stump indent and scallop
//
// TO-DO: Use torus around cylinder to create more leverage
//*/
//Choose which item to build, or preview the full finger (with less accuracy).  Options include the Socket (rubber), the Base, Segment 1 (middle), Segment 2 (tip), Tip cover (rubber), Bumper (rubber) for the middle section, Hinge plugs to cover the nuts (rubber), and the linkage for back of hand
build_item = 0; //[0:Preview All, 1:Finger Socket, 2:Base Hinge, 3:Middle Section, 4:Tip Section, 5:Tip for 1 segment, 6:Tip Cover, 7:Middle Bumper, 8:Hinge Plugs]
//This is used for previewing how 2 parts interact with each other during modeling
build_item_2 = 0*4; //[0:Preview All, 1:Finger Socket, 2:Base Hinge, 3:Middle Section, 4:Tip Section, 5:Tip for 1 segment, 6:Tip Cover, 7:Middle Bumper, 8:Hinge Plugs]
//How many knuckles/hinges to create, current options are 1 or 2
knuckles = 2; // [1,2]

//build parts more crudely, but much more quickly - for twiddling.  print mode automatically turns this off
fast = 1* 1;

// rotate the base and tip parts, to see how the hinges interact with the middle section.  Only relevant when previewing.  0 for straight, and up to 95 for fully bent.
rotatetest = 0; //[0:95]
//explode parts apart to see them individually better.  Only relevant when previewing.
explode = 0; //[0,1] 
//print mode - puts items into print orientation, disables fast mode, and other tweaks to make proper exportable models.  
print_mode = 1; //[0,1]
print = (print_mode == 1 && build_item!=0) ? 1: 0;
	
//height of the base section, which connects to the socket and has the first hinge.  Set to -1 for minimum height.
base_height = -1;
//width of the base section
base_width = 17;
//height of the top ridge that keeps the socket secure
base_socket_ridge_height = 4 * 1;
//multiplier for rounding of the hinges.  larger numbers make for less rounding. set to 0 to disable.
base_hinge_rounding = 1.35 * 1;

//length of the 1st segment, often the middle part.  
middle_length = 20;
//height of the middle part.  The hinges depend on this variable too.
middle_height = 10;
//expiramental, dont use.  trting to increase fulcrum leverage for first knuckle
middle_hinge_bulge = 0*11;

//width of segment 1, and generally the width between the hinges
middle_width = 7;
//Which form of sides to use for the middle section.  
middle_sides = 1;//[0:Built-in sides, 1:Slots for rubber bumper]
//width of the hinges
hinge_width = 14.5;



//thickness of the hinge plugs 
hinge_plug_thickness = 2.2;
//width of the nut for the plug cutout
hinge_nut_width = 4.8; //4.05
//thickness of the nut for the plug cutout
hinge_nut_thickness = 2;//2.2
//radius of the hinge pin/axle  
hinge_pin_radius = 1.075;
//extra clearance for the hinge plugs
hinge_plug_clearance = .2 *1;
//how much curved bulge to put on the plugs
hinge_plug_bulge = 1.2;

hinge_bulge = 1* 0;
//Diameter of the clearance hole around the hinge pin nuts
hinge_pin_clearance = 7 *1;
//clearance between hinge and middle section on sides
hinge_side_clearance = .5 *1;
//vertical clearance for the curve between middle section and hinges, where tendon/elastic pass
hinge_clearance = 1 *1;
//vertical clearance for the curve between middle section and hinges, where tendon/elastic pass
base_hinge_clearance = 1.3 *1;
hinge_diameter = middle_height + hinge_clearance;
//the thickness of the hinge in between the middle section and nut.  
hinge_offset = 1 *1;
//Depth of the indent in the center of the middle part of hinge, allowing clearnce for the elastic or tendon
hinge_indent_depth = .65 *1;
//the width of the hinge indent
hinge_indent_width = middle_width/2;

//radius of the elastic and tendon tunnels
tunnel_radius = 1.2;
//tunnel_rounded = .25;
//clearance for the tunnels to the side
tunnel_clearance = .6 *1;

//The height of any elastic/tendon tunnels 
middle_tunnel_height = tunnel_radius * 2.25; //2.7 *1;
//radius of wire for a tunnel from tip to base
wire_radius = .5 *0;

tip_core_length = middle_height/2 - hinge_clearance +.5;
//echo ("tip_core_length: ", tip_core_length);
//length of the overall tip
tip_length = 15.5;
//width of the post ridge
tip_ridge_width = 11;
//width of the tip cyninder near the hinge
tip_width = 15.25;
//amount of rounding on the tip hinges
tip_hinge_rounding = 1.35 *1;
//width of the post conencting tip to tip cover
tip_post_width = 9.75 *1;
//width at the base of the rubber tip cover
tip_cover_width = 13.5;
//the percentage of the tip cover length which the fingernail covers
tip_fingernail_ratio = .55;
//advanced, the clearance between rubber tip and the tip core
tip_post_clearance = 1* .15;

//radius of set screws on tensioner block.  set to 0 to disable tensioner block
tip_tensioner_screw_radius = .85;
tip_tensioner_hole_radius = .9 *1;
middle_tensioner_screw_radius = 0*0;//.9;
//radius of set screws on base.  set to 0 to disable tensioner block
base_tensioner_screw_radius = .85;
//radius of an accessory hole from the tip cover end, great for LEDs and lasers :)
tip_accessory_radius = 0;

tip_pocket_width = tip_post_width *.85;
tip_pocket_depth = (tip_length - tip_core_length) *.75;

tip_tensioner_width = tunnel_radius*2.8 +.1;
tip_tensioner_height = 1* 2.3;//2.65;
tip_tensioner_length = tip_ridge_width*.58;
tip_tensioner_slot_width = tunnel_radius*1.6;

//diameter of the top of socket, roughly the diameter/width of the finger stump nearer the top
socket_width_top = 16.75;
//diameter of the bottom of socket, roughly the diameter/width of the finger stump bottom
socket_width_bottom = 17.25;
//Depth of the socket, roughly equates to the length of the stump
socket_depth = 26;
//thickness of the rubber socket
socket_thickness = 2.1;
//width of the post connecting the socket to the base
socket_post_diameter = 13 *1;
//width of the post ridge
socket_ridge_diameter = 16 *1;
//Include extra clearance for hinge to close into a fist
socket_hinge_clearance = 1 *1;
//include extra clearance for tendon string
socket_string_clearance = 1 *1;

washer_depth_inside = 1*0;
//how thick to make the built-in washers on the hinges
washer_depth_outside = .25 *1;
//how wide to make the washers
washer_radius = 1.5 *1;

//The radius for a scallop on the left side of the socket, to make room for webbing for the next finger.
scallop_left = 0;
//The radius for a scallop on the right side of the socket, to make room for webbing for the next finger.
scallop_right = 8;
//The vertical offset of the scallop
scallop_offset = 3.5;

tip_clearance = 1*.5;
tip_post_height = 1*2;
tip_ridge_height = 1*1.5;
socket_ridge_height = 1* 1.5;
socket_postheight = 1* 2;
socket_ridgehold =1* 2;
socket_hinge_notch = .75;

fn_fast = 25 * 1;
fn_accurate = 1* 100;

//length of tip in 1 segment mode, must be a minimum of middle_height
tip_mid_length = 6; //minimum of hinge width

//auto variables
//how far to explode
fnv = (fast==1 && print==0) ? fn_fast : fn_accurate;
explode_distance = explode ? 8 : 0;
//stump indent for sphere size
stump_indent = socket_post_diameter*1.2;
//stump indent offset for sphere
stump_indent_offset = 1* 10.75;
//length of bottom part
tunnel_bottomlen = middle_length/2 - middle_height/2 + hinge_clearance*2 +.02;			

//tip_length = 12;
tip_fingernail_rot = 1 * -3;
tip_fingernail_offset = 1 * 2.5;
tip_cuticle_rot = 1* 20;

tip_min_bottom = tip_post_height + tip_ridge_height+hinge_clearance*3;
fn_temp = tip_fingernail_ratio * tip_length;
tip_fn_length = (tip_length-fn_temp >= tip_min_bottom) ?fn_temp : tip_length-tip_min_bottom;

//make magic happen
main();

module main(){
	//Base section
	if (build_item == 2  || build_item == 0 || build_item_2 ==2){
		//We always have a base, so this is our reference position / in the center
		make_base();
	}

	//hinge Plugs
	if (build_item == 8  || build_item == 0|| build_item_2 ==8){
		
		offst = middle_width/2 + 1 + hinge_plug_clearance*2 + hinge_offset + explode_distance;
		
		if (print == 0){
			rotate([0,90,0]){
				translate([0,0,offst])			
				make_plug();

				translate([0,0,-offst])
				rotate([0,180,0])
				make_plug();
			
			if (knuckles == 2)
			rotate([0,0,-(rotatetest>0? rotatetest :0)])
			translate([-(middle_length + explode_distance*2),0,0]){
				translate([0,0,offst])			
				make_plug();

				translate([0,0,-offst])
				rotate([0,180,0])
				make_plug();
			}
			}
		}

		if(print == 1){
			union(){
				offst = hinge_pin_clearance+1;
				for (a =[0:3]){
					translate([0,offst*a,0])
					make_plug();
				}
			}
		}

	}

	//Middle section for 2 knuckles
	if (knuckles == 2 && (build_item == 3 || build_item == 0|| build_item_2 ==3)){
		rotate([rotatetest>0 ? -rotatetest : 0, print ? -90 : 0,0])
		//mid section
		translate([0, 0, middle_length/2 + (explode_distance)])
		make_middle();
	}
	
	//Bumper for middle section
	if (knuckles == 2 && (build_item == 7  || build_item == 0 || build_item_2 ==7)){
		rotate([rotatetest>0 ? -rotatetest : 0, 0, 0])
		translate ([0, (explode_distance*2), middle_length/2  + (explode_distance)])
		make_bumper();
	}
	
	//Socket
	if (build_item == 1  || build_item == 0|| build_item_2 ==1){
		rotate([0,(print? 180 : 0),0])
		translate([0,0, -middle_height/2 - base_height -socket_postheight+.5 - (explode_distance) ])
		make_socket();
	}

	//2 Segment Tip with hinge
	if (knuckles == 2 && (build_item == 4 || build_item == 0|| build_item_2 ==4)){
		rotate([-(rotatetest>0? rotatetest :0) +(print ? -90 : 0),0,0])
		translate([0,0,middle_length + (explode_distance*2) ])
		rotate([-(rotatetest>0? rotatetest :0),0,0])
		make_tip();
	}
	
		//1 segment tip (no hinge)
	if (knuckles == 1 && (build_item == 5 || build_item == 0|| build_item_2 ==5)){
		translate([0,0,middle_height/2 - hinge_clearance*1.5+ (explode_distance) ])
		rotate([-(rotatetest>0?rotatetest:0) + (print ? 180 : 0),0,0])
		make_mid_tip();
	}

	//Tip cover
	if (build_item == 6 || build_item == 0|| build_item_2 ==6){
		rot = (rotatetest>0) ? -rotatetest : 0;
		pad = (rotatetest>0) ? rotatetest/100*middle_height/1.8:0;
		//middle_height/2 : 0;
		trans = (knuckles == 2 ? middle_length+ tip_core_length + (explode_distance*3):
		tip_mid_length - .75 + (explode_distance*2)) - .75 + middle_height/2 -tip_post_height - tip_ridge_height;
		trans2 = (knuckles == 1 ? -1.8:-1); //TODO need to calculate this?
		rotate([rot,0,0])
		translate([0,trans2,trans])
		rotate([rot,0,0])
		translate([0,pad+1,pad])		//TODO - fix rotation test here
		make_tipcover();
	}
}

//functions and model sections -- modify at own risk
module make_tipcover (){
	difference(){
		intersection(){
			//plain rounded tip
			hull(){
				translate([0,0,tip_length-middle_height/2])
				resize ([tip_cover_width,0,0])
				sphere(tip_cover_width/2, $fn=fnv);
				translate([0,0,0.1])
				cylinder (h=tip_length - tip_cover_width/2, d1=tip_cover_width, d2=tip_cover_width-.5 , $fn=fnv);//+ tip_post_clearance*2
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
			cylinder (h=tip_post_height+1, d=tip_post_width, $fn=fnv);

			translate([0,0, tip_post_height])
			cylinder (h=tip_ridge_height+tip_post_clearance, d=tip_ridge_width + tip_post_clearance, $fn=fnv);	
			
			translate([0,0, tip_post_height])
			cylinder (h=tip_ridge_height+tip_post_clearance + tip_pocket_depth, d=tip_pocket_width, $fn=fnv);	
			
			translate([0,0, tip_post_height])
			cylinder (h=tip_length, r=tip_accessory_radius, $fn=fnv);	
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
			translate([0,0,tip_mid_length/2 +tip_post_height/2 ])
			cylinder (h=tip_post_height, d=tip_post_width-tip_clearance, center=true, $fn=fnv);
			//ridge
			translate([0,0,tip_mid_length/2 + tip_post_height + tip_ridge_height/2])
			cylinder (h=tip_ridge_height, d=tip_ridge_width-tip_clearance, center=true, $fn=fnv);
			
			resize ([base_width-2,0,0])
			cylinder (h=tip_mid_length, d=middle_height+middle_tunnel_height*2, $fn=fnv, center=true);
			
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
			cylinder (r=hinge_pin_radius, h=middle_width*2, center=true, $fn=fnv);
			
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
						cylinder (d=hinge_diameter, h=hinge_width, center=true, $fn=fnv);
						//nut hole ridges
						cylinder(h = hinge_width+hinge_bulge*2, d=hinge_pin_clearance+1, center=true, $fn=fnv);
					}
					if(tip_hinge_rounding>0){
						resize([0,middle_height*tip_hinge_rounding,middle_height*tip_hinge_rounding])
						sphere(middle_height, $fn=fnv);
					}
				}
				difference(){
					//body 
					translate([0,0,.1])
					cylinder (h=tip_core_length+middle_height/2 +.2-tip_post_height - tip_ridge_height, r1=tip_width/2, r2=tip_cover_width/2+.25, $fn=fnv);
			
					//bottom trim
					translate ([0, hinge_diameter/2 +middle_height/4 - tip_clearance, 0])
					cube ([ middle_width*2, middle_height/2, middle_height*2 ],true);	
				}
				//post
				translate([0,0,tip_core_length+middle_height/2 -tip_post_height - tip_ridge_height])
				cylinder (h=tip_post_height, d=tip_post_width-tip_clearance, $fn=fnv);
				//ridge
				translate([0,0,tip_core_length+middle_height/2 - tip_ridge_height])
				cylinder (h=tip_ridge_height, d=tip_ridge_width-tip_clearance, $fn=fnv);
				
				translate([0,-.25, tip_core_length + middle_height/2 + tip_tensioner_height/2 ])
				//rotate([0,-45,0])
				//tensioner block
				if (tip_tensioner_screw_radius > 0){
					difference(){					
						cube([tip_tensioner_width, tip_tensioner_length, tip_tensioner_height], true);

						//holes
					   for (i=[-1:2:1])
						translate([0, tip_tensioner_length/2*.5*i, 0 ]){  //offset each way
							//cylinder (r= tip_tensioner_hole_radius, h = tip_tensioner_height+.01, center=true, $fn=fnv);	
							cube ([tip_tensioner_screw_radius*1.25, tip_tensioner_screw_radius*2, tip_tensioner_height+.01], true);	
							
							translate([tip_tensioner_width/2, 0, 0])
							rotate([0,90,0])
							cylinder (r= tip_tensioner_screw_radius, h = tip_tensioner_width+.01, center=true, $fn=fnv);	
						}
					}
				}
			}
			//area to cut
			union(){				
				hull(){	
					//back cut
					rotate([0,90,0]) {
						cylinder (d=middle_height+hinge_clearance*2, h=middle_width+hinge_side_clearance*2, center=true, $fn=fnv);	
						//upper back cut						
						translate([middle_height/4,0,0]) 
						cylinder (d=middle_height, h=middle_width+hinge_side_clearance*2, center=true, $fn=fnv);	
					}
				}
				
				//front cut
				translate ([0, middle_height/2, 0])//-hinge_clearance])
				cube ([ middle_width+hinge_side_clearance*2, middle_height/2, middle_height +hinge_clearance],true);

				//back flat cut
				translate ([0, -middle_height/2 , -middle_height/4])
				cube([middle_width+hinge_side_clearance*2 , 5, middle_height/2], true);		

				rotate([0,90,0]){
					//nut hole
					cylinder (r=hinge_pin_radius, h=middle_width*3, center=true, $fn=fnv);
					// cut dips around hole for axle nuts
					for (i=[-1:2:1])
					translate([0,0,i * (middle_width/2+hinge_side_clearance*2 + hinge_offset +5)])
					cylinder(h = 10, d=hinge_pin_clearance, center=true, $fn=fnv);
				}
				
				echo (tip_tensioner_width);
				//trim tensioner
			//	translate([0,0,tip_core_length+middle_height/2 + tip_tensioner_width-.5])
				//cube([10,10,2], true);

				//angle elastic hole
				hull(){
					translate([0,-(middle_height/2 + tunnel_radius/2),0]) 
					sphere(tunnel_radius, $fn=fnv);

					//clone this one..
					translate([0, -tunnel_radius-tunnel_clearance , tip_core_length + middle_height/2]) 
					sphere(tunnel_radius, $fn=fnv);
				}	
				//enlarge
				translate([0,-(middle_height/2 + tunnel_radius/2) +tunnel_clearance*2,-0.1]) 
				//sphere(hole*1.5, $fn=fnv);
				cylinder (r1=tunnel_radius*2, r2=tunnel_radius, h=tunnel_radius*2.5, $fn=fnv);
				
				*translate([0,-tunnel_radius*2-tunnel_clearance, tip_core_length + middle_height/2 ]) 
				sphere(tunnel_radius*1.75, $fn=fnv);

				//tendon hole
				hull(){
					translate([0,middle_height/2 + tunnel_radius, middle_height/2 - tunnel_radius -2.5]) 
					sphere(tunnel_radius, $fn=fnv);

					translate([0,1,tip_core_length + middle_height/2]) 
					sphere(tunnel_radius, $fn=fnv);
				}	
				//enlarge end
				translate([0,middle_height/2+tunnel_radius/2,middle_height/2 - tunnel_radius]) 
				sphere(tunnel_radius*1.5, $fn=fnv);
				
				*translate([0,1.5,tip_core_length + middle_height/2]) 
				sphere(tunnel_radius*1.75, $fn=fnv);
				
				//wire_tunnel
				translate([-2.75,0,0])
				cylinder (r=wire_radius, h=tip_length, $fn=fnv);
			}
		}
		if(washer_depth_outside>0)
		rotate([0,90,0]){
			//washers
			difference(){
				cylinder (r=hinge_pin_radius+washer_radius, h=middle_width+hinge_side_clearance*2, center=true, $fn=fnv);
				union(){
					cylinder(h = middle_width*2, r=hinge_pin_radius, center=true, $fn=fnv);
					cylinder(h = middle_width + hinge_side_clearance*2 - washer_depth_outside*2, r=hinge_pin_radius + washer_radius*2, center=true, $fn=fnv);						
				}
			}
		}
	}
}

module make_middle(){
	
	difference(){
		union(){		
			d = middle_hinge_bulge;
			dm = 4;
			if( d > 0 )
			difference(){
				#translate([0.01,0.75,-middle_length/2 - .5])
				rotate([0,90,0]){
					difference(){
						cylinder(d=d, h=middle_width+.02 - 1, center=true, $fn=fnv);	
						//resize([linkage_loop_width,linkage_loop_length,linkage_loop_height])
						rotate_extrude(convexity = 3, $fn = fnv)
						translate([d/2 +dm*.45, 0, 0])
						circle(d = dm, $fn = fnv);
					}
				}
				//rotate([0,-90,0])
				//	translate([0, middle_height/2 + tunnel_radius*.8  -1, -middle_length/2 +4.25])  // /3				
				//	rotate([-45,0,0])
				//cylinder(r=middle_tensioner_screw_radius, h=4, center=true, $fn=fnv);
			}
			
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
				//	echo (middle_tunnel_height*2.5);
					resize ([base_width-2,0,0])
					cylinder (h=middle_length, d=middle_height+middle_tunnel_height *2, $fn=fnv, center=true);
				} 
				
				//trim bottom hinge area			
				translate ([-middle_width/2-.05, middle_height/2, tunnel_bottomlen/2 + hinge_side_clearance])
				cube([middle_width +.1, middle_width, tunnel_bottomlen]);		
			
				translate ([-middle_width/2-.05, middle_height/2, -tunnel_bottomlen - tunnel_bottomlen/2  ])//hinge_side_clearance.25
				cube([middle_width +.1, middle_width, tunnel_bottomlen]);		
			

				//trim sides
					//trim out bottom
					translate ([-middle_width/2-.05, middle_height/2,-tunnel_bottomlen - tunnel_bottomlen/2 ])
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
				
					//trim SIDES
					translate([middle_width/2+.01, -middle_height, -middle_length/2-.01])
					cube([middle_width, middle_height*2, middle_length+.02], center=false);
					translate([-middle_width*1.5+.01, -middle_height, -middle_length/2-.01])
					cube([middle_width, middle_height*2, middle_length+.02], center=false);			

				//wire_tunnel
				translate([-1,-3,0])
				cylinder (r=wire_radius, h=middle_length*1.5, center=true, $fn=fnv);	

				//bottom tendon hole				
				translate([0,middle_height/2 + tunnel_radius - tunnel_clearance,0]) 
				*cylinder (r=tunnel_radius, h=middle_length+middle_height, center=true, $fn=fnv);

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
				
				if(middle_tensioner_screw_radius > 0){
					translate([0, middle_height/2 + tunnel_radius*.8  -1, -middle_length/2 +4.25])  // /3				
					rotate([-45,0,0])
					cylinder(r=middle_tensioner_screw_radius, h=4, center=true, $fn=fnv);
				}else{
					//bottom knot flare
					translate([0,middle_height/2 -.5,-middle_length/2+middle_height/3+1.6])
					sphere (tunnel_radius*1.8, $fn=fnv);			
				}
				//top tunnel down
				hull(){
					translate([ tunnel_radius+tunnel_clearance/2 ,-middle_height/2 - tunnel_radius*.6, middle_length/2])		
					sphere (tunnel_radius, $fn=fnv);			

					translate([0, middle_height/2 + tunnel_radius*.8 -.5 , -middle_length/2 +1])  // /3
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
				cylinder (r=hinge_pin_radius+washer_radius, h=middle_width+washer_depth_inside*2, center=true, $fn=fnv);
			}
			
			if(middle_sides == 0)	
			make_bumper();
		
		}
		
		//hinge pins
		rotate([0,90,0]) {
			for (i=[-1:2:1])
			translate([i*middle_length/2,0,0]) 
			cylinder (r=hinge_pin_radius, h=middle_width*2, center=true, $fn=fnv);
		}
	}
	
	
}

module make_bumper(){
	
	union(){
		intersection(){
			difference(){
				resize ([base_width-2,0,0])
				cylinder (h=tunnel_bottomlen, d=middle_height+middle_tunnel_height*2, $fn=fnv, center=true);
		
				//cut middle
				sideslotdim = [ middle_width-2+       tunnel_clearance            , middle_height - tunnel_clearance -  tunnel_radius     /2    , tunnel_bottomlen +.1];
				cube(sideslotdim, center=true);

				//bottom tendon hole				
				translate([0,middle_height/2 + tunnel_radius - tunnel_clearance*1.4,0]) {
					cylinder (r=tunnel_radius*1.2, h=middle_length+middle_height, center=true, $fn=fnv);
					translate ([0,-tunnel_radius*1.2/2,0])
					cube ([tunnel_radius*2.4, tunnel_radius*1.2, middle_length+middle_height], center=true);
				}
				
				//top elastic holefrom base			
				translate([-tunnel_radius-tunnel_clearance,-(middle_height/2 + tunnel_radius - tunnel_clearance*1.3),0]) {
					cylinder (r=tunnel_radius, h=middle_length+middle_height, center=true, $fn=fnv);
					translate ([0,tunnel_radius*1.25/2,0])
					cube ([tunnel_radius*2, tunnel_radius, middle_length+middle_height], center=true);
				}
			}
			
			hull(){
				translate([0,.5,0])
				sphere(	middle_height/2 + middle_tunnel_height*1.1,$fn=fnv, center=true);
				difference(){
					resize ([base_width-2,0,0])
					cylinder (h=tunnel_bottomlen, d=middle_height+middle_tunnel_height*2, $fn=fnv, center=true);
						
					translate([0,middle_height/2-1.5,0])
					cube([middle_height*2,middle_height*2,tunnel_bottomlen +.1], center=true);
				}
			}
		}
	}
}

module make_plug(){ //end_mod = 1, side_mod = 1) {
	//hinge_nut_thickness = 2.2;//2.2
	hh=hinge_plug_thickness;//(hinge_width - middle_width - hinge_side_clearance*2 - hinge_offset*2 - hinge_plug_clearance*2) /2;
	//translate([ hinge_side_clearance/2, 0, (middle_width/2 + hinge_side_clearance + hinge_plug_clearance + hinge_offset +.1 + hh/2) * side_mod])		
	union(){
		difference(){
			cylinder(d=hinge_pin_clearance, h= hh, $fn=fnv, center=true);
			translate([0,0, ( -hh/2 +hinge_nut_thickness/2) ]) //* side_mod])//-hinge_nut_thickness 
			cylinder(d=hinge_nut_width+hinge_plug_clearance, h= hinge_nut_thickness + hinge_plug_clearance, $fn=6, center=true);
		}
		if(hinge_plug_bulge > 0){
			translate([0,0,hh/2 ])//* side_mod])
			resize([0,0,hinge_plug_bulge])
			sphere(hinge_pin_clearance/2, $fn=fnv);
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
						cylinder(h = hinge_width+hinge_bulge*2, d=hinge_pin_clearance+1, center=true, $fn=fnv);
					}
					if(base_hinge_rounding>0){
						resize([0,middle_height*base_hinge_rounding,middle_height*base_hinge_rounding])
						sphere(middle_height, $fn=fnv);
					}
				}

				//post
				translate([0,0,-middle_height/2 - base_height - socket_postheight-.25-base_hinge_clearance]) 
				cylinder (d=socket_post_diameter, h=socket_postheight+base_hinge_clearance +middle_height/2, center=false, $fn=fnv);

				//socket secure ridge 
				translate([0,0,-middle_height/2 - base_height -1.5]) 
				resize([0,socket_post_diameter-1,0])
				cylinder (d1=base_width, d2=socket_ridge_diameter-hinge_side_clearance*2-1.5, h=base_height + base_socket_ridge_height, center=false, $fn=fnv);
				
				//post ridge
				translate([0,0,-middle_height/2 - base_height - socket_postheight -.25- socket_ridge_height -base_hinge_clearance]) 
				cylinder (d=socket_ridge_diameter, h=socket_ridge_height, center=false, $fn=fnv);//-hinge_side_clearance*2

				hull(){
					//back tunnel
					translate ([0,-middle_height/3 , 0])
					resize([middle_width+2 + 2,0,0])
					cylinder(d=middle_width+2, h=1.1, center=true, $fn=fnv);//sloppy constant 2

					translate ([0,-socket_width_top/2/2 - socket_thickness/2 - tunnel_clearance,-middle_height/2 - base_height - socket_postheight - socket_ridge_height - base_hinge_clearance - hinge_side_clearance*2 +1])	
					cube([middle_width, socket_width_top/2, socket_ridge_height], center=true);		
				}
			}
			
			//area to cut
			union(){
				//test cylinder (d=2, h=30, center=true, $fn=fnv);	
				hull(){
					rotate([0,90,0]){
						//back cut
						cylinder (d=middle_height+base_hinge_clearance*2, h=middle_width+hinge_side_clearance*2, center=true, $fn=fnv);	
						//upper back cut						
						translate([-middle_height/4,0,0]) 
						cylinder (d=middle_height+base_hinge_clearance*2, h=middle_width+hinge_side_clearance*2, center=true, $fn=fnv);	
						//front cut
						translate([base_hinge_clearance*2-1,middle_height,0]) //add 1 to drop it a bit
						cylinder (d=middle_height, h=middle_width+hinge_side_clearance*2, center=true, $fn=fnv);	
					}		
				}
				//flat interface
				translate ([0,-middle_height/2 , 2.5 ])
				cube([middle_width+hinge_side_clearance*2+.001, 5, 4], true);		
			}

			//pin
			rotate([0,90,0]){
				cylinder(h = middle_width*3, r=hinge_pin_radius, center=true, $fn=fnv);
				// cut dips around hole for axle nuts
				for (i=[-1:2:1])
				translate([0,0,i*(middle_width/2+hinge_side_clearance*2 + hinge_offset + 5)])
				cylinder(h = 10, d=hinge_pin_clearance, center=true, $fn=fnv);

			}	

			//wire_tunnel
			//translate([-1,-3,0])
			//cylinder (r=wire_radius, h=middle_length*1.5, center=true, $fn=fnv);	

			//tendon hole
			hull(){
				translate([(tunnel_radius/2),-(middle_height/2 + tunnel_radius - tunnel_clearance*2) +1,-middle_height/2 + base_hinge_clearance -1]) 
				sphere (tunnel_radius, $fn=fnv);

				translate([tunnel_radius,-socket_width_top/2-socket_thickness+tunnel_clearance,-middle_height/2 - base_height - socket_postheight -socket_ridge_height/2]) 
				sphere (tunnel_radius, $fn=fnv);
			}

				translate([-(tunnel_radius+tunnel_clearance), -(middle_height/2 + tunnel_radius - tunnel_clearance)-.5,.5]) 
				sphere (tunnel_radius+.1, $fn=fnv);			
			//elastic hole
			hull(){		
				translate([-(tunnel_radius+tunnel_clearance), -(middle_height/2 + tunnel_radius - tunnel_clearance)-.5,0]) 
				sphere (tunnel_radius, $fn=fnv);

				translate([-(tunnel_radius),-base_width/2 - tunnel_radius/2 +tunnel_clearance*2,-middle_height/2 - base_height - socket_postheight - socket_ridge_height- base_hinge_clearance - .5]) 
				sphere (tunnel_radius, $fn=fnv);
			}		
			
			if (base_tensioner_screw_radius > 0 ){
				translate([-(tunnel_radius) - 2, -base_width/2 - tunnel_radius/2 +tunnel_clearance*2 +.5, -middle_height/2 - base_height - socket_postheight - socket_ridge_height- base_hinge_clearance - hinge_side_clearance*2 +2.35 ]) 
				rotate([0,90,0])
				cylinder(r=base_tensioner_screw_radius, h=2, center=true, $fn=fnv);
			}	
				//widen elastic bottom hole
		//		translate([-(tunnel_radius+tunnel_clearance),-base_width/2 - tunnel_radius/2 +base_hinge_clearance*2,
			//	-middle_height/2 - base_height - socket_postheight - socket_ridge_height - base_hinge_clearance + tunnel_radius/2] ) 
				//sphere (tunnel_radius*1.6, $fn=fnv);
			
		
			//stump indent
			translate ([0,0,-middle_length/2 - middle_height/2 - socket_postheight -socket_ridge_height -stump_indent - base_height +stump_indent_offset ]) //socket_ridge_height*2
			sphere (stump_indent, $fn=fast?80:fn_accurate);
			
		}
		if(washer_depth_outside>0)
		rotate([0,90,0]){
			//washers
			difference(){
				cylinder (r=hinge_pin_radius+washer_radius, h=middle_width+hinge_side_clearance*2, center=true, $fn=fnv);
				union(){
					cylinder(h = middle_width*2, r=hinge_pin_radius, center=true, $fn=fnv);
					cylinder(h = middle_width+hinge_side_clearance*2-washer_depth_outside*2, r=hinge_pin_radius+washer_radius*2, center=true, $fn=fnv);						
				}
			}
		}
	}
}

module make_socket(){
	socket_clearance = -.5;
	union(){
		difference(){
			//main socket body
			hull(){		
				//top ridge
				translate ([0,0,-socket_ridge_height/2]) 
				cylinder(h = socket_ridge_height, d=base_width+2, center=true, $fn=fnv);

				translate ([0,0,-socket_ridge_height/2 - socket_ridge_height - socket_postheight - socket_depth/2]) 
				cylinder(h = socket_depth, r2=socket_width_top/2 + socket_thickness +.5, r1=socket_width_bottom/2+socket_thickness, center=true, $fn=fnv);			
					
			}
			//cut interface points out at top - post section
			translate ([0,0,-socket_postheight +.01])
			cylinder(h = socket_postheight+.01, d=socket_post_diameter + socket_clearance, center=false, $fn=fnv);			
			
			//ridge section
			translate ([0,0,-socket_postheight - socket_ridge_height -.23])	
			cylinder(h = socket_ridge_height+.25, d=socket_ridge_diameter+ socket_clearance, center=false, $fn=fnv);			
			
			//ridge hold
			translate ([0,0,-socket_ridge_height - socket_postheight -socket_width_top/4 + socket_ridge_height -1  ]) 
			resize([0,0,10])
			sphere(socket_width_top/2, $fn=fnv);	

			//cut center of socket
			translate ([0,0,-socket_ridge_height - socket_postheight - socket_depth +.03 -socket_ridgehold]) 
			cylinder(h = socket_depth, r2=socket_width_top/2, r1=socket_width_bottom/2, center=false, $fn=fnv);				
				
			//tunnel
			translate ([0,-socket_width_top/2,-(socket_ridge_height + socket_postheight)/2 +.01])
			cube([middle_width+hinge_side_clearance*2, socket_width_top, socket_ridge_height + socket_postheight], center=true);
				
			//string clearance, some hacky contstans here to work out out make variables	
			if(socket_string_clearance){
				hull(){
					translate ([0,-socket_width_top/2-1.5,-(socket_ridge_height + socket_postheight)/2 +.01])
					cube([middle_width+.5, 1, 1], center=true);
					translate ([0,-socket_width_top/2 - 4,-(socket_ridge_height + socket_postheight)*2 -4+.01])
					cube([middle_width*2, 1, 1], center=true);
				}
			}
			//knuckle clearance, some hacky contstans here to work out out make variables	
			if(socket_hinge_clearance){
				hull(){
					translate ([0,socket_width_top/2, 1])
					cube([middle_width*2, 1, 1], center=true);
					translate ([0,+socket_width_top/2 + 4,-(socket_ridge_height + socket_postheight)*2 -2+.01])
					cube([middle_width*2, 1, 1], center=true);
				}
			}
			//scallops
			translate ([socket_width_top/2.5,0,-(socket_depth + socket_ridge_height + scallop_offset)])
			sphere (scallop_right, $fn=fnv);
			translate ([-socket_width_top/2.5,0,-(socket_depth + socket_ridge_height + scallop_offset)])
			sphere (scallop_left, $fn=fnv);
				
			translate([0,socket_width_top/2.5,-socket_hinge_notch/2+.01])
			cube([middle_width + hinge_side_clearance*2,socket_width_top/4,socket_hinge_notch], center=true);
		}
	}
}
