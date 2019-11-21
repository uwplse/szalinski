include<write.scad>

homeButtonDiameter=14.5;
homeTab1Width=4;
homeTab2Width=2.4;
homeTabHeight=1;
homeTabLength=1;
homeWallThickness=2;
hopeButtonCrossDepth=2.4;

ovalButtonX=7.4;
ovalButtonY=6.4;
textHeight=ovalButtonY*.5;
ovalTabbingHeight=1.5;
ovalTab1Width=2;
ovalTab2Width=4;


buttonHeight=17.2;
markingDepth=.5;

otherButtonsDiameter=10.2;


tabLength=1.25;
printGap=20;
logoOutline=10;

module ovalButton(){
	union(){
		intersection(){
			hull(){
				translate([ovalButtonX/2-ovalButtonY/2,0,0])cylinder(r=ovalButtonY/2,h=buttonHeight);
				translate([-ovalButtonX/2+ovalButtonY/2,0,0])cylinder(r=ovalButtonY/2,h=buttonHeight);
			}
		sphere(r=buttonHeight);
		}
	translate([-ovalTab1Width/2,0,0])cube([ovalTab1Width,tabLength+ovalButtonY/2,ovalTabbingHeight]);
		rotate([0,0,180])translate([-ovalTab2Width/2,0,0])cube([ovalTab2Width,tabLength+ovalButtonY/2,ovalTabbingHeight]);
	}
}

module homeButton(){
	difference(){
		union(){
			intersection(){
				cylinder(r=homeButtonDiameter/2,h=buttonHeight);
				sphere(r=buttonHeight-markingDepth);
			}
			intersection(){
				linear_extrude(buttonHeight+markingDepth)import("TCPLogo.dxf");
				sphere(r=buttonHeight);
			}
			difference(){
				intersection(){
					cylinder(r=homeButtonDiameter/2,h=buttonHeight);
					sphere(r=buttonHeight);
				}
			cylinder(r=logoOutline/2,h=buttonHeight*2);
			}
			intersection(){
				union(){
					translate([-homeTab1Width/2,0,0])cube([homeTab1Width,homeButtonDiameter/2+homeTabLength,homeTabLength]);
					rotate([0,0,180])translate([-homeTab1Width/2,0,0])cube([homeTab2Width,homeButtonDiameter/2+homeTabLength,homeTabLength]);
				}
				cylinder(r=homeButtonDiameter/2+homeTabLength,h=buttonHeight);
			}
		}
	translate([0,0,-.5])cylinder(r=homeButtonDiameter/2-homeWallThickness,h=hopeButtonCrossDepth+.5);
	}
}

module otherButtons(){
	intersection(){
		cylinder(r=otherButtonsDiameter/2,h=buttonHeight);
	sphere(r=buttonHeight);
	}
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
module ovalRB(){
	difference(){
		ovalButton();
		translate([0,0,buttonHeight-markingDepth])write("RB",t=5*markingDepth,h=textHeight,center=true);
	}
}
module ovalLB(){
	difference(){
		rotate([0,0,180])ovalButton();
		translate([0,0,buttonHeight-markingDepth])write("LB",t=5*markingDepth,h=textHeight,center=true);
	}
}
module ovalBack(){
	difference(){
		ovalButton();
		translate([0,0,buttonHeight-markingDepth])linear_extrude(5*markingDepth)import("Triangle.dxf");
	}
}
translate([0,printGap,0])ovalLB();
translate([0,-printGap,0])ovalRB();
homeButton();
