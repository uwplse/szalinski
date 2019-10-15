// Resolution
$fn =50;

// Base parameters

width      = 25.5;
length     = 23.2;
thick      =  2.5;

// emboss parameters
embWidth   = 22.5;
embLength  = 14;
embThick   =  0.5;

embOffsetX = ( width  -embWidth  ) / 2;
embOffsetY = ( length -embLength )- embOffsetX;

// wing parameters
wingHeight = 10;
wingWidth  =  5.5;
wingThick  =  1.5;
wingHole   =  2.1;


//Base
difference (){
	// base
	cube ( [ width, length, thick ] );

	// emboss
	translate ( [ embOffsetX, embOffsetY, thick - embThick] )
		cube ( [ embWidth, embLength, embThick + 0.1 ] ) ;
}

// first wing
wing();

// second wing
translate ( [ width - wingThick, 0, 0 ] )
	wing();

module wing(){
	difference (){
		//leg
		union(){
			cube ( [ wingThick, wingWidth, wingHeight - wingWidth / 2 ] );
			translate ( [ 0, wingWidth / 2, wingHeight - wingWidth / 2 ] )
				rotate ( [ 0, 90, 0 ] )
					cylinder( wingThick, wingWidth / 2, wingWidth / 2 );
		}   
		// hole                 
		translate ( [-0.1 , wingWidth / 2, wingHeight - wingWidth / 2 ])
			rotate ( [ 0, 90, 0 ] )
				cylinder( wingThick + 0.2, wingHole / 2, wingHole / 2 );
	}
}





























































