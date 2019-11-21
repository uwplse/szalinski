/* [Global] */
// Which one would you like to see?
part = "both"; // [Box:Box only,Lid:Lid only,both:box and lid]

// Arc - No of facets parameter
$fn = 60;

// Wall thickness
wallT = 1.2;
// Clearance regarding box anf lid
clearance = 0.2;
// Bottom settings
// Bottom width
bottomW = 60;
// Bottom depth
bottomD = 40;
// Bottom height
bottomH = 9;

// Holes OD
bottomHolesOD = 1.8;
// Holes spacing in X and Y
bottomHolesSpacingXY = 0.8;
// Holes spacing in Z
bottomHolesSpacingZ = 0.4;

/* [Hidden] */
// Top settings
topW = bottomW + wallT*2 + clearance*2;
topD = bottomD + wallT*2 + clearance*2;
topH = 3+wallT;



module bottom() {
  difference() {
    // Add - Main cube
    cube( [bottomW, bottomD, bottomH] );
    // Remove - Main space
    translate( [wallT, wallT, wallT ] )
      cube( [bottomW-wallT*2, bottomD-wallT*2, bottomH ] );
    // Remove - Holes on X plan
    for ( iz = [ 0 : 1 : (bottomH-bottomHolesSpacingZ*2-bottomHolesOD-wallT)/bottomHolesOD ] ) {
      for ( ix = [wallT+bottomHolesSpacingXY+bottomHolesOD/2 : bottomHolesSpacingXY+bottomHolesOD : bottomW-(bottomHolesSpacingXY+bottomHolesOD)*2] ) {
        translate( [ix+iz%2*(bottomHolesOD+bottomHolesSpacingXY)/2, 
                    -1,
                    wallT+bottomHolesSpacingZ+bottomHolesOD/2+iz*(bottomHolesSpacingZ+bottomHolesOD)
        ])
          rotate( [-90, 0, 0] ) cylinder( r=bottomHolesOD/2, h=bottomD+2 );
      }
    }
    // Remove - Holes on Y plan
    for ( iz = [ 0 : 1 : (bottomH-bottomHolesSpacingZ*2-bottomHolesOD-wallT)/bottomHolesOD ] ) {
      for ( iy = [wallT+bottomHolesSpacingXY+bottomHolesOD/2 : bottomHolesSpacingXY+bottomHolesOD : bottomD-(bottomHolesSpacingXY+bottomHolesOD)*2] ) {
        translate( [-1,
                    iy+iz%2*(bottomHolesOD+bottomHolesSpacingXY)/2,
                    wallT+bottomHolesSpacingZ+bottomHolesOD/2+iz*(bottomHolesSpacingZ+bottomHolesOD)
        ])
          rotate( [0, 90, 0] ) cylinder( r=bottomHolesOD/2, h=bottomW+2 );
      }
    }
  }
}

module top() {
  difference() {
    // Add - Main cube
    cube( [topW, topD, topH] );
    // Remove - Main space
    translate( [wallT+clearance, wallT+clearance, wallT ] )
      cube( [topW-(wallT+clearance)*2, topD-(wallT+clearance)*2, topH ] );
    // Remove - Holes
    for ( ix = [wallT+bottomHolesSpacingXY+bottomHolesOD/2 : bottomHolesSpacingXY+bottomHolesOD : topW-bottomHolesSpacingXY-bottomHolesOD] ) {
      for ( iy = [wallT+bottomHolesSpacingXY+bottomHolesOD/2 : bottomHolesSpacingXY+bottomHolesOD : topD-bottomHolesSpacingXY-bottomHolesOD] ) {
        translate( [ix, iy, -1] )
          cylinder( r=bottomHolesOD/2, h=wallT+2 );
      }
    }
  }
}


module print_part() {
  if (part == "box") {
    bottom();
  } else if (part == "lid") {
    top();
  } else if (part == "both") {
    bottom();
    translate( [0, bottomD*1.2, 0] )
      top();
  } else {
    bottom();
  }
}

print_part();