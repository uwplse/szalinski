height=13.5;
motor=8.8;
wall_size=0.8;
bottom_thickness=0.6;
bottom_pod_padding=0.4;
bottom_pod_height=7;
slit=2.5;

n=0.1;

$fn=60;

difference() {
    union() {
        cylinder(d=motor+wall_size*2,h=height+bottom_thickness);
        cylinder(d=motor+wall_size*2+bottom_pod_padding*2,bottom_pod_height);
    }
    
    translate([0,0,bottom_thickness])
        cylinder(d=motor,h=height+n);
    translate([0,-slit*0.5,bottom_thickness])
        cube([10,slit,height+n]);
}