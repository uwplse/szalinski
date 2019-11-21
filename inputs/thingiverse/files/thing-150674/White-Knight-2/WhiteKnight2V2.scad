/*[scale]*/
modelScale=.04166667;
/*[fusalage Parameters]*/
NoseDiameter=12.3;
NoseLength=73.8;
CabinLowerDiameter=61.5;
CabinUpperHeightOffset=21.525;
CabinLength=184.5;
LeghtOfFuseloge=738.0;
tailDiameter=12.3;
tailHeightOffset=18.45;
/*[ellivator Parameters]*/
ellMaxDepth=55.35;
ellMinDepth=30.75;
ellMaxWidth=258.3;
ellMidWidth=246.0;
ellMaxThickness=6.15;
ellMinThickness=3.075;
ellHeightOffset=-15.375;
ellXOffset=33.825;
/*[Tail Parameters]*/
topTailDepth=43.05;
bottomTailTriangleDepth=92.25;
tailMaxThickness=6.15;
tailMinThickness=3.075;
tailHeight=159.9;
tailTopOffset=24.6;
tailCutoutRadius=30.75;
/*[Wing Parameters]*/
fusalageOffset=399.75;
wingDepth=86.1;
wingMaxThickness=15.375;
wingMinThickness=6.15;
wingTipDepth=61.5;
wingSpan=1322.25;

modelScale=modelScale*10;


module wing(){
	translate([0,0,wingMaxThickness/2])union(){
		union(){
			hull(){
				translate([-CabinLength,CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMaxThickness/2);
				translate([-CabinLength,-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMaxThickness/2);
				translate([-CabinLength-wingDepth,CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMinThickness/2);
				translate([-CabinLength-wingDepth,-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMinThickness/2);
			}
			translate([-CabinLength-wingDepth,0,CabinLowerDiameter/2+CabinUpperHeightOffset*2-CabinLowerDiameter/2-wingMaxThickness/2])difference(){
				translate([0,-CabinLowerDiameter/2,0])cube([wingDepth,CabinLowerDiameter,CabinLowerDiameter/2+wingMaxThickness/2]);
				translate([-wingDepth/2,0,0])rotate([0,90,0])cylinder(r=CabinLowerDiameter/2,h=2*wingDepth);
			}
		}
		hull(){
			translate([-CabinLength,CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMaxThickness/2);
			translate([-CabinLength,fusalageOffset/2-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);

			translate([-CabinLength-wingDepth,CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMinThickness/2);
			translate([-CabinLength-wingDepth,fusalageOffset/2-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
		}

		hull(){
			translate([-CabinLength,-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMaxThickness/2);
			translate([-CabinLength,-fusalageOffset/2+CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);

			translate([-CabinLength-wingDepth,-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset*2])sphere(wingMinThickness/2);
			translate([-CabinLength-wingDepth,-fusalageOffset/2+CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
		}
		hull(){
			translate([-CabinLength,-fusalageOffset/2+CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth,-fusalageOffset/2+CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
			translate([-CabinLength,-3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth,-3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
		}

		hull(){
			translate([-CabinLength,fusalageOffset/2-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth,fusalageOffset/2+-CabinLowerDiameter/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
			translate([-CabinLength,3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth,3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
		}

		hull(){
			translate([-CabinLength,3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth,3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);

			translate([-CabinLength-(wingDepth-wingTipDepth)/2,wingSpan/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth+(wingDepth-wingTipDepth)/2,wingSpan/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
		}
		hull(){
			translate([-CabinLength,-3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth,-3*wingSpan/8,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);

			translate([-CabinLength-(wingDepth-wingTipDepth)/2,-wingSpan/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMaxThickness/2);
			translate([-CabinLength-wingDepth+(wingDepth-wingTipDepth)/2,-wingSpan/2,CabinLowerDiameter/2+CabinUpperHeightOffset])sphere(wingMinThickness/2);
		}

		translate([-CabinLength-wingDepth,fusalageOffset/2,CabinLowerDiameter/2+CabinUpperHeightOffset-CabinLowerDiameter/2-wingMaxThickness/2])difference(){
				translate([0,-CabinLowerDiameter/2,0])cube([wingDepth,CabinLowerDiameter,CabinLowerDiameter/2+wingMaxThickness/2]);
				translate([-wingDepth/2,0,0])rotate([0,90,0])cylinder(r=CabinLowerDiameter/2,h=2*wingDepth);
		}
		translate([-CabinLength-wingDepth,-fusalageOffset/2,CabinLowerDiameter/2+CabinUpperHeightOffset-CabinLowerDiameter/2-wingMaxThickness/2])difference(){
				translate([0,-CabinLowerDiameter/2,0])cube([wingDepth,CabinLowerDiameter,CabinLowerDiameter/2+wingMaxThickness/2]);
				translate([-wingDepth/2,0,0])rotate([0,90,0])cylinder(r=CabinLowerDiameter/2,h=2*wingDepth);
		}
	}
}



module tail(){
	translate([0,0,CabinLowerDiameter+CabinUpperHeightOffset])difference(){
		union(){
			translate([0,0,-CabinLowerDiameter-CabinUpperHeightOffset])hull(){
				sphere(tailMaxThickness/2);
				translate([topTailDepth-bottomTailTriangleDepth-tailTopOffset,0,tailHeight])sphere(tailMaxThickness/2);
				translate([-bottomTailTriangleDepth-tailTopOffset,0,tailHeight])sphere(tailMinThickness/2);
				translate([-bottomTailTriangleDepth,0,0])sphere(tailMinThickness/2);
			}

			translate([-ellXOffset,0,ellHeightOffset])hull(){
				sphere(ellMaxThickness/2);
				translate([ellMinDepth-ellMaxDepth,ellMidWidth/2,0])sphere(ellMaxThickness/2);
				translate([ellMinDepth-ellMaxDepth,-ellMidWidth/2,0])sphere(ellMaxThickness/2);
				translate([-ellMaxDepth,ellMaxWidth/2,0])sphere(ellMinThickness/2);
				translate([-ellMaxDepth,-ellMaxWidth/2,0])sphere(ellMinThickness/2);
			}
		}
		translate([0,tailMaxThickness,-CabinLowerDiameter-CabinUpperHeightOffset])rotate([90,0,0])cylinder(r=tailCutoutRadius,h=tailMaxThickness*2);
	}
}

module fuselage(){
union(){
		hull(){
			translate([NoseLength,0,0])sphere(NoseDiameter/2);
			rotate([0,270,0])cylinder(r=CabinLowerDiameter/2,h=CabinLength);
			translate([-LeghtOfFuseloge+NoseLength,0,tailHeightOffset])sphere(tailDiameter/2);
		}
		hull(){
			translate([-CabinLowerDiameter/2,0,CabinUpperHeightOffset])sphere(CabinLowerDiameter/2);
			rotate([0,270,0])cylinder(r=CabinLowerDiameter/2,h=CabinLength);
			translate([-wingDepth,0,CabinUpperHeightOffset])rotate([0,270,0])cylinder(r=CabinLowerDiameter/2,h=CabinLength);	
translate([-wingDepth,0,CabinUpperHeightOffset/4])rotate([0,270,0])cylinder(r=CabinLowerDiameter/2,h=CabinLength);	
		translate([-LeghtOfFuseloge+NoseLength,0,tailHeightOffset])sphere(tailDiameter/2);	
		}
	translate([(ellMaxDepth+ellMinDepth)/2+NoseLength-LeghtOfFuseloge,0,tailHeightOffset-tailCutoutRadius])tail();
	}
}

scale([modelScale,modelScale,modelScale]){
union(){
translate([0,fusalageOffset/2,0])fuselage();
translate([0,-fusalageOffset/2,0])fuselage();
translate([0,0,-1])wing();
}
}