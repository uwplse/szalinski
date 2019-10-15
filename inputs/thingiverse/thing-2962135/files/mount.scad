/* $fn = 100; */
inner_width = 73;
inner_height = 139;
rad = 5;
thickness = 0.8;
depth = 11;
width = inner_width + (thickness * 2) - (2 * rad);
height = inner_height + (thickness * 2) - (2 * rad);
buttons_hole = 42;
buttons_hole_w = 6;
rant = 7;
over = 70;
buttons_h = 74;


mount_angle = 10;
inner_mount = 16.25;
outer_mount = 20;
mount_length = 62;

module baseblock(w=55, h=96, r=5, t=9) {
  hull() {
    cylinder(t, r=r);
    translate([w, 0, 0]) {
      translate([0, h, 0]) cylinder(t, r=r);
      cylinder(t, r=r);
      cylinder(t, r=r);
    }
    translate([0, h, 0]) cylinder(t, r=r);
  }
}



module phonecase_short() {
  short_height = height * 0.55;
  rrant = rant * 2;
  hrant = rant;
  difference() {
    baseblock(w=width, h=short_height, t=depth);
    hull() {
      translate([thickness, thickness, thickness])
        baseblock(w=width - (thickness * 2), h=short_height * 2, t=depth - (thickness * 2));
      translate([thickness + rrant, thickness + rrant, thickness])
        baseblock(w=width - ((thickness + rrant) * 2), h=short_height - (thickness * 2), t=depth);
    }
    translate([width * 1.5, short_height+rad, rad+thickness])
      rotate(-90, [0, 1, 0])
        cylinder(width * 2, r=rad);
    translate([thickness + hrant, thickness + rrant + over, -thickness])
        baseblock(w=width - ((thickness + hrant) * 2), h=short_height - (thickness * 2), t=depth);
  }
}

module phonecase() {
  rrant = rant * 2;
  hrant = rant;
  difference() {
    baseblock(w=width, h=height, t=depth);
    hull() {
      translate([thickness, thickness, thickness])
        baseblock(w=width - (thickness * 2), h=height - thickness, t=depth - (thickness * 2));
      translate([thickness + rrant, thickness + rrant, thickness])
        baseblock(w=width - ((thickness + rrant) * 2), h=height - (thickness * 2), t=depth);
    }
    translate([thickness + hrant, thickness + rrant + over, -thickness])
        baseblock(w=width - ((thickness + hrant) * 2), h=height - (thickness * 2), t=depth);
    translate([width + rad - (thickness * 1.5), buttons_h, (depth - buttons_hole_w) / 2])
      cube([thickness*2, buttons_hole, buttons_hole_w]);
  }
}

module bikemount() {
    rotate(-90 - mount_angle, [1, 0, 0])
      intersection() {
        translate([-outer_mount, -outer_mount - (outer_mount / 2), -thickness / 2])
          cube([outer_mount * 2, outer_mount * 2, mount_length + thickness]);

        difference() {
          cylinder(mount_length, r=outer_mount);
          translate([0, inner_mount / 2, -thickness])
            cylinder(mount_length + (thickness * 2), r=inner_mount);
        }
      }
}

module mount_holes() {
  space = 15;
  for (shift = [0 : space : mount_length - (space + thickness)]) {
    rotate(-mount_angle, [1, 0, 0])
      translate([0,shift,-3])
        cube([width,6.5,2]); // 6mm stepper belt (for the grip)
    translate([0,shift,-1.9])
      cube([width,5,1.8]); // zip tie
  }
}

difference() {
  union() {
    /* phonecase(); */
    phonecase_short();
    translate([0, -2*rad, 0])
      intersection() {
        translate([width / 2, 0, -8])
          bikemount();
        translate([0, rad, - 2 * outer_mount])
            cube([width, mount_length, outer_mount * 2]);
      }
  }
  mount_holes();
}
