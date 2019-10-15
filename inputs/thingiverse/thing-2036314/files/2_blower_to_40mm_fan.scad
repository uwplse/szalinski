$fn = 50;

outside = 40;
screw_dia = 3.4;
plate_thickness = 2.2;
edge_dist = 2.6+(screw_dia/2);
fan_widths = 30.4;
fan_length = 19.6;
nub_height = 1.1;
nub_width = 2.5;
x_offset = (outside-fan_length)/2;
y_offset = (outside-fan_widths)/2;
center_offset = 6;
nub_small_y = (fan_widths/2)-(center_offset+nub_width);
nub_large_y = (fan_widths/2)+center_offset;


difference(){
    cube([outside, outside, plate_thickness]);
    translate([edge_dist, edge_dist, 0])
        cylinder(r = screw_dia/2, h = plate_thickness);
    translate([outside-edge_dist, edge_dist, 0])
        cylinder(r = screw_dia/2, h = plate_thickness);
    translate([edge_dist, outside-edge_dist, 0])
        cylinder(r = screw_dia/2, h = plate_thickness);
    translate([outside-edge_dist, outside-edge_dist, 0])
        cylinder(r = screw_dia/2, h = plate_thickness);
    
   translate([x_offset, y_offset, 0]){
       cube([fan_length, fan_widths, plate_thickness]);
       
        translate([-nub_height, nub_small_y, 0]){
            cube([nub_height, nub_width, plate_thickness]);
        }
       translate([fan_length, nub_large_y, 0]){
            cube([nub_height, nub_width, plate_thickness]);
       }
   }
    
}