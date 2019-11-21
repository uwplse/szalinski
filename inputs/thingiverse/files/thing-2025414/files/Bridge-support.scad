
width = 40;
height = 67;
track_height = 12;
support_width = 20;
thickness = 2;

$fa = 5;
$fs = 1;

extra_width = (support_width <= height) ? support_width : height;

points = [
    [-thickness,thickness/2],
    [width/2+thickness/2,thickness/2],
    [width/2+thickness/2,height-thickness/2],
    [-thickness,height-thickness/2],
    [0,height/2],
    [width/2+extra_width,thickness/2],
    [width/2+thickness/2,height+track_height],
    [width/2,height+track_height+thickness/2]
];

links = [[0,5],[1,6],[2,3],[1,4],[2,4],[6,7]];

mirX() union() {
    mesh(points, links, d=thickness, h=track_height);
    translate([width/2+extra_width+thickness/2,extra_width+thickness/2,0])
        rotate(-45)
            arc(h=track_height,d=extra_width*2+thickness,d2=extra_width*2-thickness, a=82);
}




module arc(h, d, t, a=360, d1=false, d2=false) {
	outerD = (d1==false) ? d : d1;
	innerD = (d2==false) ? d-t*2 : d2;
	2dia = 2*d;
	difference() {
	 	difference() {
			cylinder(h=h, d=d, center=true);
			cylinder(h=h+1, d=innerD, center=true);
		}
		//triangle
		if(a<360) {
			linear_extrude(height = h+1, center = true, convexity=10)
				polygon(points=[[0,0],[2dia*sin(a/2),-2dia*cos(a/2)],[2dia,-2dia],[2dia,2dia],[-2dia,2dia],[-2dia,-2dia],[-2dia*sin(a/2),-2dia*cos(a/2)]]);
		}
	}
}

module mesh(p, x="All", d=5, h=5, shape="cylinder", cenTrue=true) {
	//echo(len(d));
	d= (len(d)>1) ? d : [d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d,d];
	//x = (x=='Chain') ? [ for (i = [0:len(p)]) [i,i+1] ] : x;
	all= (x=="All") ? true : false;
	if (all==false) {
		for(i = x) {
			hull() {
				//echo(d[i[0]], d[i[1]]);
				translate(p[i[0]]) part(shape, d=d[i[0]], h=h, center=cenTrue);
				translate(p[i[1]]) part(shape, d=d[i[1]], h=h, center=cenTrue);
			}
		}
	} else {
		for(i = [0:len(p)-1]) {
			for(j = [i:len(p)-1]) {
				hull() {
					echo(i, j, p[i], p[j]);
					translate(p[i]) part(shape, d=d[i], h=h, center=cenTrue);
					translate(p[j]) part(shape, d=d[j], h=h, center=cenTrue);
				}
			}
		}
	}
	module part(type, d, h=0, cenTrue=true) {
		if(type=="cube") {
			cube([d,d,h], center=cenTrue);
		}
		if(type=="sphere") {
			sphere(d=d, center=cenTrue);
		}
		if(type=="cylinder") {
			cylinder(d=d, h=h, center=cenTrue);
		}
	}
}

module mir(plane=[1,0,0]) {
	children();
	mirror(plane)
		children();
}
module mirX() {children(); mirror([1,0,0]) children();}
module mirY() {children(); mirror([0,1,0]) children();}
module mirZ() {children(); mirror([0,0,1]) children();}
