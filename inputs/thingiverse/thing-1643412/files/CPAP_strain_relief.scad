FUZZ = 0.1;
THICKNESS = 2;
BRACKET_HEIGHT = 26;
BRACKET_DEPTH = 30;
PILLAR_HEIGHT = 300;
TUBE_RADIUS = 29.5;
HOSE_BRACKET_ANGLE = 90;
WIDTH = 30;
SCREW_DIAMETER = 2.5;
NUT_HEIGHT = 1.6;

module flat_nut(dia, height)
{
  out_h = 2*dia;
  out_r = out_h/sqrt(3);
	difference()
	{
		cylinder(r=out_r,h=height,$fn=6, center=true);
    cylinder(r=dia/2,h=height+FUZZ, $fn=50, center=true);
	}
}

module bracket(h, w, d) {
  difference() {
    cube([h, w, d], center=true);
    translate([0, 0, THICKNESS/2])
      cube([h-THICKNESS*2, w+2*FUZZ, d-THICKNESS+FUZZ], center=true);
    translate([-h/2+THICKNESS-NUT_HEIGHT/2+FUZZ/2,0,0])
        rotate([0,90,0]) {
         flat_nut(SCREW_DIAMETER, NUT_HEIGHT+FUZZ);
         translate([0,0,-NUT_HEIGHT/2])
          cylinder(d=SCREW_DIAMETER+FUZZ/2, h=2*THICKNESS, $fn=50, center=true);
      }
  }
}

module pillar(r, h) {
  cylinder(h, r=r);
}

module tube_collar(r, d) {
  difference() {
    cylinder(d, r=r+THICKNESS*2, center=true);
    cylinder(d+FUZZ, r=r, center=true);
  }
}

module main(bracket_h, bracket_d, pillar_h, tube_r, hose_bracket_angle) {
  translate([0, 0, tube_r+THICKNESS]) {
    translate([0,0,pillar_h+bracket_h/2])
      rotate([0,90,0])
        bracket(bracket_h, WIDTH, bracket_d, screw_d);
    pillar(WIDTH/2-THICKNESS*2, pillar_h);
  }
  rotate([90, 0, hose_bracket_angle])
    tube_collar(tube_r, WIDTH);
}

main(BRACKET_HEIGHT, BRACKET_DEPTH, PILLAR_HEIGHT, TUBE_RADIUS, HOSE_BRACKET_ANGLE);

