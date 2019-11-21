dist = 5.3;
material = 6;

basex1 = 12;
basex2 = 8;
basey = 20;
basez1 = 11;
basez2 = 30;

difference() {

  mirror([0,0,1])

    difference() {
      union() {

        translate([-(material/2-dist),0,0]) cube([(material/2-dist),basey,basez1]);
        translate([-basex2-(material/2-dist),0,-basez2+basez1]) cube([basex2,basey,basez2]);
        cube([basex1,basey,basez1]);
      }

      translate([9,5,1]) cube([2.2,10,10]);

      hull() {
        translate([5,(basey-8.5)/2,0]) cube([4,8.5,1]);
        translate([1.5,(basey-14)/2,basez1]) cube([6.5,14,1]);
      }

    }


  translate([-(material/2-dist)-1,1.5,5]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(1) text(text=str(material), size=10);


}
