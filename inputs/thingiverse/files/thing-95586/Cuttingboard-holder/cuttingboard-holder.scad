// number of boards
count=3;

// board thickness
board_thickness=25;

// holder width
holder_width=30;

// divider thickness
divider=3;

// height of the holder
holder_height=3;

module board(){

union(){
	cube([holder_width,divider * (count+1) + board_thickness * count,holder_height/2]);
		for (i=[0:count]){
			translate([0,i * (divider + board_thickness), holder_height/2.0]){
				cube([holder_width,divider,holder_height/2.0]);
			}

		}
	}
}

board();