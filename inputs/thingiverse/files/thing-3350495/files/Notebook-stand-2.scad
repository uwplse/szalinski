/*[ Stand properties.  Size to your laptop]*/

//Thickness of material used (subtract as needed to account for kerf)
material_thickness = 4.0; //[1 : 0.1 : 20]

//The size of the kerf (4mm MDF = 0.23) (size to materiel and machine)
kerf = 0.23; //[0 : 0.01 : 0.5]

//the total width of the stand (not including any overhang)
stand_width = 280; //[200 : 5 : 500]

//Optional crossmember overhang for pressfit side support
cross_member_overhang = 10; //[0 : 1 :50]

//Height of the back of the stand
stand_height = 180; //[100 : 5 : 300]

//Depth bottom edge support legs (shorter than upper deck but too short and stand will be unstable)
lower_deck_depth = 190; //[150 : 5 : 300]

//Upper deck depth (too short and laptop will fall off the back, too long and stand will be unstable)
upper_deck_depth = 250; //[200 : 5 : 300]

//The angle of the upper deck. Generally between 20-30 degress, increase to make steeper
upper_deck_angle = 25; //[0 : 1 : 40]

/*[ Support structure properties]*/

//The width of the side spars, set too thin will make for a fragile stand
side_spar_thickness = 30; //[20 : 1 : 40]

//The suggested spacing between supports. Automatically adjusts support numbers for optimal placement
spar_spacing = 70; //[10 : 1 : 100]

//The suggested spacing between cross members. Automatically adjusts support numbers for optimal placement
cross_member_spacing = 60;//[10 : 1 : 100]

//Adjustment to move internal supports when there are conflicts with crossmembers
internal_spar_upper_deck_depth_divisor = 0.25; //[0.1 : 0.05 : 1]

//increase the number of end layers for increased stand strength with thinner materiels
edge_supports_layers = 1; //[1 : 1 : 10]

//The radius of corners, Smaller numbers make for sharper corners
curve_radius = 22; //[15 : 1 : 35]

/*[ Laptop Lip properties. Size appropriately to your laptop]*/

//The center width of supports with lips. For better stability > 90 is reccomended
upper_deck_front_lip_width = 94; //[50 : 5 : 400]

//The height the lip needed to catch the front edge of your laptop
upper_deck_front_lip_height = 12; //[0 : 5 : 50]

//The length the laptop can extends past the front of the top deck.
upper_deck_front_lip_depth = 0; //[-20 : 5 : 30]

//Cuts holes for a middle crossmember for extra support with thinner or deeper stands
use_bottom_mid_crossmember = "false";//[true, false]

/*[ Model properties.]*/

//The resolution of the curves. Higher values give smoother curves but increases render time.
resolution = 30; //[10 : 10 : 120]

//show 2d projection of individual parts with a 100mm square for scale
projection = "false";//[true, false]

$fn = resolution;

actualStandWidth = stand_width - material_thickness;
acutalLipWidth = upper_deck_front_lip_width - material_thickness;
upper_deck_rear_height = stand_height - 2 * curve_radius;
actual_lower_deck_depth = lower_deck_depth - curve_radius;
actual_upper_deck_depth = upper_deck_depth - curve_radius;

if (projection == "true") {
    //end support
    projection() side(true, false);
    //inner support
    projection() translate([0,upper_deck_rear_height * 1.5,0] )side(true, true);
    //inner support with lip
    projection() translate([actual_lower_deck_depth * 1.5,0 ,0] )side(false, true);
    //cross member
    projection()  translate ([-10-curve_radius-(side_spar_thickness * 2),0,0]) crossMember(true);
    projection()  translate ([-10-curve_radius-(side_spar_thickness * 4),0,0]) crossMember(false);
    projection() translate ([-10-curve_radius-(side_spar_thickness * 6),0,0]) bottomRightCrossMember();
    
    //scale
    translate([actual_lower_deck_depth * 1.5, upper_deck_rear_height,0] ) square([100,100]);

} else {
    supportStructure();
    translate ([-10-curve_radius-(side_spar_thickness * 2),0,0]) crossMember(true);
    translate ([-10-curve_radius-(side_spar_thickness * 4),0,0]) crossMember(false);
    translate ([-10-curve_radius-(side_spar_thickness * 6),0,0]) bottomRightCrossMember();
}

module supportStructure() {    
    normal_spar_count = floor(actualStandWidth / spar_spacing);
    normal_spar_spacing = actualStandWidth  / normal_spar_count;
    
    lipspaceLeft  = actualStandWidth / 2.0 - acutalLipWidth / 2.0;
    lipspaceRight = actualStandWidth / 2.0 + acutalLipWidth / 2.0;

    for(i=[0:normal_spar_count]) {
        if (upper_deck_front_lip_height == 0 || i * normal_spar_spacing < lipspaceLeft || i * normal_spar_spacing > lipspaceRight) {
            if ( i==0 || i == normal_spar_count) {
                    translate([0,0,i*normal_spar_spacing]) color("red") side(true, false);
            } else {
                if (abs(i*normal_spar_spacing - lipspaceLeft) > 5 && abs(i*normal_spar_spacing - lipspaceRight) > 5) {
                    translate([0,0,i*normal_spar_spacing]) side(true, true);
                }
            }
        } 
    }
    
    //double up end supports?
    if (edge_supports_layers > 1) {
        for(i=[2:edge_supports_layers]) {
            diff = i - 1;
            translate([0,0,diff*material_thickness]) color("red") side(true, false);
            translate([0,0,actualStandWidth - diff*material_thickness]) color("red") side(true, false);
        }
   }
     
    //add 2 lipped spars
    if (upper_deck_front_lip_height > 0) {
       normal_lip_count = floor(acutalLipWidth / spar_spacing);
       if (normal_lip_count < 2) {
            translate([0,0,lipspaceLeft]) color("green") side(false, true);
            translate([0,0,lipspaceRight]) color("green") side(false, true);
      } else {
           normal_lip_spacing = acutalLipWidth / normal_lip_count;
           for(i=[0:normal_lip_count]) {
                translate([0,0,lipspaceLeft + i*normal_lip_spacing]) color("blue") side(false, true);
            }
        }
    }
 
}


module side(hideLip, isInternal) {    
    linear_extrude(height=material_thickness) {
        difference() { //remove crossmember holes
            union() {
                if (!isInternal) {
                    difference() {
                        edgeSidePieces();     
                        offset(r = -side_spar_thickness) edgeSidePieces();
                    }
                   difference() {
                        edgeSupportPieces();     
                        offset(r = -side_spar_thickness) edgeSupportPieces();
                    }
                } else {
                    difference() {
                        internalSidePieces();     
                        offset(r = -side_spar_thickness) internalSidePieces();
                    }
                }
                     
                if (!hideLip) {
                    topDeckLip();
                }
            }
            //subtract cross members
            crossMemberHoles(isInternal);
        }
    }
}

module edgeSupportPieces() {
         hull () {
        //top left
        translate([0, 0, 0]) circle(r=curve_radius);
        //top right
        rotate([0,0,-upper_deck_angle]) translate([(actual_upper_deck_depth - curve_radius) * internal_spar_upper_deck_depth_divisor , 0, 0]) circle(r=curve_radius);
        //bottom left
        translate([0, -upper_deck_rear_height, 0]) circle(r=curve_radius);
        
     }
 }

module edgeSidePieces() {
    hull () {
        //top left
        translate([0, 0, 0]) circle(r=curve_radius);
        //top right
        rotate([0,0,-upper_deck_angle]) translate([actual_upper_deck_depth - curve_radius, 0]) circle(r=curve_radius);
        //bottom left
        translate([0, -upper_deck_rear_height, 0]) circle(r=curve_radius);
        //bottom right
         translate([actual_lower_deck_depth - curve_radius, -upper_deck_rear_height, 0]) circle(r=curve_radius);
    }
}

module internalSidePieces() {
    union() {
                   rotate([0,0,-upper_deck_angle]) hull () {
                       //make sure spar extends out to lip
        translate([0, curve_radius - side_spar_thickness/2.0, 0]) circle(d=side_spar_thickness);
         translate([actual_upper_deck_depth - curve_radius, curve_radius - side_spar_thickness/2.0, 0]) circle(d=side_spar_thickness);

                   }

    difference() {
    hull () {
        //top left
        translate([0, 0, 0]) circle(r=curve_radius);
        //top right
        rotate([0,0,-upper_deck_angle]) translate([(actual_upper_deck_depth - curve_radius) * internal_spar_upper_deck_depth_divisor , 0, 0]) circle(r=curve_radius);
        //bottom left
        translate([0, -upper_deck_rear_height, 0]) circle(r=curve_radius);
        
     }
     }
    }

}

module topDeckLip() {
    //top right
    rotate([0,0,-upper_deck_angle])
    union() {
            hull () {
                     translate([actual_upper_deck_depth - curve_radius, curve_radius - side_spar_thickness, 0]) square([side_spar_thickness/2.0,side_spar_thickness]);
                     translate([actual_upper_deck_depth + upper_deck_front_lip_depth, curve_radius - side_spar_thickness/2.0, 0]) circle(d=side_spar_thickness);
            }
             hull () {
                     translate([actual_upper_deck_depth + upper_deck_front_lip_depth, curve_radius - side_spar_thickness/2.0, 0]) circle(d=side_spar_thickness);
                     translate([actual_upper_deck_depth + upper_deck_front_lip_depth - side_spar_thickness/4.0, curve_radius + upper_deck_front_lip_height, 0]) circle(d=side_spar_thickness/2.0);

        }
    }  
}

module crossMemberHoles(isInternal) {
    
    //back members
    actual_back_height = upper_deck_rear_height - 2 *curve_radius;
    back_crossMember_count = floor(actual_back_height / cross_member_spacing);
    back_crossMember_spacing = actual_back_height  / back_crossMember_count;
       
    //do not stagger back, makes assembly hard
    for(i=[0:back_crossMember_count]) {
        translate([-curve_radius,-i * back_crossMember_spacing - curve_radius,0]) 
            square([side_spar_thickness / 2.0, material_thickness - kerf]);
         
    }

    //top members
    actual_top_depth = actual_upper_deck_depth - 3 * curve_radius;
    top_crossMember_count = floor(actual_top_depth / cross_member_spacing);
    top_crossMember_spacing = actual_top_depth  / top_crossMember_count;
       
    for(i=[0:top_crossMember_count]) {
            if (isInternal) { //stagger holes
              rotate([0,0,-upper_deck_angle]) 
                translate([i * top_crossMember_spacing + curve_radius ,curve_radius - side_spar_thickness-0.1,0]) 
                    square([material_thickness - kerf,side_spar_thickness / 2.0]);
            } else {
               rotate([0,0,-upper_deck_angle]) 
                translate([i * top_crossMember_spacing + curve_radius ,curve_radius - side_spar_thickness / 2.0 +0.1,0]) 
                    square([material_thickness - kerf,side_spar_thickness / 2.0]);
         }
    }
    
    //bottom right
    translate([actual_lower_deck_depth - (curve_radius + side_spar_thickness / 2.0) ,-upper_deck_rear_height - curve_radius,0]) 
                    square([side_spar_thickness / 2.0 - kerf, material_thickness - kerf]);

    if (use_bottom_mid_crossmember == "true") {
     //bottom mid
        translate([actual_lower_deck_depth/2.0 - (curve_radius/2.0) ,-upper_deck_rear_height - curve_radius,0]) 
                    square([side_spar_thickness / 2.0 - kerf, material_thickness - kerf]);
    }


}

module basicCrossMember() {
           hull() {
            square([side_spar_thickness, stand_width]);
            if (cross_member_overhang > 0) {
                if (cross_member_overhang < side_spar_thickness) {
                    translate([side_spar_thickness/2.0,-cross_member_overhang,0]) 
                        resize([side_spar_thickness, cross_member_overhang, 0])
                            circle(d=side_spar_thickness);
                    translate([side_spar_thickness/2.0,stand_width+cross_member_overhang,0]) 
                           resize([side_spar_thickness, cross_member_overhang, 0])
                                circle(d=side_spar_thickness);        
                    }else {
                    translate([side_spar_thickness/2.0,-cross_member_overhang,0]) 
                                circle(d=side_spar_thickness);
                    translate([side_spar_thickness/2.0,stand_width+cross_member_overhang,0]) 
                                circle(d=side_spar_thickness);
                }
            } 
        }
    }

module bottomRightCrossMember() {
        linear_extrude(height=material_thickness) {
  
    difference() {

       //material
        basicCrossMember();
    
      //doubled up end supports?
        for(i=[1:edge_supports_layers]) {
            diff = i - 1;
            translate([0,diff*material_thickness,0]) square([side_spar_thickness/4.0, material_thickness-kerf]);
            translate([3*side_spar_thickness/4.0,diff*material_thickness,0]) square([side_spar_thickness/4.0, material_thickness-kerf]);
            translate([0,actualStandWidth - diff*material_thickness,0]) square([side_spar_thickness/4.0, material_thickness-kerf]);
            translate([3*side_spar_thickness/4.0,actualStandWidth - diff*material_thickness,0]) square([side_spar_thickness/4.0, material_thickness-kerf]);
          }
      }
  }

}

module crossMember(isReversed) {
    
        linear_extrude(height=material_thickness) {

    difference() {

        //material
        basicCrossMember();   
        //cutouts
        
        normal_spar_count = floor(actualStandWidth / spar_spacing);
        normal_spar_spacing = actualStandWidth  / normal_spar_count;

        lipspaceLeft  = actualStandWidth / 2.0 - acutalLipWidth / 2.0;
        lipspaceRight = actualStandWidth / 2.0 + acutalLipWidth / 2.0;

        for(i=[0:normal_spar_count]) {
            if (upper_deck_front_lip_height == 0 ||  (abs(i*normal_spar_spacing - lipspaceLeft) > 5 && abs(i*normal_spar_spacing - lipspaceRight) > 5)) {
                if ( i==0 || i == normal_spar_count || !isReversed) { //edge
                    translate([side_spar_thickness/2.0,i*normal_spar_spacing,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
                } else { //internal
                    translate([0,i*normal_spar_spacing,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
                }
            } 
        }
            
        //doubled up end supports?
        if (edge_supports_layers > 1) {
            for(i=[2:edge_supports_layers]) {
                diff = i - 1;
                translate([side_spar_thickness/2.0,diff*material_thickness,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
                translate([side_spar_thickness/2.0,actualStandWidth - diff*material_thickness,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
              }
       }
             
        //add 2 lipped spars
 
        if (upper_deck_front_lip_height > 0) {
           normal_lip_count = floor(acutalLipWidth / spar_spacing);
           if (normal_lip_count < 2) {
               if (!isReversed) {
                 translate([side_spar_thickness/2.0,lipspaceLeft,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
                 translate([side_spar_thickness/2.0,lipspaceRight,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
               } else {
                translate([0,lipspaceLeft,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
                translate([0,lipspaceRight,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
               }
          } else {
               normal_lip_spacing = acutalLipWidth / normal_lip_count;
               for(i=[0:normal_lip_count]) {
                                  if (!isReversed) {
                    translate([side_spar_thickness/2.0,lipspaceLeft + i*normal_lip_spacing,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
                                  } else {
                      translate([0,lipspaceLeft + i*normal_lip_spacing,0]) square([side_spar_thickness/2.0, material_thickness-kerf]);
                                }
                }
            }
        }
    }
    }
}
    

    
