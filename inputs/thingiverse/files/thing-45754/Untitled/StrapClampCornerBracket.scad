

// How wide is the strap and any extra play you want added
StrapWidth = 40;
// Space for the gap for the hook to hold the clamp corner on the strap
StrapThickness = 3;

// Minimum Thickness of the clamp corner body. It will be twice as thick in the corner
ClampThickness = 2;
// How long to make the clamp from corner to end
ClampLength = 60 ;

// Angle too be clamped
ClampAngle = 90;



difference()
{
	CornerBracket();
	// Make a spot for the glue to sqeeze out
	hull()
	{	
		cylinder(h = StrapWidth + ClampThickness * 2, r=ClampThickness * .5 , $fs=0.01);	
		translate([ClampThickness  , -ClampThickness   , 0]) cylinder(h = StrapWidth + ClampThickness * 2, r=ClampThickness * .75 , $fs=0.01);	
	}


}

module CornerBracket()
{
	frame();
	rotate(a = ClampAngle, v = [ 0, 0, -1]) mirror([0, 1, 0]) frame();
	
	hull ()
	{
		OutsideCorner();
		rotate(a = ClampAngle, v = [ 0, 0, -1]) mirror([0, 1, 0]) OutsideCorner();
	}
}		

module frame ()
{
 	//Base
     hull(){
		translate(v = [ClampLength, 0, 0]) cylinder(h = ClampThickness, r=ClampThickness * .5, $fs=0.01);
		translate(v = [-ClampThickness * .5, ClampThickness * .5, 0]) cylinder(h = ClampThickness, r=ClampThickness , $fs=0.01);	
		translate(v = [0,  (ClampThickness  * 2 + StrapThickness)  , 0])  cylinder(h = ClampThickness , r=ClampThickness * .5 , $fs=0.01);
		translate(v = [ClampLength,  (ClampThickness + StrapThickness) , 0])  cylinder(h = ClampThickness , r=ClampThickness * .5, $fs=0.01);
	}

       //Sides
	hull(){
		// Narrow side
		translate(v = [ClampLength, 0, 0]) cylinder(h = StrapWidth + ClampThickness * 2, r=ClampThickness * .5, $fs=0.01);
		// Wide side
		translate(v = [-ClampThickness * .5, ClampThickness * .5, 0]) cylinder(h = StrapWidth + ClampThickness * 2, r=ClampThickness , $fs=0.01);	
	}
	//Short Side
	hull(){
		translate(v = [0,  (ClampThickness  * 2 + StrapThickness)  , 0])  cylinder(h = StrapWidth * .1 + ClampThickness , r=ClampThickness  * .5, $fs=0.01);
		translate(v = [ClampLength,  (ClampThickness + StrapThickness) , 0])  cylinder(h = StrapWidth * .1 + ClampThickness , r=ClampThickness * .5, $fs=0.01);
	}
	//Upper step Side
	hull(){
		// inline part
		translate(v = [0,  ClampThickness *.5  , StrapWidth + ClampThickness * 2 - StrapThickness])  cylinder(h = StrapThickness , r=ClampThickness , $fs=0.01);
		translate(v = [ClampLength,  0  , StrapWidth + ClampThickness * 2 - StrapThickness])  cylinder(h = StrapThickness , r=ClampThickness * .5, $fs=0.01);
		// Outside step part
		translate(v = [-ClampThickness * 1.5,  ClampThickness * 1.5 , StrapWidth + ClampThickness * 2 - .1])  cylinder(h = .1 , r=ClampThickness  * .5, $fs=0.01);
		translate(v = [ClampLength,  ClampThickness *.5  , StrapWidth + ClampThickness * 2 - .1])  cylinder(h = .1 , r=ClampThickness * .5, $fs=0.01);
	}
}

module OutsideCorner()
{
	cylinder(h = ClampThickness, r=ClampThickness * .5 , $fs=0.01);	
	translate(v = [0,  (ClampThickness  * 2 + StrapThickness)  , 0])  cylinder(h = ClampThickness , r=ClampThickness * .5 , $fs=0.01);
}