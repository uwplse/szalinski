// Name for Nameplate. The number of letters that fit varies per width of the letters.  Try some names.  Also, try spaces before/after the name, to control centering and letter spacing for short names. 
name = " DANAL ";

union() {
  difference() {
    rotate(-90 + arcangle / 2, 0, 0)
    linear_extrude(18)
    arc(ir, or - ir, arcangle);

    translate([10.25, -58.25, 6.4])
    rotate([90, 0, 11])
    cylinder(3.5, 5.1, 5.1);

    translate([9.16, -58, 11.2])
    rotate([90, 0, 11])
    cube([2, 4.3, 3.5]);

    translate([55, -20.1, 6.4])
    rotate([90, 0, 70.5])
    cylinder(3.5, 5.1, 5.1);

    translate([55, -21.1, 11.2])
    rotate([90, 0, 70.5])
    cube([2, 4.3, 3.5]);
  }
  for (i = [0: l - 1]) {
    angle = (arcangle / l * i * .95) + angle_correction;
    dist = or - 0.1;
    translate([dist * sin(angle), dist * -cos(angle), (letter_high / 2) + high_above_baseline])
    rotate([90, 0, angle])
    linear_extrude(letter_thick)
    text(name[i], letter_high, font = "Arial Narrow",
      halign = "center",
      valign = "center");
  }
}

module arc(radius, thick, angle) {
  intersection() {
    union() {
      rights = floor(angle / 90);
      remain = angle - rights * 90;
      if (angle > 90) {
        for (i = [0: rights - 1]) {
          rotate(i * 90 - (rights - 1) * 90 / 2) {
            polygon([
              [0, 0],
              [radius + thick, (radius + thick) * tan(90 / 2)],
              [radius + thick, -(radius + thick) * tan(90 / 2)]
            ]);
          }
        }
        rotate(-(rights) * 90 / 2)
        polygon([
          [0, 0],
          [radius + thick, 0],
          [radius + thick, -(radius + thick) * tan(remain / 2)]
        ]);
        rotate((rights) * 90 / 2)
        polygon([
          [0, 0],
          [radius + thick, (radius + thick) * tan(remain / 2)],
          [radius + thick, 0]
        ]);
      } else {
        polygon([
          [0, 0],
          [radius + thick, (radius + thick) * tan(angle / 2)],
          [radius + thick, -(radius + thick) * tan(angle / 2)]
        ]);
      }
    }
    difference() {
      circle(radius + thick);
      circle(radius);
    }
  }
}

$fn = 360;
l = len(name);
arcangle = 80;
ir = 59.7;
or = 64.7;
letter_thick = 1.4;
letter_high = 15;
high_above_baseline = 1;
angle_correction = 7; //Letters are centered, each. Arc is not. This is a fudge. 


module confirm() {
  rotate(40, 0, 0)
  translate([0, 0, 50])
  color("Yellow")
  import ("C:/Users/Danal/Google Drive/3D Print/Vorpal_Hexapod_Name_Plates/files/NamePlate_-_Ambler.stl");
}
