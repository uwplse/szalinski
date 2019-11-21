

/*
 *  Girder Box
 * by Bo Boye
 * All copyrights reserved.
 *
 * published under Gnu public licens.
 *
 *
 */
 
/*
    default values
*/
/* [Global] */

// Which one would you like to see?
part = "both"; // [first:Box Only,second:Lid Only,both:Box and Lid]
// Radius
radius=50; // [10:100]
// Thickness
thick=4;
// X Max cutoff. Where the flatness starts(from center). If larger then the radius, its all round.
xmax=50; // [0:100]
// X Min cutoff. Where the flatness starts(from center). If larger then the radius, its all round.
xmin=-35; // [-100:0]
// Y Max cutoff. Where the flatness starts(from center). If larger then the radius, its all round.
ymax=35; // [0:100]
// Y Min cutoff. Where the flatness starts(from center). If larger then the radius, its all round.
ymin=-30; // [-100:0]
// Number of fragments, wich also means number of calcs per turn.
fn=100;

/* [Box] */
// Height of box.
height=80;  // [5:100]
// Number of helixes(Below 4 is not printable without support).
nhelixes=8; // [4:64]
// Number of turns
turns=0.25; 

/* [Lid] */
// Lid guard height.
lid_guard = 3;  // [0:10]

/* [Hidden] */
preview_tab = "";
$fn=fn;
step = 360/fn;
div =  (360*turns) / height;
rev = height / (360 / div);

print_part();    

module print_part() {
	if (part == "first") {
		highlight("Box") box();
	} else if (part == "second") {
		highlight("Lid") lid();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

function maxx(x) = max(xmin,min(xmax,x));
function maxy(y) = max(ymin,min(ymax,y));
module helem(thick=2) {
    cube(thick);
    //cylinder(r=thick/2,h=thick);
    }
module helix(start=0,step=5,rev=.75,r=20,div=3,thick=4) {
	translate([-thick/2,-thick/2,0])  {
    for(a=[step:step:360*rev]) {
        x=maxx(sin(a+start)*r);
        y=maxy(cos(a+start)*r);
        x2=maxx(sin((a+start)-step)*r);
        y2=maxy(cos((a+start)-step)*r);
		hull() {
			translate([x,y,a/div]) 
                helem(thick);
			translate([x2,y2,(a-step)/div]) 
                helem(thick);
		}
	}
}
}
module helixc(start=0,step=5,rev=.75,r=20,div=3,thick=4) {
    translate([-thick/2,-thick/2,0]) union() {
        for(a=[0:-step:-(360-step)*rev]) {
            x=maxx(sin(a+start)*r);
            y=maxy(cos(a+start)*r);
            x2=maxx(sin((a+start)-step)*r);
            y2=maxy(cos((a+start)-step)*r);
            hull() {
                translate([x,y,-a/div]) 
                    helem(thick);
                translate([x2,y2,-(a-step)/div]) 
                    helem(thick);
            }
        }
    }
}

module helixgrid(n=7,rev=1,r=20,div=3,thick=2) {
    for(v=[0:360/n:360]) {
        helix(v,rev=rev,r=r,div=div,thick=thick);
        helixc(v,rev=rev,r=r,div=div,thick=thick);
        //top(v+(360/(n*2)),n,((360*rev)/div)-4);
    }

}
module topcut(r=57.5,adj=1.5) {
    difference() {
        cylinder(r=r,h=20);
        translate([-r+xmin+adj,-r,-1]) cube([r,r*2,20]);
        translate([xmax-adj,-r,-1]) cube([r,r*2,20]);
        translate([-r,ymax-adj,-1]) cube([r*2,r*2,20]);
        translate([-r,-r*2+ymin+adj,-1]) cube([r*2,r*2,20]);
    }
}

module guard(r=60,h=10,adj=1) {
    difference() {
        cylinder(r=r,h=h);
        translate([0,0,-1]) topcut(r-thick,adj*2);
        translate([-r*2+xmin+adj,-r,-1]) cube([r*2,r*2,20]);
        translate([xmax-adj,-r,-1]) cube([r*2,r*2,20]);
        translate([-r,ymax-adj,-1]) cube([r*2,r*2,20]);
        translate([-r,-r*2+ymin+adj,-1]) cube([r*2,r*2,20]);
    }
}
module top(r=60,h=10,adj=1) {
    difference() {
        cylinder(r=r,h=h);
        translate([0,0,-1]) topcut(r-thick,adj*2);
        translate([-r+xmin-adj,-r,-1]) cube([r,r*2,20]);
        translate([xmax+adj,-r,-1]) cube([r,r*2,20]);
        translate([-r,ymax+adj,-1]) cube([r*2,r,20]);
        translate([-r,-r+ymin-adj,-1]) cube([r*2,r,20]);
    }
}
module bottom(r=60) {
    difference() {
        cylinder(r=r,h=2.5);
        //translate([0,0,-1]) topcut(r-2.5);
        translate([-r+xmin-1,-r,-1]) cube([r,r*2,20]);
        translate([xmax+1,-r,-1]) cube([r*2,r*2,20]);
        translate([-r,ymax+1,-1]) cube([r*2,r,20]);
        translate([-r,-r+ymin-1,-1]) cube([r*2,r,20]);
    }
}
module highlight(this_tab) {
  if (preview_tab == this_tab) {
    color("red") child(0);
  } else {
    child(0);
  }
}
module box() {
    bottom(radius);
    helixgrid(nhelixes,rev,radius-2.5,div,thick);
    translate([0,0,height]) top(radius,thick);
}
module lid() {
    mirror([1,0,0]) {
        bottom(radius);
        guard(radius-thick*2,lid_guard+thick,thick);
    }
}
module both() {
    box();
    translate([radius*2 + 10,0,0]) lid();
}






