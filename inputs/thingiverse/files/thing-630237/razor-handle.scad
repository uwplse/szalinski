handle_diameter = 15;
overall_length = 85;

// length of unknurled top dome
transition_length = 10; 
// controls the shape of the top dome
transition_dome_scale = 2.5; 
// higher for smoother, lower for rougher
knurl_smoothing = 75; 

// angle from vertical
bevel_angle = 40; 
bevel_distance = 2;

// diameter for hole below nut, to accomodate the head screw
screw_clearance_diameter = 5.8; 
// total length for screw hole
screw_length = 8; 

// M5 nut
nut_flats_diameter = 8; 
nut_height = 4.2;


/* [Hidden] */
$fa = 5;
$fs = 0.5;
knurl_length = overall_length - transition_length;
nut_points_diameter = nut_flats_diameter/cos(30);
slop = 1;

difference() {
  intersection() {
    // bounding box
    translate([-(handle_diameter + slop)/2, -(handle_diameter + slop)/2]) cube([handle_diameter+slop, handle_diameter+slop, overall_length]);

    union() {
      // knurling
      knurl(k_cyl_hg=knurl_length, k_cyl_od=handle_diameter, s_smooth=knurl_smoothing, e_smooth=0);

      // dome area
      translate([0, 0, knurl_length]) rotate_extrude() intersection() {
        scale([1, transition_dome_scale, 1]) circle(handle_diameter/2);
        square([handle_diameter/2 + slop, handle_diameter*transition_dome_scale + slop]);
      }
    }
  }

  // nut
  translate([0, 0, overall_length-nut_height]) linear_extrude(nut_height+slop) circle(nut_points_diameter/2, $fn=6);

  // screw hole
  translate([0, 0, overall_length-screw_length]) cylinder(h=screw_length, r=screw_clearance_diameter/2);

  // bevel
  rotate_extrude() translate([handle_diameter/2 - bevel_distance, 0]) rotate([0, 0, -bevel_angle]) square([handle_diameter, handle_diameter]);
}



/*
 * knurledFinishLib_v2.scad
 * 
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:31122
 *
 * Derived from knurledFinishLib.scad (also Public Domain license) available at
 *
 * http://www.thingiverse.com/thing:9095
 *
 * Usage:
 *
 *   Drop this script somewhere where OpenSCAD can find it (your current project's
 *   working directory/folder or your OpenSCAD libraries directory/folder).
 *
 *   Add the line:
 *
 *    use <knurledFinishLib_v2.scad>
 *
 *   in your OpenSCAD script and call either...
 *
 *    knurled_cyl( Knurled cylinder height,
 *                 Knurled cylinder outer diameter,
 *                 Knurl polyhedron width,
 *                 Knurl polyhedron height,
 *                 Knurl polyhedron depth,
 *                 Cylinder ends smoothed height,
 *                 Knurled surface smoothing amount );
 *
 *  ...or...
 *
 *    knurl();
 *
 *  If you use knurled_cyl() module, you need to specify the values for all and
 *
 *  Call the module ' help(); ' for a little bit more of detail
 *  and/or take a look to the PDF available at http://www.thingiverse.com/thing:9095
 *  for a in depth descrition of the knurl properties.
 */


module knurl( k_cyl_hg  = 12,
          k_cyl_od  = 25,
          knurl_wd =  3,
          knurl_hg =  4,
          knurl_dp =  1.5,
          e_smooth =  2,
          s_smooth =  0)
{
    knurled_cyl(k_cyl_hg, k_cyl_od, 
                knurl_wd, knurl_hg, knurl_dp, 
                e_smooth, s_smooth);
}

module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
{
    cord=(cod+cdp+cdp*smt/100)/2;
    cird=cord-cdp;
    cfn=round(2*cird*PI/cwd);
    clf=360/cfn;
    crn=ceil(chg/csh);

    echo("knurled cylinder max diameter: ", 2*cord);
    echo("knurled cylinder min diameter: ", 2*cird);

   if( fsh < 0 )
    {
        union()
        {
            shape(fsh, cird+cdp*smt/100, cord, cfn*4, chg);

            translate([0,0,-(crn*csh-chg)/2])
              knurled_finish(cord, cird, clf, csh, cfn, crn);
        }
    }
    else if ( fsh == 0 )
    {
        intersection()
        {
            cylinder(h=chg, r=cord-cdp*smt/100, $fn=2*cfn, center=false);

            translate([0,0,-(crn*csh-chg)/2])
              knurled_finish(cord, cird, clf, csh, cfn, crn);
        }
    }
    else
    {
        intersection()
        {
            shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

            translate([0,0,-(crn*csh-chg)/2])
              knurled_finish(cord, cird, clf, csh, cfn, crn);
        }
    }
}

module shape(hsh, ird, ord, fn4, hg)
{
  x0= 0;  x1 = hsh > 0 ? ird : ord;   x2 = hsh > 0 ? ord : ird;
  y0=-0.1;  y1=0; y2=abs(hsh);  y3=hg-abs(hsh); y4=hg;  y5=hg+0.1;

  if ( hsh >= 0 )
  {
    rotate_extrude(convexity=10, $fn=fn4)
    polygon(points=[  [x0,y1],[x1,y1],[x2,y2],[x2,y3],[x1,y4],[x0,y4] ],
          paths=[ [0,1,2,3,4,5] ]);
  }
  else
  {
    rotate_extrude(convexity=10, $fn=fn4)
    polygon(points=[  [x0,y0],[x1,y0],[x1,y1],[x2,y2],
                [x2,y3],[x1,y4],[x1,y5],[x0,y5] ],
          paths=[ [0,1,2,3,4,5,6,7] ]);
  }
}

module knurled_finish(ord, ird, lf, sh, fn, rn)
{
    for(j=[0:rn-1])
    assign(h0=sh*j, h1=sh*(j+1/2), h2=sh*(j+1))
    {
        for(i=[0:fn-1])
        assign(lf0=lf*i, lf1=lf*(i+1/2), lf2=lf*(i+1))
        {
            polyhedron(
                points=[
                     [ 0,0,h0],
                     [ ord*cos(lf0), ord*sin(lf0), h0],
                     [ ird*cos(lf1), ird*sin(lf1), h0],
                     [ ord*cos(lf2), ord*sin(lf2), h0],

                     [ ird*cos(lf0), ird*sin(lf0), h1],
                     [ ord*cos(lf1), ord*sin(lf1), h1],
                     [ ird*cos(lf2), ird*sin(lf2), h1],

                     [ 0,0,h2],
                     [ ord*cos(lf0), ord*sin(lf0), h2],
                     [ ird*cos(lf1), ird*sin(lf1), h2],
                     [ ord*cos(lf2), ord*sin(lf2), h2]
                    ],
                triangles=[
                     [0,1,2],[2,3,0],
                     [1,0,4],[4,0,7],[7,8,4],
                     [8,7,9],[10,9,7],
                     [10,7,6],[6,7,0],[3,6,0],
                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
                    ],
                convexity=5);
         }
    }
}

module knurl_help()
{
  echo();
  echo("    Knurled Surface Library  v2  ");
   echo("");
  echo("      Modules:    ");
  echo("");
  echo("        knurled_cyl(parameters... );    -    Requires a value for each an every expected parameter (see bellow)    ");
  echo("");
  echo("        knurl();    -    Call to the previous module with a set of default parameters,    ");
  echo("                                  values may be changed by adding 'parameter_name=value'        i.e.     knurl(s_smooth=40);    ");
  echo("");
  echo("      Parameters, all of them in mm but the last one.    ");
  echo("");
  echo("        k_cyl_hg       -   [ 12   ]  ,,  Height for the knurled cylinder    ");
  echo("        k_cyl_od      -   [ 25   ]  ,,  Cylinder's Outer Diameter before applying the knurled surfacefinishing.    ");
  echo("        knurl_wd     -   [   3   ]  ,,  Knurl's Width.    ");
  echo("        knurl_hg      -   [   4   ]  ,,  Knurl's Height.    ");
  echo("        knurl_dp     -   [  1.5 ]  ,,  Knurl's Depth.    ");
  echo("        e_smooth   -    [  2   ]  ,,  Bevel's Height at the bottom and the top of the cylinder    ");
  echo("        s_smooth   -    [  0   ]  ,,  Knurl's Surface Smoothing :  File donwn the top of the knurl this value, i.e. 40 will snooth it a 40%.    ");
  echo("");
}

