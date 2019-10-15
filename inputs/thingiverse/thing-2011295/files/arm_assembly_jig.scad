/* [Eyelet dimensions] */

// thckness of jig walls
wall_t=3;

// insert internal diameter
eye_insert_id=3;

// insert outer diameter for spacer sizing
eye_insert_od=6.5;

// eyelet outer diameter for spacer sizing
eye_od=12;

// width of the insert
eye_insert_w=5.8;

// width of the outer shell
eye_outer_w=4.25;

// length from tip of threaded part to center of mounting hole
eye_l=45;

// length of the threaded part
eye_thread_l=17;

/* [Diagonal rod size] */

// outer diameter
rod_od=5;

// length
rod_l=310;

/* [Diagonal total length] */

// space between centers of bolt holes on either end of rod
eye_space=325;

/* [Hidden] */

$fn=60;

// diameter of screws to be used
screw_d=3;

screw_l=2*eye_insert_w+2*wall_t;

extrusion_w=20;

mount_screw_d=5;
mount_screw_head_d=7;
mount_screw_head_h=4;

assembly_offset=wall_t+mount_screw_head_h+rod_od;
rod_support_w=2*eye_insert_w+2*wall_t;

spacer_w=eye_insert_w-eye_outer_w;

module spacer(){
    translate([1.25*eye_od,0,spacer_w/2]) difference(){
        cylinder(d=eye_od,h=spacer_w,center=true);
        cylinder(d=eye_insert_od+1,h=spacer_w+0.1,center=true);
    }
}

//!eye_support();
module eye_support(){
    translate([0,0,assembly_offset/2])difference(){
        union(){
            translate([-eye_l/2,0,0])cube([eye_l,rod_support_w,assembly_offset],center=true);
            cube([eye_od,rod_support_w,assembly_offset],center=true);
            translate([0,0,assembly_offset/2])rotate([90,0,0])cylinder(d=eye_od,h=rod_support_w,center=true);
        }
        // rod cradle
        for (m=[0,1])mirror([0,m,0])translate([-eye_l,eye_insert_w/2,assembly_offset/2])rotate([0,90,0])cylinder(d=rod_od+0.25,h=eye_l,center=true);
        // eye cutout
        translate([0,0,eye_od/2+wall_t])difference(){
            cube([eye_l+2,2*eye_insert_w+0.25,assembly_offset+eye_od],center=true);
            cube([eye_od,2*eye_insert_w+1,assembly_offset+eye_od+1],center=true);
        }
        translate([0,0,eye_od/2+wall_t])cube([eye_od*2,2*eye_outer_w+0.25,assembly_offset+eye_od],center=true);
        translate([0,0,eye_od/2+wall_t])cube([eye_insert_od,2*eye_insert_w+0.25,assembly_offset+eye_od],center=true);
        // alignment_notch
        translate([0,0,assembly_offset/2+1.15*eye_od])rotate([0,45,0])cube([eye_od,rod_support_w+1,eye_od],center=true);
        // screw_hole
        translate([0,0,assembly_offset/2])rotate([90,0,0])cylinder(d=eye_insert_id,h=rod_support_w+1,center=true);
        // mount screws
        translate([-(eye_l-mount_screw_head_d/2),0,0]){
            cylinder(d=mount_screw_d,h=assembly_offset+2,center=true);
            translate([0,0,wall_t])cylinder(d=mount_screw_head_d,h=assembly_offset,center=true);
            translate([0,0,wall_t])cube([mount_screw_head_d+2,2*eye_insert_w+0.25,assembly_offset],center=true);
        }
        translate([(eye_od-mount_screw_head_d)/2,0,0]){
            cylinder(d=mount_screw_d,h=assembly_offset+2,center=true);
            translate([0,0,wall_t])cylinder(d=mount_screw_head_d,h=assembly_offset,center=true);
        }
    }
}

eye_support();
spacer();
