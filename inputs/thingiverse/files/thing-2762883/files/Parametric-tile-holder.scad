//================================================
// Hexagonal Tile holder for Boardgames by satanin
//================================================
// All sizes are mm.
// Hexagonal Tile Diameter
diameter=40;
// Container Height
height=27; 
// Wall and base thickness
wall=2;//[1:5]
// use cover?
use_cover="yes"; //["yes":yes,"no":no]
// Reforced structure
use_reforced_structure="yes";//["yes":yes,"no":no]
// use perforations in cover?
use_cover_perforation="yes";//["yes":yes,"no":no]
// Perforation perforation percentage
cover_perforation_percentage=60;//[1:90]
// use perforations in base?
use_base_perforation="yes";//["yes":yes,"no":no]
// Base perforation percentage
base_perforation_percentage=60;//[1:90]
// use minimalistic structure
minimalistic="no";//["yes":yes,"no":no]
// print just the cover?
just_the_cover="no";//["yes":yes,"no":no]
// Multiple pieces
use_multiple_pieces="yes";//["yes":yes,"no":no]
// How many pieces?
pieces=4;//[1:10]
// use hive distribution
use_hive_distribution="yes";//["yes":yes,"no":no]

//===============================================
/* [Hidden] */
sides=6;
spacer=1;
radius=diameter/2;

use_text="no";
cover_text="Tiles";
text_size=5;

cover_position_spacer=diameter/2;

$reforced_structure_z= use_reforced_structure=="yes" ? diameter/5 : wall;
module perforation(perforation_percentage){
	perforation_radius = (radius*perforation_percentage)/100;
	cylinder(height,perforation_radius, perforation_radius, center=true);
}

module gap (){
	factor=2;
	slot=radius/2;
	rotate([0,0,0], center=true){
		translate([-(slot)/2,- diameter*(factor/2),wall+$reforced_structure_z]){
			cube([slot,diameter*factor,height*factor]);
		}
	}
	
	rotate([0,0,60], center=true){
		translate([-(slot)/2,- diameter*(factor/2),wall+$reforced_structure_z]){
			cube([slot,diameter*factor,height*factor]);
		}
	}
	rotate([0,0,120], center=true){
		translate([-(slot)/2,- diameter*(factor/2),wall+$reforced_structure_z]){
			cube([slot,diameter*factor,height*factor]);
		}
	}
	
	if(minimalistic=="yes"){
		rotate([0,0,30], center=true){
			translate([-(slot),- diameter*(factor/2),wall+$reforced_structure_z]){
				cube([radius,diameter*factor,height*factor]);
			}
		}
	}
}

module holder() {
	z=wall;
	difference(){
		difference(){
			cylinder(height,radius+wall,radius+wall,center=false,$fn=sides);
			translate([0,0,z]){
				cylinder(height+100,radius,radius,center=false,$fn=sides);
			}
		}
		gap();
		if(use_base_perforation=="yes"){
			perforation(base_perforation_percentage);
		}
	}
}

module cover(){
	translate([diameter+cover_position_spacer,0,0]){
		if(use_cover=="yes"){
			spacer=0.1;
			color("red"){
				difference(){
					cylinder(wall,(radius+wall-spacer)-(wall/2),(radius+wall-spacer)-(wall/2),center=false,$fn=sides);
					if(use_cover_perforation=="yes"){
						perforation(cover_perforation_percentage);
					}
				}
			}
			if(use_text=="yes"){
				color("blue"){
					translate([diameter+position_spacer, radius/1.5, wall]){
						linear_extrude(0.5){
							text(cover_text, text_size, valign="center", halign="center");
						}
					}
				}
			}
		}
	}
}

module cover_(){
	spacer=0.5;
	color("red"){
		translate([0,0,height-wall]){
			difference(){
				cylinder(wall+10,(radius+wall)-(wall/2),(radius+wall)-(wall/2),center=false,$fn=sides);
				if (use_cover_perforation=="yes"){
					translate([0,0,height-wall]){
						cylinder(height,radius/2, radius/2, center=true);
					}
				}
			}
		}	
	}
}

module final_holder(){
	if(just_the_cover!="yes"){
		if (use_cover=="yes") {
			difference(){
				holder();
				cover_();
			}
		}else{
			holder();
		}
	}
}

if (use_multiple_pieces=="yes"){
	for(i=[0:1:pieces-1]){
		side=diameter+wall;
		move_odd=sqrt((side*side)-(radius*radius));
		if(use_hive_distribution=="yes"){
			if(i%2>0){
				translate([(diameter-(radius/3.0)- wall/2),(move_odd/2)*i,0]){
					final_holder();
				}
				translate([(diameter*2)-radius*1.8,move_odd*(i/2)+i,0]){
					cover();
				}
			}else{
				translate([0,move_odd*(i/2),0]){
					final_holder();
				}
				translate([diameter-radius*1.5,move_odd*(i/2)+i,0]){
					cover();
				}
			}
		}else{
			translate([0,move_odd*(i),0]){
				final_holder();
			}
			translate([0,move_odd*(i),0]){
				cover();
			}
		}
	}
}else{
	if (just_the_cover=="yes"){
		translate([-diameter-cover_position_spacer,0,0]){
			cover();
		}
	}else{
		final_holder();
		cover();
	}
}