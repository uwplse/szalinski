// Spheroform with Tetrahedral Symmetry
// Based on Solids of constant width - the Meissner Tetrahedron - in OpenSCAD (http://ceptimus.co.uk/?p=345) ceptimus 2018-01-13
// Modified for tetrahedral symmetry using calculations from http://www.xtalgrafix.com/Spheroform2.htm

width = 50; // width of the object to be printed
$fn = 132; // higher numbers give smoother object but (much) longer render times
AT = 0.001/1; // Epsilon

// Hull not really necessary, adds compile time but makes cleaner intersections. Mostly optimised now.
useHull = 0; // [0:No, 1:Yes]
// Use real spheres for more accuracy, but slightly slower (implies useHull).
spheres = 1; // [0:No, 1:Yes]
// scale of negative internal volume
intscale = 0.9;

// Which one would you like to see?
part = "whole"; // [whole:Whole,half:Half split,hollwhole:Hollow Whole,hollhalf:Hollow Half split,althalf:Alternate Half split]

segs = round($fn/6)+1; // Number of segments to edges
s=1/segs; // Edge segment width

// vertices and edge length of Reuleaux Tetrahedron from Wikipedia
v1 = [sqrt(8/9), 0, -1/3]/1;
v2 = [-sqrt(2/9), sqrt(2/3), -1/3]/1;
v3 = [-sqrt(2/9), -sqrt(2/3), -1/3]/1;
v4 = [0, 0, 1]/1;
a = sqrt(8/3); // edge length given by above vertices

k = width / a; // scaling constant to generate desired width from standard vertices

alpha = atan(2 * sqrt(2)) / 2; // half 'dihedral angle' (amount the three edges up to the apex lean inwards from the vertical)

beta = asin((12-2*sqrt(2))/17)/2; // wedge cutout half angle
// ideally, 360/($fn/4) should be a multiple of beta so spindle seams line up with transition. Multiple of 11 should be close enough. The coice of $fn/4 for the sphere envelope is arbitrary.

if (part=="whole") {
    spheroformTetrahedron();
} else if (part=="half") {
    intersection(){
        rotate([90,0,0])spheroformTetrahedron();
        translate([0,0,width])cube(2*width,center=true);
    }
} else if (part=="hollwhole") {
    difference(){
        spheroformTetrahedron();
        scale(intscale)spheroformTetrahedron();
    }
} else if (part=="hollhalf") {
    intersection(){
        rotate([90,0,0])difference(){
            spheroformTetrahedron();
            scale(intscale)spheroformTetrahedron();
        }
        translate([0,0,width])cube(2*width,center=true);
    }
} else if (part=="althalf") {
    intersection(){
        rotate([90,0,0])difference(){
            spheroformTetrahedron();
            intersection(){
                translate(k*v4)mirror([0,0,1])scale(k)
                    cylinder(r1=0,r2=sqrt(8/9),h=4/3,$fn=3);
                translate(intscale*k*v4+[0,0,-width/10*0])
                    rotate([180,0,180])scale(3*k*intscale)
                        cylinder(r2=0,r1=sqrt(8/9),h=4/3,$fn=3);
            }
        }
        translate([0,0,width])cube(2*width,center=true);
    }
} else if (part=="demo") { // For testing out ideas and demonstrating constant width
    scale(k)translate(v4)mirror([0,0,1]) // Internal tetrahedron
            cylinder(r1=0,r2=sqrt(8/9),h=4/3,$fn=3);
    for(i=[-0.5:s:0.5]){
        r1=width*(((4*sqrt(2)-8)*i*i+2-sqrt(2))/8);
        translate(k*((0.5+i)*v1+(0.5-i)*v2))
            translate(r1*(v1+v2)/mod(v1+v2))
                sphere(r=r1); // envelope spheres
        translate(k*((0.5+i)*v3+(0.5-i)*v4))
            translate(r1*(v4+v3)/mod(v4+v3))
                sphere(r=r1); // opposite envelope spheres
        for(j=[-0.5:s:0.5]){
            r2=width*(((4*sqrt(2)-8)*j*j+2-sqrt(2))/8);
            vec1 = k*((0.5+i)*v1+(0.5-i)*v2) + r1*(v1+v2)/mod(v1+v2);
            vec2 = k*((0.5+j)*v3+(0.5-j)*v4) + r2*(v4+v3)/mod(v4+v3);
            //echo(mod(vec2-vec1)+r1+r2);
            translate(vec1)
                orientate(vec2-vec1)
                    color("red")translate([0,0,-r1])
                        cylinder(h=width,r=0.1,$fn=4);
        }
    }

    for(i=[0:s:0.5]){
        r1=env(i);
        for(j=[0:1/ceil(segs*r1/env(0)/2)/2:0.5+AT]){ // reduce number of points near apex proportional to r, but align borders (whole numberof segments).
            r2=env(j);
            vec1 = k*((0.5+i)*v1+(0.5-i)*v2) + r1*(v1+v2)/mod(v1+v2);
            vec2 = k*((0.5+j)*v3+(0.5-j)*v4) + r2*(v4+v3)/mod(v4+v3);
            // These will be our polyhedron points
            translate(vec1+(vec1-vec2)/mod(vec2-vec1)*r1)
                color("blue")mirror([0,0,1])scale(0.1)cylinder(r1=0,r2=sqrt(8/9),h=4/3,$fn=3);
        }
    }

    // The lazy way, hull of cross sections. Not sure if it's any slower than polyhedron anyway.
    hull()for(i=[0:s:0.5]){
        // non-flat "cross section/slice" (projection of opposite edge parabola through sphere centre onto sphere surface). Only i=0 is flat.
        sp=concat([k*(v1+v2)/2],[
            for(j=[0:1/ceil(segs*env(i)/env(0)/2)/2:0.5+AT])
                vec(v1,v2,i)+(vec(v1,v2,i)
                -vec(v3,v4,j))/mod(vec(v3,v4,j)
                -vec(v1,v2,i))*env(i)
            ]
        );
        sf=[for(j=[1:1:ceil(segs*env(i)/env(0)/2)])[
            0,j,j+1
        ]];
        color("green")polyhedron(
            points=sp,
            faces=sf,
            convexity=1
        );
    }

    // Getting the pattern for generating rounded wedge as single polyhedron
    // before I decided to reduce vertexes near apex which will complicate things a bit.
    // generate envelope points using list comprehension syntax
    tp=concat([k*v1,k*(v1+v2)/2],[
        for(i=[0:s:0.5])for(j=[0:s:0.5])
                vec(v1,v2,i)+(vec(v1,v2,i)
                -vec(v3,v4,j))/mod(vec(v3,v4,j)
                -vec(v1,v2,i))*env(i)
            ]
        );
    //echo(tp);
    tf=[
        [1,2,3,4,5,6,7,9,10,11,12,13], // centre face
        [134,122,110,98,86,74,62,50,38,26,14,2,1,0], // side face
        [0,1,13,25,37,49,61,73,85,97,109,121,133,145], // side face
        [3,2,14],[4,3,15],[5,4,16],[6,5,17], // envelope odd triangles
        [3,14,15],[4,15,16],[5,16,17],[6,17,18], // envelope even triangles
        [15,14,26],
        [15,26,27],
        [0,145,144,143,142,141,140,139,138,137,136,135,134] // tip
    ];
    polyhedron(
        points=tp,
        faces=tf,
        convexity=2
    );
} else { //segment for testing
    if(useHull){
        hull()reuleauxSegment();
    } else {
        reuleauxSegment();
    }
}

// Envelope sphere radius and offset
function env(x) = width*(((4*sqrt(2)-8)*x*x+2-sqrt(2))/8);
// vector to sphere sweep center
function vec(v1,v2,i) = k*((0.5+i)*v1+(0.5-i)*v2) + env(i)*(v1+v2)/mod(v1+v2);

module spheroformTetrahedron(){
    if(useHull || spheres){ // sparing use of hull on segments
        reuleauxTetrahedron()hull()reuleauxSegment();
    } else {
        reuleauxTetrahedron()reuleauxSegment();
    }
    
    // previously omitted central tetrahedron to reduce hull complexity
    scale(k)translate(v4)mirror([0,0,1])cylinder(r1=0,r2=sqrt(8/9),h=4/3,$fn=3);
}

module reuleauxTetrahedron() {
    children();
    orientate(v1)children();
    orientate(v2)children();
    orientate(v3)children();
}

module reuleauxSegment() { 
    mir()baseSegment();
}

module baseSegment() {
    intersection(){
        translate(v4 * k)
            rotate([90, 0, 90])
                sphere(r = width);
        translate(v3 * k)
            rotate([-90, 180-alpha, 0])
                wedge();
        translate([0,0,-k/3])mirror([1,0,1])cube(k);
        translate([0,0,-k/3])rotate([0,0,30])mirror([1,0,1])cube(k);
    }
    spindle();
}

module wedge() {
    translate([0, 0, -1]){
        rotate([0, 0, -beta])
            translate([-width,-width,0])
                cube([1.2*width, width, width + 2]);
    }
}

module spindle() {
    // The lazy way, hull of cross sections. Not sure if it's any slower than polyhedron anyway.
    for(i=[0:s:0.5]){
        // non-flat "cross section/slice" (projection of opposite edge parabola through sphere centre onto sphere surface). Only i=0 is flat.
        sp=concat([k*(v2+v3)/2],[
            for(j=[0:1/ceil(segs/2*env(i)/env(0)/2)/2:0.5+AT])
                vec(v2,v3,i)+(vec(v2,v3,i)
                -vec(v4,v1,j))/mod(vec(v4,v1,j)
                -vec(v2,v3,i))*env(i)
            ]
        );
        sf=[for(j=[1:1:ceil(segs/2*env(i)/env(0)/2)])[
            0,j,j+1
        ]];
        color("green")polyhedron(
            points=sp,
            faces=sf,
            convexity=1
        );
    }
}

//The Reuleaux tetrahedron can be modified into a 'solid of constant width' by replacing all six edges with sections of an 'envelope of spheres' - a sphere-sweep in ray tracing terminology. The resulting solid is spheroform and has tetrahedral symmetry.
// From: http://www.xtalgrafix.com/Spheroform2.htm
module spindle_old() {
    for(x=[0:s:0.5-AT]){ // TODO: It would be nice to align the hull contact curves of the spheres with the face curve segments. They don't quite line up now due to the offset tangent.
        r1=width*(((4*sqrt(2)-8)*x*x+2-sqrt(2))/8);
        r2=width*(((4*sqrt(2)-8)*(x+s)*(x+s)+2-sqrt(2))/8);
        translate([0,0,width*(0.5+x)]){
            if(spheres)color("red")intersection(){
                translate([0,r1,0])rotate([0,0,90])
                    sphere(r=r1,$fn=round($fn/4/11)*11); // TODO: find tangent angle and rotate sphere/(align equatorial circle). 45deg trim will do.
                rotate([0,0,AT])translate([0,r1*(1+1/sqrt(2)),0])cube([2*r1,2*r1,r1/sqrt(2)]); // trim some redundant faces
                rotate([0,0,90-beta-AT])cube(2*r1);
            } else {
                // We are using an approximation for the envelope of spheres, replacing them with equatorial circles (linear_extruded). This introduces noticable error since the part of the sphere touching the envelope is not the equator. Similarly rotate_extruding the intersection about the internal tetrahedron edge (ceptimus approximation) results in "blunter" corners than should be. Need to investigate the actual cross section of a sphere sweep. Perhaps generate it directly with polygon.
                linear_extrude(height=(x+s)<=0.5+AT?s*width:s*width/2,scale=r2/r1)
                    intersection(){
                        translate([0,r1,0])
                            rotate([0,0,90]) // keep edge sharp
                                circle(r=r1,$fn=round($fn/4/11)*11); // multiple of 11 to line up seams (almost)
                            rotate([0,0,AT])square(2*r1);
                            rotate([0,0,90-beta-AT])square(2*r1);
                        }
            }
        }
    }
}

// Exploit tri-radial and bilateral symmetry of segements for a further 6-fold reduction in hull complexity
module mir(){
    for (angle = [0 : 120 : 240])
        rotate([0, 0, angle]){
            children();
            mirror([0,1,0])children();
        }
}

//-- Openscad vector library
//-- This is a component of the obiscad opescad tools by Obijuan
//-- (C) Juan Gonzalez-Gomez (Obijuan)
//-- Sep-2012
//---------------------------------------------------------------
//-- Released under the GPL license
//---------------------------------------------------------------
function mod(v) = (sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]));
function cross(u,v) = [u[1]*v[2]-v[1]*u[2],-(u[0]*v[2]-v[0]*u[2]),u[0]*v[1]-v[0]*u[1]];
function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];
function anglev(u,v) = acos( dot(u,v) / (mod(u)*mod(v)) );
module orientate(v,vref=[0,0,1], roll=180){
  raxis = cross(vref,v);
  ang = anglev(vref,v);
  rotate(a=roll, v=v)
    rotate(a=ang, v=raxis)
      children();
}