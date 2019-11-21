module lensCover(width, height, depth, thickness = 2, logo = "Playstation Eye") {
    
    // Top section (depth)
    difference() {
        linear_extrude(thickness) {
            square([width, depth + thickness * 2]);
        }

        mirror() {
            translate([-width/2, height/2, -thickness]) {
                linear_extrude(thickness * 1.2) {
                    text(logo, size=height/3, halign="center", valign="center");
                }
            }
        }
    }
        
    // Front panel, blocking camera (height)
    color("red") {
        linear_extrude(height + thickness) {
            square([width, thickness]);
        }
    }
        
    // Back panel, behind camera
    color("blue") {
        translate([0, depth + thickness, 0]) {
            linear_extrude(height / 2 + thickness) {
                square([width, thickness]);
            }
        }
    }
}

lensCover(106, 27.5, 28.5);
