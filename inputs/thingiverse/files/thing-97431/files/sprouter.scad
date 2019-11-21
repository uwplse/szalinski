/* 	Parametric bean/seed sprouter By schlem
	 	5/26/13

A screen to fit inside the ring of a mason
jar, such that water can be introduced and 
drained to coax sprouting.  Additionally,
air shold be able to freely ventilate the 
jar.  

Do it Yourself – How to Sprout
===============================
1. Soak seeds overnight in a bowl with water.
2. The next morning, drain water and rinse with 
fresh water once or twice.
3. Place in a sprouting bag, or sprouting jar 
without any water. (Should still be humid, not 
completely dry.)
4. Every morning and night rinse with fresh 
water, to keep the sprouts wet and clean of mold.
5. Ensure the sprouts never dry up, and repeat 
process until your desired length or age of sprout.

Much more info: 
	http://en.wikipedia.org/wiki/Sprouting

Parametric control over:
-size of insert and related dimensions
-size of screening elements
-size of meshwork in screen
*/

// ***************  First Things ***************  

$fn=180*1;

// ***************  Parameters ***************  

/*
These dimensions work with a standard Mason Jar and
work well with Mung beans.  You can change the diameter
and mesh size for different jar and bean sizes.

I looked all over the interwebs for a table of sizes 
for sproutable seeds and beans.  No dice.  If you find 
such, can you post?  Thanks - schlem
*/  

//Inside Diam
ID = 51; 	
//Outside Diam
OD = 56; 	
//Tube Height
tube_h =8;	
//Mesh Size mm
Mesh = 3;	
//Screening Size
Bar = 1.5; 	
//Thickness of Disk and Mesh
height = 2;
//Lid Diam
lid_diam = 68; 	

/*More info:
//Inside Diam
ID = 51; 	// diameter of inside of tube; ID < OD
//Outside Diam
OD = 56; 	// diameter of outside of tube; OD > ID
//Tube Height
tube_h =8;	// height of tube extending through ring;
//Mesh Size mm
Mesh = 3;	// opening size in mesh mm;
//Screening Size
Bar = 1.5; 	// width of screening elements in mesh mm;
//Thickness of Disk and Mesh
height = 2; // height of mesh and outer disk;
//Lid Diam
lid_diam = 68; 	// diameter of outer disk that ;
			// fits into Mason Jar ring;
*/

// ***************  Top Level code ***************   

union()
{
	difference()
	{
		union()
		{
			slats(L=ID, w=Bar, h=height, space=Mesh);
			rotate(a=[0,0,90])
				slats(L=ID, w=Bar, h=height, space=Mesh);
			tube(t_ID=ID, t_OD=OD, t_h=tube_h);
		}
	translate([0,0,-height*.05])
	tube(t_ID=OD, t_OD=OD*1.5, t_h=height*1.1);
	}
tube(t_ID=OD, t_OD=lid_diam, t_h=height);
}


// ***************  Modules ***************   


module slats(L=50, w=2, h=2, space=2)
//		 slats(L=ID, w=Bar, h=height, space=Mesh)
{ 
	translate([0,0,h/2])
	for ( i = [0 : (L/2)/(w+space)] )
		{
	    translate([0, i*(w+space), 0])
			cube([L,w,h], center = true);
		} 	
	
	translate([0,0,h/2])rotate([180,0,0])
	for ( i = [0 : (L/2)/(w+space)] )
		{
	    translate([0, i*(w+space), 0])
			cube([L,w,h], center = true); 	
		}
}

// ***************           ***************

module tube(t_ID=25, t_OD=30, t_h=10)
//		 tube(t_ID=ID, t_OD=OD, t_h=height)
{
	translate([0,0,t_h/2])
	difference()
	{
		cylinder(r=t_OD/2, h=t_h, center = true);
		cylinder(r=t_ID/2, h=t_h*1.1, center = true);
	}
	

}





// module module(P1=, P2=, P3=){ }





