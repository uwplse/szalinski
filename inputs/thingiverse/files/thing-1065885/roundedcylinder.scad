//Radius of the cylinder
r=20; 

// Height of the cylinder
h=50; 

// rounding radius on the edge of the cylinder
rounding=5;

// Should we round only top? 
roundTopOnly=false; // [true, false]

// Number of fragments of the cylinder. 
fn=100; 

module roundedCylinder(r, h, rounding, roundTopOnly=false){
    function getFn(r, fn, fs, fa) = 
        (fn > 0.0) ? floor(fn >= 3 ? fn : 3)
                   : ceil(max(min(360.0 / fa, r*2*PI / fs), 5));

    
    function point(a, c, N) = 
        c*(N+1) + a;

    function face(a, c, N, flag) = 
        let (c1 = c==0?4*N:c-1) 
            [ 
                point(a, c, N), 
                point(a-1, c1, N), 
                flag ? point(a-1, c, N) : point(a, c1, N)
            ];

    fn = getFn(r, $fn, $fs, $fa);
    K=fn/360;
    N=K*90;
    points = [ 
        for (c= [0: 4*N]) 
            for (a = [0 : N]) 
                let (b=a/K, d=c/K) 
                    [ 
                        rounding*sin(b) * cos(d) + (r-rounding)*cos(d), 
                        rounding*sin(b) * sin(d) + (r-rounding)*sin(d), 
                        rounding*cos(b) 
                    ] 
            ];

    faces = [ 
        for (c= [0:4*N]) 
            for (a = [1:N]) 
                for (flag=[false, true]) 
                    face(a, c, N, flag) 
            ];

    hull(){    
        translate([0, 0, h-rounding])
            polyhedron(points=points, faces=faces);

        if(!roundTopOnly){
            translate([0, 0, rounding])
            rotate([180, 0, 0])
                polyhedron(points=points, faces=faces);
        }

        if(roundTopOnly){
            cylinder(r=r, h=h-rounding);
        }

    }
}
  
roundedCylinder(r=r, h=h, rounding=min(rounding, h/(roundTopOnly?1:2), r), roundTopOnly=roundTopOnly, $fn=fn);