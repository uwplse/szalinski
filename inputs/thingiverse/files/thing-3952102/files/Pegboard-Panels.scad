//What to Render
Render = 0; //[0:Panel,1:Brace]
//panel base Size
PanelSize = 200;
//Thickness of the Panel
PanelThick = 5;

//Hole Size in mm
HoleSize = 6;
//Hole Spacing center to center
Spacing = 25;
HoleCount = PanelSize/Spacing;

//Mounting related

//Turn off if you want to use braces to connect your panels. You can turn this on but may interfere with mounting the brace. Turn MountCount down to ensure clearance
Mounting = 0; //[1:Yes,0:No]
MountWidth = 10;
MountLength = 3;
MountHeight = 10;
MountCount = 4;
//Set to what screws that you're using. Tolerance not accounted in this. Shared with Braces Parameter. 
ScrewSize = 3;

//Brace related if mounting pegs not used
//Dual or Quad screw mounting
BraceType = 1; //[0:Dual,1:Quad,2:Diagonal]
//Thickness of brace bars
BraceThick = 2;
//Offset of the bar aka chamfers
BraceOffset = 2;
SnapThick = PanelThick/2;

//Change according to your printer's spec
Tolerance = 0.2;

module PegHole(){
color("green") 
    for(i = [0:(HoleCount-1)],j = [0:(HoleCount-1)])
    {
        translate([-(i*Spacing),-(j*Spacing),0])translate([(PanelSize/2)-(Spacing/2),(PanelSize/2)-(Spacing/2),0]) cylinder(PanelThick+2,d=HoleSize, center = true,$fn = 50);
    }
}

module Mounting(){

    for(k = [1:(MountCount)])
    {
        translate([(k*((PanelSize/1)/(MountCount/1))-(PanelSize/2)+(Tolerance/2))-(PanelSize/MountCount/2),-(MountLength/2)+(PanelSize/2)-(Tolerance/2),(PanelThick/2)+(MountHeight/2)])
    {
        difference(){
            cube([MountWidth,MountLength,MountHeight],true);
            rotate([90,0,0]) color ("gold")cylinder(h=10, d= ScrewSize, center = true, $fn= 50);
        }
    }
    //echo (k*((PanelSize/1)/MountCount));

        translate([(MountLength/2)-(PanelSize/2)+(Tolerance/2),-(k*((PanelSize/1)/(MountCount/1))-(PanelSize/2)+(Tolerance/2))+(PanelSize/MountCount/2),(PanelThick/2)+(MountHeight/2)])
        {
        difference(){
                rotate([0,0,90])cube([MountWidth,MountLength,MountHeight],true);
                rotate([0,90,0]) color ("gold")cylinder(h=10, d= ScrewSize, center = true, $fn= 50);
            }
        }
    }    
}

module DualBrace(){
    difference()
    {
        union()
        {
//			echo(-(SnapThick+(BraceThick/2)-SnapThick/2));
            translate([0,0,-(SnapThick+BraceThick/2-SnapThick/2)])
                
                hull(){
                    
                translate([Spacing/2,0,0])cylinder(h=BraceThick,d1 = HoleSize,d2 = (HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
                translate([-Spacing/2,0,0])cylinder(h=BraceThick,d1 = HoleSize,d2=(HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
                }
                translate([Spacing/2,0,0])cylinder(h=SnapThick,d=HoleSize-Tolerance, center = true, $fn = 50);
                translate([-Spacing/2,0,0])cylinder(h=SnapThick,d=HoleSize-Tolerance, center = true, $fn = 50);  
        }
            translate([Spacing/2,0,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
            translate([-Spacing/2,0,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
        
    }
}

module QuadBrace(){
    translate([0,Spacing/2,0])DualBrace();
	translate([0,-Spacing/2,0])DualBrace();
	
	rotate([0,0,90])
	{
		translate([0,Spacing/2,0])DualBrace();
	translate([0,-Spacing/2,0])DualBrace();
	}
	
	translate([0,0,-(SnapThick+BraceThick/2-SnapThick/2)])
	difference(){
		hull(){
						
					translate([Spacing/2,Spacing/2,0])cylinder(h=BraceThick,d1 = HoleSize-Tolerance,d2 = (HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
					translate([-Spacing/2,-Spacing/2,0])cylinder(h=BraceThick,d1 = HoleSize-Tolerance,d2=(HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
					}
		
		translate([Spacing/2,Spacing/2,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
		translate([-Spacing/2,-Spacing/2,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
				}
				
	translate([0,0,-(SnapThick+BraceThick/2-SnapThick/2)])
	rotate([0,0,90])
				difference(){
		hull(){
						
					translate([Spacing/2,Spacing/2,0])cylinder(h=BraceThick,d1 = HoleSize-Tolerance,d2 = (HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
					translate([-Spacing/2,-Spacing/2,0])cylinder(h=BraceThick,d1 = HoleSize-Tolerance,d2=(HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
					}
		
		translate([Spacing/2,Spacing/2,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
		translate([-Spacing/2,-Spacing/2,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
				}
}

module DiaBrace()
{
	difference(){
		union(){
			translate([0,0,-(SnapThick+BraceThick/2-SnapThick/2)])
			hull(){
						
					translate([Spacing/2,Spacing/2,0])cylinder(h=BraceThick,d1 = HoleSize-Tolerance,d2 = (HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
					translate([-Spacing/2,-Spacing/2,0])cylinder(h=BraceThick,d1 = HoleSize-Tolerance,d2=(HoleSize+BraceOffset)-Tolerance, center = true, $fn = 50);
				}
				translate([Spacing/2,Spacing/2,0])cylinder(h=SnapThick,d=HoleSize-Tolerance, center = true, $fn = 50);
                translate([-Spacing/2,-Spacing/2,0])cylinder(h=SnapThick,d=HoleSize-Tolerance, center = true, $fn = 50);  
			}
		translate([Spacing/2,Spacing/2,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
		translate([-Spacing/2,-Spacing/2,-(PanelThick/2+BraceThick/2)])cylinder(h=PanelThick*4,d=ScrewSize, center = true, $fn = 50);
				}
}

if(Render == 0){
    difference()
	{
        color ("skyblue",0.50)cube([PanelSize-Tolerance,PanelSize-Tolerance,PanelThick], true);
        PegHole();
    }
    if(Mounting){
    Mounting();
    rotate([0,0,180])Mounting();
    }
}else
{
    if(BraceType == 0 )
    DualBrace();
    else if(BraceType == 1)
        QuadBrace();
	else if(BraceType == 2)
		DiaBrace();
}