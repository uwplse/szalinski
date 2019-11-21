// Customizer Parameters

// Create a T-nut for v-slot style extrusions. Defaults for 2020 extrusion with M3 hole.
//
// Arguments:
// length of tnut
length=20;

// how many holes to put in it
holes=1;

// diameter of holes
holesize=3;

// distance between hole centers (which are always centered on the nut)
spacing=10;

// depth of nut sink
sink=2.5;

// height of tnut (use 4mm for 2020 extrusion)
height=4;

// width of tnut (use 10mm for 2020 extrusion)
width=10;

// inset distance of bezel (use 3mm for 2020 extrusion)
bezel=2;

// depth of base (negative from z=0); use for slide-on attachments to other parts)
base=0;

// nut parameters
// how many sides on the nut (hex=6)
nutsides=6;
// nutsize = point-to-point size of nut
nutsize=6.25;
// amount to rotate (to fit inside body)
nutrotation=30;

// circle optimization
$fn=12;

// include <mygeom.scad>
module rotate_axis(axis, d) {
    rotate(list_for_axis(axis, d)) children();
}

module xrotate(d) {
    rotate_axis("x", d) children();
}

module yrotate(d) {
    rotate_axis("y", d) children();
}

module zrotate(d) {
    rotate_axis("z", d) children();
}

function list_for_axis(axis, d) =
(
    axis=="x" ? [d, 0, 0] : (
        axis=="y" ? [0, d, 0] : (
            axis=="z" ? [0, 0, d] : [0, 0, 0]))
);

module translate_axis(axis, d) {
    translate(list_for_axis(axis, d)) children();
}

module xmove(d) {
    translate_axis("x", d) children();
}

module ymove(d) {
    translate_axis("y", d) children();
}

module zmove(d) {
    translate_axis("z", d) children();
}

module spread_axis(axis, d, n=1) {
    x = d/2;
    if(d==0 || n==0) {
        children();
    }
    else
    {
        for(i=[-x:(d/n):x]) {
            translate_axis(axis, i) children();
        }
    } 
}

module xspread(d, n=1)
{
    spread_axis("x", d, n) children();
}

module yspread(d, n=1)
{
    spread_axis("y", d, n) children();
}


module zspread(d, n=1)
{
    spread_axis("z", d, n) children();
}

module star(points, id, od)
{
    polygon([
        for(i=[0:points*2])
            [
            (i%2==0) ? cos(i*(360/(points*2)))*od/2 : cos(i*(360/(points*2)))*id/2,
            (i%2==0) ? sin(i*(360/(points*2)))*od/2 : sin(i*(360/(points*2)))*id/2
            ]
    ]);
}

module unit_star(points, height, id, od, center=true)
{
    linear_extrude(height, center=center) star(points, id, od);
}

module unit_polygon(r, n)
{
    polygon([
        for(i=[0:360/n:360])
            [ cos(i)*r, sin(i)*r ]
    ]);
}


module screw_hole(size, depth, sinkwidth=5, sinkdepth=0, type="round", center=true) {
    zmove(center ? 0 : depth/2) {
        cylinder(h=depth, d=size, $fn=12, center=true);
        ref=sinkdepth/abs(sinkdepth) * depth/2;
        zmove(ref-sinkdepth/2) {
            if(type=="round") cylinder(h=abs(sinkdepth), d=sinkwidth, $fn=12, center=true);
            if(type=="hex") linear_extrude(height=abs(sinkdepth), center=true) rotate([0, 0, 30]) unit_polygon(sinkwidth/2, 6);
        }
    }
}

module rounded_cube(size, diameter, center=false) {
    hull() {
        xmove((size[0])/2) xspread(size[0]-diameter) ymove((size[1])/2) yspread(size[1]-diameter) cylinder(d=diameter, h=size[2], center=center);
    }
}

module round_chamfer() {
    intersection() {
        cylinder(d=4, h=11, $fn=20);
        cube(size=[2, 2, 11]);
    }
}


// tnut.scad
module tnut(l) {
    difference() {
        union() {
            // nut block
            cube([width, l, height]);
            // base
            zmove(-base) xmove(bezel) cube([width-2*bezel, l, base]);
        }
        // bezels
        ymove(-0.02) rotate([-90, 0, 0]) linear_extrude(height=l+0.04) polygon([ [-0.02, -height/4-0.02], [bezel, -height-0.02], [-0.02, -height-0.02] ]);
        ymove(-0.02) rotate([-90, 0, 0]) linear_extrude(height=l+0.04) polygon([ [width+0.02, -height/4-0.02], [width-bezel, -height-0.02], [width+0.02, -height-0.02] ]);
        // hole and countersink
        ymove(l/2) yspread((holes-1)*spacing, holes-1) xmove(width/2) {
            zmove(height-sink) linear_extrude(height=sink+0.02) rotate([0, 0, nutrotation]) unit_polygon(nutsize/2, nutsides);
            zmove(-base-0.02) cylinder(d=holesize, h=height+base+0.02);
        }
    }
}

// Examples
//tnut(40, holes=4, spacing=10); // 4-hole 40mm

//tnut(40, holes=2, spacing=20); // 2-hole 40mm
//xmove(20) tnut(10); // 1-hole 20mm

//xmove(20) tnut(10); // 1-hole 10mm

//xmove(40) tnut(40, holes=3, spacing=10, base=3); // 3-holes 10mm apart with a 3mm base

// square nut with 6mm diagonal
//xmove(-20) tnut(20, holes=2, spacing=10, nutsides=4, nutrotation=45, nutsize=6);

// Customizer
tnut(length);