// radius of hemispere
shellR = 15;
// radius of holes
holeR = 1.3;
// distance multiplier, depend on the radius of hole
dist = 3;   // depend on the radius of hole
// wallthickness
wall = 1.5;
// size of holes
type = "fix";    // [fix,increase,decrease]
// form of holes
holeForm = 64;             // [3:64]



// [Hidden]
$fn = holeForm;
deltA = 360 / (2 * shellR * PI / (dist * holeR));

module hole(r) {
  translate([0, shellR, 0])
    rotate([90, 0, 0])
      cylinder(r = r, h = wall * 3, center = true);
}

function search_delta(orig) =
  360 % orig == 0 ?
    360 / orig :
    search_delta(orig + 1);

module holes() {
  deltAi = search_delta(floor(360 / deltA));
  for (i = [deltAi:deltAi:180]) {
    deltAj = search_delta(floor(360 / (deltAi / cos(i))));
    for (j = [deltAj:deltAj:360]) {
      rotate([i, 0, j]) {
        if (type == "increase") {
          hole(holeR * sqrt(sin(i)));
        } else if (type == "decrease") {
          hole(holeR * sqrt(cos(i)));
        } else {
          hole(holeR);
        }
      }
    }
  }
}

module hemisphere() {
  difference() {
    sphere(r = shellR, $fn = 50);
    sphere(r = shellR - wall, $fn = 50);
    translate([-shellR - 1, -shellR - 1, -shellR - 1])
      cube([2 * shellR + 2, 2 * shellR + 2, shellR + 1]);
    holes();
  }
}

hemisphere();
