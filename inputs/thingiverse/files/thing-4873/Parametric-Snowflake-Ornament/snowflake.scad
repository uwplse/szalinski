//Parametric Snowflake... and star
//common snowflake variables
//make seed 100 for a star
arm_num = 6;
branch_length =40;
branch_angle = 15;
branch_thickness = 3;
thickness = 6;
spike_num = 6; //suggest under 40
seed =1; //any number 1 -7

//snowflake starts
module tree(branch_length,branch_angle, branch_thickness, thickness,spike_num,seed){
	module half_tree(){
		cube([branch_thickness/2,branch_length,thickness]);

		for ( i = [1:spike_num]){
			translate([0, (branch_length-1.3)*cos(i*13), 0]) 
			rotate(branch_angle*(seed+sin(i*15))) 
			cube([branch_length*sin(i*(2+seed))+0.5, branch_thickness, thickness]);
		}
	}

	half_tree(branch_length, branch_angle,branch_thickness, thickness,spike_num, seed);
	mirror()half_tree(branch_length, branch_angle, thickness, spike_num, seed);
}

module snowflake(arm_num, branch_length, branch_angle, branch_thickness, thickness, spike_num, seed){
	hole_dist = branch_length;
	translate([0,branch_length,0])cylinder(h=thickness, r=branch_length*sin(1*(2+seed))+branch_thickness, $fn=10);
		for ( i = [0:arm_num-1]){
			rotate( i*360/arm_num, [0,0,1])
			tree(branch_length,branch_angle, branch_thickness, thickness,spike_num,seed);
		}
}

translate([branch_length,branch_length,0]){
difference(){

snowflake(
	arm_num, 
	branch_length, 
	branch_angle,
	branch_thickness,
	thickness,
	spike_num,
	seed
);
translate([0,branch_length,-2])cylinder(h=thickness*2, r=branch_length*sin(3), $fn=10);
}
}