//WIRE LOOM SQUARE by Spicer
//Customizer version
//Default length is 120mm about 4 3/4 inches half of what was set to print on my 2016 Creator Pro diagonally
//Default width/height is very small at 4mm two sided box
//but that is why the options to scale the length, width, and height.
/* [Global] */
/*Customizer variables begin */

/* [LENGTH IN MM ]  "(size approximate)" */
// 180mm default length increased to a max of 480mm (how are ever going to print that?
 length = 1;//[1:120mm,1.5:180mm,2:240mm,3:360mm,4:480mm]
/* [WIDTH / HEIGHT IN MM]   "(size approximate)" */  
 width = 2;//[1:≈4mm,2:≈8mm,3:≈12mm,4:≈16mm]

 
// Customizer variables end
 height = width;
 hol = (width + length / 2);
 
 
 
 M = [ [ length, 0, 0, 0 ],
       [ 0, width, 0, 0 ],  
       [ 0, 0, height, 0 ],
       [ 0, 0, 0, 1 ] ] ;
 
 multmatrix(M) {
difference() {	 
{	//create box and make it hollow
difference() {	
union () {  //add the shoulder to main box
	cube ([120, 4.75, 4.75]);  // main box
	translate ([0, -0.125, 3.75+0.35/height])
	minkowski() {cube ([120, 5, 0.35/height]); rotate ([0, 90, 0]) cylinder($fn=6, r=0.4, h=1); } // top lip shoulder
	}
translate ([-0.5, 0.625, 0.625]) 
	cube ([122, 3.5, 5.5]);
	
//saw tooth the sides to allow wire insert
for(sr = [2:6:120])  //slot right
translate ([sr, -0.75, 1]) cube ([1.5, 2, 4.5]);

for(sl = [2:6:120])  //slot left
translate ([sl, 3.25, 1]) cube ([1.5, 2, 4.5]);
}
//place holes in bottom for screws

for(cr = [1.75:4:120])  //circle 
translate([cr,2.25,-1])  cylinder($fn = 15, h=3, r1=0.625/hol, r2=1.25/hol);
}
}

}