/**
 * Reel hub adapter to close in the open side of a flexible TUA
 * reel, so it works with the reel hub system.
 *
 * OD = outside diamter of adapter
 * ID = inside diameter of adapter
 * H = height of adapter
 * T = wall thickness for rings and struts
 */
$fa=1;
$fs=1;
OD = 83;
ID = 53;
H = 12;
T = 3;

difference(){
    cylinder(r=OD/2, h=H);
    cylinder(r=OD/2-T, h=H);
}
difference(){
    cylinder(r=ID/2+T, h=H);
    cylinder(r=ID/2, h=H);
}
difference() {
for (i = [1:12]){
   rotate(a=360*i/12,v=[0,0,1]){
       difference(){
            cube([T, OD/2-T, H]);
            cube([T, ID/2+T/2, H]);
       }
   }
}
cylinder(r=ID/2+T, h=H);
}
