//--------------------------------------------
// Parametric card holder by @satanin
//--------------------------------------------
// Length of the holder
length= 180; // [20:300]
// front text, leave empty to disable
front_text= "Game Name";
// back  text, leave empty to disable
back_text= "Card Games";
// wall thickness
thickness=1.5; //[1.5,2,2.5,3]


/* [Hidden] */
side=20; // [20:40]
base_x=side; 
base_z=side; 
angle=30; // [5:60]
calculated_font_size=length/10;
font_size=min(12,calculated_font_size);
text_volume=0.4;
back_angle=15;
front_z=base_z*0.7;
back_z=base_z*0.9;

module front_side_with_text(custom_text){
	cube([thickness,length,front_z]);
	color("Orange"){
		translate([thickness,length/2,front_z/2]){
			rotate([90,0,90]){
				linear_extrude(text_volume){
					text(custom_text, size=font_size,halign="center", valign="center");
				}
			}
		}
	}
}

module back_side_with_text(custom_text){
	cube([thickness,length,back_z]);
	color("Orange"){
		translate([0,length/2,back_z/2]){
			rotate([90,0,-90]){
				linear_extrude(text_volume){
					text(custom_text, size=font_size,halign="center", valign="center");
				}
			}
		}
	}
}

module base(){
		cube([base_x,length,thickness]);
	
		translate([0,0,thickness]){
			rotate([0,back_angle,0]){
				back_side_with_text(back_text);
			}
		}

		translate([base_x,0,0]){
			rotate([0,-angle,0]){front_side_with_text(front_text);}		
		}
		

		translate([base_x/1.7,0,0]){
			translate([0,0,base_z/3.5]){
				rotate([0,-angle,0]){
					front_side_with_text("");
				}
			}
			
			translate([-thickness*0.125,0,thickness/2]){
				cube([thickness,length,base_z/3.5]);
			}
		}
}

module holder(){
	difference(){
		base();
		translate([base_x*0.1,-length/2,base_z*0.9]){
			cube([base_x,length*2,thickness]);
		}
	}
}
//--------------------------------------------

holder();
//back_side_with_text();