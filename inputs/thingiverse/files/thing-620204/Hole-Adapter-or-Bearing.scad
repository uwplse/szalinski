// variables
height = 3; // [1:100]
pipe_height_in_percent = 66; // [0:100]
washer_diameter = 10; // [1:99]
pipe_diamater = 7; // [1:100]
hole = 1; // [1:Yes,0:No]
hole_diameter = 4; // [1:100]
resolution = 100; // [100:rough,150:middle,200:fine]


// model
difference(){
	union(){
		cylinder(h=height/100*(100-pipe_height_in_percent),r1=washer_diameter/2,r2=washer_diameter/2,$fn=resolution);
		translate([0,0,height/100*(100-pipe_height_in_percent)]) cylinder(h=height/100*pipe_height_in_percent,r1=pipe_diamater/2,r2=pipe_diamater/2,$fn=resolution);
	}
	if(hole==1){
		cylinder(h=height,r1=hole_diameter/2,r2=hole_diameter/2,$fn=resolution);
	}
}
