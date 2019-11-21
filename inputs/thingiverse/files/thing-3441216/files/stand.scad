part = "print"; // [print,demo,section]

stand_width=20;
stand_height=13;
foot_height=4;
foot_width=16;
foot_rounding="yes"; // [yes,no]
membrane_length=18;
membrane_thickness=1.2;
membrane_num=5;
stud_height=7;
stud_dia=9;
solid_part_width=16;

profile_screw_dia = 3.6;
profile_screw_cap_dia=7;
profile_screw_depth=1.5;

bed_screw_dia=3.6;
bed_screw_insert_dia=4;
bed_screw_insert_height=3;
bed_screw_insert_space=3;
bed_screw_insert_bore_depth=3;
bed_screw_insert_bore_dia=5;
/*
bed_nut_size=5.5+0.3;
bed_nut_bore_depth=8;
*/
$chamfer=0.5;

// Set to 0 to disable preload
preload_bend_height=0;
piezo_plate_dia=31;
piezo_crystal_dia=20;
piezo_plate_height=0.2;
piezo_crystal_height=0.5;
piezo_position = "bottom"; // [bottom,top]
// Shift center of piezo out of the membrane edge towards the foot
piezo_shift=1;

/* [Hidden] */

$fn=32;

// Circle radius from segment length and height
preload_r = preload_bend_height ?
    (preload_bend_height + pow(piezo_plate_dia,2)/preload_bend_height)/8 :
    0;
echo(str("Preload radius: ", preload_r, " mm"));

slot_thickness=(stand_height-foot_height-membrane_num*membrane_thickness)/(membrane_num-1);
slot_interval=slot_thickness+membrane_thickness;
echo(str("Slot thickness: ", slot_thickness, " mm"));

echo(str("Bed above profile: ", stand_height+stud_height, " mm"));
bed_screw_max = piezo_position=="bottom" ?
    stand_height+stud_height+3/*Bed thickness*/-foot_height :
    stand_height+stud_height+3/*Bed thickness*/+6/*Profile slot depth*/;
bed_screw_min = stand_height+stud_height+3/*Bed thickness*/-foot_height-bed_screw_insert_bore_depth-bed_screw_insert_height+2;
echo(str("Bed screw max length: ", bed_screw_max, " mm, min length: ", bed_screw_min, " mm"));

stand_length=solid_part_width+2*membrane_length+2*foot_width;
echo(str("Stand length: ",stand_length," mm"));

// Horizontal beam length: 353 mm, bed ear width: 100 mm, bed screw offset: 7 mm
beam_holder_offset = 353/2-(100/2-7)-(solid_part_width+2*membrane_length+2*foot_width)/2;
echo(str("Stand offset from beam butt-end: ",beam_holder_offset," mm"));

module reflect(v)
{
    children();
    mirror(v)
        children();
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

module chamfered_cylinder(r=0,d=0,h=10,chamfer=999999,center=false)
{
    r = d?d/2:r;
    chamfer = chamfer!=999999?chamfer:($chamfer?$chamfer:0);
    translate([0,0,center?0:h/2]) {
        if (chamfer >= 0) {
            hull() {
                cylinder(r=r,h=h-2*chamfer,center=true);
                cylinder(r=r-chamfer,h=h,center=true);
            }
        } else {
            cylinder(r=r,h=h,center=true);
            translate([0,0,h/2+chamfer])
                cylinder(r1=r,r2=r-chamfer,h=-chamfer);
            translate([0,0,-h/2])
                cylinder(r1=r-chamfer,r2=r,h=-chamfer);
        }
    }
}

module chamfered_cube(size=10,chamfer=999999,center=false)
{
    sz = size[0]?size:[size,size,size];
    chamfer = chamfer!=999999?chamfer:($chamfer?$chamfer:0);
    translate(center?[0,0,0]:sz/2) {
        hull() {
            cube([sz.x,sz.y-2*chamfer,sz.z-2*chamfer],center=true);
            cube([sz.x-2*chamfer,sz.y-2*chamfer,sz.z],center=true);
            cube([sz.x-2*chamfer,sz.y,sz.z-2*chamfer],center=true);
        }
    }
}

module part(piezo_demo=false)
{
    color([100/255,100/255,102/255]) difference() {
        union() {
            // Feet
            reflect([1,0,0]) {
                translate([solid_part_width/2+membrane_length,-stand_width/2,0]) {
                    extra_height=3;
                    extra_width=1.5;
                    if (foot_rounding == "yes") {
                        cyl_scale=1.4;
                        extra_seg=stand_width/2*(1-cos(asin(1/cyl_scale)));
    
                        intersection() {
                            chamfered_cube([foot_width,stand_width,stand_height]);
                            hull() {
                                translate([-stand_width/2+extra_seg+extra_width,stand_width/2,0])
                                    scale([1,cyl_scale,1])
                                        chamfered_cylinder(d=stand_width,h=stand_height,$fn=2*$fn);
                                translate([foot_width-stand_width/2,stand_width/2,0])
                                    scale([1,cyl_scale,1])
                                        chamfered_cylinder(d=stand_width,h=extra_height,$fn=2*$fn);
                            }
                        }
                    } else {
                        hull() {
                            chamfered_cube([extra_width,stand_width,stand_height]);
                            chamfered_cube([foot_width,stand_width,extra_height]);
                        }
                    }
                }
            }

            // Beam
            union() {
                difference() {
                    translate([0,0,stand_height/2+foot_height/2])
                        chamfered_cube([solid_part_width+2*membrane_length+4*$chamfer,stand_width,stand_height-foot_height],center=true);
    
                    if (preload_bend_height && piezo_position != "bottom")
                        translate([solid_part_width/2+piezo_shift,0,stand_height+preload_r-preload_bend_height])
                            rotate([90,0,0])
                                cylinder(r=preload_r,h=stand_width+2,center=true,$fn=1024);
                }
                if (!preload_bend_height && piezo_position == "bottom") {
                    translate([solid_part_width/2+piezo_shift,0,foot_height]) {
                        intersection() {
                            cylinder(d=piezo_plate_dia,h=$chamfer);
                            translate([0,0,$chamfer/2])
                                cube([piezo_plate_dia,stand_width,$chamfer],center=true);
                        }
                    }
                }
                if (preload_bend_height && piezo_position == "bottom") {
                    intersection() {
                        translate([solid_part_width/2+piezo_shift,0,foot_height+preload_r-preload_bend_height])
                            rotate([90,0,0])
                                cylinder(r=preload_r,h=stand_width,center=true,$fn=1024);
                        pzw=2*sqrt(pow(piezo_plate_dia/2,2)-pow(stand_width/2,2));
                        translate([solid_part_width/2+piezo_shift-pzw/2,-stand_width/2,foot_height-preload_bend_height-$chamfer-1])
                            cube([pzw,stand_width,$chamfer+preload_bend_height+2]);
                    }
                    intersection() {
                        translate([solid_part_width/2+piezo_shift,0,foot_height+preload_r-preload_bend_height])
                            rotate([90,0,0])
                                chamfered_cylinder(r=preload_r,h=stand_width,center=true,$fn=1024);
                        translate([0,0,-($chamfer+preload_bend_height+2)/2+foot_height+$chamfer+1])
                            cube([solid_part_width+2*membrane_length+4*$chamfer,stand_width,$chamfer+preload_bend_height+2],center=true);
                    }
                }
            }

            // Stud
            translate([0,0,stand_height-2*$chamfer-preload_bend_height])
                chamfered_cylinder(d=stud_dia,h=stud_height+2*$chamfer+preload_bend_height);
        }

        // Membrane slots
        difference() {
            union() {
                reflect([1,0,0])
                    for(zz=[membrane_thickness:slot_interval:stand_height-foot_height-0.001])
                        translate([solid_part_width/2+membrane_length/2,0,zz+slot_thickness/2+foot_height])
                            cube([membrane_length,stand_width+2,slot_thickness],center=true);
                // Bended membrane
                if (preload_bend_height && piezo_position == "bottom") {
                    intersection() {
                        translate([solid_part_width/2,-stand_width/2-1,foot_height-preload_bend_height])
                            cube([membrane_length,stand_width+2,membrane_thickness+slot_thickness+preload_bend_height]);
                        translate([solid_part_width/2+piezo_shift,0,foot_height+preload_r-preload_bend_height])
                            rotate([90,0,0])
                                cylinder(r=preload_r-membrane_thickness,h=stand_width+2,center=true,$fn=1024);
                    }
                }
            }

            if (preload_bend_height && piezo_position != "bottom")
                translate([solid_part_width/2+piezo_shift,0,stand_height+preload_r-preload_bend_height])
                    rotate([90,0,0])
                        cylinder(r=preload_r+membrane_thickness,h=stand_width+2,center=true,$fn=1024);
        }

        // Profile fixation screws
        reflect([1,0,0])
            translate([solid_part_width/2+membrane_length+foot_width/2,0,0])
                screw_hole_flathead(stand_height,profile_screw_dia,profile_screw_cap_dia,profile_screw_depth);

        // Bed fixation screw    
        translate([0,0,-1])
            cylinder(d=bed_screw_dia,h=stand_height+stud_height+2);
        /*
        bed_nut_dia=bed_nut_size*2/sqrt(3);
        translate([0,0,-1])
            cylinder(d=bed_nut_dia,h=foot_height+bed_nut_bore_depth+1,$fn=6);
        */
        cylinder(d=bed_screw_insert_dia,h=foot_height+bed_screw_insert_bore_depth+bed_screw_insert_height+bed_screw_insert_space);
        cylinder(d=bed_screw_insert_bore_dia,h=foot_height+bed_screw_insert_bore_depth);
    }

    // Piezo demo
    if (piezo_demo) {
        pz_vpos = piezo_position=="bottom" ?
            foot_height-preload_bend_height-piezo_plate_height-piezo_crystal_height :
            stand_height-preload_bend_height;
        translate([solid_part_width/2+piezo_shift,0,pz_vpos]) {
            if (preload_bend_height) {
                translate([0,0,0.001]) {
                    color([181/255, 166/255, 66/255],0.3) render() {
                        intersection() {
                            translate([0,0,preload_r]) {
                                rotate([90,0,0]) {
                                    difference() {
                                        cylinder(r=preload_r-piezo_crystal_height,h=piezo_plate_dia,center=true,$fn=1024);
                                        cylinder(r=preload_r-piezo_plate_height-piezo_crystal_height,h=piezo_plate_dia+2,center=true,$fn=1024);
                                    }
                                }
                            }
        
                            intersection() {
                                cylinder(d=piezo_plate_dia,h=piezo_plate_height+piezo_crystal_height+preload_bend_height);
                                translate([0,0,(piezo_plate_height+piezo_crystal_height+preload_bend_height)/2])
                                    cube([piezo_plate_dia,stand_width-0.001,piezo_plate_height+piezo_crystal_height+preload_bend_height],center=true);
                            }
                        }
                    }
                }
                translate([0,0,0]) {
                    color([192/255, 192/255, 192/255],0.3) render() {
                        intersection() {
                            translate([0,0,preload_r]) {
                                rotate([90,0,0]) {
                                    difference() {
                                        cylinder(r=preload_r,h=piezo_crystal_dia,center=true,$fn=1024);
                                        cylinder(r=preload_r-piezo_crystal_height,h=piezo_plate_dia+2,center=true,$fn=1024);
                                    }
                                }
                            }
        
                            intersection() {
                                cylinder(d=piezo_crystal_dia,h=piezo_plate_height+piezo_crystal_height+preload_bend_height);
                                translate([0,0,(piezo_plate_height+piezo_crystal_height+preload_bend_height)/2])
                                    cube([piezo_plate_dia,stand_width-0.001,piezo_plate_height+piezo_crystal_height+preload_bend_height],center=true);
                            }
                        }
                    }
                }
            } else {
                color([181/255, 166/255, 66/255],0.3) render() {
                    intersection() {
                        translate([0,0,piezo_crystal_height-0.001])
                            cylinder(d=piezo_plate_dia,h=piezo_plate_height);
                        translate([0,0,(piezo_plate_height+piezo_crystal_height)/2])
                            cube([piezo_plate_dia,stand_width,piezo_plate_height+piezo_crystal_height],center=true);
                    }
                }
                color([192/255, 192/255, 192/255],0.3) render()
                    intersection() {
                        translate([0,0,-0.002])
                            cylinder(d=piezo_crystal_dia,h=piezo_crystal_height);
                        translate([0,0,(piezo_plate_height+piezo_crystal_height)/2])
                            cube([piezo_plate_dia,stand_width,piezo_plate_height+piezo_crystal_height],center=true);
                    }
            }
        }
    }
}

if (part=="section") {
    rotate([-90,0,0]) {
        intersection() {
            color("gold")
                translate([-stand_length/2-1,0,-1])
                    cube([stand_length+2,stand_width/2+1,stand_height+stud_height+2]);
            part();
        }
    }
} else if (part=="print") {
    rotate([-90,0,0])
        part();
} else if (part == "demo") {
    part(piezo_demo=true);
}