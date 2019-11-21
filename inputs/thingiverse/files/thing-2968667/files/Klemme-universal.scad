//Clamp for the mount for WLANThermo Nano, Mini, MiniV2
//Fully configurable
//(c)Armin Thinnes, Juni 2018
//Find more about the fine BBQ-thermometre at https://www.wlanthermo/de and visit the forum: https://forum.wlanthermo.de




innendurchmesser=31.25; //inner diametre, 31.25 for Napoleon handle, 25 for Weber kettle-leg
wandstaerke=3; //wallthickness
breite=25; //clamp-width
oeffnung=0.77; // percentage of diameter for the opening
flanschbreite=15; //width of flansch
flanschhoehe=5; //thickness of flansch, make sure it is > wandstaerke/2

aussendurchmesser=2*wandstaerke+innendurchmesser;
$fn=100;

module ring() {
difference(){
    cylinder (d=aussendurchmesser,h=breite);
    cylinder (d=innendurchmesser,h=breite);
    translate ([-oeffnung*innendurchmesser/2,0,0]) cube([oeffnung*innendurchmesser,aussendurchmesser,breite]);
}
}
module ring_plus(){
    ring();
    translate([-flanschbreite/2,-(innendurchmesser/2+flanschhoehe+wandstaerke/2),0]) cube([flanschbreite,flanschhoehe,breite]);
};
difference(){
    ring_plus();
    translate ([0,0,breite/2]) rotate([90,0,0]) cylinder(d=4.5, h=innendurchmesser/2+wandstaerke+flanschhoehe);
    translate ([0,0,breite/2]) rotate([90,0,0]) cylinder(d=9, h=innendurchmesser/2 + wandstaerke);
};


