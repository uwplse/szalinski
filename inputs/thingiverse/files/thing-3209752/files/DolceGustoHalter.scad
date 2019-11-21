$fn=400;

breite=121;
laenge=121;
hoehe=10;
wandstaerke=4;

// Halterung für Kapselpackung
//
difference()
{
    cube([breite + wandstaerke, laenge + wandstaerke, hoehe]);
    
    translate([wandstaerke/2, wandstaerke/2, wandstaerke/2])
    cube([breite, laenge, hoehe]);
    
    translate([breite/2-(breite-27)/2 +wandstaerke/2,laenge/2-(breite-27)/2 + wandstaerke/2,0])
    cube([breite-27, breite-27, wandstaerke]);
}

// Kleberand
//
translate([0,0,-10])
cube([breite+wandstaerke, wandstaerke/2, 10]);

// Verstärkung unten
//
/*
translate([9,0,0])
difference(){
   
    translate([0,0,0])
    rotate([90, 0, 90])
    cylinder(12,11 + wandstaerke,11 + wandstaerke);

    translate([0,-15,-20])
    cube([breite-20+0.5, 15, 40]);

    translate([0,wandstaerke/2, wandstaerke/2])
    cube([breite-20+0.5,20,20]);

    translate([0,0,+hoehe])
    cube([breite-20+0.5, wandstaerke/2, hoehe*2]);
}

translate([104,0,0])
difference(){
   
    translate([0,0,0])
    rotate([90, 0, 90])
    cylinder(12,11+wandstaerke,11+wandstaerke);

    translate([0,-15,-20])
    cube([breite-20+0.5, 15, 40]);

    translate([0,wandstaerke/2, wandstaerke/2])
    cube([breite-20+0.5,20,20]);

    translate([0,0,+hoehe])
    cube([breite-20+0.5, wandstaerke/2, hoehe*2]);
}
*/

translate([0,0,0])
rotate([90,0,90])
linear_extrude(15.5)
polygon(points=[[0,0],[laenge/2,0],[0,-10.0]]);

translate([breite-15.5+wandstaerke,0,0])
rotate([90,0,90])
linear_extrude(15.5)
polygon(points=[[0,0],[laenge/2,0],[0,-10.0]]);
