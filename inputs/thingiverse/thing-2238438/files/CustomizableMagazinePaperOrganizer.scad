include <MCAD/boxes.scad>

//Customizable magazine paper organizer


/* [Outside Box Dimensions] */
//Depth (Paper or mazine width width)
Depth=212; 
//Width 
Width=160; 
//Height 
Height=180;


//Y Dividers (0 for no dividers)
row=3; 
//Divider Wall Thickness
divWall=2;
//Chamfer angle
chamferAngle=45;


/* [Wall Thickness] */
//Wall Thickness (min: 2mm)
wall=2;



/* [Hidden] */
boxDim=[Depth, Width, Height]; 
over=0; //amount to extend parts that need to have interference (such as dividers)
//Chamfer size
chamfer=Height;



module xDiv(inSide){
  xInc=inSide[0]/col;
  for ( i = [1 : col-1] ) {
    translate([i*xInc, 0, 0])cube([divWall, inSide[1]+over, inSide[2]+over], center=true);
  }
}


module yDiv(inSide){
  yInc=inSide[1]/row;
  echo("Tool width:",yInc);
  for (i = [1 : row-1] ) {
	translate([0, i*yInc, 0])cube([inSide[0]+wall, divWall, inSide[2]+wall], center=true);
  }
}

module drawBox () {
  innerBox=[Depth-wall, Width-(2*wall), Height-wall];
  echo("innerBox=", innerBox);
  difference(){
		union() {
			difference() {
			  roundedBox(boxDim, 0, 1, $fn=36);
			  translate([wall+1,0,wall])roundedBox(innerBox, 0, 1, $fn=20);
			}
			translate([0, -innerBox[1]/2, 0]) yDiv(innerBox);
		}
		translate([boxDim[0]/2+5,-boxDim[1]/2-5,-30])rotate([0,-chamferAngle,0])cube([chamfer, boxDim[1]+10, boxDim[2]*2], center=false);	
	}
	//
	
}

module assemble() {
    translate([0,0,boxDim[2]/2])drawBox();
}

assemble();
