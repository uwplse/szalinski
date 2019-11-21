Amount = 1;

module makeSnowflake() {
  armWidth = round(rands(2,5,1)[0]);
  union(){
    cylinder(r1=5, r2=5, h=2, center=true);
    for (j = [1 : abs(1) : 6]) {
      rotate([0, 0, (60 * j)]){
        translate([15, 0, 0]){
          union(){
            dotSize = round(rands(armWidth + 2,armWidth + 10,1)[0]);
            cube([25, armWidth, 2], center=true);
            translate([0, 0, 0]){
              if (0 == round(rands(0,1,1)[0])) {
                cube([dotSize, dotSize, 2], center=true);
              } else {
                cylinder(r1=(dotSize / 2), r2=(dotSize / 2), h=2, center=true, $fn=50);
              }

            }
          }
        }
      }
    }

    translate([30, 0, 0]){
      difference() {
        cylinder(r1=5, r2=5, h=2, center=true, $fn=50);

        cylinder(r1=2, r2=2, h=4, center=true, $fn=50);
      }
    }
  }
}

for (i = [0 : abs(1) : Amount - 1]) {
  translate([(i * 60), 0, 0]){
    makeSnowflake();
  }
}