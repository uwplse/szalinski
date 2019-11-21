hole = 13;					//diameter of hole, 0 = none
base = 20;					//diameter of outer base
clearance = 0.1;			//lateral spacing between cogs
extra_filler = 0.2;			//makes the back of teeth longer, closes tooth-and-base gap
tooth_thickness = 3.9;		//thickness of a tooth
tooth_height = 6;			//length of one tooth
round_teeth = true;			//round the tip of teeth to central radius
height = 20;				//extruded height of one gear
twist = 90;					//rotations of thread per height of one gear
res = 45;					//resolution of curves on all surfaces
slices = 20;				//over 1000 = wizard level rendering
double = true;				//add second mirror gear
two = true;					//use the clearance var. to mesh two gears
animate = 0;				//1 or 0 to keep objects centered, or allow animation



color("SteelBlue"){
	rotate([0, 0, ($t*-360*animate)]){
		gear();
	}
	if(two){
		translate([base+tooth_height, 0, 0]){
			rotate([0, 0, 22.25+($t*360*animate)]){
				mirror(){
					gear();
				}
			}
		}
	}
}
module gear(){
    linear_extrude(height = height, twist = twist, slices = slices, center = true){
        cog();
    }
	if(double){
		translate([0, 0, -height]){
			linear_extrude(height = height, twist = -twist, slices = slices, center = true){
				translate([0, 0, -height]){
					cog();
				}
			}
		}
	}
}
module cog(){
    for(i = [0 : 45 : 360]){
        rotate([0, 0, i]){
            tooth();
        }
    }
    difference(){
        circle(r = base/2, $fn = res, center = true);
        circle(r = hole/2, $fn = res, center = true);
    }
}
module tooth(){
    translate([(base/2)+(tooth_height/2)-clearance, 0, 0]){
        intersection(){
			translate([-(extra_filler/2)+(clearance), 0, 0]){
				square([tooth_height+extra_filler, tooth_thickness], center = true);
			}
			if(round_teeth){
				translate([-(base/2)-clearance, 0, 0]){
					circle(r = (tooth_height/2)+(base/2), $fn = res, center = true);
				}
			}
        }
    }
}