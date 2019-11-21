$line1 = "name";
$line2 = "street";
$line3 = "city,state";
$line4 = "zip code";
translate([30,-20,2]){
rotate([180,0,180]){
union(){
linear_extrude(height=2)translate([0,0,10])square([60,40]);
    translate([0,0,-1]){
linear_extrude(height=3){
translate([2,33])text($line1,halign="left",size=5);
translate([2,23])text($line2,halign="left",size=5);
translate([2,13])text($line3,halign="left",size=5);
translate([58,3])text($line4,halign="right",size=5);
}
}
}
}
}
