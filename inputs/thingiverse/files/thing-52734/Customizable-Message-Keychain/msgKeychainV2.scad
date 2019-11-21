//Message Keychain
//http://www.thingiverse.com/thing:52734
//By allenZ
//v2 allow adjustment by user to avoid unconnected parts

include <write/Write.scad>

//Message
message = "allenZ";

Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille]

font_size = 10;

font_thickness = 5;

stick_thickness = 3;

stick_width = 8;

hole_radius = 3;

flat_bottom = 2; //[1:Yes,2:No]


translate ([0,0,font_thickness/2])

union () {
write(message,t=font_thickness, h=font_size, center = true, font = Font);
if (flat_bottom == 1) translate ([0,0,-font_thickness/2+stick_thickness/2]) flatstickwithhole();

if (flat_bottom == 2) flatstickwithhole();

}

module flatstickwithhole() {
difference () {

union () {

translate ([-2,0,0]) cube ([font_size*len(message)/1.3, stick_width, stick_thickness],center=true);

translate ([-2,0,0]) translate ([-font_size*len(message)/2.6,0,0]) cylinder (r=stick_width/2,h=stick_thickness,center=true,$fn=50);
}

translate ([-2,0,0]) translate ([-font_size*len(message)/2.6,0,0]) cylinder (r=hole_radius,h=stick_thickness+2,center=true,$fn=50);
}
}