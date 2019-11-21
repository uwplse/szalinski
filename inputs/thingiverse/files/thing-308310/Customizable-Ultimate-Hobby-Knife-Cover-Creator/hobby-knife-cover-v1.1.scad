// All values in MM.
// preview[view:south, tilt:top]

// this is the skirt covering the locking knurl
innerDiameter=13;			

// how far over the locking knurl should it extend
innerDepth=15;	

// side wall thickness of the skirt			
wallThickness=1.5; 

// wide enough to accomodate your widest blade		
bladeSlotWidth=14;		

// blade thickness
bladeSlotThickness=1.2;	

// deep enough for the longest blade
bladeSlotDepth=35;	

// 0.1 min , the lower the #, the more segments in circles.
smoothness=0.3; 

// width of the gap in the skirt over the knurl          
gap=5;	

// 1 = trim blade end, 0 = leave round					
trimBlade=1;

				
// ** no changes below this line **

height= innerDepth + bladeSlotDepth + wallThickness;
outterDiameter = innerDiameter + ( 2 * wallThickness );

bottomDiameter = bladeSlotWidth + ( 2 * wallThickness );

if( bottomDiameter <= outterDiameter ){
	//echo("bottom less than outer");
	main(outterDiameter,outterDiameter);
} else if ( bottomDiameter > outterDiameter ){
	//echo("bottom greater than outter");
	main(bottomDiameter,bottomDiameter);
}


module main (slotWidth,bottomDiameter) {
	//echo("bottomDiameter = ", bottomDiameter);
	//echo("outterDiameter = ", outterDiameter);
	//echo("slotWidth = ", slotWidth);

difference() {
	// Generate the main cylindar first
	cylinder(h = height, r1 = bottomDiameter/2, r2 = outterDiameter/2, center = false, $fa = 1, $fs = smoothness);
	union () {

		// Cutout for the locking knurl
		translate([0,0,height - innerDepth])
		cylinder (h = innerDepth+1, r = innerDiameter/2, center = false, $fa = 1, $fs = smoothness);

		// cutout the round at the bottom of the slot
		translate([-((slotWidth/2)+1),0,height - innerDepth+1]) 
			rotate([0,90,0]) 
				cylinder (h = slotWidth + 2, r = gap/2, center = false, $fa = 1, $fs = smoothness);

		// cutout the slot
		translate([-((slotWidth/2)+1),-(gap/2),height+1]) 
			rotate([0,90,0]) 
				cube(size = [innerDepth,gap,slotWidth+2], center = false);

		// cutout the blade slot
		translate([-(bladeSlotWidth/2),-(bladeSlotThickness/2),wallThickness])
		cube(size = [bladeSlotWidth,bladeSlotThickness,bladeSlotDepth], center = false);
	}
		// trim the blade end
		if ( trimBlade == 1 ) {
		trim_blade(((bottomDiameter - bladeSlotThickness -(2*wallThickness))/2)-1,(bladeSlotDepth-(bottomDiameter - bladeSlotThickness -(2*wallThickness))/2),bottomDiameter);
		}
} 
}

module trim_blade(trimDepth,trimHeight,bottomDiameter){
	//echo("trimDepth = ", trimDepth);
	//echo("trimHeight = ", trimHeight);
	//echo("bottomDiameter = ", bottomDiameter);
	//echo("outterDiameter = ", outterDiameter);

	difference(){
		union(){
		translate([-(bottomDiameter/2),-(bottomDiameter/2),-1]) 
			cube(size = [bottomDiameter, trimDepth,trimHeight+1], center = false);
		translate([-(bottomDiameter/2),-(bottomDiameter/2)-1,trimHeight-1])
			rotate([0,90,0]) 	
			cylinder (h = bottomDiameter, r = trimDepth+1, center = false, $fa = 1, $fs = smoothness);
		translate([-(bottomDiameter/2),(bottomDiameter/2)-trimDepth,-1]) 
			cube(size = [bottomDiameter, trimDepth,trimHeight+1], center = false);
		translate([-(bottomDiameter/2),(bottomDiameter/2+1),trimHeight-1])
			rotate([0,90,0]) 	
			cylinder (h = bottomDiameter, r = trimDepth+1, center = false, $fa = 1, $fs = smoothness);
		}
	}
}
