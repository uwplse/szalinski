// Create a decorative hyperboloid.
// Slices the object into frustums.
// Formula used:
// girth*x² + girth*y² - z² = w 

height=20;      // overall height
radius=10;      // at top or bottom
stepping=.5;    // height of a single frustum slice in mm
girth=1.8;      // play with it... 
$fn=100;        // level of detail

// no modifications below here needed

halfheight=height/2;
w=girth*radius*radius-halfheight*halfheight;
oldr=sqrt(w/girth); // no idea why this doesn't work
echo(oldr);
for(z=[stepping:stepping:halfheight]){
    r=sqrt((w+z*z)/girth);
    oldr=sqrt((w+(z-stepping)*(z-stepping))/girth);
	translate([0,0,halfheight+z-stepping]) cylinder(stepping,oldr,r);
    translate([0,0,halfheight-z]) cylinder(stepping,r,oldr);
	//oldr=r; // no idea why this approach doesn't work
}
