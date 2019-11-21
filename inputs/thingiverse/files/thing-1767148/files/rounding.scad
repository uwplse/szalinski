// A cube with the x-y corners rounded by 'corner' radius.
// Still fits inside a 'size' cube
module round(size, corner, $fn = $fn, $fa = $fa, center=false) {
  translation = (center ? [-size[0]/2, -size[1]/2, -size[2]/2]: [0,0,0]);
  translate(translation)
    hull() {
      for (x = [corner, size[0] - corner]) {
        for (y = [corner, size[1] - corner]) {
          translate([x, y, 0])
            cylinder(r=corner, h=size[2], $fn = $fn, $fa = $fa);
        }
      }
    }
}
// Makes a cube with the x-y corners rounded by 'corner' radius
// and all edges chamfered by 'chamfer' radius. Still fits inside
// a 'size' cube.
module doubleround(size, corner, chamfer, $fn1 = $fn, $fn2 = $fn, center=false)
{
  translation = (center ? [-size[0]/2, -size[1]/2, -size[2]/2]: [0,0,0]);
  translate(translation)
    minkowski(){
      translate([chamfer, chamfer, chamfer])
        round([size[0]-2*chamfer, size[1]-2*chamfer, size[2]-2*chamfer], corner, $fn = $fn1);
      sphere(r=chamfer, $fn = $fn2);
    }
}


cube([15, 10, 5]);
translate([0,0,10])
    round([15, 10, 5], 3, $fn = 20);
translate([0,0,20])
    doubleround([15,10,5], 3, 1, $fn1 = 20, $fn2 = 20);
translate([0,0,30])
    doubleround([15,10,5], 3, 2, $fn1 = 1, $fn2 = 1);
