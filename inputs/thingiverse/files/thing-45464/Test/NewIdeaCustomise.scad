MouthX=0;//[-200:200]
MouthY=0;//[-200:200]
//Does He have a big mouth?
MouthSize=25;//[25:100]
//Rotating the mouth 180 makes it a sad face instead of a happy face.
MouthRotate=0;//[0:364]



//How strong is the emotion?
Mouth="Very";//[Super,Very]
height=5;
radius=25;
thing(Mouth, height,radius,MouthSize,MouthX);

module thing(Mouth){
$fn=64;

	color([0,1,1])
	cylinder(h=height,r=radius,center=true);

	if (Mouth=="Super"){
rotate([0,0,MouthRotate])		
1happyMouth( );
	}else if (Mouth=="Very"){
rotate([0,0,MouthRotate])		
happyMouth( );
	}
}


module 1happyMouth(){

translate([MouthX,MouthY,height/2]){
	difference(){
		cylinder(r=MouthSize-MouthSize/4,h=2,center=true);
		translate([MouthX,23,0])
		cube([1000,MouthSize*2,100],center=true);
}
}	
}




module happyMouth( ){
translate([MouthX,MouthY,height/2]){
	difference(){
		cylinder(r=MouthSize-MouthSize/4,h=3,center=true);
		translate([MouthX,17.5,0])
		cube([500,MouthSize+10,20],center=true);
		cylinder(r=MouthSize/2,h=20,center=true);
	}
}
}