
// Which one would you like to see?
part = "both"; // [button:Button Only,ring:Retaining Ring Only,both:Button and Ring, tools: Cutting Pattern and fitting cup]

holeCount = 4; 

//distance in mm from centre of button
holeDistance = 3.6;

//diameter of holes in mm
holeDiameter = 2.6;

//button thickness in mm
thickness = 4;

//button diameter in mm
width = 40;


/* [Hidden] */
height = thickness;
wallThickness = 0.9;
patternWidth = (width + height * 6 + wallThickness * 6);

$fn = 90;
module button(){
    
    difference(){
        cylinder(h = height+wallThickness, r = width/2);
    
        translate([0, 0, wallThickness]){    
            cylinder(h = height+0.1 - wallThickness, r = (width/2) - (wallThickness  ));
        }

        for(i = [0: 1 : holeCount-1]){
            angle = ((360 / holeCount) * i);
            
            rotate([0, 0, angle]){
                translate([0, holeDistance, -0.05]){    
                    cylinder(h = wallThickness+0.1, r = holeDiameter/2);
                }
            }
        }
        
        translate([0, 0, height+0.01]){    
            cylinder(h = wallThickness, r1 = width/2- (wallThickness), r2 = width/2 - (wallThickness  *2));
        }
    }
}

module retaining_ring(){
    difference(){     
        cylinder(h = wallThickness * 3, r = width/2 - (wallThickness  *2));
    
        translate([0, 0, -0.01]){
            cylinder(h = wallThickness * 3 + 0.1, r = width/2 - (wallThickness  *5));
        }
 
    }
}

module fittingCup(){    
    difference(){
        cylinder(h = height+wallThickness * 3, r = width/2 + wallThickness * 1.5);
 
        translate([0, 0, wallThickness]){
            cylinder(h = height+wallThickness* 3, r = width/2+ wallThickness * 0.5);
        }
         translate([0, 0, -wallThickness]){
            cylinder(h =wallThickness* 3, r = width/4);
        }
    } 
 }
 
 
 module cuttingPattern(){
 
    difference(){
        cylinder(h = wallThickness, r = patternWidth/2);
 
        translate([0, 0, -.05]){  
            cylinder(h = wallThickness+0.1, r = patternWidth/3);
        }
    }
}

module tools() {
    
    translate([0, width/1.8, 0]){
        fittingCup();
 }
 
 translate([0, -patternWidth/1.8, 0]){
      cuttingPattern();
 }
}

module both() {
    translate([-width/1.8,0,0]) button();
    translate([width/1.8,0,0]) retaining_ring();
}
print_part();

module print_part() {
	if (part == "button") {
		button();
	} else if (part == "ring") {
		retaining_ring();
	} else if (part == "cup") {
		fittingCup();
	}else if (part == "pattern") {
		cuttingPattern();
	} else if (part == "tools") {
		tools();
	} else {
		both();
	}
}