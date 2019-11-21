// preview[view:south, tilt:top]

/* [Global] */

// Which one would you like to see?
part = "pendant"; // [pendant:Pendant,halfPendant:Half Pendant,mold1:Mold side 1 (no hole),mold2:Mold side 2 (has hole),mold3:Mold part 3 (funnel)]

/* [Key loops] */
// The diameter of the rings on the key handle (at the center of the model) in mm.  This makes the center as a whole bigger or smaller.  By default a lot of things scale with this.
torusRingDiameter=10; //[0:40]

//How thick are the rings on the key handle?  This makes the center thinner or thicker.
torusRingThickness=2; //[0:10]

/* [Star points] */
//How many star points should the pendant have?
starPoints=7; //[0:10]

//This controlls how long the star points are.  That is, how far out fron the center they go
starRadius=25.4; //[0:200]

//How tall (z-axis) are the points at their bases?
starSpreadHeight=2; //[0:10]

//How wide (x-axis) are the star points at their base?
starSpreadWidth=5; //[0:10]

/* [Keys] */
//How many key blades do we display?
keys=4; //[0:8]

// How far out from the center should the keys extend?
keyRadius=25.4; //[0:200]

//What is the radius of the cylinder which makes up the majority of the length from the center to the tip of the key?
keyRodRadius=1; //[0:10]

//Just play with it. manipulates key tip
keyBitOffset=1.5; //[0:10]

//Play with it. manipulates key tip
keyBitOffsetLength=2; //[0:10]

//Play with it. manipulates key tip
keyBitWidth=1.5; //[0:10]

//Play with it. manipulates key tip
keyBitLength=4; //[0:10]

/* [Hanging loop] */
//Whats the outer radius of the cylinder put through the uppermost star point so this can be hung on a necklace?
ringOuterRadius=2; //[0:10]

//How thick is that part?
ringThickness=2; //[0:10]

/* [Casting] */

// controls the radius of the hole for pouring in casting material.  The first number is the radius at the entrance, the second the size where the hole meets the pendant.
pourwayBigR=3; //[0:10]
pourwayLittleR=2; //[0:10]

//What shape would you like the final mold to be?  Cube may be easier to work with; cylinder could print faster
moldShape="cube"; //[cube:Square/cube,cylinder:Round/Cylindrical,projection:Projection]

//How tall should the funnel part be?
funnelHeight=10; //[0:40]

//Controls the radius at the top of the funnel.  The bottom is automatically set to match the ourway size
funnelTopRadius=30; //[0:100]

/* [Hidden] */
moldHoleRadius=[pourwayBigR,pourwayLittleR];

//Regulates the fineness of all the round parts.  Higher is more detail and more rendering time.
$fn=30; //[10:100]

//variable to track what we've been asked to do
printHalf=(part=="halfPendant");
makeMold=(part=="mold1" || part=="mold2" || part=="mold3");
makeMoldHole=(part=="mold2");

//And how wide? Adjust to make sure the entire point is cut
ringWidth=starSpreadWidth; //[0:10]


module torus(r1, r2){
	rotate_extrude() {
		translate([r1/2,0,0]) {
			circle(r=r2);
		}
	}
}

module middle(r1, r2){
	linear_extrude(height=2*r2,center=true) {
		difference() {
			square([r1+r2,r1+r2],center=true);
			translate([r1/2,r1/2,0]) circle(r=r1/2);
			rotate([0,0,90]) translate([r1/2,r1/2,0]) circle(r=r1/2);
			rotate([0,0,180]) translate([r1/2,r1/2,0]) circle(r=r1/2);
			rotate([0,0,270]) translate([r1/2,r1/2,0]) circle(r=r1/2);
		}
	}
}

module middle_rings(r1, r2){
	linear_extrude(height=2*r2,center=true) {
		union() {
			square([r1+r2,r1+r2],center=true);
			translate([r1/2,r1/2,0]) circle(r=r1/2);
			rotate([0,0,90]) translate([r1/2,r1/2,0]) circle(r=r1/2);
			rotate([0,0,180]) translate([r1/2,r1/2,0]) circle(r=r1/2);
			rotate([0,0,270]) translate([r1/2,r1/2,0]) circle(r=r1/2);
		}
	}
}

//BaseWidth is a slight misnomer.  its the distance from the center of the base to each point on the base.
module star_point(radius,baseheight,basewidth) {
	polyhedron(
		points=[ [0,0,baseheight],[0,-basewidth,0],[0,0,-baseheight],[0,basewidth,0], // the four points at base
			[radius,0,0]  ],                                 // the apex point 
		triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],          // each triangle side
			[1,0,3],[2,1,3] ]                         // two triangles for square base
 );
}

module key(radius, rodRadius, bitOffset, bitOffsetLength, keyBitWidth, keyBitLength) {
	rotate([0,90,0]) union() {
		cylinder(h=radius, r=rodRadius);
		translate([-rodRadius/2,0,radius-bitOffsetLength-(keyBitLength-bitOffsetLength)/2]) cube([rodRadius, bitOffset,bitOffsetLength]);
		translate([-rodRadius/2,bitOffset,radius-keyBitLength]) cube([rodRadius,keyBitWidth, keyBitLength]);
	}
}

module pendant() {
	union() {
		translate([torusRingDiameter/2,torusRingDiameter/2,0]) torus(torusRingDiameter,torusRingThickness);
		translate([torusRingDiameter/2,-torusRingDiameter/2,0]) torus(torusRingDiameter,torusRingThickness);
		translate([-torusRingDiameter/2,torusRingDiameter/2,0]) torus(torusRingDiameter,torusRingThickness);
		translate([-torusRingDiameter/2,-torusRingDiameter/2,0]) torus(torusRingDiameter,torusRingThickness);
	
		middle(torusRingDiameter,torusRingThickness);
	
		difference(){
			union() {
				for(i = [0:360/starPoints : 360]) {
					rotate([0,0,i]) translate([torusRingDiameter/2,0,0]) star_point(starRadius,starSpreadHeight,starSpreadWidth);
				}
		
				//keyblades
				for(i=[0: keys-1]) {
					if ((((2*i)+0.5)*(360/starPoints))<180) {
						rotate([0,0,(((2*i)+0.5)*(360/starPoints))]) key(keyRadius,keyRodRadius,keyBitOffset,keyBitOffsetLength,keyBitWidth,keyBitLength);
					} else {
						mirror([0,1,0]) rotate([0,0,360-(((2*i)+0.5)*(360/starPoints))]) key(keyRadius,keyRodRadius,keyBitOffset,keyBitOffsetLength,keyBitWidth,keyBitLength);
					}
				}
				
				//reinforcement for the hanging ring
				translate([(torusRingDiameter/2)+(2/3)*starRadius,0,0]) rotate([90,0,0]) cylinder(r=ringOuterRadius,h=ringWidth,center=true);
			}
		
			middle_rings(torusRingDiameter,torusRingThickness);
	
			//And finally, hole for hanging the pendant by
			translate([(torusRingDiameter/2)+(2/3)*starRadius,0,0]) rotate([90,0,0]) # cylinder(r=ringOuterRadius-ringThickness,h=ringWidth+0.1,center=true);
		}
	}
	
	if (printHalf) {
		translate([-(keyRadius+torusRingDiameter),-(keyRadius+torusRingDiameter),-2*torusRingThickness]) #cube([2*keyRadius+2*torusRingDiameter,2*keyRadius+2*torusRingDiameter,2*torusRingThickness]);
	}
}

//key(keyRadius,keyRodRadius,keyBitOffset,keyBitOffsetLength,keyBitWidth,keyBitLength);

difference() {
	if (makeMold) {
		if (moldShape=="cube") {
			if(part!="mold3") {
				translate([-(keyRadius+torusRingDiameter),-(keyRadius+torusRingDiameter),-2*torusRingThickness]) cube([2*keyRadius+2*torusRingDiameter,2*keyRadius+2*torusRingDiameter,2*torusRingThickness]);
			} else {
				translate([-(keyRadius+torusRingDiameter),-(keyRadius+torusRingDiameter),0]) cube([2*keyRadius+2*torusRingDiameter,2*keyRadius+2*torusRingDiameter,funnelHeight]);
			}
		}
		if (moldShape=="cylinder") {
			if (part!="mold3") {
				union() {
					translate([0,0,-1.2*torusRingThickness]) cylinder(r=keyRadius+torusRingDiameter, h=1.2*torusRingThickness);
					translate([keyRadius+torusRingDiameter-torusRingThickness,-torusRingThickness,-1.2*torusRingThickness]) cube([2*torusRingThickness,2*torusRingThickness, 1.2*torusRingThickness]); //a "key" to help align the molds
				}
			} else {
				cylinder(r=keyRadius+torusRingDiameter, h=funnelHeight);
			}
		}
		if (moldShape=="projection") {
			if (part!="mold3") {
				translate([0,0,-1.2*torusRingThickness]) linear_extrude(height=1.2*torusRingThickness, convexity=10, twist=0) projection(cut=false) scale(1.1) hull() pendant();
			} else {
				linear_extrude(height=funnelHeight, convexity=10, twist=0) projection(cut=false) scale(1.1) hull() pendant();
			}
		}
	}
	
	if (part!="mold3") {
		pendant();
	} else {
		cylinder(r1=pourwayLittleR, r2=funnelTopRadius, h=funnelHeight);
	}
	
	if (makeMold && makeMoldHole) {
		#mirror([0,0,1]) translate([0,0,torusRingThickness]) cylinder(r2=moldHoleRadius[0], r1=moldHoleRadius[1], h=torusRingThickness*0.2);
	}
}