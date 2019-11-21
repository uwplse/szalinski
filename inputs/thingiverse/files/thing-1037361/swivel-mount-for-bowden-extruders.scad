// Justfalter's Swivel Mount for Bowden Extruders
// Mike Ryan (falter@gmail.com)
// Creative Commons Sharealike Attribution license 4.0: 
//  https://creativecommons.org/licenses/by-sa/4.0/
//
// revision 1 - 2015-09-26

/* [Global] */

part="mount"; // [mount:Mount,spacer:Bearing Spacer]

mount_type="NEMA 17"; // [NEMA 14,NEMA 17,NEMA 23]

// In millimeters:
base_plate_thickness=4; // [3:0.1:5]
// Height from the bottom of the base to the top of the mount, in millimeters: 
total_height=30;  // [22:0.1:50] 

// Amount to add to the inner-diameter of the mount. Increase to give more room for the bearings, decrease to tighten things up.
fudge=0.0; // [-2:0.1:2]

/* [Hidden] */

BEARING_DIA = 22.4+fudge;
BEARING_WIDTH=7;

SPACE_FOR_BOLT_HEAD=7;
BEARING_SPACING=total_height-2*BEARING_WIDTH-SPACE_FOR_BOLT_HEAD;

$fn = 36;

print_part();

module print_part() {
  if (part == "mount") {
    print_mount();
  } else if (part == "spacer") {
    spacer();
  } else {
    print_mount();
  }
}

module print_mount() {
  // Main body of the mount:
  if(mount_type=="NEMA 17") {
    mount(31,31,3,2,6);
  } else if (mount_type=="NEMA 14") {
    mount(26,26,2.5,2,5);
  } else if (mount_type=="NEMA 23") {
    mount(47.1,47.1,5,0,0);
  } else {
    echo("ERROR: UNKNOWN MOUNT TYPE");
  }
}

module boltHolePattern(hole_x,hole_y) {
  xOffset = hole_x/2;
  yOffset = hole_y/2;
  for(i=[-xOffset,xOffset]) {
    for(j=[-yOffset,yOffset]) {
      translate([i,j,0]) children();
    }
  }
}

module boundingBox(hole_dia,hole_x,hole_y) {
  hull() boltHolePattern(hole_x,hole_y) {
    cylinder(d=hole_dia+8,h=total_height);
  }
}

module mount(hole_x,hole_y,hole_dia,hole_cs_depth,hole_cs_dia) {
  wallThickness = 2;
  outerDia = BEARING_DIA+3*wallThickness;
  difference() {
    union() {
      hull() boltHolePattern(hole_x,hole_y) {
        cylinder(d=hole_dia+8,h=base_plate_thickness);
      }
      translate([0,0,base_plate_thickness]) {
        cylinder(d=outerDia, h=total_height-base_plate_thickness);
      }

      // Curve at base
      intersection() {
        translate([0,0,base_plate_thickness]) difference() {
          v = 6.5;
          cylinder(d=outerDia+2*v, h=v);
          translate([0,0,v]) rotate_extrude() {
            translate([outerDia/2+v,0,0]) circle(r=v);
          }
        }
        boundingBox(hole_dia,hole_x,hole_y);
      }
    }

    // Main through hole.
    translate([0,0,0]) cylinder(
        d=BEARING_DIA-4, 
        h=total_height);

    spacer_bottom = total_height - BEARING_WIDTH - BEARING_SPACING;

    // tapered bottom 
    translate([0,0,0]) cylinder(d1=BEARING_DIA+1, d2=BEARING_DIA, 
      h=spacer_bottom-BEARING_WIDTH);
    translate([0,0,0]) cylinder(
      d=BEARING_DIA, 
      h=spacer_bottom
    );

    // top bearing
    translate([0,0,total_height-BEARING_WIDTH]) {
      cylinder(d=BEARING_DIA, h=BEARING_WIDTH+1);
    }
    translate([0,0,total_height-1]) {
      cylinder(d2=BEARING_DIA+1,d1=BEARING_DIA, h=2);
    }


    translate([0,0,0]) boltHolePattern(hole_x,hole_y) {
      cylinder(d=hole_dia,h=10);
      if (hole_cs_depth > 0) {
        translate([0,0,base_plate_thickness - hole_cs_depth]) cylinder(d=hole_cs_dia,h=10);
      }
    }
  }

}

module spacer() {
  d = 8.3;
  difference() {
    cylinder(h=BEARING_SPACING,d=d+4);
    translate([0,0,-1]) cylinder(h=BEARING_SPACING+2,d=d);
  }
}
