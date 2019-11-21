
height=52;
width=48;
top=10;
thickness=1.6;
$fn=60;
x_count=3;
y_count=3;
version="B"; // [0,0] module ; A B C D

r=top/2;                    // 45d.
R=width*sqrt(2)/2-top/2;    // 45d.
dr=r*sqrt(2);               // 0d.  // = width-dR
dR=R*sqrt(2);               // 0d.  // = width-dr
dim=width/2;
h=height;
t=thickness/2;

module quarter(){
    intersection() {
        cube([dim,dim,h]);
        cylinder(h,dR,dr,$fn=4);
    }
}
module single_cylinder(){
    intersection() {
        translate([-dim,-dim,0])cube([2*dim,2*dim,h]);
        cylinder(h,dR,dr,$fn=4);
    }
}
module single_4(){
    single_cylinder();
    translate([2*dim,0,0]) single_cylinder();
    translate([0,2*dim,0]) single_cylinder();
    translate([2*dim,2*dim,0]) single_cylinder();
}

module single(v) {
    intersection(){
        cube([2*dim,2*dim,h]);
        if (v=="A")
            single_4();
        else if(v=="B")
            translate([-dim,0,0]) single_4();
        else if(v=="C") 
            translate([-dim,-dim,0]) single_4();
        else if(v=="D")
            translate([0,-dim,0]) single_4();
        else ;
    }
}

function opposed(v) =
let ( m=search(v,"ABCD"), n=(m[0]+2)%4 )
"ABCD"[n];

module all(xc,yc,v){
for (x=[0:xc-1]) for (y=[0:yc-1]) {
    translate([x*2*dim,y*2*dim,-t])
        single(v);
    translate([x*2*dim,y*2*dim,h+t]) mirror([0,0,1])
        single(opposed(v));
    }
}

module reverse_all(xc,yc,v) {
    difference() {
        translate([0,0,-t])
            cube([xc*2*dim,yc*2*dim,h+2*t]);
        all(xc,yc,v);
        
    }
}

// quarter();
// single_cylinder();
// single_4();
// single(version);
// all(x_count,y_count,version);
reverse_all(x_count,y_count,version);

