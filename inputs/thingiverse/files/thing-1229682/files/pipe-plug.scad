$fn=50;

plug_height=3;
plug_depth=12;
pipe_thickness=2;
pipe_side=40;
outer_rad=5;
inner_rad=1.5;
plug_walls=3;
lock_rad=5;
lock_protrusion=0.2;
lock_position=7;
chamfer=0.3;

hull() {
cylinder(r=outer_rad,h=plug_height);
translate([pipe_side-2*outer_rad,0,0]) cylinder(h=plug_height,r=outer_rad);
translate([pipe_side-2*outer_rad,pipe_side-2*outer_rad,0]) cylinder(h=plug_height,r=outer_rad);
translate([0,pipe_side-2*outer_rad,0]) cylinder(h=plug_height,r=outer_rad);
}

translate([0,0,plug_height]) 

difference() {

union() {
hull() {
cylinder(h=plug_depth-2,r=outer_rad-pipe_thickness);
translate([0,0,plug_depth-2]) cylinder(h=2,r1=outer_rad-pipe_thickness,r2=outer_rad-pipe_thickness-chamfer);

translate([pipe_side-2*outer_rad,0,0]) {
cylinder(h=plug_depth-2,r=outer_rad-pipe_thickness);
translate([0,0,plug_depth-2]) cylinder(h=2,r1=outer_rad-pipe_thickness,r2=outer_rad-pipe_thickness-chamfer);
}

translate([pipe_side-2*outer_rad,pipe_side-2*outer_rad,0]) {
cylinder(h=plug_depth-2,r=outer_rad-pipe_thickness);
translate([0,0,plug_depth-2]) cylinder(h=2,r1=outer_rad-pipe_thickness,r2=outer_rad-pipe_thickness-chamfer);
}

translate([0,pipe_side-2*outer_rad,0]) {
cylinder(h=plug_depth-2,r=outer_rad-pipe_thickness);
translate([0,0,plug_depth-2]) cylinder(h=2,r1=outer_rad-pipe_thickness,r2=outer_rad-pipe_thickness-chamfer);
}
}

translate([0,lock_rad-outer_rad+pipe_thickness-lock_protrusion,lock_position])
rotate([0,90,0])
cylinder(h=pipe_side-2*outer_rad,r=lock_rad);

translate([0,-lock_rad+pipe_side-outer_rad-pipe_thickness+lock_protrusion,lock_position])
rotate([0,90,0])
cylinder(h=pipe_side-2*outer_rad,r=lock_rad);

translate([lock_rad-outer_rad+pipe_thickness-lock_protrusion,0,lock_position])
rotate([0,90,90])
cylinder(h=pipe_side-2*outer_rad,r=lock_rad);

translate([-lock_rad+pipe_side-outer_rad-pipe_thickness+lock_protrusion,0,lock_position])
rotate([0,90,90])
cylinder(h=pipe_side-2*outer_rad,r=lock_rad);

translate([pipe_side-2*outer_rad,0,0])
rotate_extrude(convexity = 10, $fn = 100)
translate([outer_rad-pipe_thickness, lock_position, 0])
translate([-lock_rad+lock_protrusion,0,0])
difference() {
circle(r = lock_rad, $fn = 100);
translate([-lock_protrusion-0.5,0,0]) square(lock_rad*2,center=true);
}

translate([pipe_side-2*outer_rad,pipe_side-2*outer_rad,0])
rotate_extrude(convexity = 10, $fn = 100)
translate([outer_rad-pipe_thickness, lock_position, 0])
translate([-lock_rad+lock_protrusion,0,0])
difference() {
circle(r = lock_rad, $fn = 100);
translate([-lock_protrusion-0.5,0,0]) square(lock_rad*2,center=true);
}

translate([0,pipe_side-2*outer_rad,0])
rotate_extrude(convexity = 10, $fn = 100)
translate([outer_rad-pipe_thickness, lock_position, 0])
translate([-lock_rad+lock_protrusion,0,0])
difference() {
circle(r = lock_rad, $fn = 100);
translate([-lock_protrusion-0.5,0,0]) square(lock_rad*2,center=true);
}

rotate_extrude(convexity = 10, $fn = 100)
translate([outer_rad-pipe_thickness, lock_position, 0])
translate([-lock_rad+lock_protrusion,0,0])
difference() {
circle(r = lock_rad, $fn = 100);
translate([-lock_protrusion-0.5,0,0]) square(lock_rad*2,center=true);
}

}

hull() {
cylinder(h=plug_depth+100,r=inner_rad);
translate([pipe_side-2*outer_rad,0,0]) cylinder(h=plug_depth+100,r=inner_rad);
translate([pipe_side-2*outer_rad,pipe_side-2*outer_rad,0]) cylinder(h=plug_depth+100,r=inner_rad);
translate([0,pipe_side-2*outer_rad,0]) cylinder(h=plug_depth+100,r=inner_rad);
}

}