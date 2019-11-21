// measurements in mm

brush_length=12; //12
brush_handle_diam=14;
thickness=1.5;
holder_height=20;
smoothness=200;

foot_diam=(brush_handle_diam/2 + brush_length)*2;

$fn=smoothness;


difference(){
    union(){
        cylinder(h=holder_height, d=brush_handle_diam+2*thickness);
        cylinder(h=thickness, d=foot_diam, $fn=6);
    }
    
    translate([0,0,-1]){
        cylinder(h=holder_height*2, d=brush_handle_diam);
    }
}

