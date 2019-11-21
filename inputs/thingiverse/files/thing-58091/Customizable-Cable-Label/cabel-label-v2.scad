//cable label
//http://www.thingiverse.com/thing:58091
//by allenZ
//v2, fixed short label issue
//NC-SA

include <write/Write.scad>

label = "Printer";
cable_diameter = 10;
//the thickness applys to snap ring and the label
thickness = 1.2;
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille]

label_orientation = 2; //[1:Horizontal,2:Vertical]

cable_radius = cable_diameter/2;
font_size = cable_diameter*0.8;

width = cable_diameter+thickness*2;
length = font_size*len(label)*.8+thickness*2;
snap_ring_width = width;

module labelfx() {
if (length < width) {
if (label_orientation == 1) translate ([0,-thickness,width/2]) rotate ([90,0,0])
label(width,width,thickness);
if (label_orientation == 2) translate ([0,-thickness,width/2]) rotate ([90,-90,0])
label(width,width,thickness);
} else {
if (label_orientation == 1) translate ([0,-thickness,width/2]) rotate ([90,0,0])
 label(length,width,thickness);
if (label_orientation == 2) translate ([0,-thickness,length/2]) rotate ([90,-90,0])
 label(length,width,thickness);
}
}

module label(l,w,t) {
union() {
translate ([0,0,t/2])
write(label,t=t, h=font_size, center = true, font = Font);
translate ([0,0,-t/2])
union () {
cube ([l,w,t],center=true);
translate ([0,w/2-t/2,t]) cube ([l,t,t],center=true);
translate ([0,-w/2+t/2,t]) cube ([l,t,t],center=true);
translate ([l/2-t/2,0,t]) cube ([t,w,t],center=true);
translate ([-l/2+t/2,0,t]) cube ([t,w,t],center=true);
}
}
}

module snapring() {
linear_extrude(height = snap_ring_width, center = true)
union () {
difference () {
union() {
circle (r=cable_radius+thickness);
translate ([-(cable_radius+thickness),0,0]) 
square ((cable_radius+thickness));
}

circle (r=cable_radius);
//cut openning
square (cable_radius*2);
}
//
translate ([cable_radius/2+thickness+cable_radius,0,0])
difference() {
circle (r=cable_radius/2+thickness);
circle (r=cable_radius/2);
translate ([0,-cable_radius,0]) square (cable_radius*2,center=true);
}
}
}


translate ([0,cable_radius,snap_ring_width/2])
rotate ([180,0,0])
snapring();
labelfx();
