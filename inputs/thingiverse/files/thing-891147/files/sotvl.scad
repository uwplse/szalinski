
h=78;	//117;			//	высота цилиндра
n=10;	//16;			//	количество сот на окружности
dw=18;	//15;		//	расстояние между гранями соты
h1=5;		//4.2;			//	высота выступа соты
w=1;		//	промежуток между сотами
an=30;		//	угол наклона заострения соты

sw=1;

ds=(dw-w)/sin(360/6);
dc=((n*dw)/(2*PI))*2;
dh=dw*sin(360/6);

echo(dc);


module st() {
mirror([0,0,1])
difference() {
translate([dc/2, 0,0]) rotate([0,90,0]) cylinder(h1*2, ds/2, ds/2, $fn=6, true);
rotate([30,0,0])
for (r1=[0:2]) {
translate([dc/2+h1, 0,0]) rotate([r1*120,0,0]) rotate([0,-an,0]) translate([0.01,-dw/2,0]) cube([h1*2,dw,dw]);
//%translate([dc/2, 0,0]) rotate([r1*120-30,0,0]) translate([0,-dw/2,-h1/2]) rotate([0,0,45]) mirror([0,1,0]) cube([h1,h1,h1]);
//translate([dc/2, 0,0]) rotate([r1*120-30,0,0]) translate([-1,-dw/2-0.7,-h1/2]) rotate([0,0,15]) mirror([0,1,0]) cube([h1,h1,h1]);
} // for
} // df

} // mod st;


module stin() {
mirror([0,0,1])
difference() {
translate([dc/2-sw, 0,0]) rotate([0,90,0]) cylinder(h1*2, ds/2-sw, ds/2-sw, $fn=6, true);
for (r1=[0:2])
translate([dc/2+h1-sw, 0,0]) rotate([r1*120,0,0]) rotate([0,-an,0]) translate([0.01,-dw/2,0]) cube([h1*2,dw,dw]);
} // df

} // mod st;


module sotc() {
difference() {
union() {
translate([0,0,0])cylinder(h, dc/2, dc/2, $fn=128);

for (hn=[0:h/dh-1])
translate([0,0,hn*dh])
rotate([0,0,360/n/(hn%2+1)])
for (r=[0:n-1]) {
	 translate([0,0,dh/2]) rotate([0,0,360/n*r]) st();
//	translate([0,0,-dh/2]) rotate([0,0,360/n/2]) rotate([0,0,360/n*r]) st();
} // for

} // un
//%for (mz=[0,1]) mirror([0,0,mz])
translate([0,0,0]) mirror([0,0,1]) cylinder(ds*2, dc/2+h1*2, dc/2+h1*2, $fn=128);

translate([0,0,h]) cylinder(20, dc/2+10, dc/2+10, $fn=128);


} // df


} // mod sotc

module sotcin() {
difference() {
union() {
translate([0,0,sw]) cylinder(h+dh, dc/2-sw, dc/2-sw, $fn=128);

for (hn=[0:h/dh-1])
translate([0,0,hn*dh])
rotate([0,0,360/n/(hn%2+1)])
for (r=[0:n-1]) {
	translate([0,0,dh/2]) rotate([0,0,360/n*r]) stin();
//	translate([0,0,-dh/2]) rotate([0,0,360/n/2]) rotate([0,0,360/n*r]) stin();
} // for

} // un
//for (mz=[0,1]) mirror([0,0,mz])
translate([0,0,sw]) mirror([0,0,1]) cylinder(ds*2, dc/2+h1*2, dc/2+h1*2, $fn=128);


} // df
} // mod sotc

module vt() {
union() {
for (r=[0:10:360])
rotate([0,0,r]) {
hull() {
rotate([0,0,-10/2]) translate([dc/2+2, 0,0]) rotate([90,0,0]) rotate([0,0,r*2-20/2]) cylinder(0.1, 6/2, 6/2, $fn=6, true);
rotate([0,0,10/2])translate([dc/2+2, 0,0]) rotate([90,0,0]) rotate([0,0,r*2+20/2]) cylinder(0.1, 6/2, 6/2, $fn=6, true);
} // hl

} // for
} // un
} // mod vt


difference() {
union() {

difference() {
sotc();
//sotcin();
} // df

//translate([0,0,h/2]) vt();
//translate([0,0,-h/2+2]) vt();
} // un


translate([0,0,-h/2]) mirror([0,0,1]) cylinder(ds*2, dc/2+h1*2, dc/2+h1*2, $fn=128);
} // df

