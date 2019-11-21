
$fa=1;
$fs=1;

/*
slice with no top/bottom, infill that beads won't fall through
in Cura set Infill Line Distance just under bead minimum size plus line width (.4)
and choose an Infill Pattern of Grid or Triangles (nothing 3D)
Connect Infill Lines and Alternate Extra Wall probably hold the grid in better
*/

tray_depth=14.5;
core_diameter=39.2;
tray_diameter=225.5;

wall_thickness=2.4;
floor_thickness=.2+6*.32;

slop=.5;

overall_height=tray_depth-slop;
overall_diameter=tray_diameter-2*slop;
core_hole_diameter=core_diameter+2*slop;

// outer wall
difference() {
    cylinder(d=overall_diameter,h=overall_height);
    cylinder(d=overall_diameter-2*wall_thickness,h=overall_height);
}
// floor and inner wall
difference() {
    union() {
        cylinder(d=core_hole_diameter+2*wall_thickness,h=overall_height);
        cylinder(d=overall_diameter,h=floor_thickness);
    }
    cylinder(d=core_hole_diameter,h=overall_height);
}
