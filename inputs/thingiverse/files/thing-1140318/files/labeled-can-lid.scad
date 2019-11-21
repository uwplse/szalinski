// Thickness of walls in mm
thickness = 1.5; //[1:0.1:2]
// The height of the overhanging lip
lid_height = 5; //[1:10]
// The diameter of the inside of the lid in millimeters
lid_inside_diameter = 85; //[10:250]
// The diameter of the entire lid in millimeters
lid_outside_diameter = lid_inside_diameter + (thickness * 2);
// The text for the first line of the label
label_text_line1 = "Can";
// The text for the second line of the label
label_text_line2 = "Lid";
// The size of the label text scaling
label_size = 2; //[0:0.1:10]
// Resolution for the cylinders--higher is rounder
roundness = 100; //[3:100]


module label(the_text) {
  scale([label_size,label_size,1]) 
    linear_extrude(height=thickness/2) 
    text(the_text, halign="center", valign="center");
}

module lid() {
  translate([0,0,lid_height / 2]) {
    difference() {
      cylinder(h=lid_height, d=lid_outside_diameter, center=true, $fn=roundness);
      
      translate([0,0,thickness])
        cylinder(h=lid_height, d=lid_inside_diameter, center=true, $fn=roundness);
      }
   }
}

module lid_engraved() {
  difference() {
    lid();
    
    mirror(0,0,180)
    if(label_text_line2 == "") {
      label(label_text_line1);
    } else {
      translate([0,lid_inside_diameter * 0.15,0])
        label(label_text_line1);
      
      translate([0,lid_inside_diameter * -0.15,0])
        label(label_text_line2);
    }
  }
}

lid_engraved();