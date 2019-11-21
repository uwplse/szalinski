// preview[view:south west, tilt:top diagonal]

/* [Main Settings] */
// The Inner Height of the Cells
height=4;  // [2,3,4,6,8,12,16,24,32,48,64,96,128]

// Number of Rows
rows=2;   // [1:8]

// Number of Columns
columns=2;   // [1:8]

// Radius Used to Round Off Inner Edges
radius=2;  // [0:8]

/* [Enable Features] */
// Add Joints to the Next Tray 
addJoint=1; // [0:No, 1:Yes]

// Round the Floor of the Cells
roundFloor=1; // [0:No, 1:Yes]

// Add Corners to Keep Square Notes
addEdges=0; // [0:No, 1:Yes]

/* [Hidden] */
fl=92; // floor length
wt=1;  // wall thickness
jt=2;  // joint thickness
jw=20; // joint width
jh=3;  // joint height
tl=0.1; // toleranz
el=8;  // edge length

ih=height;
n=rows;
m=columns;
rr=radius+0.001;
ro=fl/2-rr;
ri=fl/2+wt/2;
$fn=16;

module joint(y, a, t) {
    rotate(a)
        translate([fl/2+wt+jt/2+t,y,(jh+wt+ih)/2-0.001])
            cube([jt-2*t,jw-2*t,jh+wt+ih+0.002],center=true);
}

module rounding_inner()
    if (roundFloor) translate([0,0,rr+wt]) {
        sphere(r=rr);
        cylinder(r=rr, h=ih-rr+0.001);
    } else translate([0,0,wt])
        cylinder(r=rr, h=ih+0.001);

module rounding_outer() {
    cylinder(r=rr+wt+jt-0.001, h=ih+wt);
}

difference() {
    union() {
        difference() {
            hull() for (x=[-1:2:1]) for (y=[-1:2:1])
                translate([x*ro,y*ro,0]) rounding_outer();
            for (x=[0:n-1]) for (y=[0:m-1])
                hull() for (i=[0:1]) for (j=[0:1])
                    translate([-ri+2*ri*(x+i)/n + (1-2*i)*(wt/2+rr), -ri+2*ri*(y+j)/m + (1-2*j)*(wt/2+rr),0])
                        rounding_inner();
        }
        if (addJoint) {
            joint(0, 0, tl);
            joint(jw, 90, tl);
            joint(-jw, 90, tl);
            joint(0, 180, tl);
            joint(jw, 270, tl);
            joint(-jw, 270, tl);
        }
        if (addEdges) translate([0,0,ih]) linear_extrude(height=wt)
            for (x=[-1:2:1]) for (y=[-1:2:1])
                polygon([[x*fl/2,y*fl/2],[x*fl/2,y*(fl/2-el)],[x*(fl/2-el),y*fl/2]]);
    }
    joint(jw, 0, -tl);
    joint(-jw, 0, -tl);
    joint(0, 90, -tl);
    joint(jw, 180, -tl);
    joint(-jw, 180, -tl);
    joint(0, 270, -tl);
}


    





