///////////////////////////////////////////////////////////////////////////
// HOHOHO Tissue !!! A hexagon chain mail V3  
//
// Copyright (C) 2013  Lochner, Juergen
// Email: aabblapo@googlemail.com
// www.thingiverse.com/Ablapo
//
// Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0)
// http://creativecommons.org/licenses/by-nc/3.0/
//
// You are free: 
// 1. to Share - to copy, distribute and transmit the work
// 2. to Remix - to adapt the work
//
// Under the following conditions:
// 1. Attribution - You must attribute "HOHOHO Tissue !!! A hexagon chain mail V3" to Ablapo with link.
// 2. Noncommercial - You may not use this work for commercial purposes.
///////////////////////////////////////////////////////////////////////////
//
// Set your parameters:

// Choose object:
select_object=1;  // [1:Chain_mail, 2:Circle, 3:Single_element, 4:Bracelet, 5:Snowflake_coaster]

// Vertical gap:
v_gap=0.9;

// Horizontal gap:
h_gap=1.3;

// Vertical bridge thickness: 
vbt=1.3; 

// Horizontal bridge thickness: 
hbt=1.3 ;

// Corner's joint length: 
dy=1.25 ;		

// Number of stacked levels:
levels=2;

// Chain mail's number of x-elements (*2):
xel=5;

// Chain mail's number of y-elements (*4):
yel=3;

//
////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////
// Derived values for polyhedron
////////////////////////////////////////////////////////////////////////////
zdim=2*vbt+v_gap;						// Overall height of a layer
dx=hbt*2/sqrt(3);						// other corner's joint length  
ri=dy+dx+2*h_gap/sqrt(3)*2;			// Distance from center to inner edge:
pr = (3*ri+dx+dy)/2 ;					// position radius for centering bridges
ha=zdim/2;								// top level, used for polyhedron (+ha,-ha)
hb=zdim/2-vbt;							// sub level, used for polyhedron (+hb,-hb)
ra=ri+dx;									// outside radius
c3=cos(30); s3=sin(30);					// shortcuts save time & shorter code

////////////////////////////////////////////////////////////////////////////
// Values of the polyhedron's edges : 
// (a = ouside vertices, i = interior vertices, d = corner type)
////////////////////////////////////////////////////////////////////////////
a1x = 0; 			a1y = -ra;		i1x = 0; 			i1y = -ri;		d1=dx;
a2x = -ra*c3; 	a2y = -ra*s3;		i2x = -ri*c3; 	i2y = -ri*s3;		d2=dy;
a3x = -ra*c3;		a3y = ra*s3;		i3x = -ri*c3;		i3y = ri*s3;		d3=dx;
a4x = 0;			a4y = ra ;		i4x = 0;			i4y = ri ;		d4=dy;
a5x = ra*c3;		a5y = ra*s3;		i5x = ri*c3;		i5y = ri*s3;		d5=dx;
a6x = ra*c3;		a6y = -ra*s3;		i6x = ri*c3;		i6y = -ri*s3;		d6=dy;



////////////////////////////////////////////////////////////////////////////
// Module element
////////////////////////////////////////////////////////////////////////////
module element(){
rotate([0,0,30])
polyhedron(
  points=[ 

// -ha außen:
	[a1x+d1*c3,a1y+d1*s3,-ha], [a1x,a1y,-ha],	// 0,1	
	[a2x,a2y,-ha], [a2x,a2y+d2,-ha],				// 2,3	
	[a3x,a3y-d3,-ha], [a3x,a3y,-ha],				// 4,5
	[a4x,a4y,-ha], [a4x+d4*c3,a4y-d4*s3,-ha],	// 6,7
	[a5x-d5*c3,a5y+d5*s3,-ha], [a5x,a5y,-ha],	// 8,9
	[a6x,a6y,-ha], [a6x-d6*c3,a6y-d6*s3,-ha], 	// 10,11

// -ha innen:
	[i2x,i2y,-ha],[i2x,i2y+d2,-ha],				// 12,13
	[i4x,i4y,-ha],[i4x+d4*c3,i4y-d4*s3,-ha],	// 14,15
	[i6x,i6y,-ha],[i6x-d6*c3,i6y-d6*s3,-ha], 	// 16,17

// -hb außen:
	[a1x-d1*c3,a1y+d1*s3,-hb],[a2x+d2*c3,a2y-d2*s3,-hb],	// 18,19
	[a3x+d3*c3,a3y+d3*s3,-hb],[a4x-d4*c3,a4y-d4*s3,-hb],	// 20,21
	[a5x,a5y-d5,-hb] ,[a6x,a6y+d6,-hb] ,	 					// 22,23

// -hb innen:
	[i1x,i1y,-hb],[i2x+d2*c3,i2y-d2*s3,-hb],				// 24,25
	[i3x,i3y,-hb],[i4x-d4*c3,i4y-d4*s3,-hb],				// 26,27
	[i5x,i5y,-hb] ,[i6x,i6y+d6,-hb], 							// 28,29

// +hb außen:
	[a2x,a2y+d2, hb],[a3x,a3y-d3, hb],						// 30,31
	[a4x+d4*c3,a4y-d4*s3,hb], [a5x-d5*c3,a5y+d5*s3,hb],	// 32,33
	[a6x-d6*c3,a6y-d6*s3,hb], [a1x+d1*c3,a1y+d1*s3,hb],	// 34,35

// +hb innen:
	[i2x,i2y+d2,hb], [i3x,i3y,hb],				// 36,37
	[i4x+d4*c3,i4y-d4*s3,hb], [i5x,i5y,hb],		// 38,39
	[i6x-d6*c3,i6y-d6*s3,hb], [i1x,i1y,hb],		// 40,41

// +ha außen:
	[a1x,a1y, ha],[a1x-d1*c3,a1y+d1*s3, ha],	// 42,43
	[a2x+d2*c3,a2y-d2*s3, ha],[a2x,a2y, ha],	// 44,45
	[a3x,a3y, ha],[a3x+d3*c3,a3y+d3*s3, ha],	// 46,47
	[a4x-d4*c3,a4y-d4*s3, ha],[a4x,a4y, ha],	// 48,49
	[a5x,a5y, ha], [a5x,a5y-d5, ha],				// 50,51
	[a6x,a6y+d6,ha], [a6x,a6y, ha],				// 52,53

// +ha innen:
	[i2x+d2*c3,i2y-d2*s3, ha],[i2x,i2y, ha],	// 54,55
	[i4x-d4*c3,i4y-d4*s3, ha],[i4x,i4y, ha],	// 56,57
	[i6x,i6y+d6, ha] ,[i6x,i6y, ha] 				// 58,59

 ],                                
  triangles=[
// -ha horizontal:
	[0,2,1],[2,0,12],[3,2,12],[3,12,13],    [5,4,6],[6,4,14],[7,6,14],[7,14,15] ,
	[9,8,10],[10,8,16],[11,10,16],[16,17,11] ,

// +ha horizontal:
	[42,43,59],[42,59,53],[59,52,53],[52,59,58], [46,47,55],[55,45,46],[55,44,45],[44,55,54],   
	[50,51,57],[50,57,49],[49,57,48],[48,57,56], 

// -hb horizontal:
	[18,19,24],[19,25,24], 	[20,21,26],[26,21,27], 	[22,23,28],[23,29,28], 

// +hb horizontal:
	[31,30,36],[36,37,31],  [33,32,38],[38,39,33], [35,34,40],[40,41,35],

// +ha -hb vertical steps:
	[18,24,43],[24,41,43],[25,19,44], [25,44,54],
	[18+2,24+2,43+4],[24+2,41-4,43+4],[25+2,19+2,44+4], [25+2,44+4,54+2],
	[18+2+2,24+2+2,43+4+4],[24+2+2,41-2,43+4+4],[25+2+2,19+2+2,44+4+4], [25+2+2,44+4+4,54+2+2],

// -ha +hb vertical steps:
	[36,30,3],[13,36,3],[31,37,4], [4,37,26],
	[36+2,30+2,3+4],[13+2,36+2,3+4],[31+2,37+2,4+4], [4+4,37+2,26+2],
	[36+2+2,30+2+2,3+4+4],[13+2+2,36+2+2,3+4+4],[31+2+2,37+2+2,0], [0,37+2+2,24],

// inner vertical wall:
	[0,24,12],[12,24,25],[12,25,55], [54,55,25],[13,12,36],[12,55,36],[36,55,37],[37,55,47],
	[4,24+2,12+2],[12+2,24+2,25+2],[12+2,25+2,55+2], [54+2,55+2,25+2],[13+2,12+2,36+2],[12+2,55+2,36+2],[36+2,55+2,37+2],[37+2,55+2,47+4],
	[8,24+2+2,12+2+2],[12+2+2,24+2+2,25+2+2],[12+2+2,25+2+2,55+2+2], [54+2+2,55+2+2,25+2+2],[13+2+2,12+2+2,36+2+2],[12+2+2,55+2+2,36+2+2],[36+2+2,55+2+2,37+2+2],[37+2+2,55+2+2,47-4],

// außen vertical wall:
	[1,43,42],[1,18,43],[18,1,2], [2,19,18],[2,45,19],[19,45,44], 
	[2,3,45],[3 ,30,45],[31,45,30], [31,46,45],[46,31,4],[4,5,46], 
	[46,5,47],[47 ,5,20],[20,5,6], [6,21,20],[21,6,48],[48,6,49], 
	[6,7,49],[49 ,7,32],[33,49,32], [33,50,49],[50,33,8],[9,50,8], 
	[9,51,50],[22 ,51,9],[10,22,9], [10,23,22],[52,23,10],[52,10,53], 
	[53,10,11],[34 ,53,11],[34,42,53], [42,34,35],[ 35,0,42 ],[0,1,42], 
]                        
 );

}


////////////////////////////////////////////////////////////////////////////
// Module Stacked Elements
////////////////////////////////////////////////////////////////////////////
module stack(n=levels){
	for (i=[0:1:n-1]) translate([0,0,zdim*i]) mirror([0,0,1*(i%2)]) element();
}


////////////////////////////////////////////////////////////////////////////
// Module group of 4 elements, used as repeating pattern for meshes
////////////////////////////////////////////////////////////////////////////
module group(n=levels){					
	for (i=[0:1:3]) { rotate([0,0,i*60]) translate([0,pr,0]) rotate([0,0,120*i+30])stack(n); }
}


////////////////////////////////////////////////////////////////////////////
// Module group of 5 elements, used as repeating pattern for chains
////////////////////////////////////////////////////////////////////////////
module five(posi=1, anz=5){		// chain : opening position, number of elements =5
	rotate([0,0,60*posi]) for (i=[1:1:anz]) rotate([0,0,i*60]) translate([0,pr,0]) rotate([0,0,120*i+30])stack(); 
}


////////////////////////////////////////////////////////////////////////////
// Module circle: group of 6 elements
////////////////////////////////////////////////////////////////////////////
module kreis(){						
	for (i=[1:1:6]) { rotate([0,0,i*60]) translate([0,pr,0]) rotate([0,0,60*(i*2)+30])stack(); }
}


////////////////////////////////////////////////////////////////////////////
// Module chain mail, array with nElements=xel*2 * yel*4 
////////////////////////////////////////////////////////////////////////////
module cmail( ){    		
	for (yi=[0:1:yel-1]){ for (xi=[0:1:xel-1]){ translate([pr*sqrt(3)*xi,pr*3*yi,0])group();}};
}


////////////////////////////////////////////////////////////////////////////
// Module snowflake chain
////////////////////////////////////////////////////////////////////////////
module chain(){					
	for(ii=[0:1:5]) { rotate([0,0,30+60*ii])translate([pr*3,0,0])rotate([0,0,30])five();}
}

////////////////////////////////////////////////////////////////////////////
// Module snowflake mesh
////////////////////////////////////////////////////////////////////////////
module snowflake(){						
	kreis();
	for(ii=[0:1:5]) { rotate([0,0,30+60*ii])translate([pr*3,0,0])rotate([0,0,30])kreis();}
}

////////////////////////////////////////////////////////////////////////////
// Select object:
////////////////////////////////////////////////////////////////////////////

if (select_object==2) kreis();
if (select_object==1) cmail();	
if (select_object==3) stack();
if (select_object==4) chain();
if (select_object==5) snowflake();




																	

