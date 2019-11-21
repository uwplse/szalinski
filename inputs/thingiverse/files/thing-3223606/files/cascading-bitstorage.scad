$fn=30;

// How many rows of bits do you want?
stairs = 4;
// How much heigher shouch each step be?
strairinc = 8;
// How many bits go on each step?
number = 10;

width = 10 * (number);

for (i=[1:stairs]) {
	row(i);
}

module row(pos) {
	translate([0, 10*(pos-1), 0])
		difference() {
				cube([width, 10, 10+(strairinc*(pos-1))]);
				for (i=[0:number-1]) {
					bit(5+10*i,5,0.5+(strairinc*(pos-1)));
				}
			}
}

module bit(x,y,z) {
	translate([0,0,4+2+z]) linear_extrude(height=8,center=true) hexagon(3.4,x,y);
}

module hexagon(r,x,y){
polygon(points=[[(r+x),(r*(tan(30)))+y],
                [x,(r*(2/sqrt(3)))+y],
                [-r+x,(r*(tan(30)))+y],
                [-r+x,-(r*(tan(30)))+y],
                [x,-(r*(2/sqrt(3)))+y],
                [r+x,-(r*(tan(30)))+y]]);

 }
