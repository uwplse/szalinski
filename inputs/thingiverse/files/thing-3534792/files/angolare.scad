appoggio_misX = 50;
appoggio_misY = 50;
spessore = 5;
altezza = 45;
raggio_foro = 1.5;

cube([appoggio_misX,appoggio_misY,spessore]);

difference(){
color("red");
translate([0,0,spessore])
cube([appoggio_misX,spessore,altezza-spessore]);
#translate([appoggio_misX/2,spessore,altezza/2])
rotate([90,0,0])
cylinder(spessore*2,raggio_foro);
}
