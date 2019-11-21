height = 50;
base_width = 30;
top_width = 5;
base_height = 2;
wall_thickness = 1;

difference() {
    union() {
        intersection() {
            translate([-base_width/2,-base_width/2,0]) cube([base_width,base_width,base_height]);
            cylinder(r=0.6*base_width,h=base_height);
        }
        cylinder(r1=base_width/2-2*wall_thickness, r2=top_width/2, h=height);
    }
    cylinder(r1=base_width/2-3*wall_thickness, r2=top_width/2-wall_thickness, h=height);
}