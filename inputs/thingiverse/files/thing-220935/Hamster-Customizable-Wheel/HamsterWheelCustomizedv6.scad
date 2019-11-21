// A better Hamster Wheel  Jan 3, 2014
//
//  Goal was to learn OpenScad and create something valuable
//  for my daughters little friend Pippi the hamster.
//
//  You will find a very customizable wheel along with a
//  custom axel made to snap onto the back of the cage.
//
//  The wheel itself is a big print, so I suggest first printing
// the axel along with the center post.   While the center post is
// a throw-away once you print the wheel this gives you the chance
// to verify that it will fit onto the cage properly and that the
// post spins freely.  You may need to try the axel a few times 
// to get the parameters right for a snap on fit for the cage.
//
// Pippi the hamster loves his new 150cm wheel.
//
// The measurements below all worked well for me and resulted in
// a sturdy fast wheel.
//

//CUSTOMIZER VARIABLES

/* [Global] */
// Which view do you want to use?
part = "Wheel"; // [Wheel:Print Wheel,SnapOnAxel:Snap on Axel,AxelWithPost:Print Snap-on Axel and Center Post)]



// This section displays the wheel options
// Diameter(mm) of wheel (measured to the outside)
wheel_diam=150;  // [90:200]

// Depth(mm) of wheel determines width of the running track
wheel_depth=65;  // [20:120]

// Thickness of back of wheel
back_thick=1.8;  // [1.0,1.2,1.4,1.6,1.8,2.0,2.2,2.4,2.6,2.8]

// Thickness of wheel running track
wheel_thick=1.6; // [1.0,1.2,1.4,1.6,1.8,2.0,2.2,2.4,2.6,2.8]


// Diameter of your axel.  Must hold the wheel and fit through bars
axel_diam=8; // [2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10,10.5,11,11.5,12]

// Center post outside diameter.  At least +4 over axel diameter.
center_post_diam=12; // [4,4.5,6,6.5,7,7.5,8,8.5,9,10,11,12,13,14,15,16]

// Center post height (also the axel length).  Over half of wheel depth. 
center_post_h=46;  // [10:120]

// Post base radius.  Adds stiffness to center post
post_base_corner_r=14;  // [4:20]


// Radius of rounded back outside edge of wheel (small to avoid overhang)
o_corner_r=1.5;  // [0,0.5,1,1.2,1.5,1.8,2,2.2,2.5,2.8,3,3.2,3.5,3.8,4]

// Radius of rounded back inside edge of wheel (make at least 0.5 > than outside radius corner
i_corner_r=8;    // [1,2,3,4,5,6,7,8,9,10]

// Pct of material to cut out of back (makes printing easier).
hole_coverage=50; // [0:75]

// Number of sections to cut out of back (size depends on prior parameter)
hole_sections=12; // [4:16]

// Number of treads on running path (creates bumps for grip)
tread_sections=40; // [10:80]


//echo("tread bump distance=",(3.14159*wheel_diam)/tread_sections);

   axel_hole_diam=axel_diam+1; // how much wiggle room for axel 

// Diameter of cage bar
bar_d=2.2; // [1,1.2,1.4,1.6,1.8,2,2.2,2.4,2.6,2.8,3,3.2,3.4.3.6,3.8,4]

// Space between bars (measured on center).
bar_space=10;  // [7,7.5,8,8.5,9,9.5,10,10.5,11,11.5,12,12.5,13,13.5,14,14.5,15,15.5,16,16.5,17,17.5]

// Overhang to make the axel snap to cage.  Smaller is looser.
bar_snap=0.4;  // [0.1,0.2,0.3,0.4,0.5,0.6]

// Space back wheel needs to be held way from cage for spin clearance.
wheel_cage_clearance=11;

/* [Hidden] */
 
   i_cage_offset=bar_d+wheel_cage_clearance;


   o_base_d=3.6+0;
   o_base_w=20+0;
   o_base_h=bar_space*9;
   axel_overlap_d=axel_hole_diam+1.1;// enough to keep wheel in place
   axel_l=center_post_h+1;
   axel_corner_r=axel_overlap_d/4;
   axel_cap_h=axel_corner_r+1; // assume half round
   bend_gap_w=axel_overlap_d-axel_hole_diam+1.2;  // must be able to 
									//squeeze the overlap into the axel hole
									// the 1 should provide that space
   bend_gap_h=axel_l*3/5;




//CUSTOMIZER VARIABLES END

// [Wheel:Print Wheel,SnapOnAxel:Print Axel,AxelWithPost:Print Snap-on Axel and Center Post,All:Show all parts with cage bars(not for print)]
print_part();

module print_part() {
  if (part=="Wheel") {
    print_wheel();
  } else if (part=="SnapOnAxel"){
    print_axel();
  } else if (part=="AxelWithPost") {
    print_axel_w_post();
  } else if (part=="All") {
    show_all();
  } else {
    show_all();
  }
}

// -- Time to Render //
module print_wheel() {
	translate([0,0,wheel_depth]) rotate([0,180,0]) 
		hamster_wheel(wheel_diam=wheel_diam,
						wheel_depth=wheel_depth,
						back_thick=back_thick,
						center_post_diam=center_post_diam,
						center_post_h=center_post_h,
						axel_hole_diam=axel_hole_diam,
						o_corner_r=o_corner_r,
						i_corner_r=i_corner_r,
						post_base_corner_r=post_base_corner_r,
						hole_coverage=hole_coverage,
						hole_sections=hole_sections,
						tread_sections=tread_sections);
}

module print_axel() {
	translate([0,0,o_base_d])	
		axel(post_h=center_post_h,
				  axel_diam=axel_diam,
				  axel_hole_diam=axel_hole_diam);
}


module print_axel_w_post() {
  print_axel();
  translate([50,0,0])
			difference() {
				translate([0,0,0])
					center_post(post_h=center_post_h,
						 post_diam=center_post_diam,
						 base_corner_r=post_base_corner_r,
						 corner_r=1);
				translate([0,0,0])
        			cylinder(h=wheel_depth+2,r=axel_hole_diam/2,$fn=32);
  			};
}

module show_all() {
  // axel
  translate([0,0,0-(i_cage_offset)])  
		union() {
			 axel(post_h=center_post_h,
				 	axel_diam=axel_diam,
				  	axel_hole_diam=axel_hole_diam);
			 color("black") bars(bar_space=bar_space,bar_d=bar_d);
		}
  print_wheel();
}



// ------------------------------------------------------
// For the rounded corners I used the fillet
// modules from "Airtripper's Bowden 3D Printer Extruder" 
// thingiverse project.
// The modules were slightly modifed for my needs for proper
// overlap and height consistency.
//


// 2d primitive for inside fillets.
module fil_2d_i(r, angle=90) {
  difference() {
    polygon([
      [0, 0],
      [0, -r],
      [-r * tan(angle/2), -r],
      [-r * sin(angle), -r * cos(angle)]
    ]);
    circle(r=r);
  }
}

// 3d polar inside fillet.
module fil_polar_i(R, r, angle=90) {
  rotate_extrude(convexity=10) {
    translate([R, 0, 0]) {
      fil_2d_i(r, angle);
    }
  }
}

// 2d primitive for outside fillets.
module fil_2d_o(r, angle=90) {
   $fn=100;
   intersection() {
    circle(r=r);
    polygon([
      [0, 0],
      [0, r],
      [r * tan(angle/2), r],
      [r * sin(angle), r * cos(angle)]
    ]);
  }
}

// 3d polar outside fillet.
module fil_polar_o(R, r, h, angle=90) {
  $fn=100;
  union(){
	  translate([0,0,h-r]) {
		rotate_extrude(convexity=10) {
		    translate([R-r, 0, 0]) {
		      fil_2d_o(r, angle);
		    }
		  }
	      cylinder(r=R-r+0.1, h=r+0.1);
      }
      cylinder(r=R, h=(h-r)+0.1);
  }
}


// --------------------------------------------
// -----------------------------------------
// Main modules for building the Hamster Wheel
// along with axel and cage attachment.
//  
// Main 2 modules are:
//    hamster_wheel() and axel()
// 

// cylinder_rounded_top() is used to create a
// vertical cylinder with the top edge rounded
// off a a given corner r.
// This module is called often for creating rounded
// edges.
module cylinder_rounded_top(diam,corner_r,depth) { 
 fil_polar_o(R=diam/2,r=corner_r,h=depth, angle=90);
}


// hollow_wheel() creates the main fram of the wheel
// essentially by creating a bowl. (actually it creates
// a dome which will be flipped later)
module hollow_wheel(wheel_diam,
						  i_corner_r,
						  o_corner_r,
						  wheel_depth,
						  back_thick) {
	inner_diam=wheel_diam-(wheel_thick*2);
	difference() {
     	cylinder_rounded_top(diam=wheel_diam,
										corner_r=o_corner_r,
										depth=wheel_depth);
		translate([0,0,-1]) 
			cylinder_rounded_top(diam=inner_diam,
											corner_r=i_corner_r,
											depth=(wheel_depth-back_thick)+1);
	 }
}

// bars() draws the bars representing the cage bars.
// This is used for visualization and also for removing
// grooves needed by the snap-on axel.
// The bars are only shown when drawing the Axel while
// in display="together" mode.
module bars(bar_space,bar_d) {
  for (i=[1:8]) {
	  	translate([0,bar_space*i-bar_space/2,bar_d/2])
   	   rotate([0,90,0]) cylinder(h=200,r=bar_d/2,$fn=16,center=true);
		translate([0,0 - (bar_space*i-bar_space/2),bar_d/2])
   	   rotate([0,90,0]) cylinder(h=200,r=bar_d/2,$fn=16,center=true);
  }
}



// axel() creates the axel around which the wheel will spin
// The axel is also attached to the snap-on cage
// attachement.  
module axel(post_h,
				axel_diam,
				axel_hole_diam) {
 
   axel_over=0.6;  // make the axel a bit longer
                   // which is used to overlap the
						 // parts and avoid face gaps.     


   rotate([1,0,0])  // angles the axel ever so slightly upward
						  // which I found compensates for the bend
						  // of the cage with the wheel attached.
						  // decided to leave this off the parameter list
   translate([0,0,i_cage_offset-axel_over])
   difference () {
		difference() { // post with mushroom cap
 			cylinder_rounded_top(diam=axel_overlap_d,
											depth=axel_l+axel_cap_h+axel_over,
											corner_r=axel_corner_r);
			difference() { // sleeve to subtract
				cylinder(h=axel_l+axel_over,
											r=(axel_overlap_d/2)+1,
											$fn=64);
            cylinder(h=axel_l+axel_over,
											   r=axel_diam/2,
									  			$fn=64);
			} 
		} // gap to substract
      union () { // remove sqeezable gap (which is squeezed to fit the
                // axel cap thru the smaller axel hole in the post. 
      	//squeeze gap
			translate([0-bend_gap_w/2,
				     0-axel_overlap_d/2,
					  axel_l+axel_cap_h-bend_gap_h])
				cube([bend_gap_w,axel_overlap_d,bend_gap_h+1]);
			// The bar only squeezes in one direction so the cap
		   // must be shaved off in the other direction in order
		   // to fit thru the post axel hole.
         // shave right cap (+y)
			translate([axel_overlap_d/2,
				     ((axel_diam)/2),
					  axel_l+axel_cap_h-bend_gap_h])
				rotate([0,0,90]) 
					cube([bend_gap_w,axel_overlap_d,bend_gap_h+1]);
         //shave left cap(-y)
			translate([axel_overlap_d/2,
				     0-((axel_diam)/2+bend_gap_w),
					  axel_l+axel_cap_h-bend_gap_h])
				rotate([0,0,90]) 
					cube([bend_gap_w,axel_overlap_d,bend_gap_h+1]);
	 	}			
	}  
   // Now build the snap on plate that the axel is attached to
   // it snaps onto the outside of the cage bars.
   difference() {
    union() {
   // block sticking up between bar for axel to attach to
   // This block sticks up far enough to give the wheel
   // freedom to spin without hitting the cage wall.
   // adjust using the cage_clearance parameter.
   	translate([0,0,i_cage_offset/2]) 
			cube([axel_overlap_d+2,axel_diam,i_cage_offset],center=true);
   // block are created with just enough room for the cage
   // bars to squeeze tight between.  
   // blocks between bars below axel
   	translate([0,bar_space,bar_d])  
			cube([o_base_w,bar_snap+bar_space-bar_d,bar_d*2],center=true);
   	translate([0,bar_space*2,bar_d])  
			cube([o_base_w,bar_snap+bar_space-bar_d,bar_d*2],center=true);
   // block between bars above axel 
   	translate([0,0-bar_space,bar_d])
			cube([o_base_w, bar_snap+bar_space-bar_d,bar_d*2],center=true);
   // block between 3 bars above axel with raised base
   	translate([0,0-bar_space*4,bar_d])
			cube([o_base_w,bar_snap+bar_space-bar_d,bar_d*2],center=true);
   // block between 4 bars above axel with raised base
   	translate([0,0-bar_space*5,bar_d])
			cube([o_base_w,bar_snap+bar_space-bar_d,bar_d*2],center=true);
   // the stiff strip attaches vertically on outside of cage
		translate([0,0-o_base_h/2+bar_space*3,0-o_base_d/2])
      union() {
 		  cube([o_base_w,o_base_h,o_base_d],center=true);
      }
	 } // now by removing the space where the bars should
      // be, we provide a small rounded edge to the bars to
      // snap into.
    union () {  // remove the following 
		bars(bar_space=bar_space,bar_d=bar_d);
		translate([0,0,bar_d+0.4]) 
			bars(bar_space=bar_space,bar_d=bar_d);
    }
   }

}

// ---------------------------------------------------
// center_post() build the post which rotates around the 
// axel.  It is a cylinder with a hole just big enough
// for the axel.  It has a rounded top and the base is
// flared out with gives is a very rigid attachment to 
// the back of the wheel.
module center_post(post_h,
						 post_diam,
						 base_corner_r,
						 corner_r) {
   cylinder_rounded_top(diam=center_post_diam,
									depth=post_h,
									corner_r=1);
	translate([0,0,base_corner_r]) 
		fil_polar_i(R=center_post_diam/2+base_corner_r,
						r=base_corner_r,angle=90);
}


// back_holes() creates a 2D pattern to be used to
// remove this pattern from the back of the wheel.
// I had issues trying to get the very large area
// solid back to stick to the build plate while printing
// the first 2 layers.
// I found that by removing material it printed better
// and so this also helps make an attractive pattern
// that is customizable.  Need to leave enough material
// to keep the wheel stiff.
module back_holes(o_rad,i_rad,sections,coverage)
{  a=(360*coverage/100)/sections;
   o_y=2*sin(a/2)*o_rad;
   i_y=2*sin(a/2)*i_rad;
   len=(o_rad-i_rad)-o_y/2-i_y/2;
   for (i=[1:sections]) { 
				rotate([0,0,i*360/sections]) 
               intersection() {
                 hull(convexity=10) {translate([i_rad+i_y/2,0,0]) circle(i_y/2);
                         translate([o_rad-o_y/2,0,0]) circle(o_y/2);
			               }
                 polygon(points=[[0,0],
											[o_rad,0-o_y/2],
											[o_rad,0+o_y/2]],
								 convexity=10);
                              }
       }
}


// ----------------------------------------
// tread() produces the little bumps along the
// running path of the wheel.   I found the hamster
// really likes them to be less than 2cm apart.
// Use the parameter tread_sections to adjust.
// The bumps are the edges of cylinders embedded
// in the wheel.
module tread(wheel_diam,
				 wheel_depth,
			    wheel_thick,
				 o_corner_r,
				 sections)
{  a=360/sections;
   R=wheel_diam/2-wheel_thick;
   r=wheel_thick/2-.1;
   h=wheel_depth-o_corner_r;
   for (i=[1:sections]) { 
				rotate([0,0,i*a])
			  		translate([R,0,0])
						cylinder(h=h,r=r,$fn=16);
   } 
}

//------------------------------------
// hamster_wheel() puts the wheel together and
// finishes it off with a rounded bezel around the
// open edge.
module hamster_wheel(wheel_diam,
							wheel_depth,
							back_thick,
							center_post_diam, 
							center_post_h,
							axel_hole_diam,
							o_corner_r,
							i_corner_r,
							post_base_corner_r,
							hole_coverage,
							hole_sections,
							tread_sections) {
  difference() {
  	 union() { // full shell 
          hollow_wheel(wheel_diam=wheel_diam,
                       i_corner_r=i_corner_r,
							  o_corner_r=o_corner_r,
                       wheel_depth=wheel_depth,
                       back_thick=back_thick);
  	       translate([0,0,wheel_depth]) rotate([0,180,0]) 
               center_post(post_h=center_post_h,
                           post_diam=center_post_diam,
                           base_corner_r=post_base_corner_r,
								   axel_diam=axel_hole_diam, 
                           corner_r=o_corner_r/2);
			 tread(wheel_diam=wheel_diam,
					 wheel_depth=wheel_depth,
			   	 wheel_thick=wheel_thick,
					 o_corner_r=o_corner_r,
					 sections=tread_sections);
			 translate ([0,0,0]) 
				rotate_extrude(convexity=10,$fn=64) {
		    		translate([wheel_diam/2, 0, 0]) {
		      		circle(wheel_thick/2+.2,$fn=32);
		     }
		  }
    }

	 union() // parts to remove
      {	
        translate([0,0,0])
        		cylinder(h=wheel_depth+2,r=axel_hole_diam/2,$fn=32);
        translate([0,0,wheel_depth-back_thick*2])
            linear_extrude(height=back_thick*4,convexity=10) 
               {back_holes(o_rad=wheel_diam/2-wheel_thick-i_corner_r-2,
                           i_rad=center_post_diam/2+post_base_corner_r,
                           sections=hole_sections,
                           coverage=hole_coverage);
               }
      }
	}
}


