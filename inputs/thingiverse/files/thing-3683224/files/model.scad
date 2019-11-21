// Plant
plant="Thyme";

// Text Size
text_size=11;

// Anchor length (the little bit sticking out the bottom)
anchor_size=70;

// Anchor thickness (the little bit sticking out the bottom)
anchor_thickness=1.5;

// Tombstone thickness
tombstone_thickness = 10;

// How deep the letters go
letter_thickness = 1;

module tombstone_body() {
    color("gray") {
        union() {
            translate([0,-25,0])
            cube([50,50,tombstone_thickness], center=true);
            cylinder(h=tombstone_thickness, r=25, center=true);
        }
    }
}

module tombstone_text(plant="Basil", size=15) {
    font = "Times New Roman";
    translate([0,0,
        tombstone_thickness/2-letter_thickness+0.01]) {
        linear_extrude(height = letter_thickness) {
            text(
                text = "RIP",
                font = font,
                size = 15,
                halign = "center",
                valign = "center");
            translate([0,-20,0])
            text(
                text = plant,
                font = font,
                size = size,
                halign = "center",
                valign = "center");
         }
     }
 }
 
module tombstone(plant="Basil", text_size=15) {
    difference() {
        tombstone_body();
        tombstone_text(plant=plant, size=text_size);
    }
}
 
module anchor(size=70, thickness=1.5) {
    linear_extrude(height = thickness)
    polygon([[-7.5, 0.01], [7.5, 0.01], [1, -size], [-1, -size]]);
}

translate([0,50,tombstone_thickness/2])
tombstone(plant=plant, text_size=text_size);
anchor(size=anchor_size, thickness=anchor_thickness);