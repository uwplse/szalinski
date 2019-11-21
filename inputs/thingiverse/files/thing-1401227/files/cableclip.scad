/*

*/

//-------------configure
//degree of detail
$fn=50;

//scale in x (not height)
sizex = 50;

//scale in y (not height)
sizey = 30;

//scale in z (height)
sizez = 7;

//wall thickness
wall = 6;

//thickness of the actual cable
cablesize = 4;

//getting a cable in is supposed to be a tight fit
//ajust here how tight (compared to cable thickness)
entranceScale = 0.8;

//0 to turn off entrance improvements
//1 to turn on entrance improvements
entranceImprovement=1;

//-------------configure end
eimp = true;


entrance = cablesize*entranceScale;

//this code creates the opening for the back side
//of the clip
module channel(){
	difference(){
		scale([sizex - wall * 2,sizey - wall * 2]) 
			circle(r=0.5);	
		scale([sizex - wall * 2-cablesize *2,sizey - wall * 2-cablesize *2]) 
			circle(r=0.5);	
		translate([0,-sizey/2])
			square([sizex/2,sizey]);
		translate([-(sizex/2 - cablesize -wall),-sizey/2])
		square([sizex/2 - cablesize -wall,sizey/2]);
	
	}
}

//this is what gets cit out of the elipse to create
//a clip.
module stencil() {
	difference()
	{
		scale([sizex - wall * 2,sizey - wall * 2]) 
			circle(r=0.5);
		
		difference(){
			translate([-(sizex/2-wall),-sizey/2])
				square([cablesize+wall,sizey]);
	
			channel();
		}

	}

//i was experimenting with a circular ending of the
//channel.  Turned out do be a structual weakness feel
//free to experiment ;-)

/*
	translate([-(sizex/2 - wall-cablesize ),-cablesize/2])
	scale([cablesize,cablesize ])
	#circle(r=0.5);
*/
}

module improvedEntrance()
{
translate([sizex/2 -wall/2,-wall/2 -entrance/2])
difference(){
translate([0,0])
	square([wall/2, wall/2 + entrance/4]);
scale([wall,wall])
			circle(r=0.5);
}


translate([sizex/2 -wall/2,wall/2 +entrance/2])
difference(){
translate([0,-(wall/2 + entrance/4)])
	square([wall/2,wall/2 + entrance/4]);
scale([wall,wall])
			circle(r=0.5);
}

}

//cutting out the stencil from the elipse makes the clip
module main(){
	difference()
	{
		scale([sizex,sizey])
			circle(r=0.5);
		stencil();
translate([sizex/2 -wall * 1.5,-entrance/2]) 
			square([wall * 2,entrance]);
	
	}
}

module CableClip(){
difference()
{
	main();
	if(entranceImprovement != 0)
	{
		improvedEntrance();
	}
}

	if(entranceImprovement != 0)
	{
		translate([sizex/2 -wall/2,-wall/2 -entrance/2])
		scale([wall,wall])
				circle(r=0.5);
	
		translate([sizex/2 -wall/2,wall/2 +entrance/2])
		scale([wall,wall])
				circle(r=0.5);
	}
}


//making the 2d drawing 3d
//commend out for 2d dawing
linear_extrude(height=sizez)
	CableClip();