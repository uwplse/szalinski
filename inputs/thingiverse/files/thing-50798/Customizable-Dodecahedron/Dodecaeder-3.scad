//Customizable Dodecahedron
//By allenZ
//http://www.thingiverse.com/apps/customizer/run?thing_id=50798
//Version 3
//added difference cylinder radius for hole
//allow more thick wall design

//Preview? Choose No for create STL
preview = 1; //[1:Yes,0:No]

radius = 40; //[20:100]

thickness = 40; //[4:100]

gap=1; //[1:4]

center_hole = 1; //[1:Yes,0:No]

center_hole_radius_1 = 20; //[6:80]

center_hole_radius_2 = 35; //[6:80]


if (preview == 0) dodecaeder(radius,thickness,gap);

if (preview == 1) assembler(radius,thickness);


module assembler (r,high) {
translate ([0,0,-1.3*r+high/2]) pentagonwithcut (r,high);
for (i=[0:4]) {
rotate ([0,0,i*72]) rotate ([0,180-116.565,0]) translate ([0,0,-1.3*r+high/2]) rotate ([0,0,36]) pentagonwithcut (r,high);
}

rotate ([0,0,36])
mirror([ 0, 0, 1 ]) {
translate ([0,0,-1.3*r+high/2]) pentagonwithcut (r,high);
for (i=[0:4]) {
rotate ([0,0,i*72]) rotate ([0,180-116.565,0]) translate ([0,0,-1.3*r+high/2]) rotate ([0,0,36]) pentagonwithcut (r,high);
}
}
}

module dodecaeder (r,h,g) {
union () {
flat (r,h,g);
connect (r,g);
}

d = r*cos(36);

translate ([(r+r*sin(18))*2+d*2+g+2*g/cos(36),-(r*cos(18)*2+2*g*sin(36)),0])
rotate ([0,0,36]) 
union () {
flat (r,h,g);
connect (r,g);
}

//connect two big flat
translate ([(r+r*sin(18))+d+g/2+g/cos(36),-(r*cos(18)+g*sin(36)),1/2])
cube([g*2,r,1],center=true);
}

//Modules
module pentagonwithcut (r,h) {
d_angle = 116.565;

difference() {
pentagon(r,h);

for (i=[0:4]) 
{
rotate(i*360/5+360/5/2,[0,0,1]) 
translate ([r*cos(360/10)+h/2/sin(d_angle/2)/2,0,0]) 
rotate(-(90-d_angle/2),[0,1,0]) 
cube([h,r*sin(36)*2.2,h*2],center=true);
}

if (center_hole == 1) {
	//if (cut_type == 2 ) 
	cylinder (r1=center_hole_radius_1,r2=center_hole_radius_2,h=h+2,center = true);
}

}
}

module pentagon (r,h)
{
pi=180;
c1=cos(2*pi/5);
c2=cos(pi/5);
s1=sin(2*pi/5);
s2=sin(4*pi/5);

translate ([0,0,-h/2])
linear_extrude(height = h)
scale (r,r,1)
polygon(points=[[1,0],[c1,s1],[-c2,s2],[-c2,-s2],[c1,-s1]], paths=[[0,1,2,3,4]]);

}


module flat (r,h,g) {
gr=1.618;
translate ([0,0,h/2])
union () 
{
pentagonwithcut (r,h);
for (i=[0:4]) 
{
rotate(i*360/5+360/5/2,[0,0,1]) translate ([r*gr+g,0,0])  pentagonwithcut (r,h);
}
}
}

module connect(r,g) {
translate ([0,0,1/2])

for (i=[0:4]) 
{
rotate(i*360/5+360/5/2,[0,0,1]) translate ([r*cos(36)+g/2,0,0])  cube([g*2,r,1],center=true);
}
}

