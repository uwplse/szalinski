/* [Parameters] */
tip_perimeter=64;
tip_width=17;

mid_perimeter=200;
mid_width=17;

bottom_perimeter=210;
bottom_width=17;

distance_tip_mid=24.5;
distance_mid_bottom=41.5;

thickness=2.5;

/* [Hidden] */
e=thickness;
r=8;
r2=2;
tfp=tip_perimeter;
tfw=tip_width;

mp=mid_perimeter;
mw=mid_width;

bp=bottom_perimeter;
bw=bottom_width;

dtm=distance_tip_mid;
dmb=distance_mid_bottom;

//modulos
module cubox(l1,w1,e1,r1){
hull(){
translate([l1/2-r1,w1/2-r1,0]){
cylinder(e1,r1,r1,$fn=50, center=true);
}
translate([l1/2-r1,-w1/2+r1,0]){
cylinder(e1,r1,r1,$fn=50, center=true);
}
translate([-l1/2+r1,-w1/2+r1,0]){
cylinder(e1,r1,r1,$fn=50, center=true);
}
translate([-l1/2+r1,w1/2-r1,0]){
cylinder(e1,r1,r1,$fn=50, center=true);

}
}
}


//TIP
cube(size=[tfp,tfw*0.4,e] , center=true);

difference() {
translate([0,tfw*0.5-r2/2,0]){
union(){
cube(size=[tfp*0.375+2*tfw*0.6,tfw*0.6-r2,e] , center=true);
translate([0,r2/2,0]){
cubox(tfp*0.375,tfw*0.6,e  ,r2);
}
}
}
    union() {
    translate([-(tfp*0.375/2+tfw*0.6),tfw*0.8,0]){
    cylinder(e+2,tfw*0.6,tfw*0.6, center=true);
    }
   translate([tfp*0.375/2+tfw*0.6,tfw*0.8,0]){
    cylinder(e+2,tfw*0.6,tfw*0.6, center=true);
    } 
    }

}

//MIDDLE
dtm2=dtm+0.4*tfw/2+mw/2;
translate([0,-dtm2,0]){  
cubox(mp,mw,e,r);
}

//BOTTOM
dmb2=dmb+bw/2+mw/2;
translate([0,-dtm2-dmb2,0]){  
cubox(bp,bw,e,r);
}

//union
cl=tfw+dtm+mw+dmb+bw;
translate([0,-cl/2+tfw*0.8,0]){
difference() { 
rotate([90,0,0]){ 
scale([1.3,1,1]){
cylinder(cl,3,3, center=true);
}
}
translate([0,0,-(10+e)/2]){ 
cube(size=[10,cl+10,10] , center=true);
}
}
}