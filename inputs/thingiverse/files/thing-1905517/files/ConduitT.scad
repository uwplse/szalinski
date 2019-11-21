//-----------------------------------------
// Counduit Tube for electric wires T union
//
// (c) Pedro Barrio 2016
//-----------------------------------------

// External diameter
extDiameter  = 16.5  ;

// Wall Thickness
wallThick    =  1.5;

// Tube Length
tubeLength   = 16  ;

// Insertion Length
insertLength = 20  ;

// Transition Length
tranLength   = 10;

// circle precision
$fn=200;

difference(){
	union(){
		TubeWithInsert();
		rotate ([0,90,0])
			TubeWithInsert();
		rotate ([0,180,0])
			TubeWithInsert();
	}
	// final holes
	union(){
		cylinder( extDiameter , extDiameter/2 - wallThick , extDiameter/2 - wallThick , center = true);
		rotate ([0,90,0])
			cylinder( extDiameter/2 , extDiameter/2 - wallThick, extDiameter / 2 - wallThick );
	}
}

// Tube segment
module Tube(){
	difference(){
		cylinder( tubeLength, extDiameter/2             , extDiameter/2             );
		cylinder( tubeLength, extDiameter/2 - wallThick , extDiameter/2 - wallThick );
	}
}

// Tube Insertion
module Insert(){
	// Transition
	difference(){
		cylinder( tranLength, extDiameter/2             , extDiameter/2  + wallThick );
		cylinder( tranLength, extDiameter/2 - wallThick , extDiameter/2              );
	}
   
	// Tube biggest diameter
	translate ([0,0,tranLength])
	difference(){
		cylinder( insertLength, extDiameter/2 + wallThick , extDiameter/2 + wallThick );
		cylinder( insertLength, extDiameter/2             , extDiameter/2             );
	}
}

module TubeWithInsert()
{
	Tube();
	translate ([0,0,tubeLength])
		Insert();
}