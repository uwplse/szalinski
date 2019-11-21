// Customize by adjusting the following variables
// All measurements in mm


part="both"; //[both:both,base:base,top:top]

// The number of pins you want your cable shell to accommodate .
pins=8;

// Desired height of the header shell body.  ALL MEASUREMENTS ARE "mm".
height=10;

// Desired thickness of the shell walls.
wallThickness=1;

// MEASURED thickness of the plastic bar in the male header, assumed to be square for each wire (typical value is 2.5mm).
header=2.5;

// Thickness of the cable -- not its width, measure the thin dimension.  The old IDE cables in my "old wires" box are 0.9mm and a snug fit is achieved with a 1mm gap.
cableThickness=1;

// Adjustment factors to perfect the fit between the two shell parts. Smaller numbers tighten, larger numbers loosen.  The following values produced a snug fit with 0.4mm nozzle using PLA. 
cutAdjustmentX=0.2;
cutAdjustmentY=0.2;
cutAdjustmentZ=0.3;

/* [Hidden] */
//==== Don’t edit after this unless you want to change the way the script works ====
//==== basic calculations ==========================================================


outerBodyX=(2*wallThickness)+header;
outerBodyY=(2*wallThickness)+(header*pins);
outerBodyZ=height;

innerBodyX=outerBodyX-(2*wallThickness)+(2*cutAdjustmentX);
innerBodyY=outerBodyY-(2*wallThickness)+(2*cutAdjustmentY);
innerBodyZ=height+2;

innerCutTranslateX=wallThickness;
innerCutTranslateY=wallThickness;
innerCutTranslateZ=-1;

orientationIndicatorX=1;
orientationIndicatorY=2;
orientationIndicatorZ=height/2;

//strain relief shell
outerHullX=outerBodyX+(2*wallThickness);
outerHullY=outerBodyY+(2*wallThickness);
outerHullZ=height*1.5;

innerHullX=outerBodyX+(2*cutAdjustmentX);
innerHullY=outerBodyY+(2*cutAdjustmentY);
innerHullZ=outerHullZ;

//==== the object ==================================================================
$fn=50;

finalAssembly();

module finalAssembly()
{
	
	if(part=="both")
	{

		base();
		translate([0,0,-5])  fastener();
	}
	
	if(part=="base")
	{
		base();
	}
	
	if(part=="top")
	{
		fastener();
	}
}

//the complete base into which pins are inserted
module base()
{
	difference()
	{
		union()
		{
			pinCore();
			wireSeparators();
			translate([0,outerBodyY-0.1,0]) catchTab();
			translate([outerBodyX,0.1,0]) rotate([0,0,180]) catchTab();
		}
		wireChannels();
	}
}

//the shell into which pins are inserted
module pinCore()
{
	difference()
	{
		union()
		{
			cube([outerBodyX, outerBodyY, outerBodyZ]);
			difference()
			{
				//lip
				rotate([-90,0,0]) cylinder(r=2*wallThickness, h=outerBodyY);
				
				//flatten bottom
				translate([0,0,-3*wallThickness]) cylinder(r=outerBodyY*1.2, h=3*wallThickness);
			}
		}
		translate([wallThickness-cutAdjustmentX, wallThickness-cutAdjustmentY, -1]) cube([innerBodyX, innerBodyY, innerBodyZ]);
	}
}

module wireSeparators()
{
	start=wallThickness-cutAdjustmentY;
	increment=header;
	end=outerBodyY-cutAdjustmentY;

	for (wall=[start:increment:end] )
	{
		translate([0, wall, 0]){color("Orchid") cube([outerBodyX, 0.5, (outerBodyZ-header)], center=false);}
	}
}

module catchTab()
{
	translate([outerBodyX,0,4])
	rotate([0,180,0]) 
	difference()
	{
		color("pink") cube([outerBodyX, 1, 4]);
		color("blue") translate([-outerBodyX/2,1,0]) rotate([14,0,0]) cube([2*outerBodyX,2*outerBodyX,outerBodyZ]);
	}
}

module wireChannels()
{
	//the 0.25 constant is based on half of the divider wall constant of 0.5
	start=wallThickness-cutAdjustmentY+header/2+0.25;
	increment=header;
	end=outerBodyY-cutAdjustmentY;

	//in lieu of hull, just stack the same thing for deeper cut
	for (wall=[start:increment:end] )
	{
		color("Orchid") translate([-wallThickness*0.8,wall,-header*0.2]) rotate([0,45,0]) cylinder(r=header*0.35, h=outerBodyZ*0.35*wallThickness);
	}
	
	for (wall=[start:increment:end] )
	{
		color("Orchid") translate([-wallThickness*0.8,wall,-header*0.4]) rotate([0,45,0]) cylinder(r=header*0.35, h=outerBodyZ*0.35*wallThickness);
	}
	
	
	for (wall=[start:increment:end] )
	{
		color("Orchid") translate([-outerBodyZ+wallThickness+0.5,wall,-header*0.1]) rotate([0,90,0]) cylinder(r=header*0.35, h=outerBodyZ);
	}
	
	for (wall=[start:increment:end] )
	{
		color("orange") translate([-outerBodyZ+wallThickness+0.5,wall,0]) rotate([0,90,0]) cylinder(r=header*0.35, h=outerBodyZ);
	}

}

module fastener()
{
	union()
	{
		//sandwich
		translate([outerBodyX-(outerBodyX+(2*wallThickness)+2),-(2+cutAdjustmentY),1-cableThickness]) cube([outerBodyX+(2*wallThickness)+3, outerBodyY+(2*cutAdjustmentY)+4, 2]);
		translate([outerBodyX-(outerBodyX+(2*wallThickness)+2),-(2+cutAdjustmentY),2-cableThickness]) rotate([-90,0,0]) cylinder(r=1, h=outerBodyY+(2*cutAdjustmentY)+4);
		
		translate([outerBodyX-(outerBodyX+(2*wallThickness)+2),-(2+cutAdjustmentY),3]) cube([outerBodyX+(2*wallThickness)+3, outerBodyY+(2*cutAdjustmentY)+4, 2]);
		translate([outerBodyX-(outerBodyX+(2*wallThickness)+2),-(2+cutAdjustmentY),4]) rotate([-90,0,0]) cylinder(r=1, h=outerBodyY+(2*cutAdjustmentY)+4);
		
		//sandwich catchRib
		translate([-((2*wallThickness)+cutAdjustmentX+1),-2, 5]) cube([1,3,1]); 
		translate([-((2*wallThickness)+cutAdjustmentX+1),outerBodyY-1, 5]) cube([1,3,1]); 	
		
		//catch wall
		translate([0,-(2+cutAdjustmentY),1-cableThickness]) cube([outerBodyX+1,1,10+cutAdjustmentZ+cableThickness-1]);
		translate([0,outerBodyY+cutAdjustmentY+1,1-cableThickness]) cube([outerBodyX+1,1,10+cutAdjustmentZ+cableThickness-1]);
		
		//angled catchRib
		translate([0,-(2+cutAdjustmentY),9+cutAdjustmentZ]) cube([outerBodyX+1,2+cutAdjustmentY,2]); 
		translate([0,outerBodyY,9+cutAdjustmentZ]) cube([outerBodyX+1,2+cutAdjustmentY,2]); 
		
		//backTab
		translate([outerBodyX,outerBodyY/4,3]) cube([1,outerBodyY/2,4]);
		
		//filler
		color("purple") translate([outerBodyX,-1.2-cutAdjustmentY,8.5]) rotate([0,180,0]) catchTab();
		color("purple") translate([outerBodyX+1,-1.2-cutAdjustmentY,8.5]) rotate([0,180,0]) catchTab();
		
		color("purple") translate([0,outerBodyY+1.2+cutAdjustmentY,8.5]) rotate([0,180,180]) catchTab();
		color("purple") translate([1,outerBodyY+1.2+cutAdjustmentY,8.5]) rotate([0,180,180]) catchTab();
	}
}

