//Ellipse Message Band
//by allenZ
//CC BY-SA
//http://www.thingiverse.com/thing:58706
//new version, fixed size issue

include <write/Write.scad>

message = "Live Laugh Love";
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille]
//measure of your wrist wideness
band_a = 60;
//measure of your wrist thickness
band_b = 45;
//band width you want
band_width = 20;
//band thickness you want
thickness = 4;

band_radius = band_width/2;
font_size = band_width*0.6;

scale ([1,band_b/band_a,1])
union () {
difference () {
rotate_extrude(center = true, $fn=72)
translate ([band_a/2+thickness/2,0,0]) scale ([thickness/band_width,1,1]) circle (r=band_radius);
translate ([0,band_a/2,0]) cube ([band_a/2,band_a/2,band_width+2],center=true);
}

writecylinder(message,[0,0,0],band_a/2+thickness,up=0.5,t=thickness/2,h=font_size,center = true,font = Font);
}


