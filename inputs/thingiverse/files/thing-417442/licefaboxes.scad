/* Parametric Boxes with lids 
   for small parts.
   Sample Sizes match the LICEFA drawer system
   mw 20140804 v.1.0 created.
   mw 20140810 v.1.1 improved lid - less material, better strength of the snap-in parts 
   works on ultimaker 1
   mw 20150205 v.1.2 now with a kanban card holder and a wall clip / Mounting rail 

*/

// Material strength (typically 1.5mm in the original boxes)
bWall=1.5;
// Outer Width (Licefa widths are 62,112,124,248)
bOuterW=62; 
// Outer Depth (Licefa depths are 56,62,112)
bOuterD=56; 
// Outer Height (Licefa heights are 33,54; this is the height without the lid on - the lid adds 1xbWall to this)
bOuterH=54; 
// Inner Radius
bInnerR=4;
// just a little outer radius to ease tight fits. MUST NOT BE > bWall/2!
bOuterR=0.7; 
// lid or no lid? snap fit or friction fit? snap fit generates little noses on the lid, friction fit just makes the rim higher=easier to close and open, but might slide off easier.
lidType="snapfit"; //[none,snapFit,frictionFit]
// Holder Bracket - This is a wall clip for an open box. Does not work with the lid on.
generateHolderBracket="yes"; //[yes,no]
HolderBracketMountingHoleDiameter=4;
// This generates a holder on one of the inner sides which can hold a cardboard label
generateKanbanCardHolder="yes"; //[yes,no]
// Overfill = extra gap to increase the holes so that parts fit well. Experiment with it. My Ultimaker needs 0.15mm.
overfill=0.15; 

//internal variables

notchW=bWall;
notchD=bOuterD/8;
notchH=2;
cardThickness=0.3;

 difference() {
	cubeX([bOuterW,bOuterD,bOuterH],bOuterR); // outer volume

	translate([bWall,bWall*2,bWall]) 
	   cubeX([bOuterW-2*bWall,bOuterD-3*bWall,bOuterH+bWall],bInnerR); // inner volume
	
	for (i=[bWall+10:10:bOuterW-bWall-bInnerR]) // 10 mm kinks
	    translate ([i,bOuterD-bWall*1.5,bOuterH-2])
	           cube([1,bWall,3]);
	
	for (i=[bWall+5:5:bOuterW-bWall]) // 5mm kinks
	    translate ([i,bOuterD-bWall*1.5,bOuterH-1])
	           cube([1,bWall,2]);
	
	for (i=[1,bOuterW-1-notchW]) // notches
	    translate ([i,bOuterD/2-notchD/2-overfill,bOuterH-2*notchH-2*overfill])
	           cube([notchW+2*overfill,notchD+2*overfill,notchH+4*overfill]);

	translate([bWall,bWall,bOuterH-4*notchH-bInnerR]) // cutaway upper rim
		difference() { 
			cubeX([bOuterW-2*bWall,bOuterD-2*bWall,bOuterH+bWall],bInnerR);
			cube([bOuterW-2*bWall,bOuterD-2*bWall,bInnerR]);
		}

    translate ([0,bWall*3,0])rotate ([0,90,0]) cylinder (bOuterW,bWall,$fn=20); // clip notch
    if (generateKanbanCardHolder=="yes") {
	    // kanban card holder - a slot 0.3mm wide and bWall/2 strong
        translate([bWall+bInnerR,bWall,bWall+bInnerR]) cube([bOuterW-2*(bWall+bInnerR),bWall*0.5,bOuterH-bInnerR]);
        translate([bWall+bInnerR+2*bWall,bWall,bWall+bInnerR+2*bWall]) cube([bOuterW-2*(bWall+bInnerR)-4*bWall,bWall*2,bOuterH-(bInnerR+2*bWall)]);

	translate([bWall,bWall*2,bWall]) 
	   cubeX([bOuterW-2*bWall,bOuterD-3*bWall,bOuterH+bWall],bInnerR); // inner volume
    } else {

	translate([bWall,bWall,bWall]) 
	   cubeX([bOuterW-2*bWall,bOuterD-2*bWall,bOuterH+bWall],bInnerR); // inner volume
    }


}


if (lidType!="none") {
	union() {
	  translate ([0,bOuterD+1,0]) {
	     cubeX([bOuterW,bOuterD,bWall],bOuterR); // lid
	     difference() {
	         translate ([bWall+2*overfill,bWall+2*overfill,-bInnerR])
	           cubeX([bOuterW-2*(bWall+2*overfill), 
	                  bOuterD-2*(bWall+2*overfill), 
	                  bOuterH-2*(bWall+2*overfill)],bInnerR); // this becomes the inner frame of the lid
	         translate ([0,0, lidType=="snapFit" ? bWall+2*notchH : bWall+4*notchH ])
	            cube([bOuterW,bOuterD,bOuterH]); // cut off the top
	         translate ([0,0,-bOuterH])
	            cube([bOuterW,bOuterD,bOuterH]); // cut off the bottom
	         translate ([2*bWall+2*overfill,      
	                     2*bWall+2*overfill,bWall])
	            cubeX([bOuterW-4*bWall-4*overfill,
	                   bOuterD-4*bWall-4*overfill,
	                   bOuterH],
	                   bInnerR-(bInnerR*(bWall/(0.5*bOuterW)))); // hollow out (correct inner radius proportionally)
	    }
	    translate ([bWall+2*overfill, bOuterD/2-notchD/2-overfill, bWall]) //bridge
	       cube([bOuterW-2*bWall-4*overfill, notchD, 2*notchH]);
	    if (lidType=="snapFit") {
	     for (i=[1+2*overfill,bOuterW-1-2*overfill-notchW]) {
	          translate ([i,(bOuterD/2)-bOuterD/16,bWall+notchH])
	                cube([notchW,notchD,notchH]); // noses
	     }
	    }
	  }
	}
}

bracketW=bOuterW-2*bWall-2*bInnerR;

if (generateHolderBracket!="no") { // clip 
    union() {
		translate ([0,-bWall,0]) rotate ([0,0,-90]) {
			translate([bWall*5+2*overfill,bWall*2-overfill,0]) cylinder (h=bracketW,d=bWall-overfill,$fn=20); 
			cubeX([bWall*10,bWall*2,bracketW],bOuterR);

			difference () {
				cubeX([bWall*2,bOuterH+6*bWall,bracketW],bOuterR);
				translate ([0,(bOuterH+6*bWall)/2+4*bWall,bracketW/4]) rotate ([0,90,0]) 
				cylinder (bWall*2+overfill, d1=HolderBracketMountingHoleDiameter, d2=HolderBracketMountingHoleDiameter+4*bWall, $fn20);
				translate ([0,(bOuterH+6*bWall)/2+4*bWall,bracketW-bracketW/4]) rotate ([0,90,0]) 
				cylinder (bWall*2+overfill, d1=HolderBracketMountingHoleDiameter, d2=HolderBracketMountingHoleDiameter+4*bWall, $fn20);
			translate([bWall*2,bOuterH+1.5*bWall,0]) cylinder (h=bracketW,d=bWall+2*overfill,$fn=20); 

			}
			translate([0,bOuterH+3*bWall,0]) cubeX([bWall*5+4*overfill,bWall*3,bracketW],bOuterR);
			translate([bWall*3+4*overfill,bOuterH+1*bWall,0]) cubeX([bWall*2,bWall*5,bracketW],bOuterR);

    		}
	}
}


/*     for (i=[bWall+1.3,(bOuterW-4*bWall)-1.3]) {
          translate ([i,bInnerR+bWall+0.5,bWall]  )
             cube([bWall*3,bOuterD-(bWall*2)-1-2*bInnerR,4]); //reinforcement strips
     }
     for (i=[bInnerR+bWall+0.5,(bOuterD-4*bWall)-.5-bInnerR]) {
          translate ([4*bWall+1.3,i,bWall]  )
             cube([bOuterW-(bWall*8)-2.6,bWall*3,4]); //reinforcement strips
     }


*/



//
// Simple and fast corned cube!
// Anaximandro de Godinho.
//

module cubeX( size, radius=1, rounded=true, center=false )
{
	l = len( size );
	if( l == undef )
		_cubeX( size, size, size, radius, rounded, center );
	else
		_cubeX( size[0], size[1], size[2], radius, rounded, center );
}

module _cubeX( x, y, z, r, rounded, center )
{
	if( rounded )
		if( center )
			translate( [-x/2, -y/2, -z/2] )
			__cubeX( x, y, z, r );
		else
			__cubeX( x, y, z, r );
	else
		cube( [x, y, z], center );
}

module __cubeX(	x, y, z, r )
{
	//TODO: discount r.
	rC = r;
	hull()
	{
		translate( [rC, rC, rC] )
			sphere( r );
		translate( [rC, y-rC, rC] )
			sphere( r );
		translate( [rC, rC, z-rC] )
			sphere( r );
		translate( [rC, y-rC, z-rC] )
			sphere( r );

		translate( [x-rC, rC, rC] )
			sphere( r );
		translate( [x-rC, y-rC, rC] )
			sphere( r );
		translate( [x-rC, rC, z-rC] )
			sphere( r );
		translate( [x-rC, y-rC, z-rC] )
			sphere( r );
	}
}

