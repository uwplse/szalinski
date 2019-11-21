//Square to Square Clip
//Example is a Nema17 motor to fan mount
//but not limited to :-).
// Author: KonKop (Bryon Wheeler)


//The object with the largest width should go to Bigger
//The object with the smallest width should go to the Smaller

//Variables
ClipHeight = 7;


//Box with the Largest Width
/* [Largest Box] */   
BiggerWidth = 42.6;
BiggerDepth = 36.3; //to hookable groove
BiggerClipSize = 2; 
BigTeethSize = 5;

//Box with Smallest Width
/* [Smallest Box] */   
SmallerWidth = 40.5;
SmallerDepth = 10.5;
SmallerClipSize = 1.7;
SmallerTeethSize = 2.5;

//
ConnectorDepth = 10.5;
ConnectorWidth = BiggerWidth;


//Air hole in the connector for air
HoleWidth = SmallerWidth;
HoleHeight = ClipHeight * .7;

HoleCutOutWidth = HoleWidth;
HoleCutOut = ConnectorDepth * .4;

NumHoleSpacers = 5;
HoleSupportSpace = (HoleWidth / (NumHoleSpacers + 1));
HoleSupportWidth = .9;



/* 
Triangle
	a: Length of side a
	b: Length of side b
	angle: angle at point angleAB
*/
module Triangle(
			a, b, angle, height=1, heights=undef,
			center=undef, centerXYZ=[false,false,false])
{
	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCA = ((heights==undef) ? height : heights[2])/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCA);

	// Calculate Offsets for centering
	offsetX = (center || (center==undef && centerXYZ[0]))?((cos(angle)*a)+b)/3:0;
	offsetY = (center || (center==undef && centerXYZ[1]))?(sin(angle)*a)/3:0;
	
	pointAB1 = [-offsetX,-offsetY, centerZ-heightAB];
	pointAB2 = [-offsetX,-offsetY, centerZ+heightAB];
	pointBC1 = [b-offsetX,-offsetY, centerZ-heightBC];
	pointBC2 = [b-offsetX,-offsetY, centerZ+heightBC];
	pointCA1 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ-heightCA];
	pointCA2 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ+heightCA];

	polyhedron(
		points=[	pointAB1, pointBC1, pointCA1,
					pointAB2, pointBC2, pointCA2 ],	
        faces=[	
			[0, 1, 2],
			[3, 5, 4],
			[0, 3, 1],
			[1, 3, 4],
			[1, 4, 2],
			[2, 4, 5],
			[2, 5, 0],
			[0, 5, 3] ] );
}

/*
Equilateral Triangle
	Create a Equilateral Triangle.

	l: Length of all sides (a, b & c)
	H: Triangle size will be based on the this 2D height
		When using H, l is ignored.
*/
module Equilateral_Triangle(
			l=10, H=undef, height=1, heights=undef,
			center=undef, centerXYZ=[true,false,false])
{
	L = (H==undef)?l:H/sin(60);
	Triangle(a=L,b=L,angle=60,height=height, heights=heights,
				center=center, centerXYZ=centerXYZ);
}


module BiggerClip(){
    
    //Bigger Box
    difference(){
    cube(size = [BiggerWidth + (BiggerClipSize * 2),BiggerDepth,ClipHeight], center = false);
    
    translate([BiggerClipSize,0,0])
    cube(size = [BiggerWidth,BiggerDepth,ClipHeight], center = false);
    }
    
    //Teeth
    translate([BiggerClipSize,BiggerDepth+BigTeethSize/2,0]) rotate([0,0,-90]) Equilateral_Triangle(l=BigTeethSize, height = ClipHeight);
    translate([0,BiggerDepth,0])
    cube(size = [BiggerClipSize,BigTeethSize,ClipHeight], center = false);
    
    translate([BiggerClipSize + BiggerWidth,BiggerDepth+BigTeethSize/2,0]) rotate([0,0,90]) Equilateral_Triangle(l=BigTeethSize, height = ClipHeight);
    
    translate([BiggerClipSize + BiggerWidth,BiggerDepth,0])
    cube(size = [BiggerClipSize,BigTeethSize,ClipHeight], center = false);
}

module SmallerClip(){
    //Offset
    Offset = ((BiggerWidth + (BiggerClipSize * 2)) - (SmallerWidth + (SmallerClipSize * 2))) / 2;
    
    //Smaller Box
    translate([Offset,-(SmallerDepth + ConnectorDepth),0])
    difference(){
    cube(size = [SmallerWidth + (SmallerClipSize * 2),SmallerDepth,ClipHeight], center = false);
    
    translate([SmallerClipSize,0,0])
    cube(size = [SmallerWidth,SmallerDepth,ClipHeight], center = false);
    }
    
    //Teeth
    translate([Offset,-SmallerDepth*2 - ConnectorDepth,0])
    {
    translate([SmallerClipSize,SmallerDepth-SmallerTeethSize/2,0]) rotate([0,0,-90])      Equilateral_Triangle(l=SmallerTeethSize, height = ClipHeight);
    
    translate([SmallerClipSize,SmallerDepth-SmallerTeethSize,0])
    translate([-SmallerClipSize,0,0])
    cube(size = [SmallerClipSize,SmallerTeethSize,ClipHeight], center = false);
    
    
    translate([SmallerClipSize + SmallerWidth,SmallerDepth-SmallerTeethSize/2,0]) rotate([0,0,90]) Equilateral_Triangle(l=SmallerTeethSize, height = ClipHeight);
    
    translate([SmallerClipSize + SmallerWidth,SmallerDepth-SmallerTeethSize,0])
    //translate([SmallerClipSize,0,0])
    cube(size = [SmallerClipSize,SmallerTeethSize,ClipHeight], center = false);
    };
}

module SpacerBar(Xval,Depth, Yval){
    translate([Xval,Yval,0])
    cube(size = [HoleSupportWidth,Depth,ClipHeight], center = false);
}

module Connector(){
    SpacerX = ConnectorWidth + (BiggerClipSize * 2);
    translate([0,-SmallerDepth,0])
    {
        difference(){
            cube(size = [SpacerX,ConnectorDepth,ClipHeight], center = false);
        
            //air Hole
            translate([ (SpacerX - HoleWidth)/2,0,(ClipHeight - HoleHeight) / 2])
            cube(size = [HoleWidth,ConnectorDepth,HoleHeight], center = false);
                
//            //Air upper and lower gap    
            translate([ (SpacerX - HoleCutOutWidth)/2,ConnectorDepth-HoleCutOut,0])
            cube(size = [HoleCutOutWidth,HoleCutOut,ClipHeight], center = false);
            
            //support for gap
            //cube(size = [HoleCutOutWidth,HoleCutOut,ClipHeight], center = false);
                
        };
        
        SupportDepth = ConnectorDepth;
        //support bars
        for (a =[(SpacerX - HoleWidth)/2 + HoleSupportSpace:HoleSupportSpace:(SpacerX - HoleWidth)/2 + HoleWidth])SpacerBar(a,SupportDepth,0);
    }
}
translate([-BiggerWidth/2,0,0]){
Connector();
SmallerClip();
BiggerClip();
}