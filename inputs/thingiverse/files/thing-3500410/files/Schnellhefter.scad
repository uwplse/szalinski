// -----------------------------------------------------
//  Schnellhefter / Filing Strip
//
//  Detlev Ahlgrimm, 18.03.2019
// -----------------------------------------------------

lochabstand=80;         // [40:0.1:100]
lochdurchmesser=6;      // [4:0.1:10]
staerke=1.0;            // [0.5:0.05:2]
halte_hoehe=4;          // [2:0.1:20]
laenge_nase=10;         // [5:20]
breite_ruecken=10;      // [4:20]
nasen_nach_aussen=1;    // [0:False, 1:True]

/* [Hidden] */
$fn=100;
breite_durchschub=lochdurchmesser-1;

// -----------------------------------------------------
//  ra  : Aussenradius
//  ri  : Innenradius
//  h   : Hoehe
//  a   : Oeffnungswinkel
// -----------------------------------------------------
module RohrTeil(ra, ri, h, a) {
  da=2*ra;
  difference() {
    cylinder(r=ra, h=h);
    translate([0, 0, -0.1]) cylinder(r=ri, h=h+0.2);
    if(a<=90)       translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da],                                [sin(a)*ra, cos(a)*ra]]);
    else if(a<=180) translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da], [da,-da],                      [sin(a)*ra, cos(a)*ra]]);
    else if(a<=270) translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da], [da,-da], [-da,-da],           [sin(a)*ra, cos(a)*ra]]);
    else            translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da], [da,-da], [-da,-da], [-da,da], [sin(a)*ra, cos(a)*ra]]);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module hefter(r=2) {
  la=lochabstand+staerke;
  hull() {
    translate([     breite_ruecken/2+r, 0, breite_ruecken/2]) rotate([-90, 0, 0]) cylinder(d=breite_ruecken, h=staerke);
    translate([la-(breite_ruecken/2+r), 0, breite_ruecken/2]) rotate([-90, 0, 0]) cylinder(d=breite_ruecken, h=staerke);
  }
  d=r-staerke;
  translate([   r, r, 0]) rotate([0, 0,  90]) RohrTeil(r, d, breite_durchschub, 270);
  translate([la-r, r, 0]) rotate([0, 0, 180]) RohrTeil(r, d, breite_durchschub, 270);
  translate([r, 0, 0]) cube([la-2*r, staerke, breite_durchschub]);

  translate([         0, r, 0]) cube([staerke, halte_hoehe-2*d, breite_durchschub]);
  translate([la-staerke, r, 0]) cube([staerke, halte_hoehe-2*d, breite_durchschub]);

  if(nasen_nach_aussen==1) {
    translate([  -r+staerke, staerke+halte_hoehe-d, 0]) rotate([0, 0, 270]) RohrTeil(r, r-staerke, breite_durchschub, 270);
    translate([la-staerke+r, staerke+halte_hoehe-d, 0]) rotate([0, 0,   0]) RohrTeil(r, r-staerke, breite_durchschub, 270);

    translate([  -laenge_nase+breite_durchschub/2, staerke+halte_hoehe, breite_durchschub/2]) rotate([-90, 0, 0]) cylinder(d=breite_durchschub, h=staerke);
    translate([la+laenge_nase-breite_durchschub/2, staerke+halte_hoehe, breite_durchschub/2]) rotate([-90, 0, 0]) cylinder(d=breite_durchschub, h=staerke);
    
    translate([-laenge_nase+breite_durchschub/2, staerke+halte_hoehe, 0]) cube([laenge_nase-breite_durchschub/2-r+staerke, staerke, breite_durchschub]);
    translate([                    la+r-staerke, staerke+halte_hoehe, 0]) cube([laenge_nase-breite_durchschub/2-r+staerke, staerke, breite_durchschub]);
  } else {
    translate([   r, staerke+halte_hoehe-d, 0]) rotate([0, 0,   0]) RohrTeil(r, r-staerke, breite_durchschub, 270);
    translate([la-r, staerke+halte_hoehe-d, 0]) rotate([0, 0, 270]) RohrTeil(r, r-staerke, breite_durchschub, 270);

    translate([   laenge_nase-breite_durchschub/2, staerke+halte_hoehe, breite_durchschub/2]) rotate([-90, 0, 0]) cylinder(d=breite_durchschub, h=staerke);
    translate([la-laenge_nase+breite_durchschub/2, staerke+halte_hoehe, breite_durchschub/2]) rotate([-90, 0, 0]) cylinder(d=breite_durchschub, h=staerke);

    translate([                                 r, staerke+halte_hoehe, 0]) cube([laenge_nase-breite_durchschub/2-r, staerke, breite_durchschub]);
    translate([la-laenge_nase+breite_durchschub/2, staerke+halte_hoehe, 0]) cube([laenge_nase-breite_durchschub/2-r, staerke, breite_durchschub]);
  }
}
translate([-staerke/2, 0, 0]) hefter();

//%translate([0, staerke, 0]) cube([lochabstand, halte_hoehe, lochdurchmesser]);
