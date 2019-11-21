
Number_of_slots = 2;
height = 15;
for (i = [1 : abs(1) : Number_of_slots]) {
  translate([(i * 20), 0, 0]){
    difference() {
      cube([22, 30, height], center=true);

      translate([0, 0, 2]){
        cube([18, 26, height], center=true);
      }
    }
  }
}
