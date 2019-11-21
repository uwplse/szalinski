center=1; // add grip layer for center bearing
pin=1; // 1: make pin; 0: make hole
click=1; // make snap-in

wheelsize=20; //mm
spinnerheight=11; //mm

wheelcore=wheelsize/2-0.1;
edgeheight=wheelsize/15; //mm
coreheight=spinnerheight/10; 
slopeheight=(spinnerheight-(2*edgeheight)-coreheight)/2;
pinsize=wheelsize/3;
pinheight=spinnerheight/5;

//center:
centerheight=wheelsize/10;
    
if (pin == 1) {
    difference () {
        union () {
            rotate_extrude($fn=200) 
                polygon( points=[
                    [0,0], 
                    [wheelsize/2,0], 
                    [wheelsize/2,edgeheight],
                    [wheelcore/2,edgeheight+slopeheight],
                    [wheelcore/2,edgeheight+slopeheight+coreheight],
                    [pinsize/2,edgeheight+slopeheight+coreheight],
                    [pinsize/2,edgeheight+slopeheight+coreheight+pinheight], 
                    [0,edgeheight+slopeheight+coreheight+pinheight ]
                ] );
            if (click==1) {
// create bulge for snap-in
                rotate_extrude($fn=200) 
                    translate([0.75*pinsize/2,edgeheight+slopeheight+coreheight+pinheight/2,    centerheight/2]) circle(d=pinheight);
            };
         }
         if (click==1) {
 // cutoutcross for flexible snaps
             union() {
                 translate([0,0,edgeheight+slopeheight+pinheight]) cube([edgeheight+slopeheight+coreheight+pinheight,0.05*pinsize,pinheight], center=true);
                 translate([0,0,edgeheight+slopeheight+pinheight]) cube([0.05*pinsize,edgeheight+slopeheight+coreheight+pinheight,pinheight], center=true);
 // take out the center to allow movement of the pin segments
                 translate([0,0,edgeheight+slopeheight+pinheight/2]) cylinder(r=pinsize/3,h=pinheight,$fn=50);

             };
         }
    }
} else {               
    difference () {
        rotate_extrude($fn=200) 
            polygon( points=[
                [0,0], 
                [wheelsize/2,0], 
                [wheelsize/2,edgeheight],
                [wheelcore/2,edgeheight+slopeheight],
                [pinsize/2,edgeheight+slopeheight],
                [pinsize/2,edgeheight+slopeheight-(1.1*pinheight)], 
                [0,edgeheight+slopeheight-(1.1*pinheight)]
             ] );
        if (click==1) {
            rotate_extrude($fn=200) 
                translate([0.75*pinsize/2,edgeheight+slopeheight-pinheight/2, centerheight/2]) circle(d=pinheight);
        }
    }
}

if (center==1) {
    rotate_extrude($fn=200)
        union() {
             polygon( points=[ 
                 [0,0],
                 [wheelsize/2,0],
                 [wheelsize/2,-centerheight],
                 [0,-centerheight]
             ] );
             translate([wheelsize/2,-centerheight/2,0]) circle(d=centerheight);
        }
}
