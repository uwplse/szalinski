// Customizeable Loom Band Loom
// TrevM 10/08/2014

/* [Global] */

// What quality?
$fn = 30;	// [20,30,40,50,60,70,80,90,100]

// Pin spacing accross loom (x)
Pin_Space_Acc = 16.5;

// Pin spacing along loom (y)
Pin_Space_Alo = 25;

// Number of pins along length
NumPinsL = 7;	// [2:10]

// Number of pins accross
NumPinsW = 4;	// [2:10]	

// Pins Staggered?
Staggered = 1;	// [0:No,1:Yes]


// End connects?
End_Connects = 1;	// [0:No,1:Yes]

// Side connects?
Side_Connects = 1;	// [0:No,1:Yes]

// Tolerance (space between mating surfaces)
Tol = 0.5;	

// Base Thickness?
Base_Th = 7;	// [2:30]

// Pin Diameter (centre part)
Pin_Narrow = 8;	// [1:20]

// Pin Hole Diameter (hole up centre of pin)
Pin_Hole = 4;	// [1:20]

// Pin Diameter (top and bottom)
Pin_Wide = 10;	// [1:20]

// Pin Height (total, base to top)
Pin_Hi = 15;	// [1:50]

// Pin Base Height (wide bit at bottom of pin)
Pin_Base = 4;	// [1:50]

// Pin Top Height (wide bit at top of pin)
Pin_Top = 3;	// [1:50]

// Connector Diameter (male & female)
Conn = 9;		// [1:20]

// Connector Offset (overlap with base)
Conn_Off = 2;	// [0:20]

/* [Hidden] */

// spacing
spw=Pin_Space_Acc;	// spacing width
spl=Pin_Space_Alo/2;	// spacing length

// base dims
bll=(NumPinsL*2*spl)+(Staggered*spl);
blw=NumPinsW*spw;

// pin dims
PinN=Pin_Narrow/2;
PinW=Pin_Wide/2;
PinD=PinW-PinN;
PinH=Pin_Hole/2;

ConR=Conn/2;
TolH=Tol/2;

loom();

module loom()
{
	base();
	for(x=[1:NumPinsW])
	{
		for(y=[1:NumPinsL])
			eachPeg(x,y);
	}
	for(a=[1:NumPinsW])
		eachArrow(a);
}

module base()
{
	translate([-blw/2,-bll/2,0])
	{
		difference()
		{
			union()
			{
				// shamfered base block
				polyhedron(
					points=[
						// base
						[1+TolH,		1+TolH,		0],		//lb
						[blw-1-TolH,	1+TolH,		0],		//rb
						[blw-1-TolH,	bll-1-TolH,	0],		//rt
						[1+TolH,		bll-1-TolH,	0],		//lt
						// top
						[TolH,			TolH,		1.1],	//lb
						[blw-TolH,		TolH,		1.1],	//rb
						[blw-TolH,		bll-TolH,	1.1],	//rt
						[TolH,			bll-TolH,	1.1]],	//lt
					faces=[
						[0,1,2,3],					//bot
						[7,6,5,4],					//top
						[4,5,1,0],					//near
						[5,6,2,1],					//left
						[3,2,6,7],					//far
						[7,4,0,3]]);				//right
				// main base block
				translate([TolH,TolH,1])
					cube([blw-Tol,bll-Tol,Base_Th-1]);
			}
			if (End_Connects==1)
			{
				for(c=[1:NumPinsW-1])
					doEndFem(c,c*spw,+ConR-Conn_Off);
			}
			if (Side_Connects==1)
			{
				for(c=[1:NumPinsL-1])
					doSideFem(c,ConR-Conn_Off,c*spl*2);
			}
		}
		if (End_Connects==1)
		{
			for(c=[1:NumPinsW-1])
				doEndMale(c,c*spw,bll+ConR-Conn_Off);
		}
		if (Side_Connects==1)
		{
			for(c=[1:NumPinsL-1])
				doSideMale(c,blw+ConR-Conn_Off,c*spl*2);
		}
	}
}

module doSideFem(n,x,y)
{
	e=floor(n/2);
	even=n-(e*2);
	//echo("n=",n," even=",even);
	if (even==0)
		Fem(x,y);
}

module doEndFem(n,x,y)
{
	e=floor(n/2);
	even=n-(e*2);
	//echo("n=",n," even=",even);
	if (even==1)
		Fem(x,y);
}

module Fem(x,y)
{
	translate([x,y,-0.1])
	{
		//cylinder(r=ConR,h=Base_Th+0.2);
		cylinder(r1=ConR+1+TolH,r2=ConR+TolH,h=1.2);
		translate([0,0,1.1])
			cylinder(r=ConR+TolH,h=Base_Th-0.9);
	}
}

module doSideMale(n,x,y)
{
	e=floor(n/2);
	even=n-(e*2);
	//echo("n=",n," even=",even);
	if (even==0)
		Male(x,y);
}

module doEndMale(n,x,y)
{
	e=floor(n/2);
	even=n-(e*2);
	//echo("n=",n," even=",even);
	if (even==1)
		Male(x,y);
}

module Male(x,y)
{
	translate([x,y,0])
	{
		cylinder(r1=ConR-1-TolH,r2=ConR-TolH,h=1.1);
		translate([0,0,1])
			cylinder(r=ConR-TolH,h=Base_Th-1);
	}
}

module eachPeg(x,y)
{
	even = floor((x-1)/2);
	exy = x-1-(even * 2);
	posx = ((x-1)*spw)+(spw/2);
	posy = ((y-1)*spl*2)+spl;
	//echo("x=",x," y=",y," even=",even," exy=",exy," posx=",posx," posy=",posy);
	if (Staggered == 0)
		peg(posx,posy);
	else
		peg(posx,posy+(exy*spl));
}

module peg(posx,posy)
{
	translate([posx-(blw/2),posy-(bll/2),Base_Th-0.1])
	{
		difference()
		{
			union()
			{
				cylinder(r=PinN,h=Pin_Hi+0.1);		// narrow
				cylinder(r=PinW,h=Pin_Base+0.1);		// base
				// base shamfer
				if (PinD > 0)
				{
					translate([0,0,Pin_Base])
						cylinder(r1=PinW,r2=PinN,h=PinD);
				}
				translate([0,0,Pin_Hi-Pin_Top+0.1])
					cylinder(r=PinW,h=Pin_Top);		// top
				// top shamfer
				if (PinD > 0)
				{
					translate([0,0,Pin_Hi-Pin_Top+0.1-PinD])
						cylinder(r1=PinN,r2=PinW,h=PinD+0.1);
				}
			}
			translate([0,0,-0.1])
			{
				cylinder(r=PinH,h=Pin_Hi+0.3);			// hole
				translate([-PinH,0,0])
					cube([PinH*2,PinW,Pin_Hi+0.3]);		// slot
				translate([-PinW-0.1,PinH,0])
					cube([(PinW+0.1)*2,PinW,Pin_Hi+0.3]);	// slice
			}
		}
	}
}

module eachArrow(x)
{
	even = floor((x-1)/2);
	exy = x-1-(even * 2);
	posx = ((x-1)*spw)+(spw/2);
	posy = spl;
	if (Staggered == 0)
		arrow(posx,posy);
	else
		arrow(posx,posy+(exy*spl));
}

module arrow(x,y)
{
	thk=2;
	translate([x-(blw/2),y-(bll/2),Base_Th-1])
	{
		// shaft
		translate([-PinH,PinW,0])
			cube([PinH*2,spl-PinW,thk]);
		// head
		polyhedron(
			points=[
				// base
				[-PinW,spl-0.1, 0],	//lb
				[ PinW,spl-0.1, 0],	//rb
				[ 0   ,spl+PinW,0],	//tip
				// top
				[-PinW,spl-0.1, thk],	//lb
				[ PinW,spl-0.1, thk],	//rb
				[ 0   ,spl+PinW,thk]],	//tip
			faces=[
				[1,0,2],						//bot
				[3,4,5],						//top
				[0,1,4,3],						//base
				[1,2,5,4],						//left
				[0,3,5,2]]);					//right
	}
}
