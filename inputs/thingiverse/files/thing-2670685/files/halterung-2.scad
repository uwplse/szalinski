$fn=30;
cable_diameter=6;
around_cable_thickness=5;
cable_pos=9;
screw_diameter=4;
around_screw_thickness=3;
screw_pos=4;
height=10;

difference() {
hull() 
    {
        translate([screw_pos,screw_pos,0]) cylinder(d=around_screw_thickness+screw_diameter,h=height);
        translate([cable_pos,cable_pos,0]) cylinder(d=cable_diameter+around_cable_thickness,h=height);
    }
union() {
translate([0,0,-2])
{
translate([screw_pos,screw_pos,0]) cylinder(d=screw_diameter,h=height*2);
    
translate([cable_pos,cable_pos,0]) cylinder(d=cable_diameter,h=height*2);
    
}
translate([cable_pos,cable_pos,cable_diameter/2]) rotate([0,90,45]) {
    cylinder(d=cable_diameter,h=2*height);
    translate([cable_diameter/2,0,cable_diameter/2]) cube([cable_diameter,cable_diameter,cable_diameter],center=true);
    translate([-cable_diameter/2,0,0]) rotate([0,45,0])
        cylinder(d=cable_diameter,h=2*cable_diameter);
    
}
}
}