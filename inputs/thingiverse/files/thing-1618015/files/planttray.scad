// this is the x/y size of the tray
width = 90;
// how deep the tray is
depth = 10;
//how far apart the "fins" should be
spacing = 6;
// how thick the walls/floor should be
wall_width = 2;
module plantTray(){
    difference() {
        cube([width,width,depth]);
        translate([wall_width,wall_width,wall_width])
            cube([width-2*wall_width,width-2*wall_width,depth]);
    }
    for (i = [1:(width-2*wall_width)/(spacing+wall_width)]) {
        translate([i * (spacing+wall_width), 2*wall_width, 0]) 
            cube([wall_width, width-4*wall_width,depth]);
    }
}
plantTray();