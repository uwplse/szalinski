// Tube diameter (mm)
tubeRadius = 25;

// Rectangular slot depth (mm)
slotDepth = 5;

// Rectangular slot width (mm)
slotWidth = 50;

// Total height (mm)
height = 30;

// Wall thickness (mm)
wallThickness = 2;

// Width of gap at the back of the rectangular slot (mm)
slotGap = 10;

// Width of gap at the front of the tube (mm)
tubeGap = 20;

// Mounting hole count
numHoles = 2;

// Mounting hole diemeters (mm)
holeDiameter = 4;

module tripodclamp()
{
	difference() {
		// Main body
			union(){
			cube([slotDepth + (2*wallThickness)
					, slotWidth + (2*wallThickness)
					, height], center = false);	
			translate([tubeRadius + slotDepth + (wallThickness*2)
							,((slotWidth + (wallThickness*2))/2)
							,0])
				cylinder(h=height
							,r=tubeRadius + wallThickness
							,$fn=200);
			}

		// Subractions
			// Belt slot
		translate([wallThickness,wallThickness,-0.1]) 
			cube([slotDepth, slotWidth, height+0.2], centre = false);

			// Tube
		translate([tubeRadius + slotDepth + (wallThickness*2)
							,((slotWidth + (wallThickness*2))/2)
							,-0.1])
			cylinder(h=height + 0.2,r=tubeRadius, $fn=200);
		
			// Belt slot gap
		translate([-0.1,((slotWidth + 2*wallThickness)/2)-slotGap/2,-0.1]) 
			cube([wallThickness + 0.2, slotGap, height + 0.2], centre = false);
		
			// Tube slot gap
		translate([2*tubeRadius + slotDepth + 2.5*wallThickness - (tubeGap/2)
					,((slotWidth + 2*wallThickness)/2)-tubeGap/2
					,-0.1]) 
			cube([tubeGap, tubeGap, height + 0.2], centre = false);

			// Mounting holes
		if(numHoles>1){
			// Distribute the holes across the base
			delta = ((slotWidth + 2*wallThickness)/(numHoles))/2;
			for(y=[0:numHoles-1]){				
				if(y==0){
					translate([-0.1,((slotWidth + 2*wallThickness)/(numHoles))/2,height/2])
						rotate([0,90,0]){
							cylinder(h=slotDepth + 2*wallThickness + 10
										,r=holeDiameter/2
										,$fn=200);
						}	
				} else {
					translate([-0.1,(y*(slotWidth + 2*wallThickness)/(numHoles))+delta,height/2])
						rotate([0,90,0]){
							cylinder(h=slotDepth + 2*wallThickness + 10
										,r=holeDiameter/2
										,$fn=200);	  	
						}
				}
			}
		} else {
			if(numHoles==1){
				// centre the hole right through the base
				translate([-0.1,((slotWidth + 2*wallThickness)/2),height/2])
					rotate([0,90,0]){
						cylinder(h=slotDepth + 2*wallThickness + 20
								,r=holeDiameter/2
								,$fn=200);	  	
					}
			}
		}
	}

}

tripodclamp();

