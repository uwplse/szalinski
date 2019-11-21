$fn=100;

diameter = 50;
height = 6.5;
toothBaseWidth = 0.94;
toothTipWidth = 0.47;
toothLength = 0.94;
toothSpacing = 1.06;
//tooth and gear overlap (preventing gap between tooth and base)
toothOverlap = 0.2;
//center axe hole
holeDiameter = 2.9;

createRim=1; //[0:None,1:Rim]
//in addition to gear diameter
rimOuterSize = 2;
//in addition to gear diameter
rimInnerSize = 0;
rimThickness = 2;

//lock profile in center axe hole
createLock = 1; //[0:None,1:Lock]
lockSize = 1;
lockLength = 0.4;

//gear with arms instead of solid cylinder
createArms = 1; //[0:None,1:Arms]
armInnerDiameter = 10;
armOuterDiameter = 45;
armThickness = 4;
//number of arms
armNumber = 3;
//arm and base overlap (to prevent gaps)
armOverlap = 2;

//joint for fixing two gears togheter (hole and peg)
createJoint = 2; //[0:None,1:Hole,2:Peg]
jointDiameter = 3;
//distance from center
jointDistance = 20;
jointLength = 2;

/* [Hidden] */

pi=3.1415923;

number_teeth = floor(pi*diameter / (toothBaseWidth + toothSpacing));
adjusted_diameter = (number_teeth *  (toothBaseWidth + toothSpacing))/pi;
tooth_angle = 360 / number_teeth;


translate([0,0,rimThickness*createRim]) { //move all to base layer
	if (createJoint == 1) {
		difference() {
			body();
			joint_hole();
			}
	} else {
		body();
	}
	
	teeth();
	if (createArms == 1) arms();
	if (createJoint == 2) joint_peg();
}

echo ("Belt diameter is ", adjusted_diameter);


module body() {
	translate([0,0,height/2]) 
	difference (){
		union() {
			cylinder(d=adjusted_diameter, h=height, center=true);
			translate([0,0,-height/2 - rimThickness*createRim])
			cylinder(d1=adjusted_diameter+2*rimOuterSize*createRim+2*toothLength, d2=adjusted_diameter+2*rimInnerSize*createRim +2*toothLength, h=rimThickness*createRim);
			mirror([0,0,1])
			translate([0,0,-height/2 - rimThickness])
			cylinder(d1=adjusted_diameter+2*rimOuterSize*createRim+2*toothLength, d2=adjusted_diameter+2*rimInnerSize*createRim +2*toothLength, h=rimThickness*createRim);
		}
	      translate([0,0,height/2-rimThickness*createRim])
			cylinder(d=holeDiameter, h=(height*2+2*rimThickness*createRim), center=true);
			if (createLock == 1) {
				translate([0,holeDiameter/2 + lockLength - lockSize/2 ,height/2-rimThickness*createRim])
				cube([lockSize,lockSize,(height*2+2*rimThickness*createRim)], center=true);
			}
		//arm space
		if (createArms == 1) {
			difference() {
				cylinder(d=armOuterDiameter, h=(height*2+2*rimThickness*createRim), center=true);
				cylinder(d=armInnerDiameter, h=(height*2+2*rimThickness*createRim), center=true);
			}
		}

	}

}


module teeth() {
	for(i=[1:number_teeth]) 
			rotate([0,0,i*tooth_angle])
			translate([0,adjusted_diameter/2,0]) {
				linear_extrude(height)
				polygon([[-toothBaseWidth/2,-toothOverlap],[toothBaseWidth/2,-toothOverlap],
			  				[toothTipWidth/2,toothLength],[-toothTipWidth/2,toothLength]]);
				}
}

module arms() {
		difference() {
		for(j=[1:armNumber]) 
			rotate([0,0,j*(360/armNumber)])
			translate([(armOuterDiameter - armInnerDiameter)/4 + armInnerDiameter/2 - armOverlap/2,0,height/2])
			cube([(armOuterDiameter - armInnerDiameter)/2 + armOverlap,armThickness,height++2*rimThickness*createRim],center = true);
			if (createJoint == 1) {
				joint_hole();
			}
		}
}

module joint_hole() {
			translate([jointDistance,0,height - jointLength/2 +rimThickness*createRim +0.1])
			cylinder(d=jointDiameter,h=jointLength+0.1, center = true);
}

module joint_peg() {
			translate([jointDistance,0,jointLength/2 + height +rimThickness*createRim])
			cylinder(d=jointDiameter,h=jointLength, center = true);

}



