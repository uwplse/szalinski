//Author: Philipp Hufnagl
//Licence: Creative Commons CC-BY-SA

$fn=50;

buttonWidth=42;
buttonHeight=15;

holeHeight= 14;
holeWidth = 6.5;
holeCut = 6;

makeHollow=0; // [0:yes, 1:no]
makeHandle=1;  // [0:yes, 1:no]
handleLength= 25;
handleWidth= 8;


//workaround so this is not configureable
overlap = 0.05	*1.0;

//makes button hollow
module ringCutout(){
	union()
	{
	translate([0,0,-overlap])
		linear_extrude(height= holeHeight - overlap){
			difference(){
				scale(buttonWidth-3)
					circle(r=0.5);

				scale(holeWidth+4)
					circle(r=0.5);
			}
		}
		translate([0,0,-overlap])
		linear_extrude(height= 1){
			scale(buttonWidth -5)
					circle(r=0.5);
		}
	}
}

//hole in the middle
module hole(){
	translate([0,0,-overlap])
	linear_extrude(height= holeHeight - overlap){
		
		difference()
		{
			scale(holeWidth)
			circle(r=0.5);
			translate([-holeWidth/2,-holeWidth/2 +  holeCut])
				square([holeWidth,holeWidth]);
		}
	}
}

//the main form of the button
module button(){
	translate([0.0,0.0,0.0])
	linear_extrude(height=buttonHeight){
		scale(buttonWidth)
			circle(r=0.5);
	}
}


//a grip (not used for this button)
module handle()
{
translate([0,-handleWidth/2,buttonHeight])
rotate([-90,0,0])
	linear_extrude(height=handleWidth)
	{
		difference()
		{
			scale(handleLength)
				circle(r=0.5);
			translate([-handleLength/2,overlap])
				square([handleLength,handleLength]);
		}
	}
}
rotate([0,180,0])
union()
{
difference()
{	
	button();
	hole();
if(makeHollow == 0)
	ringCutout();
}
if(makeHandle == 0)
	handle();
}
