p = 15;

r = 4;
b = 2;
b2 = 1.1;

f=1.5;
fh = 2.5;
c = .7;

module r(x,y,z){
	rotate([x,y,z]) child();
}

module t(x,y,z){
	translate([x,y,z]) child();
}

module f(){
$fn= 15;
t(r+b+f+b2,p/2 - f - b2,0)
union(){
t(0,0,b - 2)cylinder(r = fh, h=100, $fn=6);
cylinder(r=f, h=100, center=true);
}
}

module furos(){
f();
mirror([1,0,0]) f();

mirror([0,1,0])
union(){
	f();
	mirror([1,0,0]) f();
}
}

module spacer(){
t(r + r*sin(45) - c -1,0,0)
union(){
t(0,-(p+1)/2,-a/4 + -c/2)cube([l2/2,p+1,c], center=false);
t(c,-(p+1)/2,-a/4 + -c/2 + c/2) r(0,45 + 180,0) cube([r,p+1,c], center=false);
}
}


l = 2*r + 2*b;
a = 2*r + 2*b;
l2 = l + (b2*2 + f*2)*2;

$fn = 60;

difference(){
t(0,0,-b)
difference(){
union(){
/*
t(0,0,b)
	cube([l,p,a], center=true);
*/
t(0,0,b)
r(90,0,0)
	cylinder(r=r + b, h=p, center=true);


t(0,0,-a/4 + b)
	cube([l2,p,a/2], center=true);


}

union(){
t(0,0,b)
r(90,0,0)
	cylinder(r=r, h=p+1, center=true);
furos();
}
}

spacer();
mirror([1,0,0]) spacer();
}




//cube([l,p,a], center=true);