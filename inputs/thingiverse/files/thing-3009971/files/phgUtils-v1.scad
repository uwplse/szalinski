/*
 *  OpenSCAD utilities 
 *
 *  by Ph.Gregoire AKA Greg Ware <greg.ware@laposte.net>
 *  
 *  Includes:
 *   - shorter macro modules to get a cube or cylinder with translation and rotation
 *   -  Due to some display defects in OpenSCAD preview (F5), some can use a small epsilon 
 *      so as to cut protruding apertures in solids
 *   - useful modules to build rounded corner cubes, triangle (wedges), etc
 *
 * History
 * Date         Author      Description
 * 2017/??/??   Ph.Gregoire Initial version(s)
 * 2018/07/18   Ph.Gregoire Rework for X5S corners
 *
 *  This work is licensed under the 
 *  Creative Commons Attribution 3.0 Unported License.
 *  To view a copy of this license, visit
 *    http://creativecommons.org/licenses/by/3.0/ 
 *  or send a letter to 
 *    Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*/

// Thickness of supports for apertures
$_SUPPORT_THK=0.2;

// Cylinders $fn default
$_FN_CYL=32;

// Epsilon
$_EPSILON=0.2;

/* Simple translation */
module tr(dx,dy=0,dz=0) {
    translate([dx,dy,dz]) children();
}

/* Translate and rotate children */
module trrot(tx,ty,tz,ax,ay=0,az=0) {
    translate([tx,ty,tz]) rotate([ax,ay,az]) children();
}

/* translated cube */
module trcube(tx,ty,tz,dx,dy,dz) {
    translate([tx,ty,tz]) cube([dx,dy,dz]);
}

/* translated cube with epsilons along Z */
module trcube_eps(tx,ty,tz,dx,dy,dz) {
    translate([tx,ty,tz-$_EPSILON]) cube([dx,dy,dz+2*$_EPSILON]);
}

/* translated cylinder */
module trcyl(tx,ty,tz,d,h,center=false,fn=$_FN_CYL) {
	translate([tx,ty,tz]) cylinder(d=d,h=h,center=center,$fn=fn);
}

/* translated cylinder with epsilon along height (Z) */
module trcyl_eps(tx,ty,tz,d,h,center=false,fn=$_FN_CYL) {
    translate([tx,ty,tz-$_EPSILON]) cylinder(d=d,h=h+2*$_EPSILON,center=center,$fn=fn);
}

module trrotcyl(tx,ty,tz,ax,ay,az,d,h,center=false,fn=$_FN_CYL) {
	trrot(tx,ty,tz,ax,ay,az) cylinder(d=d,h=h,center=center,$fn=fn);
}

/* translated and rotated cylinder with epsilon along height (Z) */
module trrotcyl_eps(tx,ty,tz,ax,ay,az,d,h,center=false,fn=$_FN_CYL) {
    trrot(tx,ty,tz,ax,ay,az) translate([0,0,-$_EPSILON]) cylinder(d=d,h=h+2*$_EPSILON,center=center,$fn=fn);
}

/* translated and rotated cube */
module trrotcube(tx,ty,tz,ax,ay,az,dx,dy,dz) {
    trrot(tx,ty,tz,ax,ay,az) cube([dx,dy,dz]);
}

/* Translated rotate cube with diff children (in cube referential) */
module trrotcube_diff(tx,ty,tz,ax,ay,az,dx,dy,dz) {
    trrot(tx,ty,tz,ax,ay,az) difference() {
        cube([dx,dy,dz]);
        children();
    }
}

/* Box with apertures cut out from children */
module boxWithApertures(w,l,h,t) {
    // Bottom
    trcube(-w/2-t,-l/2-t,0,w+2*t,l+2*t,t);

    // sides
    for(s=[0:3]) {
        L=w*((s+1)%2)+l*(s%2)+2*t;
        P=l*((s+1)%2)+w*(s%2);
        
        rotate([0,0,s*90]) {
            translate([-L/2,P/2,t]) {
                difference() {
                    cube([L,t,h]);
                    // aperture
                    if($children>s) {
                        translate([thk,thk,0]) rotate([90,0,0]) children(s);
                    }
                }
            }
        }
    }

}

/* Make a support: remove a thin support layer from a flat shape */
module supportDiff(thk) {
    difference() {
        children(0);
        translate([0,0,thk/2]) {
            linear_extrude(height=$_SUPPORT_THK) projection() children(0);
        }
    }
}

/* Lateral vents 
    n: number of vents
    h: height of vent and vent spacing
    l: horizontal length of vent
    x: horizontal x offset of vent
    z: vertical offset of first vent
    t: thickness of panel
*/
module vents(n,h,l,x,z,t) {
    for(v=[0:n-1]) {
        trcube_eps(x,z+2*v*h,0,l,h,t);
    }
}

/* Fan vent 
    w: width of panel
    dz: height of center of fan
    df: diameter of fan
    dh: diameter of hub
    fs: Number of fan spokes
    t: thickness of panel
*/
module fanvent(w,dz,df,dh,fs,t) {
    difference() {
        // External
        trcyl_eps(w/2,dz,0,df,t);
        
        // central hub
        trcyl_eps(w/2,dz,0,dh,t);
        
        // spokes
        translate([w/2,dz,0]) {
            for(a=[0:fs-1]) {
                rotate([0,0,180+a*(360/fs)]) trcube_eps(-t/2,0,0,t,df,t);
            }
        }
    }
}
/* Fan mounting holes
    w: Width of panel
    dz: height of center of fan
    wfh: width of fan holes
    dfh: diameter of fan holes
    t: thickness of panel
*/
module fanholes(w,dz,wfh,dfh,t) {
    for(x=[-1,1]) {
        for(y=[-1,1]) {
            trcyl_eps(w/2+wfh/2*x,dz+wfh/2*y,0,dfh,t);
        }
    }
}

/* Position children in one corner of box, using a centered box */
module cornerPos(w,l,h,x,y,center=true) {
    translate([center?x*w/2:(x+1)*w/2,center?y*l/2:(y+1)*l/2,h]) {
        if(x==-1 && y==-1) children();
        if(x==1 && y==-1) rotate([0,0,90]) children();
        if(x==1 && y==1) rotate([0,0,180]) children();
        if(x==-1 && y==1) rotate([0,0,270]) children();
    }
}

/* Position children at each 4 corners of centered cube */ 
module cornersPos(w,l,h,center=true) {
 for(x=[-1,1]) {
        for(y=[-1,1]) {
            cornerPos(w,l,h,x,y,center=center) children();
        }
    }
}


/* Quarter Cone */
module quarterCone(r1,r2,h) {
    intersection() {
        cylinder(r1=r2,r2=r1,h=h);
        cube([r1>r2?r1:r2,r1>r2?r1:r2,h]);
    }
}

module quarterCyl(r,h) {
    intersection() {
        cylinder(r=r,h=h,$fn=$_FN_CYL);
        cube([r,r,h]);
    }
}

/* Corner rounding */
module champfer(rounding,h) {
    difference() {
        translate([-$_EPSILON,-$_EPSILON,-$_EPSILON])
            cube([rounding+$_EPSILON,rounding+$_EPSILON,h+2*$_EPSILON]);
        translate([rounding,rounding])
            cylinder(r=rounding,h=h);
    }
}

/* Triangle by extrusion. the a parameter is the rotation angle */
module triangle(dx,dy,h,a=0) {
    if(a<0) triangle(dx,dy,h,a=a+360);
    else {
        a=a%360;
        linear_extrude(height=h) {
            if(a<90) polygon(points=[[0,0],[dx,0],[0,dy],[0,0]]);
            else if(a<180) polygon(points=[[0,0],[dx,dy],[dx,0],[0,0]]);
            else if(a<270) polygon(points=[[dx,dy],[0,dy],[dx,0],[dx,dy]]);
            else if(a<360) polygon(points=[[0,0],[dx,dy],[0,dy],[0,0]]);
        }
    }
}

module roundedFlatBox(dx,dy,h,r) {
    linear_extrude(height=h)
    offset(r=r)
    translate([r,r]) square([dx-2*r,dy-2*r]);
}

module roundedBoundingBox(dx,dy,dz,rx,ry,rz) {
    minkowski() {
        trcube(rx,ry,rz,dx-2*rx,dy-2*ry,dz-2*rz);
        r=max(rx,ry,rz);
        scale([rx/r,ry/r,rz/r]) sphere(r);
    }
}

test();

module test() {
    //triangle(30,20,10,270);
    //quarterCyl(5,10);
    //champfer(5,10);
    roundedBoundingBox(40,50,20,5,10,7);
}