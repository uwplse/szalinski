include <MCAD/boxes.scad>

//Pill box with sliding lid

/* [Outside Box Dimensions] */
//Box Width (min: 5 x Wall Thickness)
bX=100; 
//Box Depth (min: 5 x Wall Thickness)
bY=160; 
//Box Height (min: 5 x Wall Thickness)
bZ=42;

//X Dividers (0 for no dividers)
col=0; 
//Y Dividers (0 for no dividers)
row=5; 
//Divider Wall Thickness
divWall=2;

/* [Lip] */
//Lip height (0 = no lip)
lipHeight=7;
//Lip width (0 = no lip)
lipWidth=7;
//Prism with (0 = no prism)
prismWith=14; 

/* [Wall Thickness] */
//Wall Thickness (min: 2mm)
wall=2;



/* [Hidden] */
boxDim=[bX, bY, bZ]; 
over=0; //amount to extend parts that need to have interference (such as dividers)
sidesonly = 1;
chamfer=30;


module xDiv(inSide){
  xInc=inSide[0]/col;
  for ( i = [1 : col-1] ) {
    translate([i*xInc, 0, 0])cube([divWall, inSide[1]+over, inSide[2]+over], center=true);
  }
}

module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}


module yDiv(inSide){
  yInc=inSide[1]/row;
  echo("Tool width:",yInc);
  for (i = [1 : row-1] ) {
	translate([0, i*yInc, 0])cube([inSide[0]+wall, divWall, inSide[2]+wall], center=true);
  }
}

module drawBox () {
  innerBox=[bX-wall, bY-(2*wall), bZ-wall];
  echo("innerBox=", innerBox);
  difference(){
		union() {
			difference() {
			  roundedBox(boxDim, 0, 1, $fn=36);
			  translate([wall,0,wall])roundedBox(innerBox, 0, 1, $fn=20);
			}
			translate([-innerBox[0]/2, 0, -over/2]) xDiv(innerBox);
			translate([0, -innerBox[1]/2, 0]) yDiv(innerBox);
			
			//lip
			if (lipHeight && lipWidth){
				translate([boxDim[0]/2-lipWidth/2,0,-innerBox[2]/2+lipHeight/2+wall])cube([lipWidth, innerBox[1], lipHeight], center=true);
				if (prismWith){
					translate([boxDim[0]/2-lipWidth,-innerBox[1]/2,-innerBox[2]/2+wall])rotate([0,-90,0])prism(innerBox[1], lipHeight,prismWith);
				}
			}
			
			
		}
		translate([boxDim[0]/2,0,boxDim[2]/2])rotate([0,-45,0])cube([chamfer, boxDim[1], chamfer+10], center=true);	
	}
}

module assemble() {
    translate([boxDim[0]/2,boxDim[1]/2,boxDim[2]/2])drawBox();
}

assemble();
