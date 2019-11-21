//Size of the bar clamp
len = 190; // [90:300]
wid=len/2.1;
rw=min(wid/4,14);
th=min(len/6,20);
// Type of the bar clamp grip
grip=14; //[20:Five-edge,14:Edged, 8:Semiround, 1:Round]
//Thickness of the barclamp
flat=10; //[5:Flat,10:Normal, 15:Thick]

winkel();
translate([th+5,th+5,0]) span(); 
translate([th+15+flat+rw,th+20,0]) bolt();
translate([th+15+flat+rw,th+50,0]) boltcap();


module boltcap(){
	cylinder(h=5,r=rw-4,r2=rw-7);
	cylinder(h=16,r=3,$fs=1);
}


module bolt(){

difference(){
union(){
	cylinder(h=len/1.7,r=6,r2=5.7);
	cylinder(h=len/5,r=rw, r2=rw-4, $fs=grip);
	translate([0,0,len/5]) cylinder(h=6,r=rw-4.2,r2=rw-1);

}
cylinder(h=len/5-3,r=rw-4, r2=rw-10);
cylinder(h=len,r=3.5,r2=3);
}
}

module span(){
sh=min(th,20);
difference(){
union(){
hull(){
	cube([flat+4,th+5,sh]);
	cube([flat+4,wid-10,sh/2]);
}
	translate([(flat+4)/2,wid-4,0]) cylinder(h=sh/2,r=9);
}
translate([2,2,0]) cube([flat+0.2,th+0.4,sh]);
translate([(flat+4)/2,wid-4,0]) cylinder(h=15,r=5.2);
}
}



module winkel(){
difference(){
union(){
cube([th,len,flat]);
cube([wid,th,flat]);
}
translate([2,2,flat/2]) cube([th-4,len-4,flat]);
translate([2,2,flat/2])  cube([wid-4,th-4,flat]);
}

pos=(th*2)-4;
c=sqrt(pos*pos+pos*pos);

translate([0,pos/2,0]) rotate([0,0,-45]) cube([c/2,2,flat]);
translate([0,pos,0]) rotate([0,0,-45]) cube([c,2,flat]);


}