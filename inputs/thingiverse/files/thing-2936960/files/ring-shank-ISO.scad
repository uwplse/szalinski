//  Comfort-fit ring shank customizer - ISO metric version
//  by jamcultur - jamcultur@gmail.com 

// inner circumference in mm
ISO_ring_size = 60; // [35:1:80]
// in mm
Band_width = 6; // [1:0.5:15]
// in mm
Band_thickness = 2; // [1:0.25:5]
// in mm
Top_width = 10; // [0:0.5:40]
// in mm
Top_height = 2; // [0:0.1:5]

id = ISO_ring_size/3.14159;
od = id+(Band_thickness*2);

difference() {
    rotate_extrude(convexity=8, $fn=256)
        translate([(od+id)/4, 0, 0])
            scale([(od-id)/(Band_width*2), 1, 1])
                circle(d=Band_width+0.25);
    translate([0, 0, Band_width/2]) 
        cylinder(d=od+2, h=2);   
    translate([0, 0, -(Band_width/2)-2]) 
        cylinder(d=od+2, h=2); 
    
    if (Top_width && Top_height<Band_thickness)
        translate([(id/2)+Top_height, -(id/2), -(Band_width/2)-1]) 
            cube([Band_thickness+1, id, Band_width+2]);
}

if (Top_width) {
    rect_width = min(max(Top_width, 1)-Band_thickness, od-Band_thickness);
    difference() {
        union() {
            translate([0, -rect_width/2, -Band_width/2]) 
                cube([(id/2)+Top_height, rect_width, Band_width]);
            rotate([0, 90, 0]) linear_extrude(height=Top_height+(id/2), $fn=128) { 
                translate([0, rect_width/2, -Band_width/2])                
                    scale([1, (od-id)/(Band_width*2), 1])
                        circle(d=Band_width+0.25);
                translate([0, -rect_width/2, -Band_width/2])                
                    scale([1, (od-id)/(Band_width*2), 1])
                        circle(d=Band_width+0.25);
            } 
        }
        
        translate([0, 0, -(Band_width/2)-1]) 
            cylinder(d=(id+od)/2, h=Band_width+2);
        translate([0, (rect_width/2)-(Band_thickness/2), Band_width/2]) 
            cube([(id/2)+Top_height+1, Band_thickness, 2]);
        translate([0, -((rect_width/2)+(Band_thickness/2)), Band_width/2]) 
            cube([(id/2)+Top_height+1, Band_thickness, 2]);   
        translate([0, (rect_width/2)-(Band_thickness/2), -(Band_width/2)-2]) 
            cube([(id/2)+Top_height+1, Band_thickness, 2]);
        translate([0, -((rect_width/2)+(Band_thickness/2)), -(Band_width/2)-2]) 
            cube([(id/2)+Top_height+1, Band_thickness, 2]);
    }        
}