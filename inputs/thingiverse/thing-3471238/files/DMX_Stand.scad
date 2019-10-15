// DMX stand for the Stairville DMX-Master
rotate([0,180,0]) {
  difference() {
    translate([0,0,70]) cube([100,100,5]);
    translate([27,15,76]) sphere($fn=256, 5);
    translate([27,85,76]) sphere($fn=256, 5);
    translate([93,-5,65]) rotate([0,45,0]) cube([15,110,15]);
  }
  difference() {
    hull() {
      translate([0,0,65]) cube([50,100,5]);
      translate([0,20,0]) rotate([0,90,0]) cylinder($fn=256, 50,r=40);
      translate([0,80,0]) rotate([0,90,0]) cylinder($fn=256, 50,r=40);
    }
    hull() {
      translate([-10,50,25]) rotate([0,90,0]) cylinder($fn=256, 110,r=40);
      translate([-10,50,-5]) rotate([0,90,0]) cylinder($fn=256, 110,r=55);
    }
    hull() {
      translate([50,-50,40]) rotate([0,90,90]) cylinder($fn=256, 200,r=30);
      translate([50,-50,-500]) rotate([0,90,90]) cylinder($fn=256, 200,r=30);
    }
    translate([-10,-50,-50]) cube([50,200,50]);
  }
}