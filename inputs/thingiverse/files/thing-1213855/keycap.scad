// diameter of the key
keydiam = 24; 

// thickness of the key
keythickness = 2.5; 

// wall thickness of the key cap
wall=0.8; 

// diameter of the hole for the ring
holesize=6; 

// offset of the edge of the hole from the edge of the key
holeoutoffset = 3.2; 

// smoothing
$fn=60; 

// Text on the side of the key
text="Home";

// Font size of the text
textsize=5;

// Depth of the text. Positive depth will stand out of the cap, negative will be embosed into the cap
textdepth=-0.1;

// Vertical offset of the text
textoffset=1.5;


rotate([-90,0,180]) {
  difference() {
    difference() {
      difference() {
          if (textdepth>=0) {
            union() { 
              cylinder(r1=keydiam/2+wall, r2=keydiam/2+wall,h=keythickness+2*wall, center=true);
              rotate([0,0,180]) translate([0,-textoffset,keythickness/2+wall]) {
                linear_extrude(height=textdepth, center=false) {
                  text(text, size=textsize, halign="center", valign="center");
                }
              }
            }
         } else {
           difference() { 
              cylinder(r1=keydiam/2+wall, r2=keydiam/2+wall,h=keythickness+2*wall, center=true);
              rotate([0,0,180]) translate([0,-textoffset,keythickness/2+wall+textdepth]) {
                linear_extrude(height=-2*textdepth, center=false) {
                  text(text, size=textsize, halign="center", valign="center");
                }
              }
            }
         }

         cylinder(r1=keydiam/2, r2=keydiam/2,h=keythickness, center=true);
      }
      
      translate([0,(keydiam+2*wall)*1.25/2*1.45,0]) {
        cube(size=[1.25*(keydiam+2*wall), 1.25*(keydiam+2*wall), (keythickness+2*wall)*1.25], center=true);
      }
    }
    
    translate([0,-1 * (keydiam/2 - holesize/2-holeoutoffset),0]) {
      cylinder(r1=holesize/2, r2=holesize/2, h=2*(keythickness+2*wall), center=true);
    }
  }
}


