//////////////////////////////////////////////////////////////////////////////////////////////
// Anti-warping block design, Octahedron Internal Structure V5
//
// Copyright (C) 2013  Lochner, Juergen
// http://www.thingiverse.com/Ablapo/designs
//
// This program is free software. It is 
// licensed under the Attribution - Creative Commons license.
// http://creativecommons.org/licenses/by/3.0/
//////////////////////////////////////////////////////////////////////////////////////////////
// dis=4/3*a+wall*2/sqrt(3);				// formula for element's distance in x,y,z axis
// min_distance = 4/3*a;					// if wall=0 -> no wall = min_distance (touching on edges).
// max_wallsize = sqrt(3)/3*a;			// if dis = 2*a -> ocathedron are (touching on corners).
// holes_diagonal = 2*a-dis = 2/3*a-2*wall/sqrt(3);
//

// Thickness of each element:		
dis=6;		// [1:40]

// Wall thickness of elements:		
wall=0.8;	//

// X-axis elements: 
x=2;		// [1:6]

// Y-axis elements:
y=20;		// [1:20]

// Z-axis elements:
zz=2;		// [1:10]

// Do you want a sticky bottom structure?  
add =0.5  ; // [0.5:yes, 0:no]


z=zz+add;
		
//dis=4/3*a+wall*2/sqrt(3);		// calculate distance of the shift by a given wall thickness and cut radius
a=3/4*(dis-wall*2/sqrt(3)); 		// calculate the outside radius a of the cut octahedrons

module octahedron(r=5){
	polyhedron(
	  points=[	[r,0,0],[0,-r,0],[-r,0,0],[0,r,0], 			// the four points at base
   		       	[0,0,r],[0,0,-r]   ],                   	// the two apex points 
	  triangles=[	[0,1,4],[1,2,4],[2,3,4],[3,0,4],          	// each triangle side
            		[5,1,0],[5,2,1],[5,3,2],[5,0,3],  ]        	// two triangles for square base
 	);
}

module pattern_rect(){						 
	translate([-round(x/2)*dis ,-round(y/2)*dis ,-round((z)/2)* dis   ])	// approximated center
	union()for (k=[0:1:z*2+1]) for (j=[0:1:y]) for (i=[0:1:x])
		translate([i*dis+(k%2)*dis/2, j*dis +dis/2*(k%2), k*dis/2 ]) 
			octahedron(r=a);
}

module oldversion(){
	difference(){
		cube([dis/2*(x*2),dis/2*(y*2),dis/2*(z*2 )],center=true);		// size the block
		pattern_rect(ratio=c);													// cut pattern
	}
}

module new(){	
	translate([-round((x-1 )/2)*dis ,-round((y-1)/2)*dis ,-round((zz-1)/2)* dis   ])	// approximated center		
	union(){
		for (k=[0:1:zz-1]) for (j=[0:1:y-1]) for (i=[0:1:x-1])
			translate([i*dis, j*dis, k*dis ]) 
				element();
	if (add==0.5)  for (j=[0:1:y-1]) for (i=[0:1:x-1]) translate([i*dis, j*dis, -dis ]) difference(){element(); translate([-dis ,-dis ,-dis/2-dis/4]) cube([2*dis,2*dis, dis]);}
	}
}



module element(){
	r=dis/2;						// half of element's width 
	od=(2*a-dis)/2;  			// half of holes diagonal
	wd=wall*sqrt(3);				// 3d diagonal length of wall thickness
	// now follows some polyhedron jigsaw :
	polyhedron(
	  points=[	[r,od,0],[r,-od,0],[r,0,od],[r,0,-od], 								// inside cuts x+
					[r,(od+wd),0],[r,-(od+wd),0],[r,0,od+wd],[r,0,-(od+wd)], 		// outside cuts x+
					[-r,od,0],[-r,-od,0],[-r,0,od],[-r,0,-od], 							// inside cuts x-
					[-r,(od+wd),0],[-r,-(od+wd),0],[-r,0,od+wd],[-r,0,-(od+wd)], 	// outside cuts x-

					[od,0,r],[-od,0,r],[0,od,r],[0,-od,r], 								// inside cuts z+
					[(od+wd),0,r],[-(od+wd),0,r],[0,(od+wd),r],[0,-(od+wd),r], 	 	// outside cuts z+			
					[od,0,-r],[-od,0,-r],[0,od,-r],[0,-od,-r], 							// inside cuts z-
					[(od+wd),0,-r],[-(od+wd),0,-r],[0,(od+wd),-r],[0,-(od+wd),-r], 	// outside cuts z-

					[od,r,0],[-od,r,0],[0,r,od],[0,r,-od], 								// inside cuts y+
   		       	[(od+wd),r,0],[-(od+wd),r,0],[0,r,(od+wd)],[0,r,-(od+wd)], 		// outside cuts y+
					[od,-r,0],[-od,-r,0],[0,-r,od],[0,-r,-od], 							// inside cuts y-
   		       	[(od+wd),-r,0],[-(od+wd),-r,0],[0,-r,(od+wd)],[0,-r,-(od+wd)], 	// outside cuts y-

				],                   	
	  triangles=[	
		// x:+r hole border
			[6,4,0],[0,2,6],[6,2,1],[1,5,6],          							  
       	[3,0,4],[4,7,3],[3,7,5],[5,1,3], 
 		// x:-r hole border  
			[0+8,4+8,6+8],[6+8,2+8,0+8],[1+8,2+8,6+8],[6+8,5+8,1+8],      
       	[4+8,0+8,3+8],[3+8,7+8,4+8],[5+8,7+8,3+8],[3+8,1+8,5+8], 
		// z:+r hole border  
			[6+2*8,4+2*8,0+2*8],[0+2*8,2+2*8,6+2*8],[6+2*8,2+2*8,1+2*8],[1+2*8,5+2*8,6+2*8],  
       	[3+2*8,0+2*8,4+2*8],[4+2*8,7+2*8,3+2*8],[3+2*8,7+2*8,5+2*8],[5+2*8,1+2*8,3+2*8], 
		// z:-r hole border  
			[0+3*8,4+3*8,6+3*8],[6+3*8,2+3*8,0+3*8],[1+3*8,2+3*8,6+3*8],[6+3*8,5+3*8,1+3*8],
			[4+3*8,0+3*8,3+3*8],[3+3*8,7+3*8,4+3*8],[5+3*8,7+3*8,3+3*8],[3+3*8,1+3*8,5+3*8], 
		// y:+r hole border
			[0+4*8,4+4*8,6+4*8],[6+4*8,2+4*8,0+4*8],[1+4*8,2+4*8,6+4*8],[6+4*8,5+4*8,1+4*8],
			[4+4*8,0+4*8,3+4*8],[3+4*8,7+4*8,4+4*8],[5+4*8,7+4*8,3+4*8],[3+4*8,1+4*8,5+4*8], 
		// y:-r hole border
			[6+5*8,4+5*8,0+5*8],[0+5*8,2+5*8,6+5*8],[6+5*8,2+5*8,1+5*8],[1+5*8,5+5*8,6+5*8],
       	[3+5*8,0+5*8,4+5*8],[4+5*8,7+5*8,3+5*8],[3+5*8,7+5*8,5+5*8],[5+5*8,1+5*8,3+5*8], 
		// inner surface
			[0,3,0+3*8],[0,0+3*8,2+3*8],[3,1,0+3*8],[1,3+3*8,0+3*8],  // ins  x+ > z-
			[2,0,0+2*8],[0,2+2*8,0+2*8],[1,2,0+2*8],[1,0+2*8,3+2*8],  // ins  x+ > z+

			[3+8,0+8,0+3*8+1],[0+8,2+3*8, 1+3*8],[1+8,3+8,1+3*8],[1+8,1+3*8,3+3*8],  // ins  x- > z-
			[0+8,2+8,1+2*8],[0+8,1+2*8,2+2*8],[2+8,1+8,1+2*8],[1+8,3+2*8,1+2*8],  // ins  x- > z+

			[0+4*8,0,2+3*8],[3+4*8,0+4*8,2+3*8],[1+4*8,3+4*8,2+3*8],[0+1*8,1+4*8,2+3*8], // ins -z
			[1+5*8,1+1*8,3+3*8],[1+5*8,3+3*8,3+5*8],[3+5*8,3+3*8,0+5*8],[3+3*8,1+0*8,0+5*8], // ins-z

			[0,0+4*8,2+2*8],[0+4*8,2+4*8,2+2*8],[2+4*8,1+4*8,2+2*8],[1+4*8,0+1*8,2+2*8], // ins +z
			[1+1*8,1+5*8,3+2*8],[3+2*8,1+5*8,2+5*8],[3+2*8,2+5*8,0+5*8],[1+0*8,3+2*8,0+5*8], // ins+z
		// outer surface
			[3+4,0+4,0+3*8+4],[0+3*8+4,0+4,2+3*8+4],[1+4,3+4,0+3*8+4],[3+3*8+4,1+4,0+3*8+4],  // out x+ > z-
			[0+4,2+4,0+2*8+4],[2+2*8+4,0+4,0+2*8+4],[2+4,1+4,0+2*8+4],[0+2*8+4,1+4,3+2*8+4],  // out x+ > z+

			[0+8+4,3+8+4,0+3*8+1+4],[2+3*8+4,0+8+4, 1+3*8+4],[3+8+4,1+8+4,1+3*8+4],[1+3*8+4,1+8+4,3+3*8+4],  // out  x- > z-
			[2+8+4,0+8+4,1+2*8+4],[1+2*8+4,0+8+4,2+2*8+4],[1+8+4,2+8+4,1+2*8+4],[3+2*8+4,1+8+4,1+2*8+4],  // out  x- > z+

			[0+4,0+4*8+4,2+3*8+4],[0+4*8+4,3+4*8+4,2+3*8+4],[3+4*8+4,1+4*8+4,2+3*8+4],[1+4*8+4,0+1*8+4,2+3*8+4], // out -z
			[1+1*8+4,1+5*8+4,3+3*8+4],[3+3*8+4,1+5*8+4,3+5*8+4],[3+3*8+4,3+5*8+4,0+5*8+4],[1+0*8+4,3+3*8+4,0+5*8+4], // out-z

			[0+4*8+4,0+4,2+2*8+4],[2+4*8+4,0+4*8+4,2+2*8+4],[1+4*8+4,2+4*8+4,2+2*8+4],[0+1*8+4,1+4*8+4,2+2*8+4], // out +z
			[1+5*8+4,1+1*8+4,3+2*8+4],[1+5*8+4,3+2*8+4,2+5*8+4],[2+5*8+4,3+2*8+4,0+5*8+4],[3+2*8+4,1+0*8+4,0+5*8+4], // out+z

 ]        	
 	);
}

new();
