// Camera-Box: "IPEVO Ziggi-HD Plus USB"
// Author: Chr. Schmitz
// Version: 0.1.2
// Date: 15.04.2016
// License: http://creativecommons.org/licenses/by/3.0/



//================================================================================
// TODO:
//  - THE LID IS TOO HIGH (EVEN HIGHER THAN THE BOTTOM). 
// 	HENCE IT SCRATCHES SLIGHTLY THE CAMERA. CHANGE THE LID-BOTTOM-RATIO.
//================================================================================



// Version History:
//  - V0.2.2: changed comments
//  - V0.2.1: Adapted PENCIL BOX to a print bed of 200x200mm by cutting the edges
// based on: 
// PARAMETRIC PENCIL BOX, V1.2
// FMMT666(ASkr) 04/2013, 05/2013
// http://creativecommons.org/licenses/by/3.0/

// - changes V1.2:
//  - added missing grip-size modifiers
//
// - changes V1.1:
//  - added variable hinge length:
//    "hiHeight" now specifies the height of the hinge pin, relative to the bottom.


// HINTS:
// - Always start with hiHeight set to 0.
//   If this parameter is larger than "botHeight", things might look strange ;)


// ===============================================================================
// choose parts to print
PRINTBOT =       1;                // 0/1 turn bottom part off/on
PRINTTOP =       1;                // 0/1 turn top part (lid) off/on
PRINTPOS =       0;                // 0/1 move lid in printing position
SHOWOFFPOS =     1;                // 0/1 nice looking off/on; ONLY IF PRINTPOS=0

// ===============================================================================
// box parameters
bCam_front = 		40;
bCam_back = 		17;
bCam_socket = 		81;
lCam_front = 		30;//79;
lCam_back = 		30;
lCam_socket = 	  175;//126;
wall =           6.0;              // thickness of the walls
floor =          3.0;              // thickness of the floor and "roof"

topHeight =     30.0;              // height of the lid
botHeight =     20.0;              // height of bottom box part

// ===============================================================================
length = 2*wall+lCam_front+lCam_socket+lCam_back;	// length of the box
width = 2*wall+bCam_socket;           				   // width of the box
// ===============================================================================
// grip modifiers
grLenTune =      1.0;              // grip-length-multiplier (default: 1.0)
grHeiTune =      1.0;              // grip-height-multiplier (default: 1.0)


// ===============================================================================
// magnet parameters
maLength =       5.5;              // length of the magnet cutout (x axis)
maWidth =        5.5;              // depth of the magnet cutout (y axis)
maHeight =       5.5;              // height of the magnet cuout (z axis)
maSpacer =       1.0;              // thickness of material around magnet 


// ===============================================================================
// hinge parameters (usually no change required)
hiHeight =       0.0;              // z pos of hinge (0.0 = lowest possible)
hiLength =      length/12;         // length of the hinge
hiOffs =        length/4;          // position of the hinge
hiDia =          3.5;              // diameter of the hinge pin cutout
hiDiaDepth =    hiOffs+hiLength;   // drill depth of the hinge pin
hiHingSpac =    hiLength/20;       // additional space to make it move freely


// ===============================================================================
// additional parameters
CHAMFEREDGES =   0;                // 0/1 chamfer edges off/on
CHAMFERLEN =     3.0;              // chamfer length



// ===============================================================================
// ===============================================================================
// ===============================================================================
// NO CHANGES BELOW HERE
CYLPREC = 100;



// ===============================================================================
// === BOX BOTTOM

if( PRINTBOT )
  BoxBottom();



// ===============================================================================
// === BOX TOP
if( PRINTTOP )
{
  if( PRINTPOS )
  {
    translate( [0, width, botHeight + topHeight ] )
    rotate( [180, 0, 0] )
    BoxTop();
  }
  else
    if( SHOWOFFPOS )
    {
      translate( [ 0, width+floor-wall, +floor+wall/2 + hiHeight ] )
        rotate( [-45,0,0] )
          translate( [ 0, -width-floor+wall, -floor-wall/2-hiHeight ] )
            BoxTop();
    }
	else
      BoxTop();
}



// ===============================================================================
// ===============================================================================
// ===============================================================================



// ===============================================================================
// === IDIOT BOX (if none of the box parts was selected)
if( !PRINTTOP && !PRINTBOT )
  cube([10,10,10]);



// ===============================================================================
// === BOX BOTTOM
module BoxBottom()
{
  difference()
  {
    // === THE BOX
	 translate([wall,wall,0])
	   minkowski()
      {
	     linear_extrude(height=botHeight-1)
			 polygon([[lCam_front,0],[lCam_front+lCam_socket,0],
			 [lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2],
			 [lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2+bCam_back],
			 [lCam_front+lCam_socket,bCam_socket],[lCam_front,bCam_socket],
			 [0,((bCam_socket-bCam_front)/2+bCam_front)],[0,(bCam_socket-bCam_front)/2]]);
		  cylinder(r=wall,h=1);
	   }
  	 translate([wall,wall,floor]) 
	   linear_extrude(height=botHeight-floor+1)
		  polygon([[lCam_front,0],[lCam_front+lCam_socket,0],
		  [lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2],
		  [lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2+bCam_back],
		  [lCam_front+lCam_socket,bCam_socket],[lCam_front,bCam_socket],
		  [0,((bCam_socket-bCam_front)/2+bCam_front)],[0,(bCam_socket-bCam_front)/2]]);
		
    // === LEFT HINGE CUTOUT
    translate( [ hiOffs - hiLength/2, width - 1.5*wall, floor + hiHeight ] )
      cube( [ hiLength, 2*wall, botHeight - floor/2 ] );

    // === RIGHT HINGE CUTOUT
    translate( [ length - hiOffs - hiLength/2, width - 1.5*wall, floor+hiHeight ] )
      cube( [ hiLength, 2*wall, botHeight - floor/2 ] );

    // === LEFT HINGE PIN CUTOUT
    translate( [ -1, width - wall/2, floor+wall/2+hiHeight ] )
    rotate( [ 0, 90 ,0 ] )
      cylinder( r=hiDia/2, h=hiDiaDepth+1, $fn=CYLPREC );

    // === RIGHT HINGE PIN CUTOUT
    translate( [ length - hiDiaDepth + 1, width - wall/2, floor+wall/2+hiHeight ] )
    rotate( [ 0, 90 ,0 ] )
      cylinder( r=hiDia/2, h=hiDiaDepth+1, $fn=CYLPREC );

    // === RECESSED GRIP CUTOUT
    RecessedGrip();

    // === LEFT MAGNET CUTOUT
    translate([hiOffs-maLength/2, wall - maWidth, botHeight - maHeight - maSpacer])
      cube( [ maLength, maWidth+1, maHeight ] );

    // === RIGHT MAGNET CUTOUT
    translate([length-hiOffs-maLength/2,wall-maWidth, botHeight-maHeight-maSpacer])
      cube( [ maLength, maWidth+1, maHeight ] );

    // === CHAMFERED EDGES
    if( CHAMFEREDGES )
      ChamferedEdges();

  } // END difference
}



// ===============================================================================
// === BOX TOP
module BoxTop()
{
  union()
  {
    difference()
    {
      // === THE BOX
     	translate([wall,wall,botHeight])
		  minkowski()
  		  {
		    linear_extrude(height=topHeight-1)
			   polygon([[lCam_front,0],[lCam_front+lCam_socket,0],
				[lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2],
				[lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2+bCam_back],
				[lCam_front+lCam_socket,bCam_socket],[lCam_front,bCam_socket],
				[0,((bCam_socket-bCam_front)/2+bCam_front)],[0,(bCam_socket-bCam_front)/2]]);
			 cylinder(r=wall,h=1);
		  }
	   translate([wall,wall,botHeight-1]) 
		  linear_extrude(height=topHeight-floor+1)
			 polygon([[lCam_front,0],[lCam_front+lCam_socket,0],
			 [lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2],
			 [lCam_front+lCam_socket+lCam_back,(bCam_socket-bCam_back)/2+bCam_back],
			 [lCam_front+lCam_socket,bCam_socket],[lCam_front,bCam_socket],
			 [0,((bCam_socket-bCam_front)/2+bCam_front)],[0,(bCam_socket-bCam_front)/2]]);

      // === RECESSED GRIP CUTOUT
      RecessedGrip();

      // === LEFT MAGNET CUTOUT
      translate([hiOffs-maLength/2, wall - maWidth, botHeight+maSpacer])
        cube( [ maLength, maWidth+1, maHeight ] );

      // === RIGHT MAGNET CUTOUT
      translate([length-hiOffs-maLength/2,wall-maWidth,botHeight+maSpacer])
        cube( [ maLength, maWidth+1, maHeight ] );

      // === CHAMFERED EDGES
      translate([0,0,botHeight+topHeight])
        mirror([0,0,1])
          ChamferedEdges();
    }

    // === LEFT HINGE
    LeftHinge();

    // === RIGHT HINGE
    translate( [ length - 2*hiOffs, 0, 0 ] )
      LeftHinge();
  } // END union
}



// ===============================================================================
// === HINGE
module LeftHinge()
{
  difference()
  {
    union()
    {
      translate([hiOffs-hiLength/2+hiHingSpac,width-wall,floor+0.5*wall+hiHeight]) 
        cube([hiLength-2*hiHingSpac, wall, botHeight-floor-0.5*wall-hiHeight ] );
      translate([hiOffs-hiLength/2+hiHingSpac,width-wall/2,floor+0.5*wall+hiHeight])
        rotate( [0,90,0] )
          cylinder( r = wall/2, h = hiLength - 2*hiHingSpac, $fn=CYLPREC );
    }

    // === LEFT HINGE PIN CUTOUT
    translate( [ -1, width - wall/2, floor+wall/2+hiHeight ] )
    rotate( [ 0, 90 ,0 ] )
      cylinder( r=hiDia/2, h=hiDiaDepth+1, $fn=CYLPREC );

  } // END difference
} // END LeftHinge



// ===============================================================================
// === RECESSED GRIP CUTOUT
module RecessedGrip()
{
  // === RECESSED GRIP
  translate( [ length/2, -wall/3, botHeight ] )
    scale( [ grLenTune*2*topHeight, wall , grHeiTune*topHeight/1.5] )
      sphere( r = 1, $fn=CYLPREC );

}




// ===============================================================================
// === CHAMFERED EDGES
module ChamferedEdges()
{
  // === FRONT CUT
  translate([0,0,CHAMFERLEN])
  rotate([-45,0,0])
    translate([-1,-length/2,-2*CHAMFERLEN])
      cube([length+2,length,2*CHAMFERLEN]);

  // === REAR CUT
  translate([0,width,CHAMFERLEN])
  rotate([45,0,0])
    translate([-1,-length/2,-2*CHAMFERLEN])
      cube([length+2,length,2*CHAMFERLEN]);

  // === LEFT CUT
  translate( [ 0, 0, CHAMFERLEN ] )
    rotate( [0,45,0] )
    translate( [ -width / 2, -1, -2 * CHAMFERLEN ] )
      cube([width,2+width,2*CHAMFERLEN]);

  // ===RIGHT CUT
  translate( [ length, 0, CHAMFERLEN ] )
  rotate( [0,-45,0] )
  translate( [ -width / 2, -1, -2 * CHAMFERLEN ] )
    cube([width,2+width,2*CHAMFERLEN]);

}





