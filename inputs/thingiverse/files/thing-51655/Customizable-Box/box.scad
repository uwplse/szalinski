//inspired by following
//http://www.thingiverse.com/thing:9602
//customizable box
//http://www.thingiverse.com/thing:51655
//By allenZ

include <write/Write.scad>

//Message
message = "My Stuff";

Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

font_size = 8;//[6:20]


//Box Outside Measurement
box_width = 50;
box_depth = 40;
box_high = 40;

box_wall_thickness = 3;

translate ([box_width+10,0,0]) boxlid();

boxwithmessage();


module boxlid() {
translate ([0,0,box_wall_thickness/2])
union () {
cube([box_width,box_depth,box_wall_thickness],center=true);
translate ([0,0,box_wall_thickness/2])
difference () {
cube([box_width-box_wall_thickness*2,box_depth-box_wall_thickness*2,box_wall_thickness*2],center=true);
cube([box_width-box_wall_thickness*3,box_depth-box_wall_thickness*3,box_wall_thickness*2],center=true);
}
}
}

module boxwithmessage () {
translate ([0,0,box_high/2-box_wall_thickness/2])

difference () {
box();

translate ([0,-box_depth/2-1,0])
rotate ([90,0,0]) 
write(message,t=3, h=font_size, center = true, font = Font);
}
}


module box() {
difference() {
cube([box_width,box_depth,box_high-box_wall_thickness],center=true);
translate ([0,0,box_wall_thickness]) cube([box_width-2*box_wall_thickness,box_depth-2*box_wall_thickness,box_high-box_wall_thickness],center=true);
}
}

