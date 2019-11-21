// Iris Box

//assembly();
//base();
ring();
//leaves();
//testbase();
//leaf();
//pin();
//pins();

d=80;// outside diameter
w1=10;// wall thickness at face
w2=2;// wall thickness at base
h=65;// height
t=5;// thickness of leaves
dp=3.1;// peg diameter
dc=3.6;// peg clearance diameter
cw=2.7;// clip width
hp=3;// peg height
t1=10;// thickness of face plate
n=40;// number of cylinders in slot
$fs=0.5;
$fa=6;

// calculations
x=(d/2-w1)/(d-w1);
theta=acos(x);
phi=90-theta;
psi=72-theta-3*phi-90;
d1=(d-w1)*sin(72-theta);
k=(d/2-w1-d1)/(72-theta-3*phi);
k1=(d/2-w1-d1)/(72-theta-3*phi+2*(90-72));
thetai=-d1/k-90;
turn1=2*asin(d1/2/(d/2-w1/2));
turn=2*phi-turn1;

module assembly(){
color([0,0,1])base();
translate([0,0,h+w1+t])rotate([180,0,-turn1-turn*$t])color([0,0,1])ring();
for (i=[0:4]){
rotate([0,0,-turn1-turn*$t+i*72])translate([(d-w1)/2,0,0])
	rotate([0,0,(sin((turn*(1-$t)+turn1)/2)-sin(turn1/2))*(d-w1)/k+turn*(1-$t)/2])
		translate([-(d-w1)/2,0,h+t])rotate([180,0,72-theta])color([1,0,0])leaf();
}}

module base(){
render()
union(){
for (i=[0:4])
	rotate([0,0,72*i])translate([d/2-w1/2,0,h])cylinder(r=dp/2,h=2*hp,center=true);
difference(){
	translate([0,0,w2])cylinder(r=d/2,h=h-w2);
	cylinder(r1=d/2-w2,r2=d/2-w1,h=h-w1/2);
	translate([0,0,h/2])cylinder(r=d/2-w1,h=h);
	for (i=[0:4])
		rotate([0,0,72*i+2*asin((w1/2+dc)/(d-w1))])translate([0,0,h-dc])track(d/2-w1/2,2*dc);
}
cylinder(r1=d/2-w2,r2=d/2,h=w2);
}
}

module track(r,w){
render()
union(){
	translate([r,0,0])cylinder(r=w/2,h=w);
	rotate([0,0,45])translate([r,0,0])cylinder(r1=w/2,r2=0,h=w);
difference(){
rotate_extrude(convexity=2,$fn=80)
	translate([r,0,0])polygon(points=[[0,w],[-w/2,0],[w/2,0]],paths=[[0,1,2]]);
translate([0,-2*r,0])cube(size=4*r,center=true);
rotate([0,0,45])translate([0,2*r,0])cube(size=4*r,center=true);
}}
}

module testbase(){
difference(){
	base();
	cube(size=2*(h-w1),center=true);
}}

module ring(){
	difference(){
		union(){
			//for (i=[0:4])
			//	rotate([0,0,72*i])translate([d/2-w1/2,0,t1]){
			//		cylinder(r=dp/2,h=2*t,center=true);
			//		translate([0,0,t])cylinder(r1=dp/2,r2=dp,h=dp);
			//	}
			translate([0,0,t1])difference(){
				scale([1,1,t1*2/w1])rotate_extrude(convexity=2)translate([d/2-w1/2,0,0])circle(r=w1/2);
				translate([0,0,d])cube(size=d*2,center=true);
			}
			for (i=[0:14]){
				rotate([0,0,i*360/15])render()translate([0,0,t1])difference(){
					scale([1,1,t1*2.5/w1])
						rotate_extrude(convexity=2)translate([d/2-w1/2,0,0])circle(r=w1/2);
					translate([0,0,d])cube(size=d*2,center=true);
					translate([0,0,-d-t1])cube(size=d*2,center=true);
					translate([0,d-(d/2-w1/2),0])cube(size=d*2,center=true);
					rotate([0,0,3])translate([d,0,0])cube(size=d*2,center=true);
					translate([-d,0,0])cube(size=d*2,center=true);
			}}
		}
		for (i=[0:4])
					rotate([0,0,72*i])translate([d/2-w1/2+0.1,0,t1]){
						cylinder(r=dc/2,h=2*t,center=true);
						translate([0,0,t])cylinder(r1=dc/2,r2=dc,h=dp);
					}
		}
}

module pins(){
	for (i=[0:4])
		rotate([0,0,72*i])translate([0,-dp*3,0]){
		pin();
		}
}

module pin(){
	difference(){
		rotate([90,0,0])translate([0,dp/2,0]){
			cylinder(r=dp/2,h=2*t,center=true);
			translate([0,0,t])cylinder(r1=dp/2,r2=dp,h=dp);
		}
		translate([0,-dp,-dp/2])cube([dp*2,2*t+dp*2,dp],true);
	}
}

module leaf(){
render()
difference(){
intersection(){
	cylinder(r=d/2,h=t);
	blob();
}
	rotate([0,0,72])blob1();
	rotate([0,0,72-theta])translate([d/2-w1/2,0,-t/2])cylinder(r=dc/2,h=2*t);
	rotate([0,0,72-theta])translate([d/2-w1/2,0,0])
		rotate([0,0,-2*phi])translate([-w1,0,0])cube(size=[2*w1,cw,3*t],center=true);
	translate([(d-w1)/2*cos(72-theta),(d-w1)/2*sin(72-theta),0])
	for (i=[0:n]){
		rotate([0,0,-i/n*(psi+90+2*(90-72))+psi+90-72])
			translate([k*(i/n*(psi+90)-90-thetai),0,t-hp-1])
			cylinder(r=dc/2,h=t);
	}
}
}

module blob(){
union(){
translate([d/2-w1,0,-t/2])cylinder(r=d/2-w1,h=2*t);
rotate([0,0,-theta])translate([d/2-w1/2,0,-t/2])difference(){
	rotate([0,0,-phi])translate([0,w1/2*(1+x),0])cube(size=[w1,w1,4*t],center=true);
	cylinder(r=w1/2,h=2*t);
}
}
}

module blob1(){
union(){
translate([d/2-w1,0,-t/2])cylinder(r=d/2-w1,h=2*t);
rotate([0,0,-theta])translate([d/2-w1/2,0,-t/2])difference(){
	rotate([0,0,-phi])translate([0,w1/2*(1+x),0])cube(size=[w1,w1,4*t],center=true);
	translate([w1/20,0,0])cylinder(r=w1/2-w1/20,h=2*t);
}
}
}

module leaves(){
for (i=[0:4])
	rotate([0,0,72*i])translate([1,-1,0])leaf();
}