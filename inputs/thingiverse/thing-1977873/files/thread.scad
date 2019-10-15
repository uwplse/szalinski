// Threading.scad - library for threadings
// Autor: Rudolf Huttary, Berlin 2016 

use <Naca_sweep.scad> // http://www.thingiverse.com/thing:900137

// examples 
//showexample = 4;   // choose your example number

//threading(pitch = 1.25, d=8, windings=20, full=true, steps = 512);

example(showexample)
{
// #1 ACME thread
  threading(pitch = 2, d=20, windings = 5, angle = 29); 

// #2 threaded rod 20°
  threading(pitch = 2, d=20, windings = 30, angle = 20, full = true); 

// #3 nut for threaded rod 20°
  Threading(pitch = 2, d=20, windings = 10, angle = 20, full = true); 

// #4 nut for threaded rod 20°, own diameter 25 mm, hires 
  Threading(D = 25, pitch = 2, d=20, windings = 10, angle = 20, full = true, step = 50, $fn=100); 

// #5 triple helix threaded rod
  threading(pitch = 2, d=20, windings = 30, helices = 3, angle = 20, full = true); 

// #6 toothed rod (no pitch) 
   threading(helices = 0, angle = 20, full = true); 

// #7 toothed cube (no pitch) 
   threading(helices = 0, angle = 60, full = true, steps=4); 

// #8 M8 hex bolt
   union(){
     threading(pitch = 1.25, d=8, windings=20, full=true); cylinder(d=14.6, h=4, $fn=6);} 
// #9 M8 hex nut
   Threading(D=14.6, pitch = 1.25, d=8, windings=5, full=true, $fn=6);  
// #10 M8 four socket nut
   Threading(D=16, pitch = 1.25, d=8, windings=5, full=true, $fn=4);  
}

module example(number=0) if(number) children(number-1);

help(); 
module help()
{
  helpstr = 
  "Thread library - Rudolf Huttary \n
    D = {0=auto};  // Cyl diameter Threading() \n
    d = 6;         // outer diameter thread() \n
    windings = 10; // number of windings \n
    helices = 1;   // number of threads \n
    angle = 60;    // open angle <76, bolts: 60°, ACME: 29°, toothed Racks: 20° \n
    steps = 40;    // resolution \n
    help();        // show help in console
    threading(pitch = 1, d = 6, windings = 10, helices = 1, angle = 60, steps=40, full = false) \n
    Threading(D = 0, pitch = 1, r = 6, windings = 10, helices = 1, angle = 60, steps=40) \n
  ";
  echo (helpstr);
}

//Threading(R=12, pitch = pitch, r=radius, windings= windings, angle = angle); 

module Threading(D = 0, pitch = 1, d = 12, windings = 10, helices = 1, angle = 60, steps=40)
{
  R = D==0?d/2+pitch/PI:D/2; 
  translate([0,0,-pitch])
  difference()
  { translate([0,0,pitch]) 
    cylinder (r=R, h =pitch*(windings-helices)); 
    threading(pitch, d, windings, helices, angle, steps, true); 
  }
}

module threading(pitch = 1, d = 12, windings = 10, helices = 1, angle = 60, steps=40, full = false)
{  // tricky: glue two 180° pieces together to get a proper manifold  
  r = d/2;
  Steps = steps/2; 
  Pitch = pitch*helices; 
  if(full) cylinder(r = r-1-pitch/PI, h=pitch*(windings+helices), $fn=steps); 
  sweep(gen_dat());   // half screw
  rotate([0, 0, 180]) translate([0, 0, Pitch/2])
  sweep(gen_dat());   // half screw
echo(steps); 
  function gen_dat() = let(ang = 180, bar = R_(180, -90, 0, Ty_(-r+1, vec3D(pitch/PI*Rack(windings, angle)))))
        [for (i=[0:Steps]) Tz_(i/2/Steps*Pitch, Rz_(i*ang/Steps, bar))]; 

  function Rack(w, angle) = 
     concat([[0, 2]], [for (i=[0:windings-1], j=[0:3])
     let(t = [ [0, 1], [2*tan(angle/2), -1], [PI/2, -1], [2*tan(angle/2)+PI/2, 1]])
        [t[j][0]+i*PI, t[j][1]]], [[w*PI, 1], [w*PI, 2]]);
}

