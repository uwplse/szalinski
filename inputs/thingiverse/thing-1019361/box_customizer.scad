//
// PARAMETRIC PENCIL BOX, V1.1
// FMMT666(ASkr) 04/2013
//


// - changes V1.1:
//  - added variable hinge length:
//    "hiHeight" now specifies the height of the hinge pin, relative to the bottom.


// HINTS:
// - Always start with hiHeight set to 0.
//   If this parameter is larger than "botHeight", things might look strange ;)

/* [Main Box] */

// Which part would you like to see?
part = "both"; // [bottom:Bottom,top:Top,both:Both]




// ===============================================================================
// choose parts to print


//PRINTBOT =       1;                // 0/1 turn bottom part off/on
//PRINTTOP =       1;                // 0/1 turn top part (lid) off/on
//PRINTPOS =       0;                // 0/1 move lid in printing position
//SHOWOFFPOS =     1;                // 0/1 nice looking off/on; ONLY IF PRINTPOS=0




// ===============================================================================
// box parameters

//Total Length of box, left-right
length =       90.0;              // length of the box
//Total Width of box, front-back
width =         60.0;              // width of the box
//Height of lid
topHeight =     10.0;              // height of the lid
//Height of bottom
botHeight =     20.0;              // height of bottom box part
//Thickness of left/right/front walls
wall =           2.0;              
//Thickness of floor and roof
floor =          3.0;              // thickness of the floor and "roof"
//Thickness of back wall hinge
backwall =       6.0;               //thickness of the back wall only

// ===============================================================================
// magnet parameters

/* [Magnets] */

//Magnet length
maLength =       5.5;              // length of the magnet cutout (x axis)
//Magnet width
maWidth =        5.5;              // depth of the magnet cutout (y axis)
//Magnet height
maHeight =       5.5;              // height of the magnet cuout (z axis)
//Magnet spacer
maSpacer =       1.0;              // thickness of material around magnet 


// ===============================================================================
// hinge parameters (usually no change required)

/* [Hinge] */

//Hinge z-height (0.0 = lowest possible)
hiHeight =       0.0;              // z pos of hinge (0.0 = lowest possible)

hiLength =      length/12;         // length of the hinge
hiOffs =        length/4;          // position of the hinge

//Hinge diameter
hiDia =          3.0;              // diameter of the hinge pin cutout

hiDiaDepth =    hiOffs+hiLength;   // drill depth of the hinge pin
hiHingSpac =    hiLength/20;       // additional space to make it move freely


// ===============================================================================
// additional parameters

/* [Chamfer] */

//Chamfer edges
CHAMFEREDGES =   1; //[1:Yes,0:No]
//Chamfer length
CHAMFERLEN =     3.0;              

// ===============================================================================
// ===============================================================================
// ===============================================================================
// NO CHANGES BELOW HERE
CYLPREC = 100/1;

print_part();

module print_part() {
	if (part == "bottom") {
		BoxBottom();
	} else if (part == "top") {
        translate( [0, width, botHeight + topHeight ] )
        rotate( [180, 0, 0] )
		BoxTop();
    } else if (part == "both") {
        BoxBottom();
        translate( [ 0, width+floor-backwall, +floor+wall/2 + hiHeight ] )
        rotate( [-45,0,0] )
        translate( [ 0, -width-floor+backwall, -floor-wall/2-hiHeight ] )
        BoxTop();
	} else {
		BoxBottom();
	}
}


// ===============================================================================
// === BOX BOTTOM

//if( PRINTBOT )
//  BoxBottom();



// ===============================================================================
// === BOX TOP
//if( PRINTTOP )
//{
//  if( PRINTPOS )
//  {
//    translate( [0, width, botHeight + topHeight ] )
//    rotate( [180, 0, 0] )
//    BoxTop();
//  }
//  else
//    if( SHOWOFFPOS )
//    {
//      translate( [ 0, width+floor-backwall, +floor+wall/2 + hiHeight ] )
//        rotate( [-45,0,0] )
 //         translate( [ 0, -width-floor+backwall, -floor-wall/2-hiHeight ] )
 //           BoxTop();
//    }
//	else
//      BoxTop();
//}



// ===============================================================================
// ===============================================================================
// ===============================================================================



// ===============================================================================
// === IDIOT BOX (if none of the box parts was selected)
//if( !PRINTTOP && !PRINTBOT )
//  cube([10,10,10]);



// ===============================================================================
// === BOX BOTTOM
module BoxBottom()
{
  difference()
  {
    // === THE BOX
    cube( [ length, width, botHeight ] );
    translate( [ wall, wall, floor ] )
      cube( [ length - 2*wall, width - wall - backwall, botHeight - floor + 1 ] );

    // === LEFT HINGE CUTOUT
    translate( [ hiOffs - hiLength/2, width - 1.5*backwall, floor + hiHeight ] )
      cube( [ hiLength, 2*backwall, botHeight - floor/2 ] );

    // === RIGHT HINGE CUTOUT
    translate( [ length - hiOffs - hiLength/2, width - 1.5*backwall, floor+hiHeight ] )
      cube( [ hiLength, 2*backwall, botHeight - floor/2 ] );

    // === LEFT HINGE PIN CUTOUT
    translate( [ -1, width - backwall/2, floor+backwall/2+hiHeight ] )
    rotate( [ 0, 90 ,0 ] )
      cylinder( r=hiDia/2, h=hiDiaDepth+1, $fn=CYLPREC );

    // === RIGHT HINGE PIN CUTOUT
    translate( [ length - hiDiaDepth + 1, width - backwall/2, floor+backwall/2+hiHeight ] )
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
      translate( [0, 0, botHeight ] )
      cube( [ length, width, topHeight ] );
      translate( [ wall, wall, botHeight -1 ] )
        cube( [ length - 2*wall, width - wall - backwall, topHeight - floor +1 ] );

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
      translate([hiOffs-hiLength/2+hiHingSpac,width-backwall,floor+0.5*backwall+hiHeight]) 
        cube([hiLength-2*hiHingSpac, backwall, botHeight-floor-0.5*backwall-hiHeight ] );
      translate([hiOffs-hiLength/2+hiHingSpac,width-backwall/2,floor+0.5*backwall+hiHeight])
        rotate( [0,90,0] )
          cylinder( r = backwall/2, h = hiLength - 2*hiHingSpac, $fn=CYLPREC );
    }

    // === LEFT HINGE PIN CUTOUT
    translate( [ -1, width - backwall/2, floor+backwall/2+hiHeight ] )
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
    scale( [ 2*topHeight, wall , topHeight/1.5] )
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





