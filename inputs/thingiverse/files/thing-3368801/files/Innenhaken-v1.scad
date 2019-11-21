
staerke = 1.5;  // materialstaerke
breite = 10.0;   // Objektbreite
s = 5.0;
tb1 = 15.5;
th1 = 13;
tb2 = 25.5;
hh1 = 100;
hb1 = 20;
hh2 = 10;
color = "lightgreen";
/*

                _tb1_
               |     | s
           th1 |
               |
          _tb2_|
         |   
         |
         | hh1
    |    |
 hh2|____|
      hb1

*/


color(color)
//rotate([90,0,0])
{
    rotate([0, 270, 0])
        cube([hh2 + staerke, breite, staerke], false);
    cube([hb1, breite, staerke], false);

    translate([hb1 + staerke, 0, 0])
        rotate([0, 270, 0])
            cube([hh1, breite, staerke], false);

    translate([hb1 + staerke, 0, hh1 - staerke])
        cube([tb2, breite, staerke], false);
    
    translate([hb1 + staerke + tb2, 0, hh1])
        rotate([0, 270, 0])
            cube([th1 , breite, staerke], false);

    translate([hb1 + tb2, 0, hh1 + th1])
        cube([tb1+ staerke, breite, staerke], false);

    #translate([hb1 + tb2 + tb1 + staerke, 0, hh1 + th1 +staerke])
        rotate([0, 90, 0])
            cube([s+ staerke, breite, staerke], false);
}

