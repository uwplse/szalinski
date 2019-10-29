// thickness of braces
bracethick=4;  
// width of clamp
width=25;  
// length of clamp
length=43;  
// clamp thickness
clampthick=6;  
// offset of hole from edge
holeoffset=10;  
// radius of hole
holeradius=3.25; 
// hole #2 offset (-1 for no hole)
hole2offset=8; 
// radius of hole 2
hole2radius=3.25; 

$fn=50-0;  // round holes please

bracesize=width;  // brace width and height


module brace() {
    rotate([90,0,-90,])difference() {
        cube([bracesize,bracesize,bracethick]);
    rotate([0,0,45])
        translate([0,0,-1]) cube([2*bracesize,2*bracesize,bracethick*2]);
    }
}



difference() {
union() {
     cube([width,length,clampthick]);
    rotate([90,0,0])
      cube([width,width,clampthick]);
    translate([width,bracesize,0]) brace();
    translate([bracethick,bracesize,0])
    brace();   
   }
translate([width/2,
   length-holeoffset,-1])  
   cylinder(r=holeradius,h=clampthick*10);
    if (hole2offset>=0)
    {
        translate([width/2,1,width-hole2offset])
rotate ([90,0,0]) 
        
        cylinder(r=hole2radius,h=clampthick*10);
    }
}