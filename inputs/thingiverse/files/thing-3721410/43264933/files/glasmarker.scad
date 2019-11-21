$fn=240;
glas_diameter=100;
glas_thickness=3.2;

width=15;
height=15;
thickness=1.5;
clamp=1.5;

winkel=width*360/3.141/(glas_diameter-thickness-glas_thickness);

difference() {
rotate_extrude(angle=winkel) translate([(glas_diameter-2*thickness-2*glas_thickness)/2,0]) square([2*thickness+glas_thickness,height+thickness]);

difference() {
cylinder(d1=glas_diameter-clamp/2,d2=glas_diameter,h=height);
cylinder(d1=glas_diameter+clamp/2-2*glas_thickness,d2=glas_diameter-2*glas_thickness,h=height);
}
}

translate([0,0,height/2]) rotate([0,0,winkel/2]) translate([glas_diameter/2+thickness-.3,0,0]) rotate([90,0,90]) linear_extrude(0.8) text("A", halign="center", valign="center");
