// this is the x/y size of the tray
width_x = 90;
width_y = 60;

// the deepth of the tray and the fins
depth = 10;
depth_fins = 6;

//how many fins you want
count_fins = 15;

// how thick the walls/floor should be
wall_width = 0.8;

// the spacing for the fins is calculated
spacing = (width_x - (count_fins+2) * wall_width) / (count_fins+1);

module plantTray(){
    difference() {
        cube([width_x,width_y,depth]);
        translate([wall_width,wall_width,wall_width])
            cube([width_x-2*wall_width,width_y-2*wall_width,depth]);
    }
    for (i = [1:(width_x-2*wall_width)/(spacing+wall_width)]) {
        translate([i * (spacing+wall_width), 2*wall_width, 0]) 
            cube([wall_width, width_y-4*wall_width,depth_fins]);
    }
}
plantTray();