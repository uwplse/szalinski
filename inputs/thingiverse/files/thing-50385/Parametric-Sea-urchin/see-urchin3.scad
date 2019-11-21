module sea_urchin()
difine();
//valiable data
//Sphere_size_r
ssz=20;

//number_of_needle
nn=360;//[0:360]

//needle_hight
nsz=50;//[0:50]

//needle_size_r1
nr1=0;//[0:10]

//needle_size_r2
nr2=3;//[0:10]

//needle_position_y
y=9;//[0:100]

//needle_position_z
z=8;//[0:100]

//needle_shape
$fn=12; //[3,4,5,6,7,8,12]
//valiable data end

	union() {
			sphere(r=ssz, $fn=24);	
	for (i = [ 0 : nn-1] ) {
				rotate([i,y*i,z*i]) translate([-ssz,0,0]) rotate([0,90,0])cylinder(h=nsz,r1=nr1,r2=nr2,center=true);
							}
			 }
module sea_urchin();

	
