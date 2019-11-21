track_length=50;

rotate (a=[90,0,0]) linear_extrude(height =track_length, center = true) polygon(points = [ [0,0], [0,9], [1,12],[4,12],[5,9],[10,9],[11,12],[29,12],[30,9],[35,9],[36,12], [39,12],[40,9], [40,0]], path = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]);

//peg
module peg(){
	translate ([0,-12.5,0])
	union(){
		cylinder(12,5.9,5.9);
		translate ([-3,5,0]) cube(size=[6,8,12]);
	}
}

translate ([20,-track_length/2,0]) peg();

translate ([20,track_length/2,0]) rotate(a=[0,0,180]) peg();