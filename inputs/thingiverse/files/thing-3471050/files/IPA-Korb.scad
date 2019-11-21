 
 _vr=75; 
 _mid=60;
 _wall=3;
_height=20;
$fn=250;


// Halter
translate([_vr-_wall*2,_vr/2.5,0]) cube([_wall,20,155]);
translate([_vr/2.5,_vr-_wall*2,0]) cube([20,_wall,155]);

translate([_vr-_wall*2,_vr/2,135]) cube([_wall,20,_height]);
translate([_vr/2,_vr-_wall*2,135]) cube([20,_wall,_height]);
translate([_vr-_wall*2,_vr/2,65]) cube([_wall,20,_height]);
translate([_vr/2,_vr-_wall*2,65]) cube([20,_wall,_height]);

// fill
difference(){
    translate([_mid, _mid, 0]) cylinder(h=_height,r=15-_wall);
    translate([_mid, _mid, 0-_wall/2]) cylinder(h=_height+_wall,r=15-_wall*2);
    translate([_mid-_wall-_height, _mid-_wall-_height, 0-_wall/2]) cube([_height*2, _height+_wall/2, _height+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, 0-_wall/2]) cube([_height+_wall/2, _height*2, _height+_wall]);
}

difference(){
    translate([_mid-_wall, _mid-_wall, 0]) cylinder(h=155,r=15);
    translate([_mid-_wall, _mid-_wall, 0-_wall/2]) cylinder(h=155+_wall,r=15-_wall);
    translate([_mid-_wall-_height, _mid-_wall-_height, 0-_wall/2]) cube([_height*2, _height, 155+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, 0-_wall/2]) cube([_height, _height*2, 155+_wall]);
}
difference(){
    translate([_mid, _mid, 65]) cylinder(h=_wall*2,r=16);
    translate([_mid-_wall, _mid-_wall, 65-_wall/2]) cylinder(h=_wall*2+_wall,r=15-_wall);
    translate([_mid-_wall-_height, _mid-_wall-_height, 65-_wall/2]) cube([_height*2, _height-9, _height+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, 65-_wall/2]) cube([_height-9, _height*2, _height+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, 65-_wall/2]) cube([_height*1.6, _height, _height+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, 65-_wall/2]) cube([_height, _height*1.6, _height+_wall]);
}

difference(){
    translate([_mid, _mid, 62]) cylinder(h=_wall,r=16);
    translate([_mid, _mid, 62-_wall/2]) cylinder(h=_wall+_wall,r=15-1);
    translate([_mid-_wall-_height, _mid-_wall-_height, 62-_wall/2]) cube([_height*2, _height+8, _height+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, 62-_wall/2]) cube([_height+8, _height*2, _height+_wall]);
}

// Halter oben
difference(){
    translate([_vr, _vr, 115]) cylinder(h=40,r=45.4);
    translate([_vr, _vr, 114]) cylinder(h=42,r=25);
    translate([_vr-3, 0, 114]) cube([100, 120, 42]);
    translate([0, _vr-3, 114]) cube([120, 100, 42]);
    translate([_vr-35, _vr,114]) rotate([90,0,0]) cylinder(h=50,r=38);
}
difference(){
    translate([_vr, _vr, 115]) cylinder(h=40,r=45.4);
    translate([_vr, _vr, 114]) cylinder(h=42,r=25);
    translate([_vr-3, 0, 114]) cube([100, 120, 42]);
    translate([0, _vr-3, 114]) cube([120, 100, 42]);
    translate([_vr-50, _vr-35,114]) rotate([0,90,0]) cylinder(h=50,r=38);
}


// support
difference(){
    translate([_mid, _mid, _height]) cylinder(h=42,r=15);
    translate([_mid, _mid, _height-_wall/2]) cylinder(h=42+_wall,r=14.5);
    translate([_mid-_wall-_height, _mid-_wall-_height, _height-_wall/2]) cube([_height*2, _height+8, 42+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, _height-_wall/2]) cube([_height+8, _height*2, 42+_wall]);}
difference(){
    translate([_mid, _mid, _height+1]) cylinder(h=40,r=15.5);
    translate([_mid, _mid, _height-_wall/2]) cylinder(h=40+_wall,r=14);
    translate([_mid-_wall-_height, _mid-_wall-_height, _height-_wall/2]) cube([_height*2, _height+8, 40+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, _height-_wall/2]) cube([_height+8, _height*2, 40+_wall]);}

// Gitter
difference(){ 
    for(i = [_wall/2 : (_vr-_wall/4*3)/12 : _vr*2]) {
        translate([-_vr, -_vr+i, 0]) cube([_vr*2, 1, 2]);
        translate([-_vr+i, -_vr, 0]) cube([1, _vr*2, 2]);}
    difference(){
        color("grey") cube([160,160,_height*2],center=true);
        hull() {
            translate([-_mid, -_mid, 0]) cylinder(h=_height,r=15);
            translate([_mid, -_mid, 0]) cylinder(h=_height,r=15); 
            translate([-_mid, _mid, 0]) cylinder(h=_height,r=15); 
            translate([_mid, _mid, 0]) cylinder(h=_height,r=15); }
    }
}

// Rahmen
difference(){
    hull() {
        translate([-_mid, -_mid, 0]) cylinder(h=_height,r=15);
        translate([_mid, -_mid, 0]) cylinder(h=_height,r=15); 
        translate([-_mid, _mid, 0]) cylinder(h=_height,r=15); 
        translate([_mid, _mid, 0]) cylinder(h=_height,r=15); }
    hull() {
        translate([-_mid, -_mid, 0]) cylinder(h=_height+_wall,r=15-_wall);
        translate([_mid, -_mid, 0]) cylinder(h=_height+_wall,r=15-_wall); 
        translate([-_mid, _mid, 0]) cylinder(h=_height+_wall,r=15-_wall); 
        translate([_mid, _mid, 0]) cylinder(h=_height+_wall,r=15-_wall); }
}


// Fuss, will be printed separately, make it hot and glue on the bottom
for(i = [0 : 90 : 360]) { rotate(i) {  difference() { union() {
    translate([_mid, _mid, -10]) cylinder(h=10,r=9);
    translate([_mid, _mid, -2]) cylinder(h=2,r=13);}
    translate([_mid, _mid, -11]) cylinder(h=12,r=5);
    translate([_mid-_wall-_height, _mid-_wall-_height, -10-_wall/2]) cube([_height*2, _height+_wall, _height+_wall]);
    translate([_mid-_wall-_height, _mid-_wall-_height, -10-_wall/2]) cube([_height+_wall, _height*2, _height+_wall]);
}}}


// Ring, will be printed separately
difference() { 
    translate([0, 0, -10]) cylinder(h=5,r1=72,r2=75);
    translate([0, 0, -11]) cylinder(h=7,r1=50, r2=53 );
}


