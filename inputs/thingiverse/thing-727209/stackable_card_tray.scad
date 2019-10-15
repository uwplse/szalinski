
	//catan - (80,55,15)

	card_x = 80;
	card_y = 55;
	card_z = 15;
	bottom_z = 3;
	inner_offset = 10;
	top_wall_x = 3;
	top_wall_z = 17;
	side_wall_y = 5;

	tanlength = sqrt(pow(card_y,2)+pow((card_z-bottom_z),2));
	module slice() {
		translate([0,0,bottom_z])  {
			rotate([atan((card_z-bottom_z)/card_y),0,0]) {
				cube([card_x,tanlength,card_z]);
			}
		}
	}
	union(){
		difference() {
			difference() {
				cube([card_x,card_y,card_z]);
				translate([inner_offset,inner_offset,0]){
					cube([card_x-(inner_offset*2),card_y-inner_offset,card_z]);
				}			
			}
			slice();
		}
		difference(){
			translate([inner_offset,-side_wall_y,0]){
				cube([card_x-(inner_offset*2),side_wall_y,card_z]);
			}
			translate([0,-card_y,0]){
				slice();
			}
		}
		translate([-top_wall_x,0,0]){
			cube([top_wall_x,card_y,(top_wall_z)]);
		}
	}






