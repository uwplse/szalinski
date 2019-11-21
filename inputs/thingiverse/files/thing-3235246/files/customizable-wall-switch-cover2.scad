$fn = 50;

base_height=120;
base_width=76;
base_depth=7;
base_radius=5.75;
switch_height=66;
switch_width=34;
switch_depth=6;
magnet_radius=5.5;
magnet_depth=2.5;
magnet_pos=11;

difference(){
minkowski(){
//cover size
cube([base_width+1-base_radius*4+3, base_height+1-base_radius*4+3, (base_depth+switch_depth)-base_radius*2+5], center=true);
rotate([90,0,0]){
cylinder(r=base_radius, h=3, center=true);};
rotate([0,90,0]){
cylinder(r=base_radius, h=3, center=true);};
rotate([0,0,90]){
cylinder(r=base_radius, h=3, center=true);};
}
//base size
cube([base_width+1, base_height+1, (base_depth)*2], center=true);
//switch size
cube([switch_width+1, switch_height+1, (base_depth)*2+(switch_depth)*2], center=true);
//cutaway size
translate([0,0,base_depth*2+2])
cube([base_width*2, base_height*2, (base_depth+1)*4], center=true);
//magnet holes
translate([0,(base_height/2)-magnet_pos,0])
cylinder(h=(base_depth+magnet_depth)*2+1, r=magnet_radius, center=true);
translate([0,-(base_height/2)+magnet_pos,0])
cylinder(h=(base_depth+magnet_depth+1)*2, r=magnet_radius, center=true);
}