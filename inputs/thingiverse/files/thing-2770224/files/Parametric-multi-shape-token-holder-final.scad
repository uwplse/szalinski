//==================================================
// MultiShape Token Holder by @satanin
//==================================================
// Choose the shape of your tokens
token_sides=60; // [3:Triangle, 4:Square, 5:Pentagon, 6:Hexagon, 60:Circular]
// Diameter of your token
token_diameter=19;
// Height of the token holder
piece_height=10;
// Thickness of the base
base_thickness=2;
// How many?
token_organizers=1;
print_cover="yes";//["yes":Yes, "no":No]

/* Hidden */
// Do not edit beyond this point unless 
// you know what you´re doing.
//---------------------------------
// Spacer to give tokens some extra space
token_spacer=1;
token_radius=token_diameter/2+token_spacer/2;
structure_spacer=1;
structure_diameter=token_diameter+structure_spacer;
structure_height=piece_height-base_thickness;

module base(){
	difference(){
		cube([structure_diameter,structure_diameter,base_thickness]);
		translate([token_radius,token_radius,0]){
			cylinder(base_thickness*3,structure_diameter/3,structure_diameter/3, center= true, $fn=60);
		}
	}
}

module body(){
	base();
  difference(){
    difference(){
      translate([0,0,base_thickness]){cube([structure_diameter, structure_diameter, structure_height]);}
      translate([token_radius, token_radius, 0]){cylinder(structure_height*3, token_radius-0.1, token_radius-0.1, center=true, $fn=token_sides);}
    }

    translate([structure_diameter/2-token_diameter/6,-structure_diameter*3,base_thickness]){cube([token_diameter/3,token_diameter*5,structure_height*2]);}
    translate([-structure_diameter*3,structure_diameter/2-token_diameter/6,base_thickness]){cube([token_diameter*5,token_diameter/3,structure_height*2]);}
  }
}

module cover(){
	if(print_cover=="yes"){
		cover_thickness=base_thickness;
		translate([0,-structure_diameter,piece_height]){
			rotate([180,0,0]){
				difference(){
					translate([0,0,piece_height-cover_thickness]){
						color("indigo"){
							cube([structure_diameter,structure_diameter,cover_thickness]);
						}
					}
					body();
				}
			}
		}
	}
}

for(i=[0:1:token_organizers-1]){	
	translate([structure_diameter*i, 0, 0]){
		body();
	}
	translate([(structure_diameter+1)*i,0,0]){
		cover();
	}
}
