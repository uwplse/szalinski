// [7:361] facettes as in $fn
fn=63;  // [7:361]
$fn=fn; // here it is, the magical fn

// kettenglieder in X
nx=5; // [1:40]
// kettenglieder in Y
ny=4; // [1:40]

ax=16-0 ;  // [16] x achse eines kettengliedes
ay=10-0 ;  // [10] y achse eines kettengliedes

// die Kette
k(nx,ny);   

module k(knX=9, knY=5) 
    {
    x=0; y=0; xs=0; ys=0;
        {
        for (ys=[0:knY]){ y=ys*(2*(ay+3)+1);
            for (xs=[0:knX]){ x=xs*(22);
                    translate([x/1.65,y/1.9, 0])
                        rotate([ 90, 90, 0])
                            kg();
            } // for (xs=
//            ra=+360*$t; echo(ra);
            xx=knX*(22);          // x maximum
            yx=knY*(2*(ay+3)+1);  // y maximum

            if ((ys % 2 == 0) && (y < yx)){
                color("lightblue")
                    translate([(x-22)/1.65 +1,y/1.9 +7, 02])
                        rotate([180, 130, 80]) kg(); 
                }
                
            if ((ys % 2 == 1) && (y < yx)){
//              ra=+360*$t; echo(ra);
                color("magenta")    // walze  y  z
                    translate([(xx+22)/1.65 -1,y/1.9 +7, 1])
                        rotate([180, 50, 80])
                            kg();
                } // if (y % 2 == 1)
            } // for ys
        } // mirror
    } // module

// KettenGlied
module kg(){
    eps=.00001;     // I name it epsilon
    d=  6 ; // the diameter of the draht
    R=  3 ; // radius des rings
    hz= 4 ; // elevation of the twist

    for (w=[0:360/fn:360])
        {
        t0=sin(w*2);
        u0=30*-cos(w*2);
        v=w+360/fn;
        t1=sin(v*2);
        u1=30*-cos(v*2);

        hull()
            {
            translate([ax*sin(w), ay*cos(w), hz*t0])
                rotate([0,90,0])
                    rotate([w,0,0])
                        cylinder(d=d, h=eps);

            translate([ax*sin(v), ay*cos(v), hz*t1])
                rotate([0,90,0])
                    rotate([v,0,0])
                        cylinder(d=d, h=eps);
            } // hull
        } // for (w=[0:360/fn:360])
    } // module