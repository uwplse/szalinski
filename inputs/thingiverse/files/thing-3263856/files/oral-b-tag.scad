// preview[view:north west, tilt:top diagonal]

// The text of the tag. One char recommended.
text = "A";
// The width of the tag. Change this, if you use larger text.
width = 7;

/* [Hidden] */

d = 13;
h = 7;
t = 1;

$fn = 100;

difference() {
    cylinder(r=d/2,h=h);
    translate([0,0,-5])cylinder(r=d/2-t,h=h+10);
    translate([-50,-50-d/3,-5]) cube([100,50,h+10]);
}
translate([-width/2,d/2-t,0]) {
    cube([width,1,h]);    
}

translate([0,d/2+0.7,h/2])
    rotate([90,0,0])
    mirror([1,0,0])
    linear_extrude(height = 1) {
        text(text = text, font = "Liberation Sans", size = h*3/4, valign = "center", halign="center");
    }