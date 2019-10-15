/* [Basics] */
number_of_spokes = 6; // [2,4,6,8,10,12,14,16,18,20]
length	= 10; // [1:20]
width =3; // [1:10]
thickness	= 2; // [1:10]

/* [Connection settings] */
connecting = "yes"; // [yes:Yes 3D,no: No I am in flat land]
connect_length = 5;
little_extra = .2;

module basic(){
intersection(){
	for(a=[1:number_of_spokes]){
		rotate([0,0,(360/number_of_spokes)*a]) translate([length/2,0,0])  cube([length,width,thickness], center=true);
	}
	translate([-length*2,-width/2,-length/2]) cube([50,length*2,50], center=false);
}
}

if(connecting=="yes"){
difference(){
	basic();
	rotate([0,0,90]) cube([connect_length,thickness+little_extra,thickness+little_extra], center=true);
}
}
else{
basic();
}