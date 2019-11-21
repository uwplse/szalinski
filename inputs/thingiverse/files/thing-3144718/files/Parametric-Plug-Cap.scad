// Inside Diameter
id=10.2;

// Plug Depth
plug_height=6;

// Cap Diameter
od=14;

// Cap Height
cap_height=2;

// Plug Wall Thickness
t=1.5;

// Tooth Thickness
tooth_width=1.3;

// Tooth Protuberance
tooth_protube=0.65;

$fn=32;

module plug() {
  difference() {
    union() {
      cylinder(d=od, h=cap_height);

      translate([0, 0, cap_height])
        cylinder(d=id, h=plug_height);

      translate([0, 0, cap_height-tooth_width/2])
        for(i=[0:30:360]) {
          echo(i);
          rotate([7, 0, i])
            translate([-tooth_width/2, 0, 0])
            cube([tooth_width, id/2+tooth_protube, plug_height]);
        }
    }

    translate([0, 0, cap_height-1])
      cylinder(d=id-t*2, h=plug_height+1);
  }
}

plug();
