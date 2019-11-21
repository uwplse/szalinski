$fn = 30;

ScrewHoleDistance = 30;
springAmplitude = 10;
springHeight = 1.5;
springThreadWidth = 1.5;
springPhaseCount = 6;
springScrewHoleDiameter = 2.2;
mountDist = 2.0;

springLength = ScrewHoleDistance-((mountDist)*2); //-(springThreadWidth*2);

springSegmentLength = (springLength)/springPhaseCount;



springInnerRadius = (springLength-(springThreadWidth*(springPhaseCount+1)))/springPhaseCount;

springOuterRadius = springInnerRadius+(springThreadWidth*2);

echo(springSegmentLength);


// mounting

mountingRingRadius = (springScrewHoleDiameter/2)+1;
difference() {
	union() {
		translate([0,0,0]) cylinder(h = springHeight, r=mountingRingRadius);
		translate([ScrewHoleDistance,0,0]) cylinder(h = springHeight, r=(springScrewHoleDiameter/2)+1);
		
		translate([0,-mountingRingRadius,0]) cube(size = [mountDist+springThreadWidth,mountingRingRadius*2,springHeight], center = false);

		translate([ScrewHoleDistance-mountingRingRadius-springThreadWidth,-mountingRingRadius,0]) cube(size = [mountDist+springThreadWidth,mountingRingRadius*2,springHeight], center = false);

		SpringBase();
	}

	translate([0,0,-0.5]) cylinder(h = springHeight+1, r=(springScrewHoleDiameter/2));
	translate([ScrewHoleDistance,0,-0.5]) cylinder(h = springHeight+1, r=(springScrewHoleDiameter/2));

	SpringBaseRemove();
	
}



module SpringBase() {
	shift = (springOuterRadius/2)+mountDist;
	for(i=[0:springPhaseCount-1]) {
		translate([(i*(springOuterRadius-springThreadWidth))+shift,((i%2)*springAmplitude)-(springAmplitude/2),0]) cylinder(h = springHeight, r=(springOuterRadius/2));
	}



	shift2 = mountDist;
	translate([0,0,springHeight/2])
	for(i=[0:springPhaseCount-1]) {
		rotate(a=[((i%2)*180)+180,0,0])
		translate([(i*(springInnerRadius+springThreadWidth))+shift2,-mountingRingRadius,springHeight/-2]) 
			cube(size = [springOuterRadius,mountingRingRadius+(springAmplitude/2),springHeight], center = false);
	}
}




module SpringBaseRemove() {
	shift = (springInnerRadius/2)+mountDist+springThreadWidth;
	for(i=[0:springPhaseCount-1]) {
		translate([(i*(springInnerRadius+springThreadWidth))+shift,((i%2)*springAmplitude)-(springAmplitude/2),-0.5]) cylinder(h = springHeight+1, r=(springInnerRadius/2));
	}

	shift2 = mountDist+springThreadWidth;
	translate([0,0,springHeight/2])
	for(i=[0:springPhaseCount-1]) {
		rotate(a=[((i%2)*180)+180,0,0])
		translate([(i*(springInnerRadius+springThreadWidth))+shift2,-mountingRingRadius-0.05,(springHeight/-2)-0.5]) 
			cube(size = [springInnerRadius,mountingRingRadius+(springAmplitude/2)+0.1,springHeight+1], center = false);
	}

}