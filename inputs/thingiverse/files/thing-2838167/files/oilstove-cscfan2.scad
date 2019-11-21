$fn=80;

x=37;
y=62;
z=40;

hmount=5;
Dwall=2;
Din=x-2*Dwall;
Dout=35;
Hconnect=10;



difference() {
cube(size = [x,y,z]);
translate([Dwall,Dwall,0]){
cube(size = [x-2*Dwall,y-2*Dwall,z-Dwall]);
}
translate([x/2,x/2,z-hmount]){
cylinder(hmount,d1=Din,d2=Din);
}
translate([0,y,10]){
rotate( [36,0,0], v = [x, y, z]) {
cube(size = [x,y,z]);
}
}
}

translate([0,38,z-Dwall]){
rotate( [306,0,0], v = [x, y, z]) {
cube(size = [x,38,Dwall]);
}
}


translate([x/2,x/2,z]){
difference() {
cylinder(hmount,d1=Din+2*Dwall,d2=Dout+2*Dwall);
cylinder(hmount,d1=Din,d2=Dout);
}
}

translate([x/2,x/2,z+hmount]){
difference() {
  cylinder(Hconnect,d1=Dout+2*Dwall,d2=Dout+2*Dwall);
cylinder(Hconnect,d1=Dout,d2=Dout);
}
}