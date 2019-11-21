// gyroid puzzle

L=20*1;// height of gyroid module will be L*sqrt(2)
d=L/3;// diameter of base clasps
tol=0.25*1;// tolerance on base clasps

//gyroid();
//base();

//Number of wiggles
n=3;
//Adjust the fit (positive makes it looser)
fit=0;

translate([-L*n/2,0,(3-fit)*sqrt(3)/4])connector(3-fit,4-fit,n);

// Assembly inputs: (n,type), where:
// n is the number of modules along each edge
// type = 0 to show rhombic dodecahedrons only
// type = 1 to show actual pieces
//assembly(4,1);// modules only
//totalAssembly(5,1);// modules and base modules
//attach();// animation of connectors twisting through gyroid

module attach(){
//block();
color([1,0,0])translate([-L-L/8,L/8,3*L/8])connector(3,4,3);
color([0,1,0])translate([L/8,3*L/8,L+L/8])rotate([0,90,0])connector(3,4,3);
color([0,0,1])translate([3*L/8,-L+L/8,L/8])rotate([0,0,90])connector(3,4,3);
}

module connector(h,w,n)
assign(R=L*L/(w-h)/16,theta=4*(w-h)/L*180/PI)
translate([-$t*L,0,0])rotate([$t*360,0,0])render()
for(i=[0:2*n-1])translate([L/2*i+L/4,0,0])rotate([0,0,i*180])
translate([0,-R*cos(theta),0])intersection(){
	rotate_extrude($fn=360/theta*4)translate([R,0])union(){
		translate([(w-h)/2,0])circle(r=h/2,$fn=6);
		translate([(h-w)/2,0])circle(r=h/2,$fn=6);
	}
	rotate([0,0,theta+0.1])translate([0,0,-R])cube(2*R);
	rotate([0,0,90-theta-0.1])translate([0,0,-R])cube(2*R);
}

module rhombDodeca(){
intersection(){
	rotate([0,0,45])cube(L*sqrt(2)*[1,1,2],center=true);
	rotate([0,45,0])cube(L*sqrt(2)*[1,2,1],center=true);
	rotate([45,0,0])cube(L*sqrt(2)*[2,1,1],center=true);
}}

module gyroid(){
translate([0,0,L/sqrt(2)])rotate([-45,0,90])
intersection(){
	scale(L/50)difference(){
		import("gyroidThick1.stl",convexity=10);
		import("gyroidThin1.stl",convexity=10);
	}
	rhombDodeca();
}}

module gyroid1(){
translate([0,0,L/sqrt(2)])rotate([-45,0,90])
intersection(){
	scale(L/50)difference(){
		import("gyroidThick1.stl",convexity=10);
		import("gyroidHalf1.stl",convexity=10);
	}
	rhombDodeca();
}}

module gyroid2(){
translate([0,0,L/sqrt(2)])rotate([-45,0,90])
intersection(){
	scale(L/50)difference(){
		import("gyroidHalf1.stl",convexity=10);
		import("gyroidThin1.stl",convexity=10);
	}
	rhombDodeca();
}}

module block(){
rotate([45,0,0])rotate([0,0,-90])translate(-[0,0,L/sqrt(2)])import("gyroidpuzzle.stl",convexity=10);
}

module assembly(n,type){
rotate([-acos(1/sqrt(3)),0,0])rotate([0,0,-45])translate(-L*(n-1)/2*[1,1,1])
	for(k=[0:n-1]){
	for(j=[0:n-1-k]){
	for(i=[0:n-1-k-j]){
		color([(i+1)/n,(j+1)/n,(k+1)/n])translate(i*[L,L,0]+j*[L,0,L]+k*[0,L,L])
			if(type==0) rhombDodeca(); else block();
	}}}
}

module base(){
render()
intersection(){
	translate([0,0,-L*3/4])rotate([180,0,0])union(){assembly(3,0);}
	translate([0,0,L])cube(2*L,center=true);
	difference(){
		union(){
			translate([0,0,L/4])rotate([-acos(1/sqrt(3)),0,0])rotate([0,0,-45])rhombDodeca();
			for(i=[0:5])rotate([0,0,i*60])translate([L/sqrt(2),0,-1])
				rotate([0,0,-45])translate([0,d/2,0])cylinder(r=d/2-tol/2,h=L,$fn=20);
		}
		for(i=[0:5])rotate([0,0,i*60])translate([L/sqrt(2),0,-1])
			rotate([0,0,-45])translate([0,-d/2,0])cylinder(r=d/2+tol/2,h=L,$fn=20);
	}
}}

module baseAssembly(n){
rotate([-acos(1/sqrt(3)),0,0])rotate([0,0,-45])translate(-L*(n-1)/2*[1,1,1])
	for(k=[0:n-1]){
	for(i=[0:n-1-k]){
		color([(i+1)/n,0,(k+1)/n])translate(i*[L,L,0]+k*[0,L,L])
			rotate([0,0,45])rotate([acos(1/sqrt(3)),0,0])base();
	}}
}

module totalAssembly(n,type){
assembly(n,type);
translate([0,0,-L])baseAssembly(n);
echo(str("Requires ",(n*n+n)/2," base modules"));
echo(str("Requires ",(n*n*n+3*n*n+2*n)/6," gyroid modules"));
}