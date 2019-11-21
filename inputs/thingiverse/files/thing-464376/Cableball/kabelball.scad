//customizable
dball=45;
dschaft=5;
dkopf=8;
dkabel=10;
sw_mutter=8;
h_mutter=5;
pos_fak=0.22;
h_fak=0.5;

translate([dball+5,0,0]){
difference(){
sphere(d=dball,$fn=100);
translate([0,0,-(dball/2)])
cube([dball,dball,dball],center=true);
rotate([0,90,0])
cylinder(d=dkabel,h=dball+5,$fn=50,center=true);

translate([dball*pos_fak,dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
cylinder(d=dkopf,h=15,$fn=50);
}
translate([-dball*pos_fak,dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
cylinder(d=dkopf,h=15,$fn=50);
}
translate([dball*pos_fak,-dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
cylinder(d=dkopf,h=15,$fn=50);
}
translate([-dball*pos_fak,-dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
cylinder(d=dkopf,h=15,$fn=50);
}
}
}

translate([0,0,0]){
difference(){
sphere(d=dball,$fn=100);
translate([0,0,-(dball/2)])
cube([dball,dball,dball],center=true);
rotate([0,90,0])
cylinder(d=dkabel,h=60,$fn=50,center=true);

translate([dball*pos_fak,dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
	cylinder(d=sw_mutter/sin(60),h=h_mutter+20, $fn=6);
}
translate([-dball*pos_fak,dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
	cylinder(d=sw_mutter/sin(60),h=h_mutter+20, $fn=6);
}
translate([dball*pos_fak,-dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
	cylinder(d=sw_mutter/sin(60),h=h_mutter+20, $fn=6);
}
translate([-dball*pos_fak,-dball*pos_fak,-1]){
cylinder(d=dschaft,h=60,$fn=50);
translate([0,0,dball/2*h_fak])
	cylinder(d=sw_mutter/sin(60),h=h_mutter+20, $fn=6);
}
}
}