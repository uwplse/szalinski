// Wall Thickness in mm (this is subtracted from the inner space of the cover, all other dimensions are outer measurements. height of 20mm, wall thickness of 1mm gives a usable inner space of 19mm height)
thickness = 2; // [0.2:0.1:50]

//Length of cover im mm (does not include screw-holders)
length = 120; // [1:1000]

//Width of cover in mm
width = 50; // [1:1000]

//Height of cover in mm
height = 30; // [1:1000]

//Width of the screwholder in mm on the side of the cover
screwholder_width = 15; // [1:100]

//How far the screwholder stands out from the cover in mm
screwholder_length = 15; // [1:100]

//How high on the box should the screwholder start to grow, higher value will lessen the overhang
screwholder_height = 15; // [1:100]

//Screhole diameter in mm 
screwhole_d = 3; // [1:100]

module screwholder() {
    difference() {
        union() {
            resize([screwholder_width, screwholder_length, screwholder_height])
            cube();
            
        }
        
        translate([thickness, 0, 0])
        resize([screwholder_width - thickness*2, screwholder_length - thickness, screwholder_height - thickness])
        cube();
        
        resize([screwholder_width+0.01, screwholder_length, screwholder_height])
        translate([0,0,1])
        rotate([0,90,0])
        linear_extrude(height=1)
        polygon(points = [[0,0], [1,0], [1,1]]);
        
        translate([screwholder_width/2, screwholder_length/2,screwholder_height-thickness])
        cylinder(d=screwhole_d, h=thickness, $fn=100);
    }
}




union() {

    difference() {
        resize([width, length, height])
        cube();
        
        translate([thickness, thickness, thickness])
        resize([width - thickness*2, length - thickness*2, height - thickness])
        cube();
    }
    
    translate([width/2 - screwholder_width/2, -screwholder_length, height - screwholder_height])
    screwholder();
    
    
    translate([width/2 - screwholder_width/2, length + screwholder_length, height - screwholder_height])
    mirror([0,1,0])
    screwholder();
}
