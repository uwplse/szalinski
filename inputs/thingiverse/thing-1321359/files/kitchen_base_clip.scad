/*kitchen plinth clip feb 2016 Glyn Cowles */
// diameter of pole
diam=30;
// clip height
ht=10; 
//percentage amount to cut off circle to form clip
cutpc=20;
// length to plinth from pole
len=20;
// thickness of clip
th=2; 
// diam of screw holes
holed=4; 
// base depth
based=6; 
holex=diam+th*2+holed; // distance apart of holes
basew=holex+holed*2; // screw part base width

$fn=50;
assemble();



//-------------------------------------------------
module assemble() {
    clip();     
    translate([-diam/2-len,-basew/2,0]) screwpart();     
}
 
//-------------------------------------------------
module clip() { 
    cut=(diam+2*th)*(cutpc/100);
    difference() {
        union() {
            rotate([0,0,0]) translate([-diam/2-len+based,-th/2,0]) strut();
            cylinder(r=diam/2+th,h=ht);
            }
        cylinder(r=diam/2,h=ht);
        translate([-cut+diam/2+th,-diam/2-th,0]) cube([diam,diam+th*2,ht]);
    }
}
//-------------------------------------------------
module strut() {
    cube([len,th,ht]);
    translate([0,th*3,0]) cube([len,th,ht]);
    translate([0,-th*3,0]) cube([len,th,ht]);
}
//-------------------------------------------------
module screwpart() {
    difference() {
        cube([based,basew,ht]);
        translate([0,-holex/2+basew/2,ht/2]) hol();
        translate([0,holex/2+basew/2,ht/2]) hol();
    }    
}
//-------------------------------------------------
module hol() {
    rotate([90,0,90]) cylinder(h=based,r=holed/2);   
}
//-------------------------------------------------
