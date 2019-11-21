//
// The ultimate corner treatment jig: rounding outward, inward, elliptical or chamfering
// Corner radius can be symmetric or asymmetric.
//
//  Author: MrFuzzy_F, 
//  License: CC BY-NC
//

$fa=1*1;
$fs=0.25*1;


// corner rounding/cutting mode
corner_mode = 0; // [0:Rounding outward,1:Rounding inward,2:Chamfer,3:Elliptical,4:Outward+Inward,5:Inward+Outward]

// symmetric: ignore r2 settings and use r1 for both edges
symmetric_mode = 1; // [0:asymmetric (use r1 and r2),1:symmetric (use only r1)]


// corner radius / chamfer offset / ellipsis radius
r1 = 20;

// Asymmetric mode: corner radius / chamfer offset / ellipsis radius. In asymmetric mode this is the left radius and r1 is the right radius (when viewed from top) 
r2 = 10;

// holding type
holder_type = 0; // [0:Finger hole,1:Screw,countersunk,2:Screw,hex head]

// show corner size label
show_label = 1; // [0:No,1:Yes]


/* [ Plate ] */

// minimal side length of ground plate
plate_size_min = 100;

// height of base plate
plate_height = 8.5;


/* [ Fence ] */

// fence thickness
fence_thickness = 5;

// offset of fence to end of rounded part
fence_offset = 20;

// fence height over plate
fence_height = 10;

// fence minimal length - plate size will be adjusted if fence length would fall below
fence_min_length = 35;


/* [ Holder ] */

// Type: finger holder - hole diameter 
finger_hole_diameter = 20;

// Type: Screwed knob - screw diameter 
holder_screw_diameter = 8.2;

// Type: Screwed knob - screw head diameter. Flat sides for hex head.
holder_screw_head_diameter = 13.0;

// thickness of screw head
holder_screw_head_thn = 5.5;


/* [ Hidden ] */
// computed or hidden 
corner_radius = r1 > r2 ? r1 : r2;
plate_size = plate_size_min-corner_radius-fence_offset >= fence_min_length ? plate_size_min : fence_min_length + fence_offset + corner_radius;
holder_pos_x = plate_size * 0.6;
holder_pos_y = plate_size * 0.6;
holder_bore = holder_type == 0 ? finger_hole_diameter : holder_screw_diameter;
r2_mod = symmetric_mode == 1 ? r1 : r2;

if (plate_size_min != plate_size) {
    echo("**********************************************************************");
    echo("INFO - fence length falls below fence_min_length => plate size increased to: ", plate_size);    
    echo("**********************************************************************");
}



jig();



module jig() {
    
    difference() {
        union() {
            jig_plate();
            translate([holder_pos_x, holder_pos_y, 0])
                cylinder(plate_height, d=holder_bore+30);
        }
        
        // hole for finger holding or screw
        translate([holder_pos_x, holder_pos_y, 0])
        {
            cylinder(plate_height, d=holder_bore);

            if (holder_type == 1) {
                // chamfer for countersunk screw head
                translate([0,0,plate_height-holder_screw_head_thn])
                    cylinder(plate_height/2, d1=holder_screw_diameter, d2=holder_screw_head_thn); 
            } else if (holder_type == 2) { // hex nut
                translate([0,0,plate_height-holder_screw_head_thn])
                    hex_nut(holder_screw_head_diameter, holder_screw_head_thn);  
            }
        }
        
        if (show_label == 1) {
            if (corner_mode >= 4) {
                label(r1,r1);
            }
            else if (corner_mode == 3) {
                label(r1,r2);
            } else {
                label(r1,r2_mod);
            }
        }
    }
}



module jig_plate() {
    
    difference() {
        union() {
            if (corner_mode == 3) {
                rounding_outward_elliptical(r1,r2);  // ignore symmetric_mode
            } else {
                difference() {
                    cube([plate_size, plate_size, plate_height]);
                    cube([r1, r2_mod, plate_height]);
                }
            }
            
            if (corner_mode == 0) {
                rounding_outward(r1,r2_mod);
            } else if (corner_mode == 1) {
                rounding_inward(r1,r2_mod);
            } else if (corner_mode==2) {
                chamfer(r1,r2_mod);
            } else if (corner_mode==4) {
                rounding_outward_inward(r1);
            } else if (corner_mode==5) {
                rounding_inward_outward(r1);
            }
                          
        }
        
        // cut-out, save material
        translate([plate_size*1.2, plate_size*1.1, plate_height/2])
            rotate([0,0,45])
                cube([plate_size*sqrt(2), plate_size*sqrt(2), plate_height], center=true);
    }
    
    if (corner_mode != 3) {
        // right fence (viewed from top)
        translate([r1+fence_offset, -fence_thickness, 0])
            cube([plate_size-r1-fence_offset, fence_thickness, fence_height+plate_height]);
        
        // left fence (viewed from top)
        translate([-fence_thickness, r2_mod+fence_offset, 0])
            cube([fence_thickness, plate_size-r2_mod-fence_offset, fence_height+plate_height]);   
    }
}


module rounding_outward(r1, r2) {
    
    h = plate_height;
    translate([r1, r2, 0])
        resize([r1*2, r2*2, h])
            cylinder(h, r=r1);
    chamfer(r1,r2);
}
 


module rounding_outward_elliptical(r1, r2) {
    // ellipsis is rotated at 45 degree angle and fitted into corner
    // such that it touches the workpiece axes
    
    // module creates entire plate
    
    h = plate_height;

    // compute the touching points of the ellipsis at 45 degree rotation angle
    a1 = r1 / sqrt(1 + pow((r2/r1),2));
    b1 = r2 / sqrt(1 + pow((r1/r2),2));
    alpha = atan(b1/a1);
    rad = sqrt(a1*a1 + b1*b1);
    a1_trans = rad * cos(alpha) * cos(45) - rad * sin(alpha) * sin(45);
    b1_trans = rad * sin(alpha) * cos(45) + rad * cos(alpha) * sin(45);

    translate([b1_trans, b1_trans, 0])
        rotate([0,0,45])
            resize([r2*2, r1*2, h])
                cylinder(h, r=r2);

    rect1 = b1_trans + a1_trans;

    plate_size_mod = plate_size_min-rect1-fence_offset >= fence_min_length ? plate_size_min : fence_min_length + fence_offset + rect1;

    linear_extrude(h)
        polygon(points=[[rect1,0], [plate_size_mod, 0], [plate_size_mod,plate_size_mod], [0,plate_size_mod], [0,rect1]]);


    // right fence (viewed from top)
    translate([rect1+fence_offset, -fence_thickness, 0])
        cube([plate_size_mod-rect1-fence_offset, fence_thickness, fence_height+plate_height]);
    
    // left fence (viewed from top)
    translate([-fence_thickness, rect1+fence_offset, 0])
        cube([fence_thickness, plate_size_mod-rect1-fence_offset, fence_height+plate_height]);   

}


module rounding_inward(r1, r2) {
    
    h = plate_height;
    difference() {
        cube([r1, r2, h]);
        resize([r1*2, r2*2, h])
            cylinder(h, r=r1);
    }
}


module rounding_inward_outward(r1) {

    mirror([1,-1,0])
        rounding_outward_inward(r1);
}


module rounding_outward_inward(r1) {
 
    difference() {
        union() {
            chamfer(r1,r1);
            translate([r1, r1/2, 0])
                cylinder(plate_height, r=r1/2); 
        }
        translate([0, r1/2, 0])
            cylinder(plate_height, r=r1/2); 
    }
}


module chamfer(r1, r2) {
    h = plate_height;
    linear_extrude(h) 
        polygon([[r1,0],[r1,r2],[0,r2]], paths=[[0,1,2]]);
}


module label(r1,r2) {    
    font_size = 5;
    translate([plate_size-5,font_size*2,0])
    {
        mirror([0,1,0])
        linear_extrude(height = 1) {
            if (r1 != r2) {
                text(text = str(r1,"mm / ", r2, "mm"), size = font_size, halign = "right");
            } else {
                text(text = str(r1,"mm"), size = font_size, halign = "right");           
            }
        }
    }
}


module hex_nut(d_head_flat, thn_head) {
    r = (d_head_flat/2) / cos(30);
    linear_extrude(thn_head)
        polygon(points = [[r, 0], [r * cos(60), r * sin(60)],
                          [r * cos(120), r * sin(120)], 
                          [r * cos(180), r * sin(180)],
                          [r * cos(240), r * sin(240)], 
                          [r * cos(300), r * sin(300)]]);
}
