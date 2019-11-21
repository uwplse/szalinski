$fn=32*1;
inch=25.4*1;

/*
 * cat toy v2, Tyler.Bletsch@gmail.com
 * 
 * variable abbreviations: id=inner diameter, od=outer diameter
 */

// Sphere outer diameter (mm)
sphere_od=40; // [15:100]

// Thickness of the sphere wall (mm)
wall=1;       // [1:5]

// Inner diameter of the holes (mm)
hole_dia = 15; // [5:80]

// Thickness of the lip around each hole (mm)
lip_thickness=5; // [1:20]

// Apply sane limits to inputs
max_hole_id = sphere_od*0.6;
max_hole_od = sphere_od*0.7;
hole_id = min(hole_dia,max_hole_id);
hole_od = min(hole_id + lip_thickness, max_hole_od);

sphere_id=sphere_od-wall*2; 

// some pythagorean theorem to find cylinder sizes

// "outer height" of the rim -- in terms of the length of a cylinder to create it
rim_oh = sqrt(pow(sphere_id/2,2)-pow(hole_od/2,2));
// "inner height" of the rim -- in terms of the length of a cylinder to subtrace out
rim_ih = sqrt(pow(sphere_od/2,2)-pow(hole_id/2,2));

// sphere with holes
difference() {
    sphere(d=sphere_od,$fn=4*$fn);
    sphere(d=sphere_id);
    for_each_rot() cylinder(d=hole_id, h=sphere_od+1, center=true);
}

// hole rims
for_each_rot() difference() {
    cylinder(d=hole_od, h=rim_ih*2, center=true); // rim body
    cylinder(d=hole_od+1, h=rim_oh*2, center=true); // cut off inside on height axis
    cylinder(d=hole_id, h=sphere_od+1, center=true); // cut off inside on radial axis
}


module for_each_rot() {
    rotate([ 0, 0, 0]) children();
    rotate([90, 0, 0]) children();
    rotate([ 0,90, 0]) children();
}

