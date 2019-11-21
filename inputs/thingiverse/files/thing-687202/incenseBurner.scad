/* [Cube] */
// preview[view:south, tilt:top]

mode = "Final";//[Draft, Final]

// in mm
peg_height = 13;
// in mm
peg_top_radius = 7.5;
// in mm
center_radius = 39;
// in mm
outer_radius = 40;
// in mm
tray_depth_mm = 9;

// in mm
stick_thickness = 1.3;

stick_length = 200;//Optional for final model, useful for visualization

sides = 42;
// in mm
wall_thickness = 3.5;
// in mm
floor_thickness = 3.5;

//overhang ratio, 0-1; 0 = burns straight up and down, 1 = the edge of the incense will meet the edge of the tray in a right angle. Maxium suggested is 0.8, maxes out at 1;
overhang_ratio = 0.0;

/* [Hidden] */
// ignore variable values
PI = 3.141592653589793238;
//  A
//  |\
//  | \
//a |  \ c
//  |   \
//  |    \
//  |_____\
//     b
// We know that
// c = stick_length
// b = outer_radius * overhang_ratio
//  and
// a^2 + b^2 = c^2
// so
// a^2 = c^2 - b^2
c = stick_length;
b = outer_radius * min(overhang_ratio, 1);
bPow2 = pow(b, 2);
cPow2 = pow(c, 2);
aPow2 = cPow2 - bPow2;
a = sqrt(aPow2);
// Great, now we need to get the angle for A
// which is the sin(b/c)

stickAngle = asin(b/c);
module stick(){
  rotate([0, stickAngle, 0])
    translate([max(peg_top_radius * 0.3, floor_thickness), 0, stick_length / 2 + floor_thickness])
      cube([stick_thickness, stick_thickness, stick_length], center=true);
}
if (mode == "Draft") {
  stick();
}

//co center_outer 
//bo bottom_outer 
//to top_outer 
//ti top_inner 
//bi bottom_inner 
//ci center_inner 

// This is the shape v1. Note that cu and co are not completed
// the whole shape is rotated to complete the shape
//                 ti---to
//                 |     |
//  ci------------bi     |
//                       |
//  co------------------bo
//
// Shape V2
//                 ti---to
//  ci--pt         |     |
//      pb--------bi     |
//                       |
//  co------------------bo
//pt=stick_thickness, peg_height 
//pb=stick_thickness, tray_depth 

center_outer = [0,                              0];//[hidden]
bottom_outer = [center_radius,                  0];//[hidden]
top_outer = [outer_radius,                      tray_depth_mm];//[hidden]
top_inner = [outer_radius - wall_thickness,     tray_depth_mm];//[hidden]
bottom_inner = [center_radius - wall_thickness, floor_thickness];//[hidden]
peg_bottom =   [peg_top_radius,                 floor_thickness];//[hidden]
peg_top =      [peg_top_radius,                 peg_height+floor_thickness];//[hidden]
center_inner = [0,                              peg_height+floor_thickness];//[hidden]

module round_tray(offset, bottomOffset){ 
  
  rotate_extrude($fn=sides) 
    polygon( points=[
      center_outer,
      bottom_outer,
      top_outer,
      top_inner,
      bottom_inner,
      peg_bottom,
      peg_top,
      center_inner
    ]
  );
}


//New Cone
//    nti---nto
//     |     |
//     |     |
//     |     |
//     |     |
//    nci---nco

cone_center_offset = max(peg_top_radius * 0.3, floor_thickness);

cone_center_outer =  [cone_center_offset + stick_thickness, 0];
cone_top_outer =     [cone_center_offset + stick_thickness, peg_height];
cone_top_inner =     [cone_center_offset,                   peg_height];
cone_center_inner =  [cone_center_offset,                   0];

module cone_tray(){
  rotate_extrude($fn=sides)
    rotate([0,0, -stickAngle])//stickAngle
      translate([0, floor_thickness, peg_height/2])
        polygon( points=[
          cone_center_outer,
          cone_top_outer,
          cone_top_inner,
          cone_center_inner
        ]
      );
}


//OLD CONE
//              nti---nto
//              /     /
//             /     /
//            /     /
//           /     /
//          /     /
//         /     /
//       nci---nco

// cone_center_offset = min(peg_top_radius * 0.3,floor_thickness);
// cone_center_outer =  [cone_center_offset + stick_thickness, 0];
// cone_top_outer =     [peg_top_radius+stick_thickness,      peg_height];
// cone_top_inner =     [peg_top_radius,      peg_height];
// cone_center_inner =  [cone_center_offset, 0];
// 
// 
// module cone_tray(){
//    rotate_extrude($fn=sides)
//      rotate([0,0,offset_tip_sticks_whole])
//        polygon( points=[
//         cone_center_outer,
//         cone_top_outer,
//         cone_top_inner,
//         cone_center_inner
//       ]
//   );
// }

difference(){
//number_of_sticks
//stick_thickness
  round_tray(0,0.1);
  translate([0,0,floor_thickness])
    cone_tray();
  
};