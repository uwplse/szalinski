/**
 * Glass Inner bottom (Ikea glass)
 * @Author Wilfried Loche
 * @Created Jan 27, 2017
 */

/* Plater size */
width = 80;
depth = 51;
thickness = 1.8;
borderHeight = 4;



cube(size=[width, depth, thickness], center=true);

translate([0, (depth-thickness)/2, thickness])
    cube(size=[width, thickness, borderHeight], center=true);
translate([0, -(depth-thickness)/2, thickness])
    cube(size=[width, thickness, borderHeight], center=true);

translate([(width-thickness)/2, 0, thickness])
    cube(size=[thickness, depth, borderHeight], center=true);
translate([-(width-thickness)/2, 0, thickness])
    cube(size=[thickness, depth, borderHeight], center=true);
