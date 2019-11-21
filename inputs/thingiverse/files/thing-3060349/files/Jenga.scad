jengax=280;
jengay=78;
jengaz=78;
wall=6;

hexwidth=2*wall;
hexdiameter=45;
groovethickness=2;
groovewidth=1.2;
tol=0.5;

lock=2.5;

module Hex(size=[100,200,10],diameter=15,thickness=4)
{
	
	dimx=floor(size[0]/(2*diameter*cos(30)))+2;
	dimy=floor(2*size[1]/(diameter*cos(30)))+2;
	
	hex=diameter;
	sep=thickness;
	intersection()
	{
		for (ii=[0:1:dimx])
		{
			for (jj=[0:2:dimy-1])
			{
				translate([ii*(hex+hex/2),-sep/2+jj*((hex/2)*cos(30)),0])
				cylinder(d=hex-sep,$fn=6,h=size[2]);
			}
		
			for (jj=[1:2:dimy-1])
			{
				translate([(3*hex/4)+ii*(hex+hex/2),-sep/2+jj*((hex/2)*cos(30)),0])
				cylinder(d=hex-sep,$fn=6,h=size[2]);
			}
		
		}
		cube(size);
	}
	
}

difference()
{
	//outside box
	cube([jengax+3*wall,jengay+2*wall,jengaz+3*wall]);
	//main cutout
	translate([wall,wall,wall])
	cube([jengax+2*wall,jengay,jengaz+2*wall]);	
	
	// XY Grooves
	translate([wall-groovewidth,wall-groovewidth,jengaz+wall])
	cube([jengax+3*wall,jengay+2*groovewidth,groovethickness]);
	
	//YZ Goooves
	translate([jengax+wall,wall-groovewidth,wall-groovewidth])
	cube([groovethickness,jengay+2*groovewidth,jengaz+3*wall]);
	
	//YZ Locks
	translate([jengax+wall,0,jengaz+2*wall-tol/2+groovethickness])
	{
		cube([2*wall,jengay+2*wall,wall+tol/2-groovethickness]);
		translate([0,0,-wall-tol/2+groovethickness])
		cube([2*wall,lock+tol/2,2*wall+tol/2-groovethickness]);
		translate([0,2*wall+jengay-lock-tol/2,-wall-tol/2+groovethickness])
		cube([2*wall,lock+tol/2,2*wall+tol/2-groovethickness]);
	}
	//Side Cutouts
	translate([2*wall,0,2*wall])
	mirror([0,0,1])
	mirror([0,1,0])
	rotate([90,90,0])
	Hex(size=[jengay-2*wall,jengax-2*wall,2*wall+jengaz+.01],diameter=hexdiameter,thickness=hexwidth);
	
	//Base Cutouts
	translate([2*wall,2*wall,0])
	mirror([1,0,0])
	rotate([0,0,90])
	Hex(size=[jengay-2*wall,jengax-2*wall,2*wall],thickness=hexwidth,diameter=hexdiameter);
	
	//end Cutouts
	translate([0,2*wall,2*wall])
	mirror([1,0,0])
	rotate([0,-90,0])
	Hex(size=[jengaz-2*wall,jengay-2*wall,2*wall],thickness=hexwidth,diameter=hexdiameter);
	
	// Only print end test
	//cube([jengax,jengay+2*wall,jengaz+3*wall]);
}

//XY Lid
translate([0,jengay+10+2*wall,0])
difference()
{
	union()
	{
		//outer
		cube([groovewidth+jengax-tol,jengay+2*groovewidth-tol,groovethickness-tol]);
		//thicker
		translate([0,groovewidth,0])
		cube([jengax-tol,jengay-tol,wall]);
		
		//lip
		translate([0,groovewidth,0])
		cube([wall,jengay-tol,2*wall]);
		
	}

	//Cutout
	translate([2*wall,wall+groovewidth,0])
	mirror([1,0,0])
	rotate([0,0,90])
	Hex(size=[jengay-2*wall-tol,jengax-3*wall-tol,wall],thickness=hexwidth,diameter=hexdiameter);

}
//XZ Lid

translate([0,-jengay-10-2*wall,0])
difference()
{
	union()
	{
		//outer
		cube([groovewidth+jengaz+2*wall-tol,jengay+2*groovewidth  -tol,groovethickness-tol]);
		//thicker
		translate([0,groovewidth,0])
		cube([jengaz+2*wall-tol,jengay-tol,wall]);
		
		//lip
		translate([0,-wall-tol/2+groovewidth,0])
		cube([wall-groovethickness,jengay+2*wall,2*wall]);
		
		//right clip
		translate([0,-wall-tol/2+groovewidth,0])
		cube([2*wall-2*groovethickness,lock,2*wall]);
		
		//left clip
		translate([0,jengay+wall+groovewidth-tol/2-lock,0])
		cube([2*wall-2*groovethickness,lock,2*wall]);
		
	}
	//Cutout
	translate([2*wall,wall*1.5,0])
	Hex(size=[jengaz-wall-tol,jengay-2*wall-tol,wall],thickness=hexwidth,diameter=hexdiameter);
}


//Optional bits to fill in full hexagons if needed.
//Hex Fill for xy-lid
*translate([-hexdiameter-2*wall,0,0])
{
	cylinder(d=hexdiameter-hexwidth+.5,h=0.2,$fn=6);
	cylinder(d=hexdiameter-hexwidth-1,h=2,$fn=6);
	
}

//Hex Fill For Top/Sides
*translate([-hexdiameter-2*wall,hexdiameter,0])
{
	cylinder(d=hexdiameter-hexwidth+.5,h=0.2,$fn=6);
	cylinder(d=hexdiameter-hexwidth-0.3,h=2,$fn=6);
	
}