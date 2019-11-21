//fabrication parameter - shell
width_destroy = 0.7;//[0.5,0.7,0.9]

//fabrication parameter - solid
width_keep = 3;

//fabrication parameter - attachment
width_tab = 4;//[4,5,6]

//pulley_diameter = 9.5;
//pulley_thickness = 2.4;

finger_length = 100;//[80:150]
finger_height = 18;//[15:25]
finger_depth = 15;//[12:20]

//finger linkage ratio L2/L1
L_ratio = 0.67;//[0.5,0.67,0.75,0.83,1]
//stiffness ratio ~K2/K1
K_ratio = 2.5;//[1.5,2,2.5,3]

//flexure length
K_length = 12;//[10:15]

//palm parameter
LB = 29.5715;//[25:35]

//offset angle 1
T1 = 15;//[15,30,45]
//offset angle 2
T2 = 15;//[15,30,45]

//ignore variable values
L2 = finger_length / (1+1/L_ratio);
L1 = finger_length - L2;
R1 = 8;
R2 = R_ratio*R1;
K1 = 4.25;
K2 = pow((K_ratio*pow(K1,3)),1/3);

//finger base:
module finger_base(){

cube([LB,finger_depth,finger_height],true);
translate([-(LB+width_tab)/2,0,-finger_height/2+width_keep/2]) cube([width_tab,finger_depth,width_keep],true);
translate([(LB+width_tab)/2,0,-finger_height/2+width_keep/2]) cube([width_tab,finger_depth,width_keep],true);

//flexure 1:
translate([LB/2+K_length/2*cos(T1/2),0,K_length/2*sin(T1/2)]) {
	rotate([0,-T1/2,0]) cube([K_length+width_keep,finger_depth,K1+2*width_destroy],true);
	
	//L1 component
	rotate([0,-T1,0]){
		translate([L1/2,0,-K_length/2*sin(T1/2)]){
			cube([L1-K_length,finger_depth,finger_height],true);

			//flexure 2:
			translate([(L1-K_length)/2+K_length/2*cos(T2/2),0,K_length/2*sin(T2/2)]){
				rotate([0,-T2/2,0]) cube([K_length+width_keep,finger_depth,K2+2*width_destroy],true);
				//L2 component
				rotate([0,-T2,0]){
					translate([L2/2,0,-K_length/2*sin(T2/2)]){
						cube([L2-K_length,finger_depth,finger_height],true);	
					}
				}
			}
		}
	}	
}

}

module dogbone(){
	rotate([-90,0,0]) cylinder(finger_depth+width_destroy,width_keep/2,width_keep/2,true);
}

module flexures(){
	translate([LB/2+K_length/2*cos(T1/2),0,K_length/2*sin(T1/2)]) {
		rotate([0,-T1/2,0]){
			cube([K_length+2*width_keep,finger_depth,K1],true);
			translate([-(K_length+2*width_keep)/2,0,K1/2]) dogbone();
			translate([-(K_length+2*width_keep)/2,0,-K1/2]) dogbone();
			translate([(K_length+2*width_keep)/2,0,K1/2]) dogbone();
			translate([(K_length+2*width_keep)/2,0,-K1/2]) dogbone();
		}

		rotate([0,-T1,0]){
			translate([L1/2+(L1-K_length)/2+K_length/2*cos(T2/2),0,K_length/2*sin(T2/2)-K_length/2*sin(T1/2)]){
				rotate([0,-T2/2,0]){
					cube([K_length+2*width_keep,finger_depth+2*width_destroy,K2],true);
					translate([-(K_length+2*width_keep)/2,0,K2/2]) dogbone();
					translate([-(K_length+2*width_keep)/2,0,-K2/2]) dogbone();
					translate([(K_length+2*width_keep)/2,0,K2/2]) dogbone();
					translate([(K_length+2*width_keep)/2,0,-K2/2]) dogbone();
				}
			}
		}
	}
}


//making basic removals:
difference(){
	finger_base();
	flexures();
}
