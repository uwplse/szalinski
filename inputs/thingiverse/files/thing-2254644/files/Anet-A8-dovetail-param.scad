// 1=left arm, 2=right arm, 3=bracket, 4=test F, 5=test M
piece=1;
// 0=no clearance, 0.2=lots of clearance (very loose)
looseness = 0.1;
// add "anti warp" grooves (0=no,1=yes)
groovy = 0;
// tower (arm) height, mm
height = 150;
// arc sections (higher=smoother arcs/cylinders)
$fn=72;

/* [Hidden] */
width = 15;
thick = 15;
base_width = 29.45;
dovetail_length = 150;

// hole distance from top edge of frame
bracket_hole1 = 20;
bracket_hole2 = 13+2*25.4;
bracket_width = 15;
bracket_thick = 7.0;

one_layer = 0.3;

module triangle(s) { // s = [x,y,z] = x wide, y high right facing right triangle, thickness z
    linear_extrude(s[2]) polygon([[0,0],[0,s[1]],[s[0],0]]);
}

module bracket() {
    union() {
        translate([0,-bracket_hole2-2,0]) cube([bracket_width, bracket_hole2+2, bracket_thick]);
        translate([bracket_width,0,bracket_thick]) rotate([180,0,0]) triangle([base_width - width, bracket_hole2+2, bracket_thick]);
    }
}

module dove2(w=10,l=100,mf=0,loose=0.1) {
    A = w / 5;
    //h = a * 1.5;
	//b = a + loose * 4;
	//c = a + loose * 2;
    s = mf==0?loose:-loose;
    s14 = s * 1.4;
    
    a = [-A, 2*A];
    aa = [-A, -2*A];
    b = [-A, 0+s];
    c = [1.5*A-s14, 0+s];
    d = [A-s14, A+s];
    e = [3*A+s14, A+s];
    f = [2.5*A+s14, 0+s];
    g = [3*A+s14, 0+s];
    h = [2.5*A+s14, -A+s];
    i = [3.5*A-s, -A+s];
    j = [4*A-s-s14, 0+s];
    jj = [4*A+s, 0+s];
    k = [4.5*A+s, 0+s];
    l = [4.5*A+s, -2*A];
    m = [6*A, -2*A];
    n = [6*A, 2*A];    
    
	if (mf == 0) {	
		points = [a,b,c,d,e,f,g,h,i,j,jj,k,l,m,n];
		difference() {
			translate([-w/2,0,0]) linear_extrude(l) polygon(points);
//			translate([w/2,h,-w/10]) mirror([1,0,0]) rotate([90,0,0]) triangle([w/2,w/2,h*2/3]);
//			translate([-w/2,h,-w/10]) rotate([90,0,0]) triangle([w/2,w/2,h*2/3]);
//			translate([w/2,h,l+w/10]) mirror([1,0,0]) rotate([90,90,0]) triangle([w/2,w/2,h*2/3]);
//			translate([-w/2,h,l+w/10]) rotate([90,90,0]) triangle([w/2,w/2,h*2/3]);
//			translate([-w/2,h/3,0]) cube([c,a,l]);
//			translate([w/2-c,h/3,0]) cube([c,a,l]);
		}		
	} else {
		points2 = [aa,b,c,d,e,f,g,h,i,jj,k,l];
		difference() {
			translate([-w/2,-4*h/3,0]) linear_extrude(l) polygon(points2);
//			translate([0,-h/3,-w/10]) mirror([1,0,0]) rotate([90,0,0]) triangle([w/2,w/2,h*2/3]);
//			translate([0,-h/3,-w/10]) rotate([90,0,0]) triangle([w/2,w/2,h*2/3]);
//			translate([0,-h/3,l+w/10]) mirror([1,0,0]) rotate([90,90,0]) triangle([w/2,w/2,h*2/3]);
//			translate([0,-h/3,l+w/10]) rotate([90,90,0]) triangle([w/2,w/2,h*2/3]);
//			translate([-b/2,-h/3-a,0]) cube([b,a,l]);

		}
	}
}

module dove(w=10,l=100,mf=0,loose=0.1) {
    A = w / 4;
    p = 0.3;
    //h = a * 1.5;
	//b = a + loose * 4;
	cc = A + loose * 2.5;

    s = mf==0?loose:-loose;
    s2 = mf==0?0:loose * 1.5;
    s3 = mf==0?loose:0;
    s14 = s * 1.0;

    a = [1.5*A+s14, 0+s2];
    b = [A+s14, A-s3];
    c = [3*A-s14, A-s3];
    d = [2.5*A-s14,0+s2];
    e = [4*A, 0+s2];
    f = [4*A, 2*A];
    g = [0, 2*A];
    h = [0,0+s2];
    
	if (mf == 0) {
		//points = [[0,0],[0,h/3-loose],[3*w/8+loose,h/3-loose],[w/4+loose,h-loose],[3*w/4-loose,h-loose],[5*w/8-loose,h/3-loose],[w,h/3-loose],[w,0]];
        points = [a,b,c,d];
		difference() {
			translate([-w/2,0,0]) linear_extrude(l) polygon(points);
            // taper ends
			translate([w/2,w/2,-w/10]) mirror([1,0,0]) rotate([90,0,0]) triangle([w/2,w/2,w]);
			translate([-w/2,w/2,-w/10]) rotate([90,0,0]) triangle([w/2,w/2,w]);
			translate([w/2,w/2,l+w/10]) mirror([1,0,0]) rotate([90,90,0]) triangle([w/2,w/2,w]);
			translate([-w/2,w/2,l+w/10]) rotate([90,90,0]) triangle([w/2,w/2,w]);
            // knock off outside points
			translate([-w/2,0,0]) cube([cc,A,l]);
			translate([w/2-cc,0,0]) cube([cc,A,l]);
		}		
	} else {
		//points2 = [[0,4*h/3],[0,h/3+loose],[3*w/8-loose,h/3+loose],[w/4-loose,h+loose],[3*w/4+loose,h+loose],[5*w/8+loose,h/3+loose],[w,h/3+loose],[w,4*h/3]];
        points2 = [a,b,c,d,e,f,g,h];
		difference() {
			translate([-w/2,-4*h/3,0]) linear_extrude(l) polygon(points2);
            // taper the ends
			translate([0,A,-w/10]) mirror([1,0,0]) rotate([90,0,0]) triangle([w/2,w/4,w]);
			translate([0,A,-w/10]) rotate([90,0,0]) triangle([w/2,w/4,w]);
			translate([0,A,l+w/10]) mirror([1,0,0]) rotate([90,90,0]) triangle([w/4,w/2,w]);
			translate([0,A,l+w/10]) rotate([90,90,0]) triangle([w/4,w/2,w]);
			translate([-A/2-loose*3,0,0]) cube([A+loose*6,A,l]);    // knock off the inside points
		}
	}
}

//color("lightblue") dove(mf=0,loose=0.1);
//color("lightgreen") dove(mf=1,loose=0.1);

module dovetail() {
	// LCD hole pattern is 6" x 2"
    //render() 
    {
        difference() {
            union() {
                difference() {
                    union() {
                        // left and right bracket arms
                        translate([dovetail_length/2,0,-bracket_thick]) bracket();
                        translate([-dovetail_length/2,0,-bracket_thick]) mirror([1,0,0]) bracket();
                        // filler above mounting holes
                        translate([-3*25.4,-5,-bracket_thick]) cube([6*25.4,5,bracket_thick]);
                        // ears for mounting holes
                        for(x=[-3*25.4,3*25.4]) for(y=[-10,-10-2*25.4]) translate([x,y,-bracket_thick]) cylinder(d=10,h=bracket_thick);
                        // filler for top mounting hole ears
                        for(x=[-3*25.4,3*25.4]) for(y=[-10]) translate([x-5,y,-bracket_thick]) cube([10,5,bracket_thick]);
                    }
                    // mounting holes
                    for(x=[-3*25.4,3*25.4]) for(y=[-10,-10-2*25.4]) translate([x,y,-bracket_thick-1]) cylinder(d=4,h=bracket_thick+2);
                    // cut away clearance for LCD PCB
                    for(x=[-3*25.4,3*25.4]) translate([x-5,-5-2*25.4,-bracket_thick-1]) cube([10,2*25.4-10,bracket_thick+2]);
                    // lightening holes in bracket arms
                    for(x=[-1,1]) {
                        translate([91.5*x,-10,-bracket_thick-1]) cylinder(d=15,h=bracket_thick+2);
                        translate([90*x,-26.5,-bracket_thick-1]) cylinder(d=12,h=bracket_thick+2);
                        translate([88.5*x,-40,-bracket_thick-1]) cylinder(d=9,h=bracket_thick+2);
                        translate([87.5*x,-51,-bracket_thick-1]) cylinder(d=7,h=bracket_thick+2);
                        translate([86.0*x,-60,-bracket_thick-1]) cylinder(d=6,h=bracket_thick+2);
                    }
                }
                rotate([270,0,0]) {
                    base=15;
                    union() {
                        translate([-dovetail_length/2-base_width,0,0]) cube([dovetail_length+base_width*2, bracket_thick, 35]);
                        translate([-dovetail_length/2-base_width,bracket_thick,0]) cube([dovetail_length+base_width*2, base-bracket_thick, 5]);
                    }
                    translate([-dovetail_length/2-base_width,bracket_thick,thick/2+5+2-1.9]) rotate([0,90,0]) dove(thick, dovetail_length+base_width*2, mf=0, loose = looseness);
                    translate([-dovetail_length/2-base_width,bracket_thick,thick/2+5+15.1]) rotate([0,90,0]) dove(thick, dovetail_length+base_width*2, mf=0, loose = looseness);
                }
            }
            if (groovy) {
                for(x=[-92:23:92]) translate([x,-10,0]) rotate([270,0,0]) cylinder(d=2,h=50);
            }
        }
    }
}

module arm(leftright=1) {
    //render() 
    {
        t = thick * 7 / 8;
        m = leftright==0?[0,0,0]:[1,0,0];
        n = leftright==0?[1,0,0]:[0,0,0];
        mirror(m)
        translate([0,0,0])
        difference() {
            union() {
                difference() {
                    union() {
                        translate([0,0,0]) cube([width, height + 7, t]);
                        translate([width,0,0]) triangle([base_width - width, height, t]);        
                    }
                    translate([-1,-1,thick/2-6]) cube([40,thick+1,thick/2+6]);
                    translate([28,-1,-1]) cube([5,thick+1,t+2]);
                }
                translate([28,thick/2,thick/2]) rotate([-90,0,90]) dove(thick, 28, mf=1, loose = looseness);
                translate([28,thick/2-thick,thick/2]) rotate([-90,0,90]) dove(thick, 28, mf=1, loose = looseness);
            }
            translate([-1,height,t/2]) rotate([0,90,0]) cylinder(d=8.25, h=width);
            translate([-1,height,t/2-8.25/2]) cube([width,8,8.25]);
            if (groovy) {
                for(y=[20:20:height]) translate([-1,y,0]) rotate([0,90,0]) cylinder(d=3,h=base_width+2);
                for(y=[20:20:height]) translate([-1,y,t]) rotate([0,90,0]) cylinder(d=3,h=base_width+2);
            }
            for(y=[30:20:height-20]) translate([7+(150-y)/20,y,-1]) rotate([0,0,0]) cylinder(d=12,h=base_width+2);
            //translate([14,6,-1]) linear_extrude(2) mirror(n) text("SVHB",size=7,halign="center",valign="center");
            translate([base_width/2,15-thick,-1]) cylinder(d=2.5,h=20);
        }
    }
}

if (piece == 1) {
    translate([-55-30+170,-20.125,thick-0.75]) rotate([0,0,0]) arm(0);
}
if (piece==2) {
    translate([-55-30,-20.125,thick-0.75]) rotate([0,0,0]) arm(1);
}
if (piece==3) {
    rotate([180,0,0])  dovetail();
}
if (piece==4) {
    rotate([180,0,0]) intersection() {
        mirror([1,0,0]) translate([0,-5,thick+bracket_thick]) rotate([180,0,0]) arm(0);
        translate([-40,-25,0]) cube([50,50,50]);
    }
}
if (piece==5) {
    intersection() {
        rotate([180,0,0])  dovetail();
        translate([80,-50,0]) cube([50,50,50]);
    }
}

