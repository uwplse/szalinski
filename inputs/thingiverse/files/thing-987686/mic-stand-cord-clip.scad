// 
// Mic stand cord clip
// version 1.0   8/27/2015
// by daozenciaoyen
//

// preview[view:southwest, tilt:top]

/* [Main] */
// (in mm)
post_diameter = 19 ; // [5:0.5:40]
// (in mm)
cord_diameter = 8 ; // [5:0.5:20]
// extra cord room (in mm)
add_clearance = 0 ; // [0:0.5:10]
// (in mm)
clip_width = 8 ; // [2:2:40]
// (in pct of post diameter)
opening_percent = 0.7 ; // [0.5:0.05:0.95]
// (in mm)
min_thickness = 2.5 ; // [2:0.5:10]

/* [Hidden] */
pd = post_diameter ;
cd = cord_diameter ;
ac = add_clearance ;
cw = clip_width ;
op = opening_percent ;
mt = min_thickness ;

opd = pd+mt*2 ; // outer post diameter
ocd = cd+mt*2 ; // outer cord diameter
pr = pd/2 ; // post radius
cr = cd/2 ; // cord radius
ol = pd*op ; // opening length
oa = asin((ol/2)/pr) ; // opening angle 
ff = .1 ; // fudge factor

$fn = 32 ;

main();

module main()
{
  linear_extrude(height=cw)
    union() {
      difference() {
        hull() {
          circle(d=opd);
          translate([pr+cr+ac,0,0]) circle(d=ocd);
        }
        circle(d=pd);
        translate([pr+cr+ac,0,0]) circle(d=cd);
        translate([0,-cr,0]) square([pr+cr+ac,cd]);
        pie(opd/2,oa*2,180) ;
      }
      rotate([0,0,oa]) translate([-pr-mt/2,0,0]) circle(d=mt);
      rotate([0,0,-oa]) translate([-pr-mt/2,0,0]) circle(d=mt);
    }
}

module pie(r,d,c)
{
  r = r + ff ; // radius
  // d = degrees (0-180)
  // c = angle of center of slice
  echo(d=d);
  rotate([0,0,180+d/2+c])
  difference() {
    intersection() {
      translate([-r,0,0]) square([r*2,r]);
      circle(r+ff);
    }
    rotate([0,0,180-d])
      translate([-r,-r,0]) square([r*2,r]);
  }
}