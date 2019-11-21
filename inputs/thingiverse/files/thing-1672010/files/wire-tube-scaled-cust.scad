//WIRE LOOM by Spicer
//Customizer version
//Default length is 120mm about 4 3/4 inches half of what was set to print on my 2016 Creator Pro diagonally
//Default width/height is very small at 4mm 3 sided cylinder
//but that is why the options to scale the length, width, and height.
/* [Global] */
/*Customizer variables begin */

/* [LENGTH IN MM ]  "(size approximate)" */
// 180mm default length increased to a max of 480mm (how are ever going to print that?
 length = 1;//[1:120mm,1.5:180mm,2:240mm,3:360mm,4:480mm]
/* [BASE WIDTH IN MM]   "(size approximate)" */ 
//Large values are slow to calculate, be patient! 
 width = 1;//[1:≈4mm,2:≈8mm,3:≈12mm,4:≈16mm,5:≈20mm,6:≈24mm]
/* [BASE TO PEAK HEIGHT IN MM]   "(size approximate)" */
//Large values are slow to calculate, be patient! 
 height = 1;//[1:≈4mm,2:≈8mm,3:≈12mm,4:≈16mm,5:≈20mm,6:≈24mm]
 
// Customizer variables end
 
 rotate([180, 0, 0]) {
 M = [ [ length, 0, 0, 0 ],
       [ 0, width, 0, 0 ],  
       [ 0, 0, height, 0 ],
       [ 0, 0, 0, 1 ] ] ;
 multmatrix(M) {
translate ([0, 0, -2]){	
difference() {

//create triangle and make it hollow	
rotate([0,90,0]) cylinder (120, 4, 4, $fn=3);
translate ([-0.5, 0, 0]) rotate([0,90,0]) cylinder (120.5, 2.75, 2.75, $fn=3);
	
//saw tooth the top to allow wire insert
for(sr = [1.725:8:120])  //slot right
translate ([sr-2, -3,-4]) cube ([4.95, 3, 2]);

for(sl = [5.725:8:120])  //slot left
translate ([sl-2, 0,-4]) cube ([4.95, 3, 2]);

//place holes in bottom for screws
for(cr = [1.75:4:120])  //circle 
translate([cr,0,.5])  cylinder($fn = 15, h=2, r1=1.25/length, r2=.5/length);

// place holes in sides for wire exits
for(hr = [1.75:8:118])  //slot right
translate ([hr, -3,-1]) rotate ([-45,0,0]) cylinder ($fn = 12, h=2.25, r=1);

for(hl = [5.75:8:118])  //slot left
translate ([hl, 3,-1]) rotate ([45,0,0]) cylinder ($fn = 12, h=2.25, r=1);
}
}
}
}