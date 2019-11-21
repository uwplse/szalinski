$fn=120;

// Which one would you like to see?
part = "both"; // [first:Left part,second:Right part,both:Both parts]

// Smaller diameter of the ellipse
barOD1 = 40;
// Larger diameter of the ellipse
barOD2 = 60;
// Thickness of the part
thickness = 8;
// Height of the part
height = 15;
// Screw diameter (M3=3)
screwOD = 3;
// Nut diameter (M3=5.5)
nutOD = 5.5;
// Nut height, usefull to compute holes depth
nutHeight = 3;
// Head height, usefull to compute holes depth
screwHeadHeight=2;
// Screw length, usefull to compute holes depth
screwLength = 12;
// Width of the top flat area
platformWidth = 10;
// Hole Clearance, 0.2 is good value, might be increased for some printers
holeClearance = 0.2;



print_part();

module print_part() {
	if ( part == "first" ) {
		part1();
	} else if ( part == "second") {
		part2();
	} else if ( part == "both" ) {
		both();
	} else {
		both();
	}
}


module ellipse( length, width, height, center = false) {
  scale( [1, width/length, 1] )
    cylinder( h=height, r=length/2, center=center );
}




module support() {
  difference() {
    union() {
      ellipse( barOD2+thickness*2, barOD1+thickness*2, height );  // Main body
      for (i = [-1, 1]) {  // Add small surface for screws
        translate( [0, (barOD1+thickness)/2*i, 0] )
          ellipse( thickness*3, thickness*2.4, height );
      }
      translate( [-barOD2/2-thickness, -platformWidth/2, 0] ) // Add a plane
        cube( [thickness, platformWidth, height] );
    };
    translate( [0, 0, -1] ) // Remove main bar
      ellipse( barOD2+holeClearance*2, barOD1+holeClearance*2, height+2 );
    // Remove support assembly screws
    for (i = [-1, 1]) {
      translate( [-thickness*3/2, (barOD1+thickness*2+screwOD)/2*i, height/2] )
        rotate( [0, 90, 0] )
          union() {
            cylinder( r=(screwOD+holeClearance)/2, h = barOD2 ); // Screw
            translate( [0, 0, screwLength*0.1] )  // Nut. 10% translation to help screwing
            cylinder( r=(nutOD+holeClearance)/2, h = thickness, $fn=6 );
            translate(  [0, 0,thickness-nutHeight+screwLength] )  // Head
              cylinder( r=(nutOD+holeClearance)/2, h = thickness*2 );
          }
    }
    // Remove object screw
    translate( [-barOD2/2+1, 0, height/2] ) rotate( [0, -90, 0] ) union() {
      cylinder( r=(screwOD+holeClearance)/2, h=thickness*2 );
      cylinder( r=(nutOD+holeClearance)/2, h=screwHeadHeight*2+1 );
    }
  }
}



module part1() {
  difference() {
    support();
    translate( [0, -barOD2*2, -barOD2*2] ) cube( barOD2*4 );
  }
}

module part2() {
  difference() {
    support();
    translate( [-barOD2*4, -barOD2*2, -barOD2*2] ) cube( barOD2*4 );
  }
}


module both() {
  part1();
  translate( [2, 0, 0] ) part2();
}