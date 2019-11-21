//Copyright Austin Floyd 2013
//http://www.thingiverse.com/thing:119050
//license GNU GPL
//austin.floyd at 3DprintGeeks (dot) com

//global variables.. if not set when calling wedge it will use these values. 
//The prefix st_ is to "namespace" the global variables so they're not accidentally overridden elsewhere


//The top angle of the right triangle
st_wedgeAngle=12; // [0.01:89.99]

//The height of the triangle (width auto-generated based on this)
st_wedgeHeight=27; // [0.01:200]

//Depth (thickness) of triangle
st_wedgeWidth=2.2; // [0.01:200]

//Increased or decreased percentage (50% would be 0.5) of top point vs bottom point
st_topFactor=0.5; // [0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]

//Whether or not to center on x/y/z
st_center=false; // [true, false]

//Flip it upside down
st_invert=false; // [true, false]

//default wedge
wedge();

//demo of several different wedges
//demo();
module demo() {
	translate([0,0,15])
	wedge(angle=75,height=10, wedgeWidth=5);

	wedge(angle=75,height=5,topFactor=.25, center=true, wedgeWidth=10);

	translate([0,0,-15])
	wedge(angle=35,height=13,center=true);

	translate([0,0,-30])
	wedge(angle=35,height=6, center=true, invert=true);
}


module wedge(angle=st_wedgeAngle, height=st_wedgeHeight, wedgeWidth=st_wedgeWidth, topFactor=st_topFactor, center=st_center, invert=st_invert) {
	angle2=180-90-angle;
	hyp=height/sin(angle2);
	width=sqrt(pow(hyp,2)-pow(height,2));
	if (!invert) {
		triangle(height, width, center, topFactor, wedgeWidth);
	}
	if (invert) {
		rotate(180,[1,0,0])
		triangle(height, width, center, topFactor, wedgeWidth);
	}
}
module triangle(height=5, width=5, center=false, topFactor=0.5, wedgeWidth) {
	triangles=[[0,1,4],[5,4,1],		// top
					[1,2,5],[2,3,4],		// sides
					[3,0,4], [4,5,2],	//back
           	[2,1,0], [2,0,3]]; // base
	halfWidth=width/2;
	halfWWidth=wedgeWidth/2;
	topWidth=wedgeWidth*topFactor;
	halfTopWidth=topWidth/2;
	topHalfDiff=(wedgeWidth-topWidth)/2;
	halfHeight=height/2;
	if (center) {
		polyhedron(
  			points=[/*0*/[halfWidth,halfWWidth,-halfHeight],/*1*/[halfWidth,-halfWWidth,-halfHeight],				//front point
					  /*2*/[-halfWidth,-halfWWidth,-halfHeight],       /*3*/[-halfWidth,halfWWidth,-halfHeight], //rear point
           	  /*4*/[-halfWidth,halfTopWidth,height-halfHeight], /*5*/[-halfWidth,-halfTopWidth,height-halfHeight] ], //front/rear top 
  			triangles=triangles
		);
	}
	else {
		polyhedron(
  			points=[/*0*/[width,wedgeWidth,0],         			 /*1*/[width,0,0],				    ////front point
					  /*2*/[0,0,0],       					  			 /*3*/[0,wedgeWidth,0], 		    //rear point
           	  /*4*/[0,wedgeWidth-topHalfDiff,height],/*5*/[0,topHalfDiff,height] ],//front/back top 
  			triangles=triangles
		);
	}
}