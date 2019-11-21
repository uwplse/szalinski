// variable description
// Which part?
part = "5tube"; // [5tube:5 Tube,4tube:4 Tube,3tubel:3 Tube lying,3tubes:3 Tube standing,tube:Single pipe,bend:Bend pipe]

// Length of front tube
lf=15; // [10:50]

// Length of back tube
lb=15; // [10:50]

// Length of top tube
lt=15; // [10:50]

// Length of left tube
ll=15; // [10:50]

// Length of right tube
lr=15; // [10:50]

// Diameter of tube
r1=10; // [5:50]

// Thickness of endtube
sf=3; // [1:10]

// Angle of bent tube
w=30;

// Diameter of bent tube
d=40;

/* [Hidden] */
r2=r1*0.9;
r3=r1*0.75;
$fn=50;
f=10;

if(part=="4tube") xtube(1);
else if(part=="3tubel") xtube(2);
else if(part=="3tubes") xtube(3);
else if(part=="5tube") xtube(4);
else if(part=="tube") tube(ts);
else if(part=="bend") bend();

/*xtube(2);
translate([s,0,0]) tube(30);
translate([-s,0,0]) tube(30);
translate([s+30,0,0]) xtube(1);
translate([-s-30,0,0]) xtube(1);
rotate ([0,0,90]) translate([53,0,0]) tube(70);
rotate ([0,0,90]) translate([106,0,0]) xtube(3);
rotate ([0,90,0]) translate([-s+10,106,0]) tube(5);
rotate ([90,0,90]) translate([106-40,s-5,0]) bend();
*/

module xtube(type) {
difference() {
    drawtube(type,false);
    drawtube(type,true);
    }
}

module drawtube(type,del) {
    // front tube
    s_tube(lf,0,0, lf,0,90,0,del);
    
    // back tube
    s_tube(lb,0,0,-lb,0,90,0,del);

    // left tube
    if(type==1 || type==2 || type==4) {
        s_tube(ll,0,0,-ll,90,0,0,del);
        if(!del) rotate([0,0,90]) translate([ll/2+sf/2,0,-r1+sf/2]) cube([ll+sf,5,sf],true); }
            
    // right tube
    if(type==4) {
        s_tube(lr,0,0,lr,90,0,0,del);
        if(!del) rotate([0,0,90]) translate([-lr/2-sf/2,0,-r1+sf/2]) cube([lr+sf,5,sf],true); }
    
    // top tube
    if(type==1 || type==3 || type==4) s_tube(lt,0,0,lt,0,0,90,del);
    
    // bottom
    if(!del) translate([(lf-lb)/2,0,-r1+sf/2]) cube([lf+lb+2*sf,5,sf],true);
}

module s_tube(l,x,y,z,wx,wy,wz,del) {
    xf=x!=0?(x>0?sf:-sf):0;
    yf=y!=0?(y>0?sf:-sf):0;
    zf=z!=0?(z>0?sf:-sf):0;
    echo(x,y,z,xf,yf,zf);
    if(!del) union() {
        rotate([wx,wy,wz]) translate([x/2,y/2,z/2]) cylinder(l,r2,r2,true);
        rotate([wx,wy,wz]) translate([x+xf/2,y+yf/2,z+zf/2]) cylinder(sf,r1,r1,true);
    }
    if(del) rotate([wx,wy,wz]) translate([x/2+xf/2,y/2+yf/2,z/2+zf/2]) cylinder(l+sf,r3,r3,true);
}

module bend() {
    rotate ([90,0,0]) translate([-d,0,0])
    difference() {
    union() {
        rotate_extrude(angle=w,convexity=10) translate([d, 0, 0]) circle(r=r2);
        rotate([90,0,0]) translate([d,0,sf/2]) cylinder(sf,r1,r1,true);
        rotate([90,0,w]) translate([d,0,-sf/2]) cylinder(sf,r1,r1,true);
    }
        rotate_extrude(angle=w,convexity=10)
        translate([d, 0, 0])
        circle(r=r3);
    
        rotate([90,0,0]) translate([d,0,sf/2]) cylinder(sf+0.1,r3,r3,true);
        rotate([90,0,w]) translate([d,0,-sf/2]) cylinder(sf+0.1,r3,r3,true);
}
}




