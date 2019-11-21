ga=180*(3-sqrt(5));
phi=((sqrt(5)+1)/2);

//number of blades
bladecnt=16; //[2:24]

//motor or generator shaft radius
rshaft=2.6;

ppmm=5;
$fn=32;
$fa=360;

module BezConic(p0,p1,p2,steps=5) {
	stepsize1 = (p1-p0)/steps;
	stepsize2 = (p2-p1)/steps;

	for (i=[0:steps-1]) {
		assign(point1 = p0+stepsize1*i) 
		assign(point2 = p1+stepsize2*i) 
		assign(point3 = p0+stepsize1*(i+1))
		assign(point4 = p1+stepsize2*(i+1))  {
			assign( bpoint1 = point1+(point2-point1)*(i/steps) )
			assign( bpoint2 = point3+(point4-point3)*((i+1)/steps) ) {
				polygon(points=[bpoint1,bpoint2,p1]);
			}
		}
	}
}

module BezCone(r="Null", d=30, h=40, curve=-3, curve2="Null", steps=50) {
	d = (r=="Null") ? d : r*2;
	curve2 = (curve2=="Null") ? h/2 : curve2;
	p0 = [d/2, 0];
	p1 = [d/4+curve, curve2];
	p2 = [0, h];
	if( p1[0] < d/4 ) { //concave
		rotate_extrude($fn=steps)  {
			union() {
				polygon(points=[[0,0],p0,p1,p2,[0,h]]);
				BezConic(p0,p1,p2,steps);
			}
		}
	}
	if( p1[0] > d/4) { //convex
		rotate_extrude($fn=steps) {
			difference() {
				polygon(points=[[0,0],p0,p1,p2,[0,h]]);
				BezConic(p0,p1,p2,steps);
			}
		}
	}
	if( p1[0] == d/4) {
		echo("ERROR, BezCone, this will produce a cone, use cylinder instead!");
	}
	if( p1[0] < 0) {
		echo("ERROR, BezCone, curve cannot be less than radius/2");
	}
}

module element(h,r){
//translate([0,0,h/2])scale([r/2,r/2,h/2])sphere(r=1);
cube([0.05,r,h]);
}


module blade(h, angle, start, stop)
rotate([0,0,angle])
for ( i = [start*PI : 0.05 : stop*PI] )
{assign(r=exp(2*ln(phi)/PI*i),r1=exp(2*ln(phi)/PI*(i+0.1)))
hull(){
rotate([0,0,180*(i/PI)]) translate([r, 0, 0]) rotate([0,-22.5,0])element(h=h,r=2.4);
rotate([0,0,180*((i+0.1)/PI)]) translate([r1, 0, 0]) rotate([0,-22.5,0])element(h=h,r=2.4);
}}


//union(){
//translate([0,0,-1])cylinder(h=2.4,r=49);
//difference(){
//translate([0,0,-4])cylinder(h=12.3,r=59,$fn=360);
//cylinder(h=9.3,r=49,$fn=360);
//ventring(2,47.8269,1);
//}
difference(){union(){
for ( i = [1:bladecnt] ){
blade(5,i*360/bladecnt-5,0,4.05);
//blade(5,i*90+45,0,4);
}//}

//BezCone(d=100,h=6,curve=-25);

difference(){
union(){
for ( i = [1:bladecnt] ) {
    rotate([90,0,i*360/bladecnt])
    scale([2.5,1,1])cylinder(h=48,r=1,$fn=96);}
    rotate_extrude($fn=360){translate([-48,0,0])
    rotate([0,180,90])
    difference(){scale([1,5]) circle(r=1); 
    translate([0,-2.5,0])square([1,5]);}
}}
translate([0,0,-1])cylinder(h=1,r=55);

}
cylinder(h=5,r1=8.5,r2=6,$fn=128);}
difference(){cylinder(h=5,r=55,$fn=360);cylinder(h=5,r1=48,r2=46,$fn=360);}
cylinder(h=5,r=rshaft,$fn=128);
}

module ventring(rexit,r,step){
//bigger growing channel
//union(){
//for ( i = [180 : step : 360] )
//{
//hull(){
//rotate([0,0,-i]) translate([r+i/360*rexit, 0, i/360*rexit]) sphere(r=i/360*rexit,$fn=i/360*rexit*2*PI);
//rotate([0,0,-i-step]) translate([r+(i+step)/360*rexit, 0, (i+step)/720*rexit]) sphere(r=(i+step)/360*rexit,$fn=i/360*rexit*2*PI);
//if(i==360){
//rotate([0,0,-i-step]) translate([r+(i+step)/360*rexit, 0, (i+step)/720*rexit]) rotate([30,67.5,0]) cylinder(r=rexit,h=9);
//}
//}}}
rotate_extrude(convexity = 10, $fn = step*360)
translate([r, 0, 0])
circle(r = rexit, $fn = 42);
}



//for ( i = [0 : 1 : 99] )
//{
	//hull(){
	//rotate([0,0,ga*(i+0.1)]) translate([3*phi*(i+0.1), 0, pow(3/(i+0.1),phi)]) sphere(r=3);
	//rotate([0,0,ga*i]) translate([3*phi*i, 0, pow(3/i,phi)]) sphere(r=3);
//}

//hull(){
//rotate([0,0,ga*i*3]) translate([phi*i, 0, 0]) cube([1.2,1.2,5]);
//rotate([0,0,ga*(i+1)*3]) translate([phi*(i+1), 0, 0]) cube([1.2,1.2,5]);
//}
//}

//difference(){
//cylinder(r=phi*100,$fn=2*PI*phi*100*ppmm);
//for (i=[0:1:99]){rotate([0,0,ga*i*3]) translate([phi*i, 0, 0]) cylinder(r=2.5,$fn=2*PI*2*ppmm);}}