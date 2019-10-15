/* Power Box Holder
This is designed to hold a power box under a cabinet
for under-cabinet lighting.

(c) Daniel T Urquhart 2018
This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
*/

/* [Basics] */

// Select which part to generate
part =  0; //[0:BoxFront, 1:BoxBack, 2:BracketLeft,3:BracketRight]

// Enable extension to hold wires?
ENABLE_EXTENSION =1; //[1:EnableWireHolder,0:Disable]

//Length of bracket (mm)
fullLen = 140;

//width of main body
centerWidth = 80;


/* [Advanced] */


//length of main body
centerLen = 50;

//width of extension
extensionWidth = 30;

//height of extension
extensionHeight = 20;

//wall thickness
wallWidth = 5;
//extension wall thickness
thinWall = 3;
//height (depth) of the holder
centerHeight = 35;

// Screw whole diameter
screwSize = 25.4/8; 



//creates a screwHole with countersink at 0,0,0
module screwHole()
{
    cylinder(r=screwSize/2,h=20,$fn = 25, center=true);
    sphere(r=screwSize,h=2,$fn = 25, center=true);
}



if( part == 0 || part == 1)
{
	//base
	//translate([0,-extensionWidth*part,0])
	cube([centerLen,centerWidth+wallWidth,wallWidth]);

	//side walls
	cube([centerLen,wallWidth,centerHeight+wallWidth]);
	translate([0,centerWidth+wallWidth])
	cube([centerLen,wallWidth,centerHeight+wallWidth]);

	//lower lip
	cube([wallWidth,centerWidth+wallWidth,wallWidth*2]);

	//upper lip
	translate([0,-wallWidth,centerHeight])
	cube([centerLen,wallWidth*2,wallWidth]);

	translate([0,centerWidth+wallWidth,centerHeight])
	cube([centerLen,wallWidth*2,wallWidth]);

	//extension lip
	if(ENABLE_EXTENSION)
	{
		centerX = (centerLen-thinWall)/2;
		for(x = [0,centerLen-thinWall]){
			extensionEdge   = part==0?centerWidth:0;
			extensionOffset = part==0?centerWidth+extensionWidth:-extensionWidth;
			
			//extension lip
			hull(){
			translate([x,extensionOffset,0])
				cube([thinWall,thinWall,extensionHeight]);
				
			translate([centerX,extensionOffset,0])
				cube([thinWall,thinWall,thinWall]);
			}
			
			//extension base
			hull(){
				translate([x==0?0:x-thinWall,extensionOffset,0])
					cube([thinWall*2,thinWall,thinWall]);
					
				translate([x,extensionEdge,0])
					cube([thinWall,thinWall,thinWall]);
				translate([centerX,extensionEdge+thinWall,0])
					cube([thinWall,thinWall,thinWall]);	
			}
		}
	}
}

module bracket()
{
    bracketSize = 12+wallWidth;
    translate([0,0,wallWidth])
        cube([fullLen,bracketSize,wallWidth]);
    
    cube([fullLen,wallWidth, wallWidth]);
    //rail
    translate([0,-wallWidth,0])
      cube([fullLen,wallWidth, wallWidth]);
    
    translate([0,0,0])
    intersection(){
    cube([fullLen,bracketSize, wallWidth]);
    translate([fullLen/2,0,fullLen*2.5])
     rotate([0,90,90])
      cylinder(h=bracketSize,r=fullLen*2.5,$fa = 1);
    }
}

module bracketWithScrews()
{
    difference()
    {
        bracket();
        
        translate([wallWidth*2,wallWidth*2,wallWidth])
            screwHole();
        translate([fullLen-wallWidth*2,wallWidth*2,wallWidth])
            screwHole();
    }
}



//double bracket would be cool but I can't print it...
if(part == 2){
	translate([0,centerWidth,0])
	translate([-fullLen/2,0,0])
		bracketWithScrews();
}
//translate([-wallWidth,0,0])
//cube([wallWidth*2,centerWidth,wallWidth*2]);
if(part == 3){
	rotate([0,0,180])
	translate([-fullLen/2,0,0])
		bracketWithScrews();
}


