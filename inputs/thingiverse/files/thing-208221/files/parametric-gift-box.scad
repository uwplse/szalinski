// This controls how tight the lid will fit to the base. .2 is the default, which is right for my printer; but you might need a higher number (for a looser fit) or a lower number (for a tighter fit).
lid_tolerance = .2;

// The *inner* length of the box base in millimeters. The *overall* length is `length + wall * 2`.
length=83;

// The *inner* width of the box base in millimeters. The *overall* width is `width + wall * 2`.
width=45;

// The *inner* height of the box base in millimeters. The *overall* height, not counting ribbon, is `height + wall * 2`. Note that the usable inner volume is decreased due to the lid inset. The lid inset is equal to wall*3.
height=35;

// The thickness of all walls, in millimeters.
wall=2;

// The amount the top-box-ribbon descends down the sides, in millimeters.
ribbon_overlap=10;

/* [Hidden] */
draw_bottom=1; draw_ribbon=1; draw_top=1; 

ribbon=(width>length?length/3:width/3);
assembled=0;

if( draw_bottom ) {
difference() {
	union() {
		translate( [(width+wall*2-ribbon)/2,length+wall*2,wall] ) {
			rotate( [0,90,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			cube( [ribbon,wall,height-wall-ribbon_overlap] );
		}
		translate( [(width+wall*2-ribbon)/2,0,wall] ) {
			rotate( [0,90,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			translate( [0,-wall,0] ) cube( [ribbon,wall,height-wall-ribbon_overlap] );
		}
		translate( [0,(length+wall*2-ribbon)/2,wall] ) {
			rotate( [-90,0,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			translate( [-wall,0,0] ) cube( [wall,ribbon,height-wall-ribbon_overlap] );
		}
		translate( [width+wall*2,(length+wall*2-ribbon)/2,wall] ) {
			rotate( [-90,0,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			cube( [wall,ribbon,height-wall-ribbon_overlap] );
		}
		cube( [width+wall*2,length+wall*2,height+wall] );
	}
	translate( [wall,wall,wall] ) cube( [width,length,height+.01] );
	translate( [width/2+wall,length/2+wall,0] ) {
		for( theta=[0,90,180,270] ) {
		rotate( [0,0,theta] )
		difference() {
			translate( [-ribbon/2-1,0,0] ) cube( [ribbon+2,length/2+wall,wall/2] );
			translate( [-ribbon/2,0,0] ) cube( [ribbon,length/2+wall,wall/2] );
		}
		}
	}
	for( x=[[0,wall],[width+wall,width+wall]] ) {
		for( y=[[0,wall],[length+wall,length+wall]] ) {
			difference() {
				translate( [x[0],y[0],0] ) cube( [wall,wall,height+wall] );
				translate( [x[1],y[1],0] ) cylinder( r=wall, h=height+wall, $fn=20 );
			}
		}
	}
}
}

if( draw_top ) {
translate( (assembled?[-width*2-wall*4,length+wall+wall,height+wall*2+.05]:[0,0,0]) )
rotate( [(assembled?180:0),0,0] )
translate( [width*2+wall*4,0,0] ) {
difference() {
	union() {
		cube( [width+wall*2,length+wall*2,wall*4] );
		translate( [(width+wall*2-ribbon)/2,length+wall*2,wall] ) {
			rotate( [0,90,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			cube( [ribbon,wall,wall+ribbon_overlap] );
		}
		translate( [(width+wall*2-ribbon)/2,0,wall] ) {
			rotate( [0,90,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			translate( [0,-wall,0] ) cube( [ribbon,wall,wall+ribbon_overlap] );
		}
		translate( [0,(length+wall*2-ribbon)/2,wall] ) {
			rotate( [-90,0,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			translate( [-wall,0,0] ) cube( [wall,ribbon,wall+ribbon_overlap] );
		}
		translate( [width+wall*2,(length+wall*2-ribbon)/2,wall] ) {
			rotate( [-90,0,0] ) cylinder( r=wall, h=ribbon, $fn=20 );
			cube( [wall,ribbon,wall+ribbon_overlap] );
		}
	}

    // Lid inner subtraction
	translate( [wall*2,wall*2,wall] ) cube( [width-wall*2,length-wall*2,wall*4+ribbon_overlap] );

    // Lid outer subtraction, west
	translate( [-lid_tolerance/2,0,wall] ) cube( [wall+lid_tolerance,length+wall*2,wall*4+ribbon_overlap] );
    // Lid outer subtraction, east
	translate( [width+wall-lid_tolerance/2,0,wall] ) cube( [wall+lid_tolerance,length+wall*2,wall*4+ribbon_overlap] );
    // Lid outer subtraction, south
	translate( [0,-lid_tolerance/2,wall] ) cube( [width+wall*2,wall+lid_tolerance,wall*4+ribbon_overlap] );
    // Lid outer subtraction, north
	translate( [0,length+wall-lid_tolerance/2,wall] ) cube( [width+wall*2,wall+lid_tolerance,wall*4+ribbon_overlap] );

	translate( [width/2+wall,length/2+wall,0] ) {
		for( theta=[0,90,180,270] ) {
		rotate( [0,0,theta] )
		difference() {
			translate( [-ribbon/2-1,0,0] ) cube( [ribbon+2,length/2+wall,wall/2] );
			translate( [-ribbon/2,0,0] ) cube( [ribbon,length/2+wall,wall/2] );
		}
		}
		translate( [-2.5,-2.5,0] ) cube( [5,5,5] );
	}

	for( x=[[0,wall],[width+wall,width+wall]] ) {
	for( y=[[0,wall],[length+wall,length+wall]] ) {
		difference() {
			translate( [x[0],y[0],0] ) cube( [wall,wall,height+wall] );
			translate( [x[1],y[1],0] ) cylinder( r=wall, h=height+wall, $fn=20 );
		}
	}}
}
}
}

if( draw_ribbon ) {
translate( (assembled?[-width,0,0]:[0,0,0]) )
rotate( (assembled?[0,90,0]:[0,0,0]) )
translate( [width*1.5+wall*3,0,0] ) {
	difference() {
		hull() {
			translate( [-wall,0,0] ) cylinder( r=wall*2, h=10, $fn=wall*5 );
			translate( [0,9.5,0] ) cube( [wall,1,10] );
		}
		hull() {
			translate( [-wall*1,0,0] ) cylinder( r=wall,h=10,$fn=wall*5 );
			translate( [0,9-wall,0] ) cube( [.01,1,10] );
		}
	}
	translate( [0,10,0] ) cube( [wall*3,5,5] );
	translate( [0,10,0] ) cube( [wall,5,10] );
	translate( [0,10,7] ) rotate( [30,0,0] ) difference() {
		cube( [wall,4,10] );
		translate( [0,2,7] ) scale( [1,1,2] ) rotate( [45,0,0] ) cube( [wall,5,5] );
	}
	translate( [0,10,8.5] ) rotate( [-30,0,0] ) difference() {
		cube( [wall,4,10] );
		translate( [0,2,7] ) scale( [1,1,2] ) rotate( [45,0,0] ) cube( [wall,5,5] );
	}
	difference() {
		hull() {
			translate( [-wall,25,0] ) cylinder( r=wall*2, h=10, $fn=wall*5 );
			translate( [0,14.5,0] ) cube( [wall,1,10] );
		}
		hull() {
			translate( [-wall,25,0] ) cylinder( r=wall, h=10,$fn=wall*5 );
			translate( [0,10+5+wall,0] ) cube( [.01,1,10] );
		}
	}
	
}
}