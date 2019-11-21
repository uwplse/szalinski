/* [Cube] */
// preview[view:south, tilt:top]
// in mm
bottom_radius = 30;
// in mm
top_radius = 40;
// in mm
tray_depth_mm = 25; 

sides = 10;
// in mm
wall_thickness = 1.5;
// in mm
floor_thickness = 1.5;

/* [Hidden] */
// ignore variable values

center_outer = [0, 0];//[hidden]
bottom_outer = [bottom_radius, 0];//[hidden]
top_outer = [top_radius, tray_depth_mm];//[hidden]
top_inner = [top_radius - wall_thickness, tray_depth_mm];//[hidden]
bottom_inner = [bottom_radius - wall_thickness, floor_thickness];//[hidden]
center_inner = [0, floor_thickness];//[hidden]

module round_tray(offset, bottomOffset){ 
  
  rotate_extrude($fn=sides) 
    polygon( points=[
      center_outer,
      bottom_outer,
      top_outer,
      top_inner,
      bottom_inner,
      center_inner
    ]
  );
      
}
// difference(){

  round_tray(0,0.1);
  // round_tray(wall_thickness, floor_thickness);
// };