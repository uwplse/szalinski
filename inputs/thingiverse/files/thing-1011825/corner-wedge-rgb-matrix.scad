
corner_piece_rgb_matrix();

module corner_piece_rgb_matrix () {
    // Units are in inches
    //rgb_matrix_depth = 0.55;
    //rgb_matrix_width = 7.5;
    //wedge_height = 2;
    
    // Units are in mm
    rgb_matrix_depth = 18;
    rgb_matrix_width = 190.5;
    wedge_height = 30;
    
  
    corner_wedge_face_length = rgb_matrix_width / 4;
    corner_wedge_face_height = rgb_matrix_depth * 1.5;
    corner_wedge_face_depth  = rgb_matrix_depth * 1.5;
    
    trough_width = rgb_matrix_depth;
    
    // draw dat wedge   
    difference() {  
        union() {
            cube([corner_wedge_face_length, corner_wedge_face_depth, wedge_height]);
            cube([corner_wedge_face_depth, corner_wedge_face_length, wedge_height]);        
        }
        
        union() {
            translate([corner_wedge_face_height/6, corner_wedge_face_height/6,rgb_matrix_depth/2])
              cube([corner_wedge_face_length, rgb_matrix_depth, wedge_height]);
     
            translate([corner_wedge_face_height/6, rgb_matrix_depth,rgb_matrix_depth/2])
              cube([rgb_matrix_depth, corner_wedge_face_length, wedge_height]);                
        }
        
    }
}