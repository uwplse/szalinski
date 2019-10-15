$fn=100;
hoehe=50;
dm=32;
idm=27;
kragen=36;
schlitz=2;
difference(){
union(){
cylinder(hoehe+3,d=dm,d=dm);
cylinder(3,d=kragen,d=kragen);
}
union() {
cylinder(hoehe*2,d=idm,d=idm);
translate( [0,-schlitz*0.5, 0]) { cube([kragen,schlitz,hoehe*2]);}}
}
