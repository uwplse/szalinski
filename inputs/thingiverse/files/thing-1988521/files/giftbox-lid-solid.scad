//These measurements work well on my machine for PETG at 100% scale and 101% flow and PLA at 104% scale and 99% flow.
cylinder_diameter=33.8;
cylinder_height=88;
cone_base=4;
cone_tip=1.25;
cone_height=2;
$fn=200;

difference(){
cylinder(d=cylinder_diameter,h=cylinder_height);
translate([0,cylinder_diameter/2,cylinder_height-cone_base/2-1.5])
rotate([90,0,0]){
cylinder(d1=cone_base,d2=cone_tip,h=cone_height);
}
}