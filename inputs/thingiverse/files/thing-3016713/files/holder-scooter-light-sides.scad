$fn = 64;
profile_width = 30;
profile_thickness = 2;

insert_chamfer = 1;
insert_protusion = 2;
insert_depth = 5;
insert_hole_diameter = 0;
gap = 4;

bracket_height = profile_width;
bracket_hole_diameter = 4;
bracket_width =  1;
bracket_thickness = 8;
bracket_arm_width = profile_width;
profile_thickness=2;

screw_diameter = 8;

stem_diameter = 34.29;
chamfer = 2;
wall_thickness = 1.5;
csg=0.01;
/**
* Insert into alu profiles
**/
module side_insert(
depth,
hole_diameter=insert_hole_diameter,
protusion=insert_protusion,
chamfer=insert_chamfer,
profile_width=profile_width, 
profile_thickness=profile_thickness,
wall_thickness=wall_thickness
) {
    
    chamfer_offset=chamfer;
    difference() {
    union() {
    translate([0,0,-0.5*protusion]) hull() {

    translate([0,0,0.5*chamfer_offset]) 
        cube([profile_width, profile_width, protusion-chamfer_offset], center=true);
    cube([profile_width-2*chamfer_offset, profile_width-2*chamfer_offset, protusion], center=true);
    

    }
        inner_width = profile_width-2*profile_thickness;
                translate([0,0,0.5*insert_depth]) difference() {
        cube([inner_width, inner_width, insert_depth], center=true);
        cube([inner_width-2*wall_thickness, inner_width-2*wall_thickness, insert_depth], center=true);

        }
}
    if(hole_diameter > 1) {
    translate([0,0,-protusion]) cylinder(h=insert_depth+protusion, d=hole_diameter);
    }
}
}
    
module screw(height, diameter, head_height, head_diameter) {
        union() {
            cylinder(h=height, d=diameter);
            translate([0,0,height]) cylinder(h=head_height, d=head_diameter);
    }
}

//screw(10, 4, 4, 6);


module chamfered_cube(vector=[0,0,0], chamfer=chamfer, center=true)  {
    x = vector[0];
    y = vector[1];
    z = vector[2];
    x_small = vector[0]-chamfer*2;
    y_small = vector[1]-chamfer*2;
    z_small = vector[2]-chamfer*2;
    hull() {
        //x cube
        cube([x, y_small, z_small], center);
        //y cube
        cube([x_small, y, z_small], center);
        //z cube
        cube([x_small, y_small, z], center);

    }
};

module chamfered_cylinder(d=0, h=0, chamfer=chamfer, center=false) {
    r = d/2;
    translation = 0;
    if (!center) {
        translation = chamfer;
    }
    union() {
        cylinder(r=r-chamfer, h=h, center=center);
        translate([0,0,translation]) cylinder(r=r,h=h-2*chamfer, center=center);
    }
}

module drill_holes(diameter, x, y, num_x=2, num_y=2, depth=900, center=true) {
    gap_x = x/num_x;
    gap_y = y/num_y;
    offset_x = gap_x/2;
    offset_y = gap_y/2;
    
    displace = [-x/2,-y/2,0];
    translate(displace) union() {
        for ( pos_x = [offset_x : gap_x : x] ) {
            for ( pos_y = [offset_y : gap_y : y] ) {
                translate([pos_x, pos_y, 0]) cylinder(h=depth, d=diameter, center=true);
            }
        }
    }
    
}
//drill_holes(2.5, 30, 30);

module bracket_ear(
    height=bracket_height, 
    width=bracket_width, 
    thickness=bracket_arm_width, 
    hole_diameter=bracket_hole_diameter,
    screw_diameter=screw_diameter,
    rect=true,
    chamfer=chamfer,
    hole_dia=2.5,
    holes=[0,0]
    ) {
    hole_offset = height/4;
        difference() {
    if (rect) {
        translate([width/2,0,0]) chamfered_cube([width, height, thickness], center=true, chamfer=chamfer);
    } else {
        scale([1,height/(thickness),1]) rotate([0,90,0]) cylinder(d=thickness, h=width);
    }
    if (holes[0] >= 1 && holes[1] >= 1) {
        translate([width/2,0,0]) drill_holes(hole_dia, width, height);
    }
}
}


module bracket(stem_diameter=stem_diameter, bracket_height=bracket_height, stem_diameter=stem_diameter, bracket_thickness=bracket_thickness, bracket_width=bracket_width) {
    endstop_chamfer=0.2;
    bracket_diameter=stem_diameter+bracket_thickness*4;
    difference() {
    hull() {
        // outer center
         
        rotate([90,0,0]) chamfered_cylinder(d=bracket_diameter, h=bracket_height, center=true);

        
        //outer
        translate([bracket_diameter/2,0,0]) bracket_ear(bracket_height, bracket_width, bracket_arm_width, chamfer=endstop_chamfer);
        rotate([0,0,180]) translate([bracket_diameter/2,0,0]) bracket_ear(bracket_height, bracket_width, bracket_arm_width, chamfer=endstop_chamfer);
    }
        rotate([90,0,0]) cylinder(d=stem_diameter, h=bracket_height+csg, center=true);
}

}

module bracket_profile(stem_diameter=stem_diameter, bracket_height=bracket_height, stem_diameter=stem_diameter, bracket_thickness=bracket_thickness, , bracket_width=bracket_width, profile_thickness=profile_thickness, profile_insert_depth=26) {
    cutout_translation=stem_diameter/2+bracket_thickness*2+bracket_width-chamfer;
    holes=[2,2];
    union() {
        bracket(stem_diameter=stem_diameter, bracket_height=bracket_height, bracket_thickness=bracket_thickness);
        union() {
        translate([cutout_translation,0,0]) bracket_ear(bracket_height-profile_thickness*2, profile_insert_depth+chamfer, bracket_arm_width-profile_thickness*2, holes=holes);
        rotate([0,0,180]) translate([cutout_translation,0,0]) bracket_ear(bracket_height-profile_thickness*2, profile_insert_depth+chamfer, bracket_arm_width-profile_thickness*2, holes=holes);
        }
    }


}
module half_bracket() {
    difference() {
    bracket_profile();
    translate([0,0,-50]) cube([200,200,100], center=true);
    }
}


module profile_insert(width, height, depth, thickness, chamfer=chamfer) {
    inner_width = height-thickness;
    inner_height = depth-thickness;
    union() {
        union(){
            cube([inner_width, inner_height, 0]);
            //cube();
            }
    }
}


half_bracket();
translate([0,profile_width+gap,0]) half_bracket();

translate([0.5*profile_width+gap,-profile_width-gap,0]) side_insert(insert_depth);
translate([-0.5*profile_width-gap,-profile_width-gap,0]) side_insert(insert_depth);

