// thickness of the wall in mm
Wall_thickness = 2;
// legth of the rack in mm
Length = 50;
// width in mm
Width = 100;
// height of the heighest rack
height = 70;
union(){
  cube([Length, Width, Wall_thickness], center=true);
  translate([(Length / 2), 0, (height / 2 + 19)]){
    rotate([0, 0, 0]){
      cube([Wall_thickness, Width, (height + 40)], center=true);
    }
  }
  translate([(Length / 6), 0, (height / 2 + 9)]){
    rotate([0, 0, 0]){
      cube([Wall_thickness, Width, (height + 20)], center=true);
    }
  }
  translate([(Length / -6), 0, (height / 2 + 4)]){
    rotate([0, 0, 0]){
      cube([Wall_thickness, Width, (height + 10)], center=true);
    }
  }
  translate([(Length / -2), 0, (height / 2 - 1)]){
    rotate([0, 0, 0]){
      cube([Wall_thickness, Width, (height + 0)], center=true);
    }
  }
}