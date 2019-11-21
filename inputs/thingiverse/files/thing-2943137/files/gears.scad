// gears.scad
// library for parametric involute gears 
// Author: Rudolf Huttary, Berlin 
// last update: June 2016


// Modifications by Hans Loeblich, June 2018
//  - make customizer script for 45 degree helix gears, right angle connection
//  - Derive module for a pair of gears based on separation and tooth counts
//  - add shaft hole
//  - add chamfer to smooth sharp corners and look cool (also hypothetically make engagement smoother/quieter, especially with a smooshed first layer)
//  - specify helix chirality as left/right handed
//  - pass iterations as parameter
//  - use $fs for determining vertical slices of linear_extrude

// Distance between meshed gear centers
separation = 44;
// Number of teeth on first gear
teeth1 = 16;
// Number of teeth on second gear
teeth2 = 32;
// Height of first gear
h1 = 15;
// Height of second gear
h2 = 15;
// Bore inner diameter
d1 = 8;
// Bore inner diameter
d2 = 8;
// Chamfer ends of gear
chamfer = 2; // [0:0.1:5]
chirality = 1; // [0:left-handed, 1:right-handed]

/* [View/Export] */
view = 3; // [1:first gear,2:second gear,3:both gears]
// When viewing "both gears", gear rotation may need adjustment for the teeth to appear meshed without intersecting.
mesh_correction = 0.5; // [0:0.01:1]
verbose = false;   // set to false if no console output is desired

/* [Hidden] */

iterations = 120; // increase for enhanced resolution beware: large numbers will take lots of time!

VIEW_FIRST = 1;
VIEW_SECOND = 2;
VIEW_BOTH = 3;

// $fs,$fa affect vertical resolution and shaft bore resolution (but not gear tooth profile)
$fs = 0.5; 
$fa = 0.1;

m = separation / ((teeth1+teeth2)/2);

if (view == VIEW_FIRST || view == VIEW_BOTH) {
rotate([0,0,360/teeth1*mesh_correction]) 
  chamfered_gear(m, teeth1, h1, d1, chamfer, chirality, iterations);
}

if (view == VIEW_SECOND) {
  chamfered_gear(m, teeth2, h2, d2, chamfer, chirality, iterations);
} else if (view == VIEW_BOTH) {
  translate([0,separation,0]) rotate([0,90,0]) 
    chamfered_gear(m, teeth2, h2, d2, chamfer, chirality, iterations);
}

module chamfered_gear(m, z, h, d, chamfer, chirality, iterations=150) {
  if (verbose) echo(str(
  "chamfered_gear(",m,",",z,",",h,",",d,",",chamfer,",",chirality,",",iterations,");"
  ));

  x = 0;

  intersection() {
    difference() {
      gear_helix(m = m, z = z, x = x, h = h, w = 20, w_helix = chirality ? -45 : 45, w_abs = 0, clearance = 0.1, center = true, verbose = verbose, iterations=iterations);
      cylinder(d=d, h=h+2, center=true);
    }

  	r_wk = m*z/2 + x; 
   	dy = m;  
  	r_kk = r_wk + dy;   

    x1 = r_kk;
    if (chamfer > 0) rotate_extrude() polygon([
      [0,-h/2-chamfer], [x1-2*chamfer, -h/2-chamfer],
      [x1+chamfer,-h/2+2*chamfer], [x1+chamfer, h/2-2*chamfer], 
      [x1-2*chamfer,h/2+chamfer], [0, h/2+chamfer]
  ]);
  }
}
//help();  // display module prototypes
// default values
// z = 10; // teeth - beware: large numbers may take lots of time!
// m = 1;  // modulus
// x = 0;  // profile shift
// h = 4;  // face_width	respectively axial height
// w = 20; // profile angle
// clearance  // assymmetry of tool to clear tooth head and foot
//    = 0.1; // for external splines
//    = -.1  // for internal splines 
// w_bevel = 45; // axial pitch angle
// w_helix = 45; // radial pitch angle 

// use this prototype:
// gear(m = modulus, z = Z, x = profile_shift, w = alpha, h = face_width);

//====  external splines with default values ===
// gear();  
// gear_helix(); 
// gear_herringbone(); 
// gear_bevel(); 

//====  internal splines with default values ===
// Gear();  
// Gear_helix(); 
// Gear_herringbone(); 
// Gear_bevel(); 
// 

//====  internal splines - usage and more examples ===
// gear(z = 25, m = 1, x = -.5, h = 4); 
// gear_bevel(z = 26, m = 1, x = .5, h = 3, w_bevel = 45, w_helix = -45); 
// gear_helix(z = 16, m = 0.5, h = 4, w_helix = -20, clearance = 0.1); 
//  gear_herringbone(z = 16, m = 0.5, h = 4, w_helix = -45, clearance = 0.1); // twist independent from height
// gear_herringbone(z = 16, m = 0.5, h = 4, w_abs = -20, clearance = 0.1);  // twist absolute


//====  external splines - usage and more examples ===
// D ist calculated automatically, but can also be specified
//
// Gear(z = 10, m = 1.1, x = 0, h = 2, w = 20,  D=18, clearance = -0.2); 
// gear(z = 10, m = 1, x = .5, h = 4, w = 20, clearance = 0.2); 

// Gear_herringbone(z = 40, m = 1, h = 4, w_helix = 45, clearance = -0.2, D = 49); 
// gear_herringbone(z = 40, m = 1, h = 4, w_helix = 45, clearance = 0.2); 

// Gear_helix(z = 20, m=1.3, h = 15, w_helix = 45, clearance = -0.2); 
// gear_helix(z = 20, m=1.3, h = 15, w_helix = 45, clearance = 0.2); 


// ====  grouped examples ===
//	di = 18; //axial displacement
//	translate([di, di])   Gear(z = 25, D=32); 
//	translate([-di, di])  Gear_helix(z = 25, D=32); 
//	translate([-di, -di]) Gear_herringbone(z = 25, D=32); 
//	translate([di, -di])  Gear_bevel(z = 25, D=32); 
	
//	di = 8; //axial displacement
//	translate([di, di])   gear(); 
//	translate([-di, di])  gear_helix(); 
//	translate([-di, -di]) gear_herringbone(); 
//	translate([di, -di])  gear_bevel(); 

// profile shift examples
//	di = 9.5; //axial displacement
//	gear(z = 20, x = -.5); 
//	translate([0, di+3]) rotate([0, 0, 0]) gear(z = 7, x = 0, clearance = .2); 
//	translate([di+3.4, 0]) rotate([0, 0, 0]) gear(z = 6, x = .25); 
//	translate([0, -di-3]) rotate([0, 0, 36])   gear(z = 5, x = .5); 
//	translate([-di-3.675, 0]) rotate([0, 0, 22.5]) gear(z = 8, x = -.25); 
 

// tooth cutting principle - dumping frames for video
//	s = PI/6; 
//	T= $t*360; 
//  U = 10*PI; 
//  difference()
//  {
//    circle(6);  // workpiece
//    for(i=[0:s:T])
//      rotate([0, 0, -i])
//      translate([-i/360*U, 0, 0])
//      Rack();  // Tool
//    }
//	rotate([0, 0, -T])
//	translate([-T/360*U, 0, 0])
//	color("red")
//  Rack();  // Tool




// === modules for internal splines
module help()
{
helpstr = 
"gears library \n
  iterations = 150;\n
  verbose = true;\n
  help();\n
  gear(m = 1, z = 10, x = 0, h = 4, w = 20, clearance = 0.1, center = true);\n
  gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0.1, center = true, verbose = true);\n
  gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0.1, center = true);\n
  gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 45, w_abs = 0, clearance = 0.1, center = true);\n
  gear_info(m = 1, z = 10, x = 0, h = 0, w = 20, w_bevel = 0, w_helix = 0, w_abs=0, clearance = 0.1, center=true);\n
annular-toothed;\n
  Gear(m = 1, z = 10, x = 0, h = 4, w = 20, D = 0, clearance = -.1, center = true);\n
  Gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, D = 0, clearance = -.1, center = true);\n
  Gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs=0, D = 0, clearance = -.1, center = true);\n
  Gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 0, w_abs = 0, D = 0, clearance = -0.1, center = true);\n
2D primitives\n
  gear2D(m = 1, z = 10, x = 0, w = 20, clearance = 0.1);\n
  Rack(m = 1, z = 10, x = 0, w = 20, clearance = 0);\n
  ";
 echo(helpstr); 
}

module Gear(m = 1, z = 10, x = 0, h = 4, w = 20, D = 0, clearance = -.1, center = true, iterations=150) 
{
   D_= D==0 ? m*(z+x+4):D; 
   difference()
   {
		cylinder(r = D_/2, h = h, center = center);
		gear(m, z, x, h+1, w, center = center, clearance = clearance, iterations); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}

module Gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, D = 0, clearance = -.1, center = true) 
{
   D_= D==0 ? m*(z+x+4):D; 
   difference()
   {
		cylinder(r = D_/2, h = h, center = center); // CSG!
    translate([0, 0, -.001]) 
		gear_herringbone(m, z, x, h+.01, w, w_helix, w_abs, clearance = clearance, center = center); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}

module Gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs=0, D = 0, clearance = -.1, center = true) 
{
   D_= D==0 ? m*(z+x+4):D; 
   difference()
   {
		cylinder(r = D_/2, h = h-.01, center = center); // CSG!
		gear_helix(m, z, x, h, w, w_helix, w_abs, clearance, center); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}

module Gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 0, w_abs = 0, D = 0, clearance = -0.1, center = true)
{
   D_= D==0 ? m*(z+x+4):D; 
   rotate([0, 180, 0])
   difference()
   {
		cylinder(r = D_/2, h = h-.01, center = center); // CSG!
		gear_bevel(m, z, x, h, w, w_bevel, w_helix, w_abs, clearance = clearance, center = center); 
	}
  if(verbose) echo(str("Ring (D) = ", D_)); 
}


// === modules for external splines
module gear_herringbone(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0.1, center = true)
{
  gear_info("herringbone", m, z, x, h, w, undef, w_abs==0?w_helix:undef, w_abs==0?undef:w_abs, clearance, center);
  translate([0, 0, center?0:h/2])
   for(i=[0, 1])
   mirror([0,0,i])
   gear_helix(m, z, x, h/2, w, w_helix, w_abs, center = false, clearance = clearance, center = false, verbose = false); 
}

module gear_helix(m = 1, z = 10, x = 0, h = 4, w = 20, w_helix = 45, w_abs = 0, clearance = 0.1, center = true, verbose = true, iterations=150)
{
  if(verbose)
    gear_info("helix", m, z, x, h, w, undef, w_abs==0?w_helix:undef, w_abs==0?undef:w_abs, clearance, center);
	r_wk = m*z/2 + x; 
  tw = w_abs==0?h/tan(90-w_helix)/PI*180/r_wk:w_abs;
  sl = abs(tw)>0?round(h/$fs):1; 
	linear_extrude(height = h, center = center, twist = tw, slices = sl, convexity = z, center = center)
   gear2D(m, z, x, w, clearance, iterations); 
}

module gear_bevel(m = 1, z = 10, x = 0, h = 4, w = 20, w_bevel = 45, w_helix = 0, w_abs = 0, clearance = 0.1, center = true, iterations=150)
{
  gear_info("bevel", m, z, x, h, w, w_bevel, w_abs==0?w_helix:undef, w_abs==0?undef:w_abs, clearance, center);
	r_wk = m*z/2 + x; 
   sc = (r_wk-tan(w_bevel)*h)/r_wk; 
  tw = w_abs==0?h/tan(90-w_helix)/PI*180/r_wk:w_abs;
  sl = abs(tw)>0 ? round(h / $fs) : 1;
	linear_extrude(height = h, center = center, twist = tw, scale = [sc, sc], slices = sl, convexity = z)
   gear2D(m, z, x, w, clearance, iterations); 
}

module gear(m = 1, z = 10, x = 0, h = 4, w = 20, clearance = 0.1, center = true, iterations = 150)
{
  gear_info("spur", m, z, x, h, w, undef, undef, undef, clearance, center); 
	linear_extrude(height = h, center = center, convexity = z)
    gear2D(m, z, x, w, clearance, iterations); 
}

module gear_info(type = "", m = 1, z = 10, x = 0, h = 0, w = 20, w_bevel = 0, w_helix = 0, w_abs=0, clearance = 0.1, center=true, D=undef, verbose=true)
{
  	r_wk = m*z/2 + x; 
   	dy = m;  
  	r_kk = r_wk + dy;   
  	r_fk = r_wk - dy;  
  	r_kkc = r_wk + dy *(1-clearance/2);   
  	r_fkc = r_wk - dy *(1+clearance/2);  
  if(verbose) 
  {
   echo(str ("\n")); 
   echo(str (type, " gear")); 
   echo(str ("modulus (m) = ", m)); 
   echo(str ("teeth (z) = ", z)); 
   echo(str ("profile angle (w) = ", w, "°")); 
   echo(str ("pitch (d) = ", 2*r_wk)); 
   echo(str ("d_outer = ", 2*r_kk, "mm")); 
   echo(str ("d_inner = ", 2*r_fk, "mm")); 
   echo(str ("height (h) = ", h, "mm")); 
   echo(str ("clearance factor = ", clearance)); 
   echo(str ("d_outer_cleared = ", 2*r_kkc, "mm")); 
   echo(str ("d_inner_cleared = ", 2*r_fkc, "mm")); 
   echo(str ("helix angle (w_helix) = ", w_helix, "°")); 
   echo(str ("absolute angle (w_abs) = ", w_abs, "°")); 
   echo(str ("bevel angle (w_bevel) = ", w_bevel, "°")); 
   echo(str ("center  = ", center)); 
  }
}


// === from here 2D stuff == 
module gear2D(m = 1, z = 10, x = 0, w = 20, clearance = 0.1, iterations)
{
  	r_wk = m*z/2 + x;
    U = m*z*PI;
   	dy = m;
  	r_fkc = r_wk + dy *(1-clearance/2);
  s = 360/iterations;
  difference()
  {
    circle(r_fkc, $fn=300);  // workpiece
    //circle(d=8); // shaft bore
    for(i=[0:s:360])
      rotate([0, 0, -i])
      translate([-i/360*U, 0, 0])
      Rack(m, z, x, w, clearance);  // Tool
  }
}

module Rack(m = 1, z = 10, x = 0, w = 20, clearance = 0)
  {
    p = m*PI; 
    dy = 2*m;  
    dx = dy * tan(w);  
    ddx = dx/2 * clearance/2; 
    ddy = dy/2 * clearance/2; 
    r_wk = m*z/2 + x; 
    y0 = r_wk+dy; 
    y1 = r_wk+dy/2-ddy; 
    y2 = r_wk+dy/2 - ddy; 
    y3 = r_wk-dy/2 - ddy; 
    x0 = p/4-dx/2 + ddx; 
    x1 = p/4+dx/2 + ddx; 
    x2 = 3*p/4-dx/2 - ddx; 
    x3 = 3*p/4+dx/2 - ddx; 
    polygon(points = tooth(z));
    
    function tooth(z = 10) = concat([[-p, y0],[-p, y1]],  
		[for(i=[-1:z], j=[0:3]) to(i*p)[j]], [[(z+1)*p, y1], [(z+1)*p, y0]]); 
      
    function to(dx) = [[dx+x0, y2], [dx+x1, y3], [dx+x2, y3], [dx+x3, y2]]; 
}

