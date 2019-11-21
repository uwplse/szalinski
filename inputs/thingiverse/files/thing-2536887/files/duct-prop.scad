// NACA4 airfoil based prop generator for use with ducts.

/*
common prop size and pitch values in mm:

    2   in = 50.8  mm
    3   in = 76.2  mm
    3.8 in = 96.52 mm
    4   in = 101.6 mm
    4.5 in = 114.3 mm
    5   in = 127.0 mm
    5.5 in = 139.7 mm
    6   in = 152.4 mm
*/

// Parameters
propDiameter=127;
propHeight=8;
propPitch=101.6;
propThickness=2.5;
propNacaCamber=0.02;
propNacaMaxCamberPosition=0.3;
propSegmentWidth=3; // 1 is good for final renders, 5 for quick previews
propBladeCount=11;
propShaftDiameter=5;
propHubDiameter=14;
propHubMinRadius=2;





// I'm including the core of <naca4.scad> file so the Thingiverse customizer will work.
// naca4 scad files: https://www.thingiverse.com/thing:898554
//
// locally you can switch this to `use <naca4.scad>`
//
// ************************
// *** BEGIN naca4.scad ***
// ************************

    // Naca4.scad - library for parametric airfoils of 4 digit NACA series
    // Code: Rudolf Huttary, Berlin 
    // June 2015
    // commercial use prohibited


    // general use: for more examples refer to sampler.scad
    // naca = naca digits or 3el vector  (default = 12 or [0, 0, .12])
    // L    = chord length [mm]      (default= 100)
    // N    = # sample points        (default= 81)
    // h    = height [mm]            (default= 1)
    // open = close at the thin end? (default = true)
    // two equivalent example calls
    //airfoil(naca = 2408, L = 60, N=1001, h = 30, open = false); 
    // airfoil(naca = [.2, .4, .32], L = 60, N=1001, h = 30, open = false); 

    module help()
    {
      echo(str("\n\nList of signatures in lib:\n=================\n", 
      "module airfoil(naca=2412, L = 100, N = 81, h = 1, open = false) - renders airfoil object\n", 
      "module airfoil(naca=[.2, .4, .12], L = 100, N = 81, h = 1, open = false) - renders airfoil object using percentage for camber,  camber distance and thicknes\n", 
      "function airfoil_data(naca=12, L = 100, N = 81, open = false)\n",
      "=================\n")); 
    }

    //help(); 
    // this is the object
    module airfoil(naca=12, L = 100, N = 81, h = 1, open = false)
    {
      linear_extrude(height = h)
      polygon(points = airfoil_data(naca, L, N, open)); 
    }

    // this is the main function providing the airfoil data
    function airfoil_data(naca=12, L = 100, N = 81, open = false) = 
      let(Na = len(naca)!=3?NACA(naca):naca)
      let(A = [.2969, -0.126, -.3516, .2843, open?-0.1015:-0.1036])
      [for (b=[-180:360/(N):179.99]) 
        let (x = (1-cos(b))/2)  
        let(yt = sign(b)*Na[2]/.2*(A*[sqrt(x), x, x*x, x*x*x, x*x*x*x])) 
        Na[0]==0?L*[x, yt]:L*camber(x, yt, Na[0], Na[1], sign(b))];  

    // helper functions
    function NACA(naca) = 
      let (M = floor(naca/1000))
      let (P = floor((naca-M*1000)/100)) 
      [M/100, P/10, floor(naca-M*1000-P*100)/100];  

    function camber(x, y, M, P, upper) = 
      let(yc = (x<P)?M/P/P*(2*P*x-x*x): M/(1-P)/(1-P)*(1 - 2*P + 2*P*x -x*x))
      let(dy = (x<P)?2*M/P/P*(P-x):2*M/(1-P)/(1-P)*(P-x))
      let(th = atan(dy))
      [upper ? x - y*sin(th):x + y*sin(th), upper ? yc + y*cos(th):yc - y*cos(th)];

// **********************
// *** END naca4.scad ***
// **********************





Pi = 3.14159265359;


module prop_profile(radius) {
    /*
        TODO:   adjust chord length and vertical offset to keep topmost point
                of airfoil at the top of the hub.
    */
    $fn=80;
    // find angle
    angle=atan(propPitch/(2*Pi*radius));
    // find chord length
    chord=(1/sin(angle))*propHeight;
    // find the thickness relative to chord
    thickness=propThickness/chord;
    rotate([90,angle,90])
    linear_extrude(height=0.01)
    polygon(points=airfoil_data(naca=[propNacaCamber, propNacaMaxCamberPosition, thickness], L=chord, N=301, open=true)); 
}

module prop_blade() {
    union() {
        for (i=[propShaftDiameter/2:propSegmentWidth:propDiameter/2]) {
            hull() {
                translate([i,0,0])
                prop_profile(radius=i);
                translate([i+propSegmentWidth,0,0])
                prop_profile(radius=i+propSegmentWidth);
            }
        }
    }
}

module prop_hub() {
    $fn=80;
    translate([0,0,-propHeight/2])
    difference() {
        rotate_extrude() {
            union() {
                translate([0,-propHeight/2]) square([propHubDiameter/2-propHubMinRadius,propHeight]);
                translate([propHubDiameter/2-propHubMinRadius,0]) scale([propHubMinRadius/propHeight,1]) circle(d=propHeight);
            }
        }
        cylinder(d=propShaftDiameter,h=propHeight*3,center=true);
    }
}

module prop() {
    intersection() {
        union() {
            prop_hub();
            bladeAngleOffset = 360/propBladeCount;
            for (i=[1:1:propBladeCount]) {
                rotate([0,0,i*bladeAngleOffset])
                prop_blade();
            }
        }
        cylinder(d=propDiameter,h=propHeight*4,center=true,$fn=300);
    }
}

prop();
