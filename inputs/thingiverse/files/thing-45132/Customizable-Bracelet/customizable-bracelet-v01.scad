//Constants
//hidden PI
//PI = 3.14159;


//CUSTOMIZER VARIABLES

//Generate Chain or Single Link
chain = true; // [true, false]

//Length Of Each Link
linkLength = 15;

//Diameter of the total item.
diameter = 62;


//Size of the link connectors
eyeletSize = 2;

//Add or remove links to make sure that the links connect.
linkAdjust = 4;

//Width of Links.
linkWidth = 4;

//Style of links.
connectType = "A"; // [A, B, C]


connectCombine = false;

useRandomLinks = false;




//Connector Type A Controls.
numConnectorsA = 2; // [2 : 10]



//Connector Type B Controls.
//Number of sides of the shapes.
numberOfSidesB = 5;

//Add randomness to the shapes
randomSpinB = true; //[true, false]

//How many sections, Less if more.
densityB = 2;

//This of the sections.
thicknessB = 1;

//Randomness on y axis of connector.
randomRotateOnB = 1; //[1: true, 0:false]

//Randomness on x axis of connector.
randomSkewOnB = 1; //[1: true, 0:false]

//Scale randomness of the skew.
randomScaleSkewB = 15;


//Connector Type C controls.

//Cause a bulge in the connector.
centerExpandC = 2;

//Total amount of twist.
twistC = 360;

//CUSTOMIZER VARIABLES END



module ring(height, thickness, eyeletSize, res=40){
	difference(){
		cylinder(h=height, r1=eyeletSize, r2=eyeletSize, center=true, $fn=res);
		cylinder(h=height*2, r1=eyeletSize-thickness, r2=eyeletSize-thickness, center=true, $fn=res);
	}

}


module link(linkLength, linkType = 0){
	
	union(){
		rotate([90, 0, 45]) translate([ 0, linkLength/2+eyeletSize, 0]) {
			ring(1, 0.5, eyeletSize);
			
		}
		
		rotate([-90, 0, -45]) translate([ 0, linkLength/2+eyeletSize, 0]) {
			ring(1, 0.5, eyeletSize);
		}
	

	
		translate([0, 0, (linkLength)/2]) cube(size=[linkWidth, 1, 1], center=true);
		
		translate([0, 0, -(linkLength)/2]) cube(size=[linkWidth, 1, 1], center=true);
	
		if (connectCombine == false){

	
			if(linkType == "A"){
				connectA();
			} 
			if(linkType == "B"){
				connectB();
			} 		
			if(linkType == "C"){
				connectC();
			}	
		}else{
			connectA();
			connectB();
		}

	}

}



module connectA(){
		
		for (i = [0: numConnectorsA-1]){
	
			translate([((linkWidth/(numConnectorsA-1))*i) - linkWidth/2, 0, 0]) cylinder(h=(linkLength)+1, r1=0.5, r2=0.5, center=true, $fn=20);
		}
}



module connectB(){

	random_vect = rands(0,360,linkLength);
	random_vect2 = rands(-45,45,linkLength);
	difference(){
		union(){
			for(i = [0 : densityB : linkLength ]){
				if (randomSpinB == true){
					rotate([90, 0, 0]) translate([0,i-((linkLength)/2) , 0]) rotate([random_vect2[i]*randomSkewOnB*(randomScaleSkewB/100), random_vect2[i]*randomSkewOnB*(randomScaleSkewB/100), random_vect[i]*randomRotateOnB]) ring(1, thicknessB, linkWidth/2, numberOfSidesB);
				} else {
					rotate([90, 0, 0]) translate([0, i-(linkLength/2), 0]) ring(1, thicknessB, linkWidth/2, numberOfSidesB);
				}
			}

		}

	translate([0, 0, linkLength/2+5]) cube(size=[linkWidth, 10, 10], center=true);
	translate([0, 0, -linkLength/2-5]) cube(size=[linkWidth, 10, 10], center=true);

	}

}










module connectC(){
		
		function getLookUp(p) = lookup(p, [[0, 1], [linkLength/2, centerExpandC], [linkLength, 1]]);

		for(i = [0 : linkLength]){
	
			translate([0, 0, (i-((linkLength)/2))]) rotate([0, 0, twistC*(i/(linkLength*2))]) cube(size=[linkWidth*getLookUp(i), 1 , 1], center=true);
		}
}






numOfLinks = ceil((diameter*PI)/(linkLength+eyeletSize)/2)+linkAdjust;

randomLinks = rands(0, 1, ceil((diameter*PI)/(linkLength+eyeletSize)/2)+linkAdjust);

if (chain){

for (i = [0 : numOfLinks]){


	rotate([0, 0, 360/numOfLinks*i]){
		if(useRandomLinks == false){
			rotate([90, 0, 0]) translate([diameter/2, 0, 0]) link(linkLength, connectType);
		
		} else {	
	
			
			rotate([90, 0, 0]) translate([diameter/2, 0, 0]) link(linkLength, round(randomLinks[i]));
		}

	}


}

}else{

	rotate([90, 0, 0]) link(linkLength, connectType);
}



