/*
2D Pixel Art
*/

/* [Draw] */

// Your art : each line starts with a '/';'*' makes a pixel;any other character is ignored
pixels="/__*_____*__/___*___*___/__*******__/__*__*__*__/_**__*__**_/***********/*_*******_*/*_*_____*_*/___**_**___"; 

/* [Dimensions] */

// mm per x unit
xUnit=5; // [0:100]

// mm per y unit
yUnit=5; // [0:100]

// mm per z unit
zUnit=5; // [0:100]

// percentage of overlap between pixels
overlap=-10; //[-100:100]

overlapFactor=1+overlap/100;
//pixelsDimension=[pixelsPerLines,rows]*1;


unitSize=[xUnit,yUnit,zUnit]*1;

newPixel(pixels,unitSize,overlapFactor,center=true);

module newPixel(pixels,unitSize,overlapFactor,center){
	
	lines = split(pixels,"/");
	size = [len(lines[0]),len(lines)];

	translate(center ? [unitSize[0]*(size[0]-1),unitSize[1]*(size[1]-1),0]*(center?-1/2:0) : unitSize/2)
	for (y=[0:size[1]-1]){
		for (x=[0:len(lines[y])-1]){
		
			if (lines[y][x]=="*"){
				translate([x*unitSize[0],(size[1]-y-1)*unitSize[1],0])	
				cube(unitSize*overlapFactor,center=true);
			}
		}
	}
}

function subString(theString,from,to)=
	to==0?"":str(subString(theString,from,to-1),theString[from+to]);

function splitInfo(positions,values)=
	[for (index = [0:len(positions)-1]) [positions[index],(positions[index+1]==undef?len(values):positions[index+1])-positions[index]-1] ];

function split(theString, splitChar)= 
	[ for (position = splitInfo(search(splitChar,theString, 0)[0],theString)) subString(theString,position[0],position[1])];


