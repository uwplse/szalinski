//version 0.1.0
//code, README, and change log available at: https://bitbucket.org/jim_stoll/f2-binding-lift-cant-shims

// Heel or Toe lift angle in degrees. Decimals supported. Enter 0 for no lift. 8 degrees, Max. Must be greater than or equal to zero. (Stock lift angle is approx 4 degrees.)
lift_angle = 3;
// Left or Right cant angle in degrees. Decimals supported. Enter 0 for no cant. 8 degrees, Max. Must be greater than or equal to zero. (Stock cant angle is approx 3.5 degrees.)
cant_angle = 2;
//Lift Orientation: H = Heel Lift, T = Toe Lift (Ignored if Lift Angle is set to zero.)
lift_direction = "Heel";  //[Heel, Toe]
//Cant Orientation, looking from Heel to Toe: L = Left Cant, R = Right Cant (Ignored if Cant Angle is set to zero.)
cant_direction = "Left";  //[Left, Right]

// Binding Size: S = Small, M = Medium, L = Large
binding_size = "S";  //[S, M, L]
//Base Depth in mm - Base height to add under the shims. Should generally be minimum of 0.5mm. Higher lift angles, or very low lift and cant angles may require a larger base depth to for the groove to print acceptably.
base_depth = 0.5;

//Layout: Preview - show as shims will sit on binding; Print - arrange for 3D Printing. Must be in 'Print' layout for proper printing.  
layout = "Preview"; //[Preview, Print]

/* [Hidden] */

//Generate Toe Piece: True - Toe Piece will be generated; False - Toe Piece will not be generated
generate_toe_piece = true;  //[true, false]
//Generate Heel Piece: True - Heel Piece will be generated; False - Heel Piece will not be generated
generate_heel_piece = true;

//translate 'pretty' variable lables and values to more workable variable names and values
arrange_for_print = layout=="Print"?true:false;
//_binding_size = (binding_size=="S"||binding_size=="L")?"SL":"M";
_lift_heel_toe = lift_direction=="Heel"?"H":"T";
_cant_left_right = cant_direction=="Left"?"L":"R";

//thickness of walls, webs and floor
wall_thickness = 5;

//the following *Fn variables affect curve smoothness - the higher the number,
// the smoother the curve, but at the cost of possibly dramatically increased
// rendering time
//cavity_fn determines the smoothness of internal holes and cavities
cavity_fn = 30;
//end_radius_fn determines the smoothness of the large curves on the ends of the
// heel and toe piece. This is worth making relatively large, as its a large
// curve, and the cost of this one particular section is relatively low
end_radius_fn = 90;
//corner_fillet_fn determines the smoothness of the corners of the hollowed-out
// volumes on the underside of the heel and/or toe pieces. This is an expensive
// operation, so the value should be kept relatively low, for reasonable render
// times. (Additionally, this is a small radius, so a super-fine resolution
// won't have much effect here.)
corner_fillet_fn = 12;

corner_fillet_rad = .6*wall_thickness; //should be a minimum of .5*wall_thickness

//internal variables that really should not be changed
$fn = cavity_fn;

base_len_s = 220;
base_len_m = 220;
base_len_l = 245;
base_len = binding_size=="S"?base_len_s:(binding_size=="M"?base_len_m:base_len_l);
plate_len_sl = 58;
plate_len_m = 51;
plate_len = (binding_size=="S" || binding_size=="L")?plate_len_sl:plate_len_m;
plate_wid = 50;
end_rad_sl = 60;
end_rad_m = 105;
end_rad = (binding_size=="S" || binding_size=="L")?end_rad_sl:end_rad_m;
hole_rad = 3.3;
hole_wid_inset = 5;
hole_len_inset_sl = 35;
hole_len_inset_m = 21.5;
hole_len_inset = (binding_size=="S" || binding_size=="L")?hole_len_inset_sl:hole_len_inset_m;

groove_wid = 4.3;
groove_dpth = 2.2;
groove_tip_wid = .5;
ridge_wid = 3;
ridge_dpth = 1.4;
ridge_tip_wid = .5;
label_dpth = .3;

lift_ht = base_len * tan(lift_angle);  //height contribution of top plate edge due to lift angle
cant_ht = plate_wid * tan(cant_angle); //height contribution of top plate due to cant angle
top_plate_x_ext = plate_len; //need to extend the top plate in X to allow for its 'shortening' in X as it is rotated around the X and/or Y axis. No need to calculate this, as the end will be trimmed with the end radius, so just make it longer than could possibly be needed (ie, add base_len to it!), and it'll subsequently be trimmed at the needed length
top_plate_y_ext = let (x = plate_wid*cos(cant_angle), y = plate_wid - x) y/cos(lift_angle); //need to extend the top plate in Y to allow for cant angle 'shortening' it in Y. This needs to be calculated, as we don't trim the sides

total_ht = lift_ht + cant_ht + ridge_dpth + base_depth; //total height/thickness of tallest/thickest part of block
ht_compensation = 1.2;      //multiplier for extra height to add to cylinders used to shape curved ends
compensated_ht = ht_compensation*total_ht;    //height of cylinders used to cut shape curved ends - make sufficiently tall to be sure to vertically enclose entire shim, including ridge at an angle

end_radius_edge_rad = 3;    //rounded corner radius for corners where curved ends meet straight sides
concave_end_radius_theta = get_theta_for_yr((plate_wid/2 - end_radius_edge_rad), end_rad + end_radius_edge_rad);
convex_end_radius_theta = get_theta_for_yr((plate_wid/2 - end_radius_edge_rad), end_rad - end_radius_edge_rad);

function get_theta_for_yr(y, r) = asin(y/r);

module concave_end_radius_edge_rounder(w, end_rad, corner_rad, dpth, diff_comp=1) {
    diff_dpth = dpth + 2*diff_comp;    
    translate([0, 0, -diff_comp - cant_ht]) {
        difference() {
            rotate([0, 0, 180]) {
                hull() {
                    for (r = [-(90 + concave_end_radius_theta)/2, 0, (90 + concave_end_radius_theta)/2]) {
                        rotate([0, 0, r])
                            cube([3*corner_rad, .01, diff_dpth]);
                    }
                }
            }
            cylinder(r=corner_rad, h=diff_dpth, $fn=end_radius_fn); 
        }
    }
}

module convex_end_radius_edge_rounder(w, end_rad, corner_rad, dpth, diff_comp=1) {
    diff_dpth = dpth + 2*diff_comp;    
    translate([0, 0, -diff_comp]) {
        difference() {
            rotate([0, 0, 180]) {
                hull() {
                    for (r = [0, (90 + convex_end_radius_theta)/2]) {
                        rotate([0, 0, r])
                            cube([3*corner_rad, .01, diff_dpth]);
                    }
                }
            }
            cylinder(r=corner_rad, h=diff_dpth, $fn=end_radius_fn); 
        }
    }
}
            
if (arrange_for_print) {
    print_x_rot = _cant_left_right=="L"?-1:1;
    print_y_rot = _lift_heel_toe=="H"?1:-1;
    print_z_adj = (_lift_heel_toe=="H"?0:lift_ht) + (_cant_left_right=="L"?base_depth:cant_ht+base_depth);
    
    translate([0, plate_wid, print_z_adj]) {
        rotate([print_x_rot*cant_angle, 180 + print_y_rot*lift_angle, 180]) {
            toe_piece();
        }
        translate([base_len, 10, 0]) {
            rotate([print_x_rot*cant_angle, 180 + print_y_rot*lift_angle, 0]) {
                heel_piece();
            }
            
        }
    }
} else {
    toe_piece();
    heel_piece();
}

module toe_piece() {
    if (generate_toe_piece) {
        
        difference() {
            _toe_piece();
            minkowski() {
                _toe_piece(wall_thickness);
                sphere(r=corner_fillet_rad, $fn=corner_fillet_fn);
            }
            translate([end_rad + plate_len , plate_wid/2, 0])
                rotate([0, 0, concave_end_radius_theta])
                    translate([-(end_rad + end_radius_edge_rad), 0, 0])
                        rotate([0, 0, 180 - (90 + concave_end_radius_theta)/2])
                            concave_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht, 2);

            translate([end_rad + plate_len , plate_wid/2, 0])
                rotate([0, 0, -concave_end_radius_theta])
                    translate([-(end_rad + end_radius_edge_rad), 0, 0])
                        rotate([0, 0, 180 + (90 + concave_end_radius_theta)/2])
                            concave_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht, 2);
                    
            translate([end_rad, plate_wid/2, 0])
                rotate([0, 0, convex_end_radius_theta])
                    translate([-end_rad + end_radius_edge_rad, 0, 0])
                        rotate([0, 0, convex_end_radius_theta/2])
                            convex_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht);
                    
            translate([end_rad, plate_wid/2, 0])
                rotate([0, 0, -convex_end_radius_theta])
                    translate([-end_rad + end_radius_edge_rad, 0, 0])
                        rotate([0, 0, -90 + convex_end_radius_theta])
                            convex_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht);
            
        }
       
    }
        
    module _toe_piece(offset=0) {
        fillet_comp = offset>0?corner_fillet_rad:0;
            
        difference() {
            
            //body and convex end radius
            intersection() {
                translate([0, offset, -offset])
                    base_shim(offset);
            translate([end_rad + offset + fillet_comp, plate_wid/2, 0])
                end_radius();
            }
            //concave end radius
                translate([plate_len + end_rad - offset - fillet_comp, plate_wid/2, 0])
                    end_radius();
            
        }
    }
}

module heel_piece() {
    if (generate_heel_piece) {
        
        difference() {
            _heel_piece();
            minkowski() {
                _heel_piece(wall_thickness);
                sphere(r=corner_fillet_rad, $fn=corner_fillet_fn);
            }
            
            translate([base_len - plate_len - end_rad, plate_wid/2, 0])
                rotate([0, 0, concave_end_radius_theta])
                    translate([end_rad + end_radius_edge_rad, 0, 0])
                        rotate([0, 0, -(90 + concave_end_radius_theta)/2])
                            concave_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht, 2);

            translate([base_len - plate_len - end_rad, plate_wid/2, 0])
                rotate([0, 0, -concave_end_radius_theta])
                    translate([end_rad + end_radius_edge_rad, 0, 0])
                        rotate([0, 0, (90 + concave_end_radius_theta)/2])
                            concave_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht, 2);
                    
            translate([base_len - end_rad, plate_wid/2, 0])
                rotate([0, 0, -convex_end_radius_theta])
                    translate([end_rad - end_radius_edge_rad, 0, 0])
                        rotate([0, 0, 90 + convex_end_radius_theta])
                            convex_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht, 2);
                    
            translate([base_len - end_rad, plate_wid/2, 0])
                rotate([0, 0, convex_end_radius_theta])
                    translate([end_rad - end_radius_edge_rad, 0, 0])
                        rotate([0, 0, 180 + convex_end_radius_theta/2])
                            convex_end_radius_edge_rounder(plate_wid, end_rad, end_radius_edge_rad, compensated_ht, 2);
        }
        
    }
        
    module _heel_piece(offset=0) {
        fillet_comp = offset>0?corner_fillet_rad:0;
            
        difference() {
            //body and convex end radius
            intersection() {
                translate([0, offset, -offset])
                    base_shim(offset);
                translate([base_len - end_rad - offset - fillet_comp, plate_wid/2, 0])
                    end_radius();
            }
            //concave end radius
            translate([base_len - plate_len - end_rad + offset + fillet_comp, plate_wid/2, 0])
                end_radius();
            
        }
    }
}

//NOTE: sides of shim aren't vertical when rendered upright (non-print layout),
// but are vertical as printed, which is probably more important to quality than them
// being slightly off-vertical once printed and upright
module base_shim(offset=0) {
    //for internal cutouts, reduce cutout geometry dimensions by corner_fillet_rad to allow
    // for minkowski sum adding it back in
    fillet_comp = offset>0?corner_fillet_rad:0;
    //for size M bindings, the shorter piece length and hole offset closer to convex end
    // results in need to shift web to inboard side of bolt holes (vs outboard side for SL size)
    _binding_size_wall_thick_comp = (binding_size=="S" || binding_size=="L")?0:wall_thickness;
    
    heel_toe_x_offset = _lift_heel_toe=="H"?0:-top_plate_x_ext;
    heel_toe_z_offset = _lift_heel_toe=="H"?0:plate_len*tan(lift_angle);

    difference() {
        //body and ridge
        union() {
            translate([0, fillet_comp, 0])
                hull() {
                    translate([heel_toe_x_offset, 0, base_depth - fillet_comp + heel_toe_z_offset])
                        rotate_feature()
                            plate(top_plate_x_ext, top_plate_y_ext, .01, offset);
                    plate(0, 0, base_depth + .01, offset);
                }
            color("Blue")
                ridge();
        }
        
        if (offset==0) {
            //groove
            color("Red") translate([heel_toe_x_offset, 0, base_depth + heel_toe_z_offset])    
                rotate_feature()
                    groove();
            
            //toe piece bolt holes
            translate([hole_len_inset, 0, 0])
                piece_holes();

            //heel piece bolt holes
            translate([base_len - hole_len_inset, 0, 0])
                piece_holes();
            
        
            //labels
            rotate_feature() {
                //toepiece
                label();
                //heelpiece
                translate([base_len - plate_len, 0, 0])
                    label();
            }

        } else {
            //diff out center area, so ridge and groove are unaffected
            //center on plate via:
            // (plate_wid - 2*offset)/2 - offset/2  (ie, half the width of the inset plate, minus 1/2 the width of the web)
           //
            translate([0, plate_wid/2 - (2*offset)/2 - offset/2 - fillet_comp, 0])
                //center diffed-out block should be 2*offset * 2*corner_fillet_rad wide,
                // to allow for minlowski'ing with sphere of rad=corner_fillet_rad,
                // for filletted internal corners
                cube([base_len, offset + 2*corner_fillet_rad, compensated_ht]);   
            
            //diff out wall area around heel bolt holes
            translate([base_len - hole_len_inset, 0, 0])
                piece_holes(offset);
            
            //diff out wall area around toe bolt holes
            translate([hole_len_inset, 0, 0])
                piece_holes(offset);
            
            //diff out wall between bolt holes
            // size SL will be on outboard side of hole centers
            // size M will be in inboard side of hole centers
            
            //heel
            translate([base_len - hole_len_inset - offset/2 - _binding_size_wall_thick_comp, 0, 0])
                cube([offset + 2*corner_fillet_rad, plate_wid - 2*offset, compensated_ht]);

            //toe
            translate([hole_len_inset - 1.5*offset + _binding_size_wall_thick_comp, 0, 0])
                cube([offset + 2*corner_fillet_rad, plate_wid - 2*offset, compensated_ht]);
        }
    }
}

module rotate_feature() {
    //following variables are used for translation and rotation directions based on lift, cant and heel/toe settings
    y_offset_dir = _cant_left_right=="L"?0:1;
    x_offset_dir = _lift_heel_toe=="H"?0:-1;
    x_rot_dir = _cant_left_right=="L"?1:-1;
    y_rot_dir = _lift_heel_toe=="H"?-1:1;
    
    translate([-x_offset_dir*base_len, y_offset_dir*plate_wid, 0])
        rotate([x_rot_dir*cant_angle, y_rot_dir*lift_angle, 0])
            translate([x_offset_dir*base_len, -y_offset_dir*plate_wid, 0])
                children();
   
}    

module groove() {
    x_offset_dir = _lift_heel_toe=="H"?-1:1;    
    hull() {
        //translate groove -.5 in X, to ensure it hangs off origin end for diff
        // also extend length by 1 in X (so, -.5 on one end, +.5 on other end), as well
        translate([x_offset_dir*.5, (plate_wid - groove_wid)/2, 0.02])
            cube([base_len + top_plate_x_ext + 1, groove_wid, .04]);
        translate([x_offset_dir*.5, (plate_wid - groove_tip_wid)/2, -groove_dpth])
            cube([base_len + top_plate_x_ext + 1, groove_tip_wid, groove_dpth]);
    }
}

module ridge() {
    hull() {
        //translate ridge -.5 in X, to ensure it hangs off origin end for diff
        // also extend length by 1 in X (so, -.5 on one end, +.5 on other end), as well
        translate([-.5, (plate_wid - ridge_wid)/2, 0])
            cube([base_len + 1, ridge_wid, .01]);
        translate([-.5, (plate_wid - ridge_tip_wid)/2, -ridge_dpth])
            cube([base_len + 1, ridge_tip_wid, ridge_dpth]);
    }
}

module plate(plate_x_ext, plate_y_ext, dpth, offset=0) {
    fillet_comp = offset>0?corner_fillet_rad:0;
    
    //if offset > 0, then this is a cutout for an internal void
    // reduce width by 2*offset (ie allow for walls along both sides)
    // and by 2*radius used to minkowski void block, to allow round edges
    cube([base_len + plate_x_ext, plate_wid - 2*offset - 2*fillet_comp + plate_y_ext, dpth]);    
}

module end_radius() {
    translate([0, 0, -(ht_compensation - 1)/2*compensated_ht - ridge_dpth -.02]) cylinder(r=end_rad, h=compensated_ht, $fn=end_radius_fn);
}

module piece_holes(offset=0) {
    fillet_comp = offset>0?corner_fillet_rad:0;
    translate([0, hole_wid_inset - offset, -.02])
        screw_hole(offset + fillet_comp);
    translate([0, plate_wid - hole_wid_inset - offset, -.02]) 
        screw_hole(offset + fillet_comp);
}

module screw_hole(offset=0) {
    //drop the screw hole down by .02 to avoid coincident surface
    translate([0, 0, -2]) cylinder(r=hole_rad + offset, h=compensated_ht, $fn=cavity_fn);
}

module label() {
    color("Red")
        translate([plate_len/2, hole_wid_inset + hole_rad*2 + 4.5, -label_dpth + base_depth])
            resize([plate_len-10, (plate_wid - hole_wid_inset - hole_rad*2 - 15 - groove_wid)/2, 0])
                linear_extrude(label_dpth + .02)
                    text(str(binding_size, "  L", lift_angle, "  C", cant_angle, "  B", base_depth), halign="center", valign="center", font=":style=Bold");
}
