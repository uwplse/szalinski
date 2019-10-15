// Released under the Creative Commons: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) license.
// http://creativecommons.org/licenses/by-sa/3.0/
// Attribution may be made by linking to:  http://www.thingiverse.com/thing:1037034

//Choose to render all parts or specific parts.
part="all"; // [tray:Main Tray,lend:Left End,rend:Right End,cup:undivided Cup,rcup:Right half Cup, lcup: Left half Cup,pins:Pins,all:All] 

bottomCutsSwitch=true; //false: no bottomcuts; true: withbottomcuts

//All measurements in mm unless otherwise indicated. Length of the main tray
trayLength=140;

//Width of the tray.
trayWidth=55;

//Thickness of the tray.
trayThickness=4;

//Width of the catch rail from tip to tip along the X axis.  See diagram in the thing page if this is not clear.
railWidth=10.6;

//Height of the catch rail from the top surface of the tray to the top top.  See diagram in the thing page if this is not clear.
railHeight=4.3;

//Depth of the rail undercut -- creates a 90 degree overhang, so don't make this too big.  See diagram in the thing page if this is not clear.
railUndercutX=2;

//Height of the rail undercut -- make this at least 1mm shorter than the total height.  A smaller number here makes the overhanging rails thicker.  See diagram in the thing page if this is not clear.
railUndercutZ=3.0;

//Distance from the back side of the tray to offset the entire catch rail.  See diagram in the thing page if this is not clear.
railOffset=2.71;

//Pin Diameter (for example, 3mm or 1.75mm would let you just cut up some filament - make each piece about 8-9 mm long).  You can also print the pins.
pinDiameter=1.75;

//This will add an adjustment to pinholes (but not to pins) to account for side ooze from your nozzle.  Your nozzle diameter is a good starting point.  You can also use this variable to tighten or loosen the fitment of pins (larger numbers loosen, smaller numbers (even negative) tighten by shrinking or enlarging the pinholes).  NOTE:  this is not applied to pins to make it possible to cut pins from filament.  If you want to enlarge pins to take into account ooze, you must do that in the pinDiameter variable.
oozeAdjustment=0.35;

//The Cup Parameters start here
//Be aware of the fact that trayWidth and trayThickness is also used for the Cup!
//Therefor the upper part matches the style of the Tray.
//The Length of the Cup. Cup can be devided(lcup and rcup) in two halfs (for printing).
cupLength = 80;
//The outer Heigth of the Cup. Inner Height is less, cause of the Bottom thickness
cupHeigth = 80;
//The Thickness of the Walls and the Bottom of the Cup
cupThickness = 4;

/* [Hidden] */
// preview[view:south west]

$fn=100;
pinRadius=pinDiameter/2;
oozeRadius=oozeAdjustment/2;

finalAssembly();

module finalAssembly()
{
    if (part=="lcup")
    {
        translate([-2*trayWidth + 20, 1, 0]) cupLeft(trayWidth,cupLength,trayThickness,cupHeigth,cupThickness);
    }
    else if (part=="rcup")
    {
        translate([-2*trayWidth + 20, 0, 0]) cupRight(trayWidth,cupLength,trayThickness,cupHeigth,cupThickness);
    }
    else if (part=="cup")
    {
        translate([-2*trayWidth + 20, 0, 0]) cup(trayWidth,cupLength,trayThickness,cupHeigth,cupThickness);
    }
	else if (part=="tray")
	{
		union()
		{
			//tray base
			difference()
			{
				union()
				{
					tray(trayWidth,trayLength,trayThickness);
					slide(trayWidth, trayLength, trayThickness, railWidth, railHeight, railUndercutX, railUndercutZ, railOffset);
				}
				
				union()
				{
					trayPinCuts(trayWidth, -1,trayThickness);
					trayPinCuts(trayWidth, trayLength-5,trayThickness);
                    if (bottomCutsSwitch)
                    {
                        trayBottomCuts(trayWidth, trayLength, trayThickness);
                    }
				}
			}
			

		}
	} else if (part=="lend")
	{
		leftEnd(trayWidth, trayThickness+10, trayThickness);
	} else if (part=="rend")
	{
		rightEnd(trayWidth, trayThickness+10, trayThickness);
	} else if (part=="pins")
	{
		pins();
	} else if (part=="all")
	{
		union()
		{
			//tray base
			difference()
			{
				union()
				{
					tray(trayWidth,trayLength,trayThickness);
					slide(trayWidth, trayLength, trayThickness, railWidth, railHeight, railUndercutX, railUndercutZ, railOffset);
				}
				
				union()
				{
					trayPinCuts(trayWidth, -1,trayThickness);
					trayPinCuts(trayWidth, trayLength-5,trayThickness);
                    if (bottomCutsSwitch)
                    {
                        if(trayThickness>=3)
                        {
                            trayBottomCuts(trayWidth, trayLength, trayThickness, 2);
                            
                        } else if (trayThickness>=2 && trayThickness<3)
                        {	
                            trayBottomCuts(trayWidth, trayLength, trayThickness, 1);
                        }
                    }
				}
			}
			

		}
		
		rightEnd(trayWidth, trayThickness+10, trayThickness);
		leftEnd(trayWidth, trayThickness+10, trayThickness);
		pins();

        translate([-2*trayWidth + 20, 1, 0]) cupLeft(trayWidth,cupLength,trayThickness,cupHeigth,cupThickness);
        translate([-2*trayWidth + 20, 0, 0]) cupRight(trayWidth,cupLength,trayThickness,cupHeigth,cupThickness);
	} else 
	{
		cylinder(r=10, h=10);
		echo ("==================================================================");
		echo ("Error -- you must select a part! See available Parts below        ");
		echo (" -- all, tray, lend, rend, pins, cup, rcup or lcup. --            ");
        echo ("==================================================================");
	}
}

//********************************************************************************************
//--------------------------------TRAY PART

module tray(tW, tL, tT)
{
	//Basic tray parts
	union() //trayWidth, trayLength, trayThickness
	{
		//base
		cube([tW,tL,tT]);
		
		//lip
		translate([(-3*tT)+(tT/1.5),0,(4*tT)-(tT/2)]) rotate([-90,0,0]) cylinder(h=tL, r=tT);		

		//pen divider, pin hole beefer
		translate([(tW*0.4),0,tT/3*2.6]) rotate([-90,0,0]) cylinder(h=tL, r=tT/3*2.5);		

		//curved front, quarter section of cylinder
		difference()
		{
			translate([0,0,(3*tT)]) rotate([-90,0,0]) cylinder(h=tL, r=3*tT);
			translate([0,-1,(3*tT)]) rotate([-90,0,0]) cylinder(h=tL+2, r=2*tT);
			translate([0,-1,tT]) cube([6*tT+1,tL+2,6*tT+1]);
			translate([-6*tT,-1,3*tT]) cube([6*tT+1,tL+2,6*tT+1]);
		}
	}
}

module slide(tW, tL, tT, rW, rH, rX, rZ, rO)
{
	difference()
	{
		translate([tW-rO-rW,0,tT-1]) cube([rW,tL,rH+1]);
		translate([tW-rO-rW-1,-1,tT]) cube([rX+1,tL+2,rZ]);
		translate([tW-rO-rX,-1,tT]) cube([rX+2,tL+2,rZ]);
	}
}

module trayPinCuts(tW, yPos, tT) 
{
	union()
	{
		//frontPinHole
		translate([(-3*tT)+(tT/1.5),yPos,(4*tT)-(tT/2)]) rotate([-90,0,0]) cylinder(h=6, r=pinRadius+oozeRadius);
		
		//middlePinHole
		 translate([(tW*0.4),yPos,tT/3*2.3]) rotate([-90,0,0]) cylinder(h=6, r=pinRadius+oozeRadius);	
		
		//backPinHole
		translate([tW-railOffset-railWidth+(railWidth/2),yPos,tT/3*2.3]) rotate([-90,0,0])  cylinder(h=6, r=pinRadius+oozeRadius);	
	}
}

module trayBottomCuts(tW, tL, tT, cutRadius)
{
	for (i=[10:10:tL-10])
	{
		translate([tW+1, i, 0]) rotate([0,-90,0]) cylinder(h=tW+(3*tT)+2, r=cutRadius);
	}
}

module rightEnd(tW, tL, tT)
{
	difference()
	{
		union()
		{
			translate([0,-(tT+11),0]) tray(tW, tL, tT);
			translate([0,-(tT+11),0]) slide(tW, tL, tT, railWidth, railHeight, railUndercutX, railUndercutZ, railOffset);
			translate([0,-(tT+11),0]) endWall(tW, 3*tT, tT);
		}
		trayPinCuts(trayWidth, -6,trayThickness);
	}
}


module leftEnd(tW, tL, tT)
{
	difference()
	{
		union()
		{
			//note we need to use global trayLength here rather than the different lenght passed to this module here
			//because we need to move the piece on Y to the other end of the main tray.
			translate([0,(trayLength+1),0]) tray(tW, tT+10, tT);
			translate([0,(trayLength+1),0]) slide(tW, tT+10, tT, railWidth, railHeight, railUndercutX, railUndercutZ, railOffset);
			translate([0,(trayLength+11),0]) endWall(tW, 3*tT, tT);
		}
		trayPinCuts(tW,trayLength,tT);
	}
}

module endWallB(tW, tL, tT)
{

	difference()
	{
		union()
		{
			cube([tW-railOffset-railWidth-(tW/8),tT,4*tT]);
			translate([0,0,(3*tT)]) rotate([-90,0,0]) cylinder(h=tT, r=3*tT);
		}
		translate([-(3*tT)-1,-1,4*tT]) cube([tW,tL+2,3*tT]);

	}
}

module endWall(tW, tL, tT)
{
	hull()
	{
		translate([tW*0.6,0,(3*tT)]) rotate([-90,0,0]) cylinder(h=tT, r=tT);
		translate([tW*0.6,0,tT]) rotate([-90,0,0]) cylinder(h=tT, r=tT);
		
		difference()
		{
			translate([0,0,(3*tT)]) rotate([-90,0,0]) cylinder(h=tT, r=3*tT);
			translate([-(3*tT)-1,-1,4*tT]) cube([tW,tL+2,3*tT]);
		}
	}
}

module pins()
{
	
	for (i=[0:3*pinRadius:18*pinRadius-1])
	{
		translate([-trayWidth/2,i,0]) cylinder(h=8, r=pinRadius);
	}
}


//********************************************************************************************
//--------------------------------CUP PART

module cupPinCuts(tW, cL, cT, cH)
{
    translate([(tW*0.4),cL - 5 ,cT/3*2.3 - cH]) rotate([-90,0,0]) cylinder(h=6, r=pinRadius+oozeRadius);
    translate([(tW*0.4),-1,cT/3*2.3 - cH]) rotate([-90,0,0]) cylinder(h=6, r=pinRadius+oozeRadius);
    if (part != "cup"){ //when Cup is not devided you dont need the holes in the middle
       translate([(tW*0.4),cL/2 - 4,cT/3*2.3 - cH]) rotate([-90,0,0]) cylinder(h=8, r=pinRadius+oozeRadius);
    }
}

module cup(tW, cL, tT, cH, cT)
{
    difference(){
        union(){
            tray(tW,cL,tT);
            slide(tW, cL, tT, railWidth, railHeight, railUndercutX, railUndercutZ, railOffset);
            translate([0,0,-cH]) cube([tW-(railWidth + railOffset), cL, cH]);
        }
        difference(){ //The inner Part of the Cup, without the Rail on the Bottom
            translate([cT,cT,-cH+cT]) cube([tW-(railWidth + railOffset) - 2*cT, cL - 2*cT, tT*2 + cH - cT]);
            //pen divider, pin hole beefer at the bottom
            translate([(tW*0.4),0,cT/3*2.6 - cH ]) rotate([-90,0,0]) cylinder(h=cL, r=cT/3*2.5);
        }
        
        trayPinCuts(tW, -1,tT);
        trayPinCuts(tW, cL-5,tT);
        if (part != "cup"){ //when Cup is not devided you dont need the holes in the middle
            trayPinCuts(tW, cL/2 - 3, tT);
        }
        cupPinCuts(tW, cL, cT, cH);
    }
}

module cupLeft(tW, cL, tT, cH, cT)
{
    difference(){
        cup(tW, cL, tT, cH, cT);
        translate([-tW,-cL/2,-2*cH]) cube([3*tW, cL, 3* cH]);
    }
}

module cupRight(tW, cL, tT, cH, cT)
{
    difference(){
        cup(tW, cL, tT, cH, cT);
        translate([-tW, cL/2,-2*cH]) cube([3*tW, cL, 3* cH]);
    }
}
