airplug_diameter=18.5;
airplug_height=10;
airplug_quality=96;
blowgun_cone_smaller=7;
blowgun_cone_larger=14;

module airplug_solid() {
cylinder(r=airplug_diameter/2,h=airplug_height,$fn=airplug_quality);
intersection() {
cylinder(r=airplug_diameter/2+3,h=airplug_height,$fn=airplug_quality);
translate([0,0,airplug_diameter*1.2])
sphere(r=airplug_diameter,$fn=airplug_quality);
}
}

difference(){
airplug_solid();
translate([0,0,-0.5])
cylinder(h=airplug_height+1,r1=blowgun_cone_smaller/2,r2=blowgun_cone_larger/2,$fn=airplug_quality);
}