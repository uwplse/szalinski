// Original - 0.4
hook_clearence=0.3;

brace_wall=4;
brace_angle=0; // [-60:60]
profile_position = "vertical"; // [vertical,horizontal]
profile_type = "2020"; // [2020,3030]
profile_stud_depth=2;
profile_clearence=0.0;
profile_nut_clearence=0.3;

screw_dia = 3;
screw_head = "flat"; // [flat,round]
// Screw head diameter, 0 for auto
screw_head_dia = 0;
// Round head screw head height, 0 for auto
round_head_screw_head_height = 0;
screw_length=8;
screw_min_wall = 2;
screw_clearence=0.2;

$chamfer=0.6;

/* [Hidden] */

// Filler holder hook measurements
hook_width=26;
hook_neck_width=20;
hook_thickness=4;
hook_height=24+26/2;
hook_wall_clearence=4;


$fn=32;

module reflect(v) {
    children();
    mirror(v)
        children();
}

module chamfered_cube(size=10,chamfer=999999,center=false)
{
    sz = size[0]?size:[size,size,size];
    chamfer = chamfer!=999999?chamfer:($chamfer?$chamfer:0);
    translate(center?[0:0:0]:sz/2) {
        hull() {
            cube([sz.x,sz.y-2*chamfer,sz.z-2*chamfer],center=true);
            cube([sz.x-2*chamfer,sz.y-2*chamfer,sz.z],center=true);
            cube([sz.x-2*chamfer,sz.y,sz.z-2*chamfer],center=true);
        }
    }
}

module screw_hole_flathead(thickness,screw_dia,cap_dia,deep)
{
    translate([0,0,-1])
        cylinder(d=screw_dia,h=thickness+2);
    translate([0,0,deep])
        cylinder(d1=screw_dia,d2=cap_dia,h=(cap_dia-screw_dia)/2);
    translate([0,0,deep+(cap_dia-screw_dia)/2-0.001])
        cylinder(d=cap_dia,h=thickness-deep-(cap_dia-screw_dia)/2+0.001+1);
}

module brace(
    profile_type=profile_type,
    brace_angle=brace_angle,
    profile_position=profile_position,
    screw_dia=screw_dia)
{
    profile_size = profile_type == "2020" ? 20 : 30;
    profile_slot_width = profile_type == "2020" ? 6 : 8;
    profile_slot_depth = profile_type == "2020" ? 6 : 9;
    // T-Nut width
    profile_nut_width = profile_type == "2020" ? 10 : 16;
    min_base_width = 20;
    min_stud_length = 3;

    // Head height of a round head screw, usually equal to the thread diameter
    _round_head_screw_head_height = round_head_screw_head_height ?
        round_head_screw_head_height :
        screw_dia;
    // Screw head diameter, usually a bit less than twice the thread diameter
    _screw_head_dia = screw_head_dia ?
        screw_head_dia :
        2 * screw_dia;
    round_head_screw_wall = max(screw_min_wall,screw_length - profile_slot_depth + 0.5);
    flat_head_screw_head_height=(_screw_head_dia-screw_dia)/2+0.5;
    flat_head_screw_wall = max(screw_min_wall+flat_head_screw_head_height/2,flat_head_screw_head_height,screw_length-profile_slot_depth+0.5);
    back_wall = screw_head=="round" ?
        max(brace_wall,_round_head_screw_head_height+round_head_screw_wall) :
        max(brace_wall,flat_head_screw_wall);

    hook_wall=hook_wall_clearence-hook_clearence;
    _brace_angle=abs(brace_angle);
    vertical=profile_position=="vertical"?1:0;
    screw_vpos = vertical ?
        hook_clearence+hook_height-screw_dia-2*screw_clearence :
        brace_wall+hook_clearence+hook_height-profile_size/2;

    mirror([brace_angle<0?1:0,0,0]) rotate(180) difference() {
        xcenter=hook_width/2+hook_clearence+brace_wall;
        xtrans=2*xcenter*(1-cos(_brace_angle));
        basewidth=brace_angle==0 ?
            hook_width+2*hook_clearence+2*brace_wall :
            vertical ?
                min_base_width :
                max(profile_nut_width+2*min_stud_length,min_base_width);

        union() {
            translate([xtrans,back_wall-brace_wall,0])
                rotate(_brace_angle)
                    chamfered_cube([hook_width+2*hook_clearence+2*brace_wall,brace_wall+2*hook_clearence+hook_thickness+hook_wall,brace_wall+hook_clearence+hook_height]);
            hull() {
                translate([xtrans,back_wall-brace_wall,0])
                    rotate(_brace_angle)
                        chamfered_cube([hook_width+2*hook_clearence+2*brace_wall,2*$chamfer+0.001,brace_wall+hook_clearence+hook_height]);
                translate([xcenter-basewidth/2,0,0])
                    chamfered_cube([basewidth,2*$chamfer+0.001,brace_wall+hook_clearence+hook_height]);
            }
            hull() {
                translate([xtrans,back_wall-brace_wall,0])
                    rotate(_brace_angle)
                        translate([0,brace_wall+2*hook_clearence+hook_thickness+hook_wall-2*$chamfer,0])
                            chamfered_cube([hook_width+2*hook_clearence+2*brace_wall,2*$chamfer+0.001,brace_wall+hook_clearence+hook_height]);
                translate([xcenter-basewidth/2,0,0])
                    chamfered_cube([basewidth,2*$chamfer+0.001,brace_wall+hook_clearence+hook_height]);
            }

            // Profile studs
            if (vertical) {
                profile_stud_height=screw_vpos-profile_nut_width/2-profile_nut_clearence;
                translate([xcenter-profile_slot_width/2+profile_clearence,-profile_stud_depth,0])
                    chamfered_cube([profile_slot_width-2*profile_clearence,profile_stud_depth+2*$chamfer,profile_stud_height]);
            } else {
                translate([xcenter,0,0])
                    reflect([1,0,0])
                        translate([-basewidth/2,-profile_stud_depth,screw_vpos-(profile_slot_width-2*profile_clearence)/2])
                            chamfered_cube([(basewidth-profile_nut_width)/2-profile_nut_clearence,profile_stud_depth+2*$chamfer,profile_slot_width-2*profile_clearence]);
            }
        }

        translate([xtrans,back_wall-brace_wall,0]) {
            rotate(_brace_angle) {
                translate([brace_wall,brace_wall,brace_wall]) {
                    translate([hook_width/2+hook_clearence,0,hook_width/2])
                        rotate([-90,0,0])
                            cylinder(d=hook_width+2*hook_clearence,h=hook_thickness+2*hook_clearence);
                    translate([0,0,hook_width/2])
                        cube([hook_width+2*hook_clearence,hook_thickness+2*hook_clearence,hook_height-hook_width/2+1]);
                }

                translate([brace_wall+(hook_width-hook_neck_width)/2,brace_wall+2*hook_clearence+hook_thickness-1,brace_wall+hook_width/2])
                    cube([hook_neck_width+2*hook_clearence,hook_wall+2,hook_height-hook_width/2+hook_clearence+1]);
            }
        }

        // Screw hole
        if (screw_head == "round") {
            translate([xcenter,0,screw_vpos]) {
                rotate([-90,0,0]) {
                    translate([0,0,-1])
                        cylinder(d=screw_dia+2*screw_clearence,h=(back_wall+hook_thickness+2*hook_clearence+hook_wall)*cos(_brace_angle)+(2*brace_wall+hook_width+2*hook_clearence)*sin(_brace_angle)+1);
                    translate([0,0,round_head_screw_wall])
                        cylinder(d=_screw_head_dia+2*screw_clearence,h=(back_wall+hook_thickness+2*hook_clearence+hook_wall)*cos(_brace_angle)+(2*brace_wall+hook_width+2*hook_clearence)*sin(_brace_angle)-round_head_screw_wall);
                }
            }
        } else {
            translate([xcenter,0,screw_vpos])
                rotate([-90,0,0])
                    screw_hole_flathead((back_wall+hook_thickness+2*hook_clearence+hook_wall)*cos(_brace_angle)+(2*brace_wall+hook_width+2*hook_clearence)*sin(_brace_angle)+1,screw_dia+2*screw_clearence,_screw_head_dia+2*screw_clearence,flat_head_screw_wall-flat_head_screw_head_height/*3-screw_dia/2-screw_clearence*/);
        }
    }
}

brace();
