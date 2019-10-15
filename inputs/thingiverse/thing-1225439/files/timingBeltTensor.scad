
//Wrench size of the nut
NutWrenchSize=5.7;

//Nut Height
NutHeight=2.8;

//Diameter of bolt 
Diameter=4;

//Nut to wall ratio
NutFixingRatio=1.5;

//Bolt Head diameter
BoltHeadD=6.5;

//Bolt Head Height
BoltHeadH=2;

//Belt Width
BeltWidth=7;

//Belt Height
BeltHeight=1.8;

//Wall thickness
Wall=1.2;

//Open option
IsOpen=true;

module pole(r,h){
    intersection(){
        cube([r,r,h]);
        cylinder(r=r,h=h);
    }
}

module frame(l,w, wall=2,space=2){
    r= l/3-space;
    h=r+wall;
    union() {
        cube([l,wall,h]);
        translate([0,w-wall,0]) cube([l,wall,h]);
        translate([0,w,0]) rotate([90,0,0]) pole(r,w);
        translate([l,w,0]) rotate([90,-90,0]) pole(r,w);
        translate([l/3,0,0]) cube([l/3,w,h]);
    }
}

module part1(nws,nh,nsr,w1d,w2d,w2h,bw,bh){
    wall=Wall;
    nd=nws*2*sqrt(3)/3;
    echo(nd);
    w=bw+wall*2;
    difference(){
        frame((nd*nsr)*3,w, wall, bh);
        translate([(nd*nsr)*1.5,w/2,0]) cylinder(d=nd,h=nh,$fn=6);
        translate([(nd*nsr)*1.5,w/2,0]) cylinder(d=w1d,h=(nd*nsr));
        translate([(nd*nsr)*1.5,w/2,(nd*nsr)-w2h]) cylinder(d=w2d,h=w2h);
        if(IsOpen){
            translate([(nd*nsr)-bh,0,0]) cube([bh,Wall,(nd*nsr)]);
            translate([(nd*nsr)*2,0,0]) cube([bh,Wall,(nd*nsr)]);
        }
    }
}

module part2(nws,nsr,w1d,bw,bh){
    nd=nws*2*sqrt(3)/3;
    l=nd*nsr;
    difference(){
        union(){
            translate([0,0,-Wall]) cylinder(d=l+bh*2,h=Wall);
            cylinder(d=l,h=bw);
            translate([0,0,bw]) cylinder(d=l+bh*2,h=Wall);
        }
        translate([-(l+bh*2)/2,0,-Wall]) cube([l+bh*2,(l+bh*2)/2,bw+2*Wall]);
        translate([0,0,bw/2]) sphere(d=w1d);
    }
}

part1(NutWrenchSize,NutHeight,NutFixingRatio,Diameter,BoltHeadD,BoltHeadH,BeltWidth,BeltHeight);
translate([-BeltWidth-3,Wall,0]) rotate([-90,0,0])
part2(NutWrenchSize,NutFixingRatio,Diameter,BeltWidth,BeltHeight);