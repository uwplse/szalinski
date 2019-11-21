use <write/Write.scad>


text="Foldarap #";


fontName="write/stencil.dxf"; //["write/Letters.dxf":Letters, "write/BlackRose.dxf":BlackRose, "write/orbitron.dxf":orbitron, "write/knewave.dxf":knewave, "write/braille.dxf":braille]

module NamePlate()
{
cube([140, 20, 4]);
}


difference()
{
NamePlate();
translate([20, 10, 0]) cylinder(r=2.8, h = 8);

NamePlate2();
translate([120, 10, 0]) cylinder(r=2.8, h = 8);
NamePlate3();
translate([70,10,2 +0])write(text, t=6, h=10,font=fontName, center=true);
}

