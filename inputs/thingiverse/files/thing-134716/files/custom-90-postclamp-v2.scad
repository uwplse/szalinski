//design and code by emanresu (http://www.thingiverse.com/Emanresu)


// preview[view:north west]

//CUSTOMIZER VARIABLES


//post clamp parameters

//What diameter of post will you be clamping?
post_diameter = 13.1;
//How thick do you want the walls of the clamp?
clamp_wall_thick = 5;
//tap hole for clamp retention screw
clamp_screw_diameter = 5.6;


//mount base parameters

//how deep do you want the mount screw hole? 
mount_depth = 5;
//how big around is the top of the post you will be attaching the clamp to?
mount_diameter = 10;
//tap hole for mounting screw, what kind of screw is the post you will attach the clamp to tapped for?
mount_screw_diameter = 3.5;


/* [Hidden] */

//sets the depth/height of the clamp section to be the diameter of the mount base
clamp_height = mount_diameter;

  /////////////
 // Modules //
/////////////


module post_clamp_90() {
	// Generates a 90º post coupling which will screw into the end of one post 
	// and clamp around another oriented perpendicular to the first
	difference() {
		hull() {
			//generates basic shape, a hull of two perpendicular cylinders
			
			//the first cylinder will be "drilled" to fit around a post
			cylinder(r=post_diameter/2+clamp_wall_thick, h=clamp_height, $fn=360, center=true);
			translate([0, post_diameter/2+clamp_wall_thick+mount_depth/2, 0]) {
				//base of clamp that will be "drilled" and tapped
				rotate([90, 0, 0]) {
					cylinder(r=mount_diameter/2, mount_depth, $fn=360,center=true);
				}
			}
		}
		cylinder(r=post_diameter/2, h=clamp_height+1, $fn=360, center=true); //hole for post
		translate([post_diameter/4+clamp_wall_thick/5, 0, 0]) {//generates clamping notch in post hole
			rotate([0, 0, 0]) {
				cube(size=[post_diameter/2, post_diameter/3, clamp_height+1], center=true);//clamping notch
			}
		}
		translate([-(post_diameter/2+clamp_wall_thick+1)/2, 0, 0]) {//clamp screw hole
			rotate([0, 90, 0]) {
				cylinder(r=clamp_screw_diameter/2, h=post_diameter/2+clamp_wall_thick+1, $fn=360, center=true);
			}
		}
		translate([0, post_diameter/2+clamp_wall_thick, 0]) {//mount screw hole
			rotate([-90, 0, 0]) {
				cylinder(r=mount_screw_diameter/2, h=mount_depth+1, $fn=360, center=false);

			}
		}
	}	
}



  //////////////////
 // Control Code //
//////////////////

translate([0, 0, clamp_height/2]) {
	post_clamp_90();
}
