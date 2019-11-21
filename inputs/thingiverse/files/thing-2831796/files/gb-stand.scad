/* [Global] */

//Width of stand
sheet_x=25;	// min/step/max: [15:5:200]

//Thickness of stand
sheet_z=1.5; // [0.5:0.5:10]

//diameter of rounded edges
sheet_d_=10; // [0:1:50]

// Depth of seat 
bottom_sheet_y=15; // [10:1:100]

// Height of rest
top_sheet_y=25; // [10:1:100]

// angle between seat and rest
angle_sheets=85; // [0:1:180]

// angle between seat and ground
angle_seat=7; // [0:1:45]

// Number of legs
legs=1; // [0:1:25]

//Width of legs
leg_w=2;// [1:1:20]

/* [Global] */
$fn=64;

sheet_d=max(sheet_d_,0.0001);


module sheet(size=[25,15,1.5],d=10){
	hull(){
		translate([0,d/2,0])cube(size-[0,d/2,0]);
		translate([d/2,d/2,0])cylinder(d=d,h=size[2]);
		translate([size[0]-d/2,d/2,0])cylinder(d=d,h=size[2]);
	}
}


module seat_seat(){
	rotate([-angle_seat,0,0])translate([0,-bottom_sheet_y,0])sheet([sheet_x,bottom_sheet_y,sheet_z],sheet_d);
}
module seat_rest(){
		rotate([-angle_seat,0,0])rotate([angle_sheets,0,0])translate([0,top_sheet_y,sheet_z])rotate([180,0,0])sheet([sheet_x,top_sheet_y,sheet_z],sheet_d);
}
module seat(){
	union(){
		seat_seat();
		seat_rest();
	}
}


module standContainer(){
	union(){
		hull(){
			linear_extrude(sheet_z)projection(cut = false)seat_seat();
			seat_seat();
		}
		hull(){
			linear_extrude(sheet_z)projection(cut = false)seat_rest();
			seat_rest();
		}
	}
}

module legs(){
	dist=sheet_x/(legs+2);
	intersection(){
		union(){
			for(a=[1:1:legs+1]){
				translate([dist*a-leg_w/2,-bottom_sheet_y*0.75,0])
					cube([leg_w,top_sheet_y+bottom_sheet_y,top_sheet_y+bottom_sheet_y*2]);
			}
		}
		standContainer();
		translate([0,0,-sheet_z])standContainer();
	}
	
}

legs();
seat();

