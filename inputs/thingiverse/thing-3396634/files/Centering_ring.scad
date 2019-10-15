ring_inner_diameter = 13;
ring_outer_diameter = 18;
ring_thickness = 1;

difference(){
    cylinder(h=ring_thickness,r=ring_outer_diameter,center=true);
    cylinder(h=ring_thickness+2,r=ring_inner_diameter,center=true);
}