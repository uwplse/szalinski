// Robot Snowman
// Created by Simon Morgan, December 2014
// http://www.thingiverse.com/SimonSnowman
// License: Creative Commons Attribution-ShareAlike CC BY-SA 

/*[Snowman]*/

// Excluding hat
height=32; // [20:80]

faceStyle=1; //[1,2]
buttonCount=3; //[2,3,4]

// Feature protrusion percentage (max 50; Reduce if things droop)
featureProtrusionPercentage=40; //[30,35,40,45,50]

/*[Arms]*/
// Left arm angle
armAngleL=25; // [15,20,25,30,35,40,178,180]
// Right arm angle
armAngleR=180; // [15,20,25,30,35,40,178,180]

/*[Hat]*/
hatStyle="Pointy"; //[None,Pointy,Blocky]
// Ignored if no hat
hatDecoration="Bobble"; //[None,Bobble]

/*[Hidden]*/
$fn=32;
bodyHeight=(9/16)*height;
headHeight=(7/16)*height;
fpp=featureProtrusionPercentage;
shoulderLX=(-bodyHeight/2)-poBody();
shoulderLZ=0.85*bodyHeight;
shoulderRX=(bodyHeight/2)+poBody();
shoulderRZ=0.85*bodyHeight;

module head()
{
	translate([-bodyHeight/2,-bodyHeight/2,0])
		cube(size=bodyHeight);
}

module body()
{
	translate([-headHeight/2,-headHeight/2,bodyHeight])
		cube(size=headHeight);
}

module hatPointy()
{
	translate([0,0,height])
		cylinder(h=headHeight,r1=(3/7)*headHeight,r2=0);
}

module hatBlocky()
{
	translate([-(2.5/7)*headHeight,-(2.5/7)*headHeight,height])
		cube([(5/7)*headHeight,(5/7)*headHeight,headHeight/7]);
	translate([-(1.5/7)*headHeight,-(1.5/7)*headHeight,height+headHeight/7])
		cube(size=(3/7)*headHeight);
}

module bobbleForBlocky()
{
	translate([0,0,height+headHeight/1.6])
		sphere(r=1*(headHeight/7));
}

module bobbleForPointy()
{
	translate([0,0,height+headHeight/1.2])
		sphere(r=1.25*(headHeight/7));
}

function poBody() =
	((fpp-50)/100)*(bodyHeight/4.5);

function poHead() =
	((fpp-50)/100)*(headHeight/3.5);

module buttons2()
{
	translate([0,-bodyHeight/2,0])
	{
		translate([0,-poBody(),(1/3)*bodyHeight])
			sphere(r=bodyHeight/9);
		translate([0,-poBody(),(2/3)*bodyHeight])
			sphere(r=bodyHeight/9);
	}
}

module buttons3()
{
	translate([0,-bodyHeight/2,0])
	{
		translate([0,-poBody(),0.25*bodyHeight])
			sphere(r=bodyHeight/9);
		translate([0,-poBody(),0.5*bodyHeight])
			sphere(r=bodyHeight/9);
		translate([0,-poBody(),0.75*bodyHeight])
			sphere(r=bodyHeight/9);
	}
}

module buttons4()
{
	translate([0,-bodyHeight/2,0])
	{
		translate([0,-poBody(),0.16*bodyHeight])
			sphere(r=bodyHeight/9);
		translate([0,-poBody(),0.38*bodyHeight])
			sphere(r=bodyHeight/9);
		translate([0,-poBody(),0.6*bodyHeight])
			sphere(r=bodyHeight/9);
		translate([0,-poBody(),0.82*bodyHeight])
			sphere(r=bodyHeight/9);
	}
}

module shoulderL()
{
	translate([shoulderLX,0,shoulderLZ])
		sphere(r=bodyHeight/9);
}

module shoulderR()
{
	translate([shoulderRX,0,shoulderRZ])
		sphere(r=bodyHeight/9);
}

module shoulders()
{
	shoulderL();
	shoulderR();	
}

module armL()
{
	translate([shoulderLX,0,shoulderLZ])
		rotate(a=-armAngleL,v=[0,1,0])
	{
			cylinder(h=bodyHeight*0.6,r1=bodyHeight/9,r2=bodyHeight/9);
			sphere(r=bodyHeight/9);	
	}
}

module armR()
{
	translate([shoulderRX,0,shoulderRZ])
		rotate(a=armAngleR,v=[0,1,0])
			cylinder(h=bodyHeight*0.6,r1=bodyHeight/9,r2=bodyHeight/9);
}

module arms()
{
	armL();
	armR();
}

module handL()
{
	translate([shoulderLX-(sin(armAngleL)*bodyHeight*0.6),0,shoulderLZ+(cos(armAngleL)*bodyHeight*0.6)])
		sphere(r=bodyHeight/8.5);	
}

module handR()
{
	translate([shoulderRX+(sin(armAngleR)*bodyHeight*0.6),0,shoulderRZ+(cos(armAngleR)*bodyHeight*0.6)])
		sphere(r=bodyHeight/8.5);	
}

module hands()
{
	handL();
	handR();
}

module face1()
{
	translate([0,-poHead()-headHeight/2,bodyHeight+(headHeight/2.25)])
	{	
		sphere(r=headHeight/7);
		translate([-headHeight/3.5,0,headHeight/3.5])
			sphere(r=headHeight/7);
		translate([headHeight/3.5,0,headHeight/3.5])
			sphere(r=headHeight/7);
	}
}

module face2()
{
	translate([0,-poHead()-headHeight/2,bodyHeight+(headHeight/2.25)])
	{	
		translate([-headHeight/3.5,0,headHeight/3.5])
			sphere(r=headHeight/7);
		translate([headHeight/3.5,0,headHeight/3.5])
			sphere(r=headHeight/7);
		translate([-headHeight/4,0,-headHeight/5])
			rotate(a=90,v=[0,1,0])
				cylinder(h=headHeight/2,r=headHeight/7);
	}
}


head();
body();

if (faceStyle==1)
{
	face1();
}
else if (faceStyle==2)
{
	face2();
}

if (hatStyle=="Pointy")
{
	hatPointy();
	if (hatDecoration=="Bobble")
	{
		bobbleForPointy();
	}
}
else if (hatStyle=="Blocky")
{
	hatBlocky();
	if (hatDecoration=="Bobble")
	{
		bobbleForBlocky();
	}
}

if (buttonCount==2)
{
	buttons2();
} 
else if (buttonCount==3)
{
	buttons3();
}
else if (buttonCount==4)
{
	buttons4();
}

shoulders();
arms();
hands();

