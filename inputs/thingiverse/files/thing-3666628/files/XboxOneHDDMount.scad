width = 80.1; // hdd width
thickness = 14.94; // hdd thickness

height = 10;  
wall = 3;
cutout = 7;
angle = 30;

rotate([90,angle,0]) {
    difference() {
        linear_extrude(thickness+2*wall,center=true) {
            polygon([
                [-width/2-wall,-sin(angle)*width/2],
                [-width/2-wall,-sin(angle)*width/2-height],
                [width/2+wall,sin(angle)*width/2],
                [width/2+wall,sin(angle)*width/2+height] 
            ]);
        }
        cube([width,1000,thickness],center=true);
        translate ([0,0,thickness/2]) {
            cube([width-2*cutout,1000,thickness-2*wall],center=true);
        }
        rotate([0,0,angle]) { 
            translate ([-width/4,0,-thickness/2-wall/2]) {
                cube([4,1000,1.5],center=true);
            }
            translate ([width/4,0,-thickness/2-wall/2]) {
                cube([4,1000,1.5],center=true);
            }
        }
    }
}