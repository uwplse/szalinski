// mount width
mw = 35;

// mount height
mh = 8;

// mount length
ml = 35;

// brim width
bw = 10;

// brim height
bh = 2.5;

// brim hole width
bhw = 4;


// hole diameter
hd = 12;

// hole width
ht = 1;

// hole height
hh = 1.2;


// inlet width
iw = 21;

// inlet height
ih = 3;

// inlet length
il = 60;

// inlet distance
id = 12;

// inlet canal length
icl = 10;


// clip thickness
ct = 1.2;

// clip offset
co = 0.4;


// nub diameter
nd = 6.5;

// nub thickness
nt = 1;

// nub height
nh = 2;

//nub tip angle
na = 60;

$fn = 100;

module nub() {
	difference() {
		translate([0,0,-ih/2+nh/2])
		cylinder(nh, d = nd, center=true);

		translate([0,nd,-ih/2])
		rotate(-atan(nh/nd), [1,0,0])
		translate([0,-nd,0])
		cube([nd*1.1,nd*1.1,nh], center=true);

		translate([0,nd/2,-ih/2])
		rotate(-na/2, [0,0,1])
		translate([-nd*1.1,-nd*2,0])
		cube([nd*1.1,nd*2.1,nh*1.1], center=false);

		translate([0,nd/2,-ih/2])
		rotate(na/2, [0,0,1])
		translate([0,-nd*2,0])
		cube([nd*1.1,nd*2.1,nh*1.1], center=false);

	}
}

module clip() {
	intersection() {
		translate([0,co,0])
		union() {
			translate([0,0,-ct/2-ih/2])
			cylinder(h=ct, r= hd/2, center=true);

			translate([0,icl/2,-ct/2-ih/2])
			cube(size=[hd,icl,ct], center=true);

			translate([0,12,-ct/2-ih/2])
			cylinder(h=ct, d=iw, center=true);

			nub();

		}
		cube([mw,ml,mh], center = true);
	}
}

module inlet() {
	union() {
		translate([0,il/2-iw/2,0])
		cube([iw,il,ih], center = true);

		translate([0,0,mh/2])
		cylinder(h=1.01*mh, r= hd/2, center=true);

		translate([0,10,10])
		cube(size=[hd,20,20], center=true);

		translate([0,12,mh/2])
		cylinder(h=1.01*mh, d=iw, center=true);

		translate([0,id+il/2,ih])
		cube([iw,il,ih*2.01], center = true);

		translate([0,0,-mh/2])
		cube([iw,iw,mh], center = true);
	}
}


module handlebrim(){

	translate([0,0,-mh/2])
	difference() {

		translate([-mw/2,-ml/2,0])
		minkowski() {
			cube([mw,ml,bh/2], center = false);
			// cube([sw - sr * 2, sl - sr * 2, sh/2]);
			// translate([sr, sr, 0])
			cylinder(r = bw, h = bh/2, center = false);
		}
		translate([0,0,bh/2])
		cube([iw,iw,bh*1.1], center = true);

		translate([(-mw-bw)/2,0,bh/2])
		cube([bhw,ml-bw+bhw,bh*1.1], center=true);

		translate([(mw+bw)/2,0,bh/2])
		cube([bhw,ml-bw+bhw,bh*1.1], center=true);

		translate([0,(-ml-bw)/2,bh/2])
		cube([mw-bw+bhw,bhw,bh*1.1], center=true);

		translate([0,(ml+bw)/2,bh/2])
		cube([mw-bw+bhw,bhw,bh*1.1], center=true);

	}
}

module mount() {
	difference() {
		cube([mw,ml,mh], center = true);
		inlet();
	}
}


module klickfast () {

	union() {
		clip();
		mount();
		handlebrim();
	}

}

// rotate(90, [1,0,0])
klickfast();
// translate([0,0,0])clip();
// mount();
