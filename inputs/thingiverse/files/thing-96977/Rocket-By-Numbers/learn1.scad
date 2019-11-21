//Rocket Tube Height
rheight = 80;

//Rocket Tube Width
rwidth = 10;

//Number of Fins
nfins = 5; // [0,1,2,3,4,5,6,7,8,9,10]

//Body
translate([0,0,rheight])
cylinder(0.55*rheight,rwidth,0);

//Cone
cylinder(rheight,rwidth,rwidth);

//N Fin
for (i = [0:nfins-1])
{
	//Rotate the fin around the centre
	rotate([90,0,(360/nfins)*i])translate([rwidth,0,0])//Push it our radius
	{ 
		//Design each fin
		polygon(points=[[0,0],[0,rheight*0.4],[rheight*0.2,0]],paths=[[0,1,2]]);
	}

}