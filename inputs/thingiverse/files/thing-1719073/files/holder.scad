
// cable diameter
cable = 8;
// number of cable pairs for holder
rows = 1;
// wall thikness */
thik  = 1.5;
// size of opening for cable
angel = 50; // [90]

/*******************************************************************************/
/* [Hidden] */
$fn=50;

outer = cable + 2*thik;
clips(rows);

/* rows of dual clips */
module clips(num) {
    linear_extrude(height=3) {
	for(idx=[0 : 1 : num-1  ]) {
	    translate([0, outer * idx])
	    dual();
	}
    }
}

/* dual clip, centred */
module dual() {
    copy_mirror()
    translate([outer/2, outer/2])
    clip(cable, outer, angel);
}

/* single clip, centered */
module clip(cable, outer, angel) {
    difference() {
	union() {
	    /* fill in the middle */
	    translate([-outer/2,0])
	    square(outer/2);
	    translate([-outer/2,-outer/2])
	    square(outer/2);

	    /* outer circle */
	    circle(d=outer);
	}
	/* remove cable circle */
	circle(d=cable);
	polygon(points=[[0,0],[ outer/2, tan(angel)*outer/2],[outer/2,-tan(angel)*outer/2]]);
    }
    /* Add rouded edge */
    hyp = ((outer-cable)/2 + cable)/2;

    translate([ cos(angel)*hyp , sin(angel)*hyp])
    circle(d=(outer-cable)/2);
    translate([ cos(angel)*hyp , -sin(angel)*hyp])
    circle(d=(outer-cable)/2);
}


/******************************************************************************/
/* generic helpers */

module copy_mirror(vec=[1,0,0]) {
    children();
    mirror(vec) children();
}
