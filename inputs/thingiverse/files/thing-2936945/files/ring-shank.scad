//  Comfort-fit ring shank customizer - North American version
//  by jamcultur - jamcultur@gmail.com 

// North American ring size
Size = 9; // [0:0.25:20]
// in millimeters
Band_width = 6; // [1:0.5:15]
// in millimeters
Band_thickness = 2; // [1:0.25:5]
// in millimeters
Top_width = 10; // [0:0.5:40]
// in millimeters
Top_height = 2; // [0:0.1:5]

id = 11.63+(Size*0.8128);
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