//CUSTOMIZER VARIABLES
/*[Disk]*/
//default units are mm
diameter_of_ring=25.4;
resoultion = 42;//[25:250]
two_halves_or_whole = 1;//[1:"whole",0:"two halves"]
/*[Rotate]*/
x_rot = 0;//[-360:360]
y_rot = 0;//[-360:360]
z_rot = 0;//[-360:360]
/*[Units]*/
units_entered = 1;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]
//default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]

//END CUSTOMIZER VARIABLES
module make_disk(x_pos=0, y_pos=0, z_pos=0, half = two_halves_or_whole){
	translate([x_pos,y_pos,z_pos]){
		difference(){
			union(){
				difference(){
					minkowski(){
						cylinder(r=diameter_of_ring*units_entered/2-5.25/2,h=.0001,$fn = resoultion,center=true);
						sphere(r=5.25/2,$fn = resoultion,center=true);
					}
					cylinder(r=diameter_of_ring*units_entered/2-5.25/2,h=10,$fn = resoultion,center=true);
				}
				cylinder(r=diameter_of_ring*units_entered/2-5.25/2, h = 1.25, $fn = resoultion, center = true);
			}
			if(half ==0){
				translate([0,0,-5.25/2]){
					cylinder(r=diameter_of_ring*units_entered,h=5.25, center = true);
				}
			}
		}
	}
}
scale(desired_units_for_output){
	rotate([x_rot,y_rot,z_rot]){
		if(two_halves_or_whole==0){
			make_disk();
			make_disk(x_pos=diameter_of_ring*units_entered+1);
		}
		else{
			make_disk();
		}
	}
}