
// Rod Diameter (mm)
rod_dia = 8;

// Clearance (mm)
clearance = 0.0;

module rail_mount() {
    end_height=rod_dia/3;
    center_height=rod_dia*3/4;
    difference() {
        hull() {
            zmove(end_height/2) xspread(rod_dia*3) cylinder(d=rod_dia*1.25, h=end_height, center=true);
            zmove(center_height/2) cylinder(d=rod_dia*2, h=rod_dia*3/4, center=true);
        }
        zmove(center_height/2-0.1) cylinder(d=rod_dia+clearance, h=center_height+0.3, center=true, $fn=40);
        zmove(-0.1) xspread(rod_dia*3) screw_hole(3.2, center_height, 6.1, rod_dia/2, center=false);
        zmove(-0.1) ymove(-1) cube([rod_dia+0.5, 1, rod_dia]);
        zmove(-0.1) xmove(rod_dia) ymove(-rod_dia) cube([0.5, rod_dia, rod_dia]);
        zmove(rod_dia*5/16) ymove(rod_dia*7/8) xmove(rod_dia*3/4) xrotate(90) screw_hole(2.2, rod_dia*15/8, 3.5, 2.5, center=false);
        zmove(rod_dia*5/16) ymove(rod_dia) xmove(rod_dia*3/4) xrotate(90) zrotate(30) screw_hole(2.2, rod_dia*15/8, 4.4, -2.5, type="hex", center=false);
    }
}

rail_mount();



// mygeom.scad
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
    if(n==0) {
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