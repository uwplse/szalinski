adapter_fanmount_length=65; //Overall length of the piece that attaches to the Wanhao i3 (or clone) fan mount.
adapter_fanmount_width=10;  //Width of fan mount
adapter_fanmount_depth=4;  //Thickness of the fan mount
adapter_fanmount_hole_length=20;  //Length of the two holes for the fan mount.  Making it longer allows for adjustability.
adapter_fanmount_hole_width=4;  //Width of the fan mount holes.
probe_mount_diameter_inner=20; //Probe diameter + 1-2mm
probe_mount_diameter_outer=35; //Outside dimeter of the piece the probe mounts to.
probe_depth=4;  //Thickness of the probe mount.
adapter_probe_overlap=5; //The overlap between the fan mount side and the probe mount side.
adapter_probe_offset=0; //The vertical offset between the fan mount and probe mount.  Allows for the probe to mount higher or lower than the fan mount.
$fn=50;

adapter();

module adapter() {
union() {
    fanmount();
    translate([adapter_fanmount_length+probe_mount_diameter_outer/2-adapter_probe_overlap,adapter_fanmount_width/2,adapter_probe_offset])
    probemount();
    translate([adapter_fanmount_length-adapter_probe_overlap,0,0])
    cube([adapter_probe_overlap,adapter_fanmount_width,adapter_fanmount_depth+adapter_probe_offset]);
}
}

module probemount() {
difference() {
cylinder(d=probe_mount_diameter_outer,h=probe_depth);
translate([0,0,-0.1])
cylinder(d=probe_mount_diameter_inner,h=probe_depth+0.2);
}
}

module fanmount() {
difference() {
cube([adapter_fanmount_length,adapter_fanmount_width,adapter_fanmount_depth]);
translate([adapter_fanmount_length/3-adapter_fanmount_hole_width,adapter_fanmount_width/2,-0.1])
fanmount_holes();
translate([adapter_fanmount_length*2/3+adapter_fanmount_hole_width,adapter_fanmount_width/2,-0.1])
fanmount_holes();
}
}

module fanmount_holes() {
translate([-(adapter_fanmount_hole_length-adapter_fanmount_hole_width)/2,0,0]) {
cylinder(d=adapter_fanmount_hole_width,h=adapter_fanmount_depth+0.2);
translate([adapter_fanmount_hole_length-adapter_fanmount_hole_width,0,0])
cylinder(d=adapter_fanmount_hole_width,h=adapter_fanmount_depth+0.2);
translate([0,-adapter_fanmount_hole_width/2,0])
cube([adapter_fanmount_hole_length-adapter_fanmount_hole_width,adapter_fanmount_hole_width,adapter_fanmount_depth+0.2]);
}
}