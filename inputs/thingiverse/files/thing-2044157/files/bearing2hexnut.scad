// Diameter of bearing hole you are filling (mm) - make it snug!
bearing_d = 22.1; 
// Height of bearing hole you are filling (mm)
bearing_h = 7;
// Diameter of hex nut side to side (not corners) - a 7/16-inch nut is about 17.5mm
hexnut_d = 17.5;   

module hexagon(width,height) {
    angle = 360/6;
    cot = width / tan(angle);
    echo(angle, 1/tan(angle), cot);
    union()
    {
        rotate([0,0,0])
            cube([width,cot,height],center=true);
        rotate([0,0,angle])
            cube([width,cot,height],center=true);
        rotate([0,0,2*angle])
            cube([width,cot,height],center=true);
    }
}

difference() {
    cylinder(r=bearing_d/2,h=bearing_h,center=true);
    hexagon(hexnut_d,bearing_h);
}
