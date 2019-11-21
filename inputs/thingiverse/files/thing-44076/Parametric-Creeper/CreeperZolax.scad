
// Minecraft Creeper Keychain
// v2, now with facial features and a better keychain attachment
// Nudel 2011

//set to 0 for no facial expressions
face_depth = 1;//[0,1]

which_face="scary";//[happy,scary]

//radius of hole for keychain
hole_size = 0; // [0:2]  

creeper(which_face);
module creeper(f){

/*do_scary_face = 0;
do_happy_face = 1;*/

rotate([0,0,90]) //rotated to lay flat
scale(2) //1 pixel = 2mm

difference(){

union()
{

	//Head
	difference(){	
		cube([8,8,8 ]);

if(face_depth>0){
	
	if(f=="scary"){
	//Scary face O_O
	translate([0,0,-0.33])
	union(){
		for(i=[2,5]) {
			#translate([-face_depth,i,1]) cube([face_depth*2,1,3]);
		}
		for(i=[3,4]) {
			#translate([-face_depth,i,2]) cube([face_depth*2,1,3]);
		}
		for(i=[1,5]) {
			#translate([-face_depth,i,5+0.01]) cube([face_depth*2,2,2]);
		}
	}
	}else{
	//Happy face ^_^
	translate([8,0,-0.33])
	union(){
		for(i=[2,5]) {#translate([-face_depth,i,2]) cube([face_depth*2,1,2]);}
		for(i=[3,4]) {#translate([-face_depth,i,1]) cube([face_depth*2,1,2]);}
		for(i=[1,5]) {#translate([-face_depth,i,5]) cube([face_depth*2,2,2]);}
	}
	}
}

}

	//Body
	translate([2,0,-12]) cube([4,8,12]);

	//Legs
	translate([0,0,2]) //moved a bit up to attach to the body
	union()
	{
		translate([-2,0,-18]) cube([4,4,6]);
		translate([-2,4,-18]) cube([4,4,6]);
		translate([ 6,0,-18]) cube([4,4,6]);
		translate([ 6,4,-18]) cube([4,4,6]);
	}

/*
// Old v1 chain attachment
rotate([0,90,0]) 
translate([-8,4,5])
{

#rotate_extrude(convexity = 10,$fn=20)
translate([3, 0, 0])
circle(r = 1,$fn=20);

}
*/

}

if(hole_size>0){
	//Hole in head for piercing equipment.
	//You might have to experiment with this to make it fit your keychain.
	rotate([0,90,0])
	translate([-8,0,4])
	{
		rotate_extrude(convexity = 10,$fn=20)
		translate([3, 0, 0])
		circle(r = hole_size,$fn=20);
	}
}


}
}

