//WIRE LOOM SQUARE by Spicer
//Customizer version
//Default length is 120mm about 4 3/4 inches half of what was set to print on my 2016 Creator Pro diagonally
//Default width/height is very small at 5mm lid to fit the matching box.
//but that is why the options to scale the length, width, and height.
/* [Global] */
/*Customizer variables begin */

/* [LENGTH IN MM ]  "(size approximate)" */
// 180mm default length increased to a max of 480mm (how are ever going to print that?
 length = 1;//[1:120mm,1.5:180mm,2:240mm,3:360mm,4:480mm]
/* [WIDTH and HEIGHT IN MM]   "(size approximate)" */  
 width = 2;//[1:≈4mm,2:≈8mm,3:≈12mm,4:≈16mm]
 
// Customizer variables end
 
height = width;
 M = [ [ length, 0, 0, 0 ],
       [ 0, width, 0, 0 ],  
       [ 0, 0, height, 0 ],
       [ 0, 0, 0, 1 ] ] ;
 multmatrix(M) {
translate ([0, 5.65, 5.65])  rotate ([180, 0, 0]) {  //flip and adjust
difference() {	
	translate ([0.1,-1.125, 2.65]) cube ([119.8, 6.75, 2.9-height/6]);  //cap start to subtract bottom from, the rest is cut away
union () {  //add the shoulder to main box	
	cube ([120, 4.5, 4.5]);  // main box
	translate ([-0.1, -0.25, 3.5+0.15/height])
	minkowski() {cube ([120, 5.03, 0.38/height]); 
		rotate ([0, 90, 0]) cylinder($fn=6, r=0.4, h=1); } // top lip shoulder
		}
translate ([-0.5, 0.5, 0.5])  
	cube ([122, 3.5, 4]);
}
}
}