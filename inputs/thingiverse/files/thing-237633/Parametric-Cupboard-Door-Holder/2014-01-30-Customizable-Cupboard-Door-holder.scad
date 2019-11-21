/*
* Cupboard Doors Holder
* This was designed to prevent my cats from
* Opening my kitchen/bathroom cupboards
* (Yes I've got quite Eveil cats ;) )
*/


/* 
*  Configuration Variables
*/

Thickness = 5 ;
Knob_Width = 10 ;
Inner_Knob_Distance = 65 ;

/* [Hidden] */
Strenght_Factor = 1.5 ;

// End Configuration

module cupboard_doorstop(THICKNESS, KNOB_WIDTH, INNER_KNOB_DISTANCE, STRENGHT_FACTOR)
{
	TOTAL_HEIGHT = KNOB_WIDTH + KNOB_WIDTH*STRENGHT_FACTOR ;
	TOTAL_LENGTH = KNOB_WIDTH*2 + (KNOB_WIDTH*STRENGHT_FACTOR)*2 + INNER_KNOB_DISTANCE ;
	
	difference() {
		difference() {
			linear_extrude(height = THICKNESS, center = false, convexity = 10, twist = 0)
			polygon(points=[[0,0],[0,TOTAL_HEIGHT],[TOTAL_LENGTH,TOTAL_HEIGHT],[TOTAL_LENGTH,0],[TOTAL_LENGTH-(KNOB_WIDTH*STRENGHT_FACTOR),0],[TOTAL_LENGTH-(KNOB_WIDTH*STRENGHT_FACTOR),KNOB_WIDTH],[TOTAL_LENGTH-(KNOB_WIDTH*STRENGHT_FACTOR)-KNOB_WIDTH,KNOB_WIDTH],[TOTAL_LENGTH-(KNOB_WIDTH*STRENGHT_FACTOR)-KNOB_WIDTH,0],[KNOB_WIDTH*STRENGHT_FACTOR+KNOB_WIDTH,0],[KNOB_WIDTH*STRENGHT_FACTOR+KNOB_WIDTH,KNOB_WIDTH],[KNOB_WIDTH*STRENGHT_FACTOR,KNOB_WIDTH],[KNOB_WIDTH*STRENGHT_FACTOR,0]]);
			
			translate([KNOB_WIDTH*STRENGHT_FACTOR+(KNOB_WIDTH/2),KNOB_WIDTH,-0.5])
			cylinder(h= THICKNESS+1, r=KNOB_WIDTH/2, $fn=20) ;
		}
		translate([TOTAL_LENGTH-(KNOB_WIDTH*STRENGHT_FACTOR+(KNOB_WIDTH/2)),KNOB_WIDTH,-0.5])
		cylinder(h= THICKNESS+1, r=KNOB_WIDTH/2, $fn=20) ;
	}
}



// Draw it ;)
cupboard_doorstop(Thickness, Knob_Width, Inner_Knob_Distance, Strenght_Factor);