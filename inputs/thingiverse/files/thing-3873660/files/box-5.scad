$fn=17;

// box width
w=30;
// box height
h=40;
// box depth
t=190;
// box wall thickness
s=10;

// closing layer / upper layer
cl=0.4; 
// Spiel um das Gelenk aussen
pl=0.3;
// Spiel im Gelenk innen
ip=0.5;

rotate([180,0,0]) base();


module base(){
    e=0.001;
    v=s/2-.1;
    difference(){
        union(){
            difference(){
                union(){
                    translate([  0, -h, 0]) cube([w,h,s], center=true); // platte 1
                    difference() {
                        union(){
                        // platte 5 - unter scharnier
                        translate([ 0,   h   -(h-t), 0]) cube([w,h+2*s -(h-t),s], center=true);
                        // deckel
                        translate([ 0, 2*h+s -(h-t), 0]) cube([w,t,s], center=true);
                        }
                        
                    // bohrung for duenne gelenktrommel 
                    translate([0,h/2*3+s -(h-t), -s/2]) rotate([0, 90, 0]) cylinder(d=s+ip, h=w, center=true);

                    // raum um grosse gelenktrommel
                    translate([ 0,h/2*3+s -(h-t), -s/2]) rotate([0, 90, 0]) cylinder(d=s*1.5+2*pl, h=w/3, center=true);
                    }
                // Halterung der duennen Gelenkstaebe
                color("gray") translate([ w/3,3/2*h+s/2 -(h-t), 0]) cube([w/3,s,s], center=true);
                color("gray") translate([-w/3,3/2*h+s/2 -(h-t), 0]) cube([w/3,s,s], center=true);

               color("gray") translate([  0, h+h-h/2+s+s+ip/2 -(h-t), 0]) cube([w/3,s,s], center=true); //-.5/2
                }
            // Schwalbenschwaenze vertikal
            translate([ (w-s+e)/2,-h/2, 0]) rotate([0,-90, 0]) cut( );
            translate([-(w-s+e)/2,-h/2, 0]) rotate([0, 90, 0]) cut( );
            translate([ (w-s+e)/2, h/2, 0]) rotate([0,-90, 0]) cut(-1);
            translate([-(w-s+e)/2, h/2, 0]) rotate([0, 90, 0]) cut(-1);

            }

        // platten 2 bis 4
        translate([       0, -(h-t)/2, 0]) cube([w,t    ,s], center=true);
        translate([ (h+w)/2, -(h-t)/2, 0]) cube([h,t-2*s,s], center=true);
        translate([-(h+w)/2, -(h-t)/2, 0]) cube([h,t-2*s,s], center=true);
        }

    // knickgelenke horizontal
    translate([ 0,-h/2  , 0]) CutCube(w);
    translate([ 0, h/2 -(h-t) , 0]) CutCube(w);
    translate([ 0, h/2*3+s -(h-t) , 0  ]) CutCube(w);

    // knickgelenke vertical
    translate([ -w/2, 0-(h-t)/2, 0]) rotate([0, 0, 90]) CutCube(t);
    translate([  w/2, 0-(h-t)/2, 0]) rotate([0, 0, 90]) CutCube(t);
    }


    // dicke gelenktrommel
    translate([   0,h/2*3+s   -(h-t), -s/2]) {
        difference() {
            union(){
            difference() {
                // dicke gelenktrommel
                translate([         0,0, 0]) rotate([0, 90, 0]) cylinder(d=s*1.5, h=w/3-.6, center=true);
                translate([ w/3/2-s/2,0 -(h-t)*2, 0]) rotate([0, 90, 0]) cylinder(d=s+pl, h=s+pl, center=true);
                translate([-w/3/2+s/2,0 -(h-t)*2, 0]) rotate([0, 90, 0]) cylinder(d=s+pl, h=s+pl, center=true);
                }

            translate([ w/3-s/2-v,0, 0])    rotate([ 0, 90, 0]) cylinder(d=s, h=w/3, center=true);
            translate([-w/3+s/2+v,0, 0])    rotate([ 0, 90, 0]) cylinder(d=s, h=w/3, center=true);

            translate([ w/3/2-s/2,0, 0]) rotate([0, 90, 0]) cylinder(d=s-.5, h=s-pl, center=true);
            translate([-w/3/2+s/2,0, 0]) rotate([0, 90, 0]) cylinder(d=s-.5, h=s-pl, center=true);

            }
            
// cut                  translate([0, 0, -s/2]) cube([w,w,s+e], center=true);
// cut                  translate([w/2 -6, 0, ]) cube([w,w,3*s], center=true);
            } 
        }

    translate([ -(w+h)/2, -(h-s)/2, 0])
        intersection(){
            cube([h,s,s], center=true);
            translate([ h/2, 0+h-t, 0]) cut(-1);
            }
    //!
    translate([ -(w+h)/2,  (h-s)/2   -(h-t), 0])
        intersection(){
            cube([h,s,s], center=true);
            translate([ h/2, 0+h-t, 0]) cut(-1);
            }
    translate([ (w+h)/2, -(h-s)/2, 0])
        intersection(){
            cube([h,s,s], center=true);
            translate([-h/2, 0, 0]) cut();
            }
    translate([ (w+h)/2,  (h-s)/2   -(h-t), 0])
        intersection(){
            cube([h,s,s], center=true);
            translate([-h/2, 0, 0]) cut();
            }

    module cut(v=1, m=h){
        umax=4;
        translate([0, (v<0)?-(h-t):0, 0]) 
        intersection(){
            for (u=[1:umax]){
                r=s/2+m*u/umax;
                difference(){
                        cylinder(r1=r         , r2=r         , h=s+e, center=true);
                        cylinder(r1=r-m/umax/2, r2=r-m/umax/2, h=s+e, center=true);
                        } // difference()
            //           t                  h     t, s
//            translate([0, v*(m*.75/2+s/2), 0]) cube([m*1.5,m*.75,s+2*e], center=true);
            }
 
    union(){
        translate([          0,   v*(-h/2),   0]) cube([s,h,s], center=true);
        translate([v*(s/2+h/2),          0,   0]) cube([h,s,s], center=true);
    }

        } // difference()
    } // module cut()

        
    module CutCube(w=10){
        l=2*s;
        p=sqrt(2*l*l);
        d=cl/l*p;
        rotate([90, 0, 90]) translate([ 0, -s/2, -w/2]) 
        linear_extrude(w){
            polygon(points = [ [-cl,cl], [cl,cl], [p,p], [-p,p], ]);
            }
        }
}
