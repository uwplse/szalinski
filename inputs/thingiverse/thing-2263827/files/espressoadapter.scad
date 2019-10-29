tassendm = 61;

hoehe = 30;
abstand = 13;

rand = 3;
randhoehe = 10;

lochdm = 12-1.2;

breite = tassendm + 2*rand;

$fn=50;


difference() {
koerper();
translate([0,0,hoehe])
   hull() { cylinder(d=tassendm, h=randhoehe); translate([0,-tassendm,0]) cylinder(d=tassendm, h=randhoehe); }
  translate([16.5,tassendm/2+abstand-32,0]) lloch();
  translate([16.5,tassendm/2+abstand-32-21,0]) lloch();
  translate([-16.5,tassendm/2+abstand-32,0]) lloch();
  translate([-16.5,tassendm/2+abstand-32-21,0]) lloch();
}


module lloch() {
    hull() {cylinder(d=lochdm, h=hoehe+randhoehe); translate([0,-6,0])cylinder(d=lochdm, h=hoehe+randhoehe); }
}


module koerper() {
union() {
hull() {
translate([-breite/2+10,tassendm/2,0]) cube([breite-20,abstand,hoehe-10]);
cylinder(d=breite, h=hoehe+randhoehe);
}
translate([-22-0.6,tassendm/2+abstand-40,-2]) cube([1.2,10,2]);
translate([22-0.6,tassendm/2+abstand-40,-2]) cube([1.2,10,2]);
}
}

