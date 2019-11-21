//!OpenSCAD
scale2 = 30;
width = 2;
thickness = 2;
power = 1.5;
linear_extrude( height=thickness, twist=0, scale=[1, 1], center=false){
  union(){
    curve();
    mirror([1,0,0]){
      curve();
    }
  }
}

module curve() {
  // chain hull
  for (t = [0 : abs(1) : 360 - 1]) {
    hull() {
    point_at(t);
    point_at((t + 1));
    }  // end hull (in loop)
   } // end loop

}

module point_at(t) {
  x = (cos(t) + cos((7 * t)) / 2) - sin((17 * t)) / 3;
  y = (sin(t) + sin((7 * t)) / 2) - cos((17 * t)) / 3;
  r = sqrt(pow(x, 2) + pow(y, 2));
  translate([(scale2 * (pow(r, power) * x)), (scale2 * (pow(r, power) * y)), 0]){
    circle(r=width);
  }
}

