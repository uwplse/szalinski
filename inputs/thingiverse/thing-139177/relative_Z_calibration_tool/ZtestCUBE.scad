//simple Z relative calibration tool by yru

//bar spacing
bs=60;
//bar radius
br=12/2;
//base radius
baser=20;
//tool width
tw=25;
//tool depth
td=10;
//tool margin
tm=5;


difference(){
union(){
translate([-td/2,-tw/2,0]) cube([10,tw,tm*2+bs+br*2]);
translate([0,0,-.1]) rotate([0,0,0]) cylinder(center=true,r=baser,h=1,$fn=44);
}
translate([0,0,tm+br]) rotate([0,90,0]) cylinder(center=true,r=br,h=td+130,$fn=44);
translate([0,0,tm+bs+br]) rotate([0,90,0]) cylinder(center=true,r=br,h=td+130,$fn=44);
}