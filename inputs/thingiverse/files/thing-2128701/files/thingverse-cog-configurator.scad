

/*[COG]*/

// total amount of teeth
teethCount = 10; // [4:1:100]

// diameter of each tooth
toothDiameter = 3; // [0.5:0.1:10]

// polygon resoultion
geometryResolution = 30; // [20:1:100]

// correction parameter to slightly adjust the space between the teeth
spaceBetweenTeeth = 0; // [0:0.1:2]

// cog height or thickness
thickness = 6; // [1:0.5:100]

/* [Axis Hole] */

// what kind of axis do you want to use
axisType = "hole"; // [hole:round hole,four:4 corner axis,five:5 corner axis,six:6 corner axis]

// round hole radius
holeRadius = 6; // [0:0.1:50]

/* [Axis Fix] */

// axis fix size radius
axisFixRadius = 8; // [1:0.5:100]

// axis fix size height
axisFixHeight = 10; // [1:0.5:100]

// axis fix offsset (default is centered)
axisFixOffset = 4; // [0:0.5:100]

/* [Screw Fix] */

// radius of the screw hole to fix the cog (default is 1.5 for 3mm screw)
axisFixScrewHoleRadisu = 1.5; // [0.1:0.1:10]

// offset to where the screw hole should be (default is 0 which is the center of the cog's height)
axisFixScrewHoleOffset = 6; // [0:0.1:100]

/* [Hidden] */

cog(teethCount,toothDiameter,spaceBetweenTeeth,thickness,holeRadius);
module cog(tooth_count,tooth_diameter,space_between_teeth,height,holeDiameter){
    
    res=geometryResolution;
    cogSegment = tooth_diameter;       
    angle = 360/(tooth_count*4);    
    radius = cogSegment/sin(angle);
	difference(){		
		difference(){
			union(){
				difference(){
					difference(){
						union(){
							cylinder(h = height,r=radius, center = true, $fn=res);
							for(r=[0 : 360/tooth_count : 360]){
								rotate([0,0,r]) translate([0,radius,0]) cylinder(h = height,r=tooth_diameter-(space_between_teeth/2), center = true,$fn=res);
							}
						}    
						rotate([0,0,(360/tooth_count)/2]){
							for(r=[0 : 360/tooth_count : 360]){
								rotate([0,0,r]) translate([0,radius,0]) cylinder(h = height+4,r=tooth_diameter+(space_between_teeth/2), center = true,$fn=res);
							}    
						}
					}
	
				}
				// axis fix
				translate([0,0,axisFixOffset]) cylinder(h = axisFixHeight,r=axisFixRadius, center = true, $fn=100);							
			}
			//screw hole fixature
			rotate([90,0,0]) translate([0,axisFixScrewHoleOffset,(radius+10)/2]) cylinder(h = radius+10,r=axisFixScrewHoleRadisu, center = true,$fn=res);
		}
		ha = axisFixHeight+ height +10;
		if (axisType == "hole") {
			cylinder(h = ha,r=(holeDiameter/2), center = true,$fn=100);			
		}else if(axisType == "four"){
			rotate([0,0,45]) cylinder(h = ha,r=(holeDiameter/2), center = true,$fn=4);
		}else if(axisType == "five"){
			rotate([0,0,20]) cylinder(h = ha,r=(holeDiameter/2), center = true,$fn=5);
		}else if(axisType == "six"){
			rotate([0,0,0]) cylinder(h = ha,r=(holeDiameter/2), center = true,$fn=6);
		}
	}	
}


