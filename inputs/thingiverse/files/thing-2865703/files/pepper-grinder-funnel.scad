/* [Global] */

//resolution
$fn=100;

//wall thickness (multiple of extrusion width, add 0.01 for small values to prevent slicing errors)
wall_t=1.6;

//tolerance of holes
tolerance=1; // [0:0.1:3]


/* [Funnel] */

//diameter of grinder opening
grinder_d_without_tolerance=33;
grinder_d=grinder_d_without_tolerance-tolerance;

//height of vertical grinder opening
grinder_h=5;

//diameter of grinder screw
screw_d_without_tolerance=6;
screw_d=screw_d_without_tolerance+tolerance;

//interior diameter of top of funnel
funnel_d_interior=65;
funnel_d=funnel_d_interior+(wall_t*2);

//funnel_angle from horizontal (determines height)
funnel_angle=45; // [15:75]

//height of funnel
funnel_h=(funnel_d-grinder_d)/tan(90-funnel_angle);


module oblong_cone(d, height, scale) {
   translate([-d/2,0,0])
      linear_extrude(funnel_h, scale=scale)
         translate([d/2,0,0])
            circle(d/2);
}

module angled_funnel() {
   difference() {
      oblong_cone(grinder_d, funnel_h, funnel_d/grinder_d);
      oblong_cone(grinder_d-(wall_t*2), funnel_h, (funnel_d-(wall_t*2))/(grinder_d-(wall_t*2)));
   }
}

module grinder_base() {
   translate([0,0,-grinder_h]) linear_extrude(grinder_h) {
      difference() {
         circle(d=grinder_d);
         circle(d=grinder_d-(wall_t*2));
      }
      difference() {
         union() {
            square([grinder_d-wall_t, wall_t], center=true);
            circle(d=screw_d+(wall_t*2));
         }
         circle(d=screw_d);
      }
   }
}

grinder_base();
angled_funnel();
