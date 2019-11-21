// chess board

// size of 8x8 chess board
size=220;
// thickness of board
T=5;
// overlap between squares
overlap=2;
// tolerance for easy fit
tol=0.5;

L=(size-overlap)/8;

translate(2*L*[-1,-1,0])4x4();
*assembly();

module assembly(){
	4x4();
	rotate([0,0,180])4x4();
	translate([-4*L,0,0])4x4();
	translate([0,-4*L,0])4x4();
}

module 4x4()
difference(){
	linear_extrude(height=T)translate(-overlap/2*[1,1])difference(){
		for(i=[0:3],j=[0:3])if((i+j)%2==0)translate([i*L,j*L])square(L+overlap);
		notches2();
		translate((L*4+overlap)*[1,1])mirror([1,1])notches2();
	}
	translate([overlap+tol,overlap+tol,T])monogram();
}

module notches2(){
	notch();
	notches();
	mirror([1,-1])notches();
}

module notches(){
	translate([2*L,0])notch();
	translate([L+overlap,0])mirror([1,0])notch();
	translate([3*L+overlap,0])mirror([1,0])notch();
}

module notch()
translate([tol/2,0])difference(){
	square(2*overlap+tol*sqrt(2),center=true);
	rotate(-45)translate([0,-2*overlap])square(overlap*4);
}

module monogram(h=1)
linear_extrude(height=h,center=true)
union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}