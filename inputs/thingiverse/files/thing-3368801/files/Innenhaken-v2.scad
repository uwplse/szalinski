
staerke_zarge = 1;    // materialstaerke an der Zarge (tb1, th1, tb2)
staerke = 4.0;          // Materialstärke der restlichen komponenten
breite = 12.0;          // Objektbreite
s = 5.0;
tb1 = 14.5; 
th1 = 13;
tb2 = 24.5;
hh1 = 100;
hb1 = 20;
hh2 = 10;
hhs = 20;               // Support, damit der Halter sich nicht zu stark biegt
versteifungen_an_tuer = true;  // Support: zus. Versteifung des Hakens (hh1, hh2, hb1, hhs)
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
     hb1 | 
         |hhs

*/

grundaufbau();
support();

if (versteifungen_an_tuer)
    versteifungen();



//color(color)
//rotate([90,0,0])
module grundaufbau() {
    rotate([0, 270, 0])
        cube([hh2 + staerke, breite, staerke], false);
    cube([hb1, breite, staerke], false);

    translate([hb1 + staerke, 0, 0])
        rotate([0, 270, 0])
            cube([hh1, breite, staerke], false);

    // Design des Hakens zwischen Tuer und Zarge
    color("lightgray")
    translate([hb1 + staerke, 0, hh1 - staerke_zarge])
        cube([tb2, breite, staerke_zarge], false);

    color("green")
    translate([hb1 + staerke + tb2, 0, hh1])
        rotate([0, 270, 0])
            cube([th1 , breite, staerke_zarge], false);

    color("yellow")
    translate([hb1 + staerke + tb2 - staerke_zarge, 0, hh1 + th1])
        cube([tb1+ staerke, breite, staerke_zarge], false);

    color("lightblue")
    translate([hb1 + staerke + tb2 - staerke_zarge + tb1+staerke, 0, hh1 + th1 +staerke_zarge])
        rotate([0, 90, 0])
            cube([s+ staerke_zarge, breite, staerke_zarge], false);
}

module support() {
    translate([hb1, 0, 0])
        rotate([0, 90, 0])
            cube([hhs + staerke, breite, staerke], false);
}

module versteifungen() {
    rotate([0, 45, 0])
        cube([sqrt((hb1*hb1 * 2)), breite, staerke], false);
}

