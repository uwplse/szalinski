
name = "BKNJ";
typeStyle = "write/Letters.dxf"; //["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic, "write/BlackRose.dxf":Fancy, "write/knewave.dxf":Italic,"write/braille.dxf":Braille]
typeSize = 12; //[8:70]
typeDepth = 3; //[1:10]
boxWidth = 100; //[20:200]
boxHeight = 25; //[20:100]
boxDepth = 20; //[20:100]
wallThickness = 2; //[1:10]


use <write/Write.scad>

difference()
{
cube([boxWidth, boxDepth, boxHeight]);
translate([wallThickness, wallThickness, wallThickness])
{
cube([boxWidth-wallThickness*2, boxDepth-wallThickness*2, boxHeight]);
}
}

translate([boxWidth/2,0,boxHeight/2])
rotate(90,[1,0,0]) // rotate around the x axis 
write(name,t=typeDepth,h=typeSize,font=typeStyle, center=true);
