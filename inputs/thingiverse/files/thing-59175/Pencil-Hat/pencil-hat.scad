//pencil hat, could be used to attach to any round stuff needs mark
//by allenZ
//CC BY-NC-SA
//http://www.thingiverse.com/thing:59175

include <write/Write.scad>

//start of parameters
message_1 = "Live";
message_2 = "Laugh";
message_3 = "Love";
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille]

pencil_diameter = 8;

thickness =2;

corner_radius =2;

length = 4;

//End of parameters

module triangle (radius=1) {
polygon(points=[[radius/sin(30),0],[-radius,(radius/sin(30)+radius)/tan(60)],[-radius,-(radius/sin(30)+radius)/tan(60)]], paths=[[0,1,2]]);
}

module roundcorner(r,a) {
l=r/sin(a/2);
difference () {
polygon(points=[[0,0],[r*sin(a/2),r*cos(a/2)],[l,0],[r*sin(a/2),-r*cos(a/2)]], paths=[[0,1,2,3]]);
circle(r=r,$fn=100);
}
}

module label(label,t) {
translate ([p_radius+thickness,0,total_length/2])
rotate ([0,90,0])
translate ([0,0,t/2])
write(label,t=t, h=font_size, center = true, font = Font);
}

font_size = pencil_diameter;

total_length = max( (max (len(message_1),len(message_2),len(message_3))+1)*pencil_diameter*0.7, length);

p_radius = pencil_diameter/2;

rotate ([0,0,60])
label(message_1,t);
rotate ([0,0,180])
label(message_2,t);
rotate ([0,0,300])
label(message_3,t);

linear_extrude(height = total_length)
difference() {
triangle(p_radius+thickness);
for (i=[0:2]) {
rotate ([0,0,i*120])
translate ([(p_radius+thickness)/sin(30)-corner_radius/sin(30)+0.01,0,0]) roundcorner(corner_radius,60);
circle (p_radius,$fn=20);
}
}
