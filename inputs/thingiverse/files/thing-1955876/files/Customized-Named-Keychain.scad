// preview[view:south, tilt:top]

// The name to show
name="ROMAIN";

// Almost any font from https://fonts.google.com/
letter_font="Fontdiner Swanky";

// If the letter does not touch, try a lower letter_spacing value
letter_spacing=0.75; // [0:0.01:1.4]

// Diameter of the ring in mm
ring_diameter=3;

// Thickness of the ring
ring_thickness=1.2;

// Set an offset, so the ring is attached to the first letter
ring_offset=1.5;

// Keychain thickness
keychain_thickness=4;


ring_radius=ring_diameter/2;
// convexity is needed for correct preview
// since characters can be highly concave
linear_extrude(height=keychain_thickness, convexity=4)
                text(name, size=16,
                     font=letter_font,
                     halign="left",
                     valign="center",
                     spacing=letter_spacing);
 translate([ring_offset,1,0]) difference() {
     cylinder(keychain_thickness, ring_radius+ring_thickness, ring_radius+ring_thickness, $fn=50);
     translate([0,0,-0.5])
         cylinder(keychain_thickness+1, ring_radius, ring_radius, $fn=50);
 }