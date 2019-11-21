include <write/Write.scad>

text="KA";
//Object Width
width=9;
//Object Thickness
thick=1;
//Label Height
height=10;
//Your nozzle diameter
nozzle=0.4;
//# of perimeters
mult=2;
//Text Height
textH=5;
//Text vertical Offset
VOff=0;
//Font
font="write/Letters.dxf"; //["write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille,"write/knewave.dxf":knewave,"write/Letters.dxf":Default,"write/orbitron.dxf":Orbitron]

union(){
difference(){
	cube([width+2*mult*nozzle,thick+2*mult*nozzle,height]);
	translate([mult*nozzle,mult*nozzle,-1])
		cube([width,thick,height+2]);
}
translate([width/2+nozzle*mult,0,height/2+VOff])
rotate([90,0,0])
write(text,t=nozzle*2,h=textH, center=true, font=font);
}