//Created by Bram Vaessen 2017

//Which one would you like to see?
part = "box"; //[box:The Box, spoolBottom:Spool Bottom, spoolTop:Spool Top, rod:Rod, door:Door]


/* [Number of Spools] */

//Number of spools per row
spoolsPerRow=5; 
//Number of rows with spools
spoolRows = 2; 

/* [Spool Size] */
//The diameter of the spools
outerDiameter=50;
//The width of the spools
spoolWidth=30;

/* [Wire Size] */
//the diameter of the holes for the wires
wireHoleDiameter=2;

/* [Printing Tolerances] */
//extra room foor the spool hole size (applied to the rod)
spoolHoleTolerance=0.5;
//extra room for the fitting between top an bottom of spool (applied to spool bottom)
spoolFitTolerance=0.1;
//extra room between the divider walls and the spools (applied to box)
spacerTolerance=1;
//the extra room between the box and the door (applied to door)
doorTolerance=0.8;
//extra room for fitting the door hinge and door closer(applied to box)
doorHingeTolerance=0.2;
//toerlance for the pegs for closing the door (applied to door)
doorCloserTolerance=0.2;
//the diameter of the little peg for keeping the doors closed (applied to door)
doorCloserDiameter=1.6;



/* [Fine Tune] */
//thickness of the box
boxThickness=3;
//the thickness of the walls dividing the spools
spacerThickness=2;
//the amount of space between spools and the sides of the box
boxSpacer=1;

//Inner Diameter of the spools
innerDiameter=18;
//Diameter of the holes of the spools
holeDiameter=13;
//thickness of the side of the spools
spoolThickness=2;

//the thickness of the door
doorThickness = 2;



print_part();

module print_part() 
{
	if (part == "box")
    	Box();
	else if (part == "spoolBottom")
		SpoolBottom();
	else if (part == "spoolTop")
		SpoolTop();
    else if (part == "rod")
		Rod();
    else if (part == "door")
		Door();
}




midDiameter=(holeDiameter+innerDiameter)/2;

circ = outerDiameter*3.1415;
insertCount = floor(circ/3);

spoolSpace = spoolWidth + spacerThickness + spacerTolerance;
totalSpace = spoolSpace * spoolsPerRow - spacerThickness;

spoolCenterThickness = innerDiameter - holeDiameter;

xInside = totalSpace;
yInside = outerDiameter + boxSpacer*2;
zInside = outerDiameter + boxSpacer*2 + 1+ doorThickness;

xOutside = xInside + boxThickness*2;
yOutside = yInside + boxThickness*2;
zOutside = zInside + boxThickness;

zMiddle = boxThickness+boxSpacer+outerDiameter/2;


doorX = xInside-doorTolerance;
doorY = yInside-doorTolerance;



//cube that is centered on x and y, but not z
module _CenterCube(size)
{
    translate([0,0,size[2]/2]) cube(size, center=true);
}


//a complete spool, for display purpopse only
module _Spool()
{
    SpoolBottom();
    translate([0,0,spoolWidth]) rotate([180,0,0]) SpoolTop();
}


//a row of spools, for display purposes only
module _SpoolRow()
{
    translate([0,0,spacerTolerance/2])
        for (z=[0:spoolsPerRow-1]) translate([0,0,z*spoolSpace])
                _Spool();
}


//the frame for the box, without holes
module _BoxFrame()
{
    //main box
    difference()
    {
        _CenterCube([xOutside, yOutside, zOutside], center=true);
        translate([0,0,boxThickness])
            _CenterCube([xInside, yInside, zOutside], center=true);
    }
    
    //the spacers in between
    if (spacerThickness>0)
    {
        startX = -xInside/2+spacerTolerance + spoolWidth + spacerThickness/2;
        spacerHeight = zInside-boxThickness*3;
        for (x=[0:spoolsPerRow-2]) 
            translate([startX+ x*spoolSpace, 0, boxThickness+spacerHeight/2])
                cube([spacerThickness, yInside, spacerHeight], center=true);
    }
    
}


//box with 1 row of compartments
module _BoxPart()
{
    hingeW = doorThickness*2/3;
    hingeR = doorThickness/2;
    hingeY = -yInside/2+hingeR + doorTolerance/2;
    hingeZ = zOutside-1-doorThickness/2;
    
    difference()
    {
        _BoxFrame();
        //hole for the end of the rod
        translate([-totalSpace/2-boxThickness/2,0,zMiddle]) rotate([0,90,0])
            cylinder(r=holeDiameter/2-1+spoolHoleTolerance/2, h=boxThickness+1, 
                     center=true, $fn=128);      
        //hole for the start of the rod
        translate([totalSpace/2+boxThickness/2,0,zMiddle]) rotate([0,90,0])
            cylinder(r=holeDiameter/2+spoolHoleTolerance/2, h=boxThickness+1, 
                     center=true, $fn=128);  
        //holes for the middle of the rod
        translate([0,0,zMiddle]) rotate([0,90,0]) 
            cylinder(r=holeDiameter/2+spoolHoleTolerance/2, 
                h=totalSpace-0.1, center=true, $fn=128);
        
        for (x=[0,1]) mirror([x,0,0]) 
        {
            //the hinge insert witht the ramped part
            translate([xInside/2-1,hingeY,hingeZ])
                rotate([0,90,0])
                    cylinder(r=hingeR+doorHingeTolerance/2,
                             h=1+hingeW+doorHingeTolerance, $fn=32);
            translate([xInside/2-1,hingeY,hingeZ])
                linear_extrude(height=hingeR*2+doorHingeTolerance, center=true)
                    polygon(points=[[0,0],[1+hingeW/2,0],[0,yInside]]);
            
            //the insert for the keeping the door closed
            translate([xInside/2,-hingeY,hingeZ])
                    sphere(r=hingeR+doorCloserTolerance/2, $fn=32);
        }
    }
    
}


//the handle for on the door
module _DoorHandle(size, length)
{
    translate([0,0,size*1.25]) rotate([0,90,0]) 
    {
    hull()
    {
        translate([-size, 0, 0]) cube([size/2,size,length], center=true);
        cube([size/2,size/4,length], center=true);
    }
    hull()
    {
        translate([size, 0, 0]) cube([size/2,size*1.5,length], center=true);
        cube([size/2,size/4,length], center=true);
    }
    }
    
}

//little edge on the rod to faster the rod in the box
module _Edge()
{
    edgeWidth = spoolHoleTolerance*0.6;
    rotate([90,0,0]) linear_extrude(height=0.8, center=true)
        polygon(points=[[-edgeWidth/2,0], [edgeWidth+spoolHoleTolerance/2,0], 
                        [edgeWidth+spoolHoleTolerance/2,boxThickness*0.5], 
                        [-edgeWidth/2,boxThickness]]);
    
}





//base plate for a spool
module _SpoolPlate()
{
    difference()
    {
        //flat cylinder with hole
        cylinder(r=outerDiameter/2, h=spoolThickness, $fn=256);
        translate([0,0,-1]) 
            cylinder(r=holeDiameter/2+spoolHoleTolerance/2, h=spoolWidth+2, $fn=128);
        //little cutouts on th eside
        for (r=[0:360/insertCount:359.9]) rotate([0,0,r]) 
            translate([outerDiameter/2,0,-1]) cylinder(r=1, h=spoolThickness+2, $fn=16); 
    }
}


//for display purpose only
module _Assembly()
{
    Box();
    translate([-totalSpace/2,0,zMiddle]) rotate([0,90,0]) _SpoolRow();
    translate([-totalSpace/2,yOutside - boxThickness,zMiddle]) rotate([0,90,0]) _SpoolRow();
    translate([0, 0, 55]) Door();
    translate([0, yOutside - boxThickness, 55]) 
        translate([0,(-doorY+1)/2,0]) rotate([50,0,0])  translate([0,(doorY/2-1),0])
            Door();
}


//the completed box
module Box()
{
    //add one or more rows to complete the box
    for (y=[0:spoolRows-1]) translate([0,y*(yOutside-boxThickness),0])
        _BoxPart();
}

//bottom part of the spool
module SpoolBottom()
{
    _SpoolPlate();
    difference()
    {
        //middle part of the spool
        cylinder(r=innerDiameter/2, h=spoolWidth-spoolThickness, $fn=128);
        translate([0,0,-1]) cylinder(r=holeDiameter/2, h=spoolWidth+2, $fn=128);
        //the cutout for fitting the spools pieces together
        translate([0,0,spoolWidth-spoolThickness-2.5]) difference()
        {   
            cylinder(r=midDiameter/2+spoolCenterThickness/10+spoolFitTolerance, h=3, $fn=256);
            translate([0,0,-1]) 
                cylinder(r=midDiameter/2-spoolCenterThickness/10-spoolFitTolerance, h=5, $fn=256);
        }
        //the little holes for keeping the wire in place
        translate([0,0,spoolThickness+wireHoleDiameter/2+0.25]) rotate([90,0,0])
            cylinder(r=wireHoleDiameter/2, h=outerDiameter, center=true, $fn=32);
        
        
    }
}

//top part of the spool
module SpoolTop()
{
    _SpoolPlate();
    translate([0,0,spoolThickness])
    //the extra cylinder to fit the spool parts together
    difference()
    {
        cylinder(r=midDiameter/2+spoolCenterThickness/10, h=2, $fn=256);
        translate([0,0,-1]) 
            cylinder(r=midDiameter/2-spoolCenterThickness/10, h=4, $fn=256);
    }
}

//one door
module Door()
{

    
    //main door with holes
    difference()
    {
        _CenterCube([doorX, doorY, doorThickness]);
        startX = -xInside/2 + spacerTolerance/2 - spacerThickness/2 + spoolSpace/2;
        for (x=[0:spoolsPerRow-1]) 
            translate([startX+x*spoolSpace, -doorY/4, -1])
                cylinder(r=wireHoleDiameter, h=doorThickness+2, $fn=32);
            
    }
    
    //the pegs for the hinges
    translate([0, -doorY/2+doorThickness/2,doorThickness/2])
        rotate([0,90,0]) 
            cylinder(r=doorThickness/2-0.01, h=doorX+doorThickness*4/3 + doorTolerance, 
                      center=true, $fn=64);

    //the pegs for keeping the door closed
    for (x=[0,1]) mirror([x,0,0])
        translate([doorX/2-doorCloserTolerance, 
                    doorY/2-doorThickness/2,doorThickness/2])
            sphere(r=doorCloserDiameter/2, $fn=64);
    
    //add the door handle
    handleSize=max(3,doorY/20);
    translate([0,doorY*.35,doorThickness]) _DoorHandle(size=handleSize, length=doorX*0.85);
    
}

//a rod for rotating the spools on
module Rod()
{
    
    edgeWidth=1;
    //main cylinder + extra part for the end
    cylinder(r=holeDiameter/2-spoolHoleTolerance/2, h=xInside+boxThickness-0.5, $fn=128);
    translate([0,0,xInside+boxThickness])
        cylinder(r=holeDiameter/2-1-spoolHoleTolerance/2, h=boxThickness+0.7, $fn=128);
    //the edges to keep it in place
    for (r=[0:360/4:359]) rotate([0,0,r])
    {
        translate([holeDiameter/2-spoolHoleTolerance/2,0,0]) 
            _Edge();
    }
    
}

