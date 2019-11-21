$fn = 64;
height = 12;
thick = height;
gap = 50;
dist = gap + thick;
totalLength = 400;
tipRadius = 20;
nut = 3;
nutFixD = thick*1.0; //make fix of nut strong enough
tolerance = 0.1;
showBase = 1;
showHook = 1;
brimH = 0.0;
brimW = 10;
//compensation of over-extrusion for holes
tol=0.15;
not=0.0001+0;


length = (totalLength+2*tipRadius+2*thick+dist)/4; // magic :-)
catchLength = (totalLength-2*length)/2;
inch = 25.4;

if (showHook) translate([0,catchLength+brimW+4*tolerance,0]){
	doubleCapHookRodHinge();
}
//translate([0,catchLength,thick*2]) rotate([180,90,0]) capHookRodHinge();
if (showBase) base();
//translate([-thick,catchLength,0]) capHookRodHinge();


module capHookRod(){
	translate([0,0,thick/2]) rotate([-90,0,0]){
		rodL = length-tipRadius-thick/2;
		rotate([0,0,0]) cylinder(h=rodL, d=thick);
		translate([0,-tipRadius,rodL]) rotate([0,-90,0]) rotate_extrude(angle = 90, convexity = 10) translate([tipRadius, 0, 0]) circle(d = thick);
		translate([0,-tipRadius,tipRadius+rodL]) sphere(d=thick);
	}
}

module hinge(){
	not=0.01;
	translate([0,0,thick]) rotate([90,0,90]) difference(){
		hull(){
			cylinderRounded(h=thick/2,d=nutFixD,r1=0,r2=thick/3);
			//translate([nutFixD/2,-thick/2,thick/2]) cube([not,not,not]);
		}
		translate([0,0,-not]) cylinder(h=thick,d=nut+2*tol);
	}
}

module hingeNegative(){
	translate([-thick/2,0,thick]) rotate([90,0,90]){
		cylinder(h=thick/2,d=nutFixD+tolerance);
		translate([0,0,-.001]) cylinder(h=thick,d=nut+2*not);
	}
}

module capHookRodHinge(){
	difference(){
		capHookRod();
		hingeNegative();
	}
	hinge();
}

module doubleCapHookRodHinge(){
	capHookRodHinge();
	translate([gap+thick,0,0]) capHookRodHinge();
	//translate([0,length-thick/2-dist,thick/2]) rotate([0,90,0]) cylinder(h=gap+thick, d=thick);
	translate([dist/2,length-dist/2-thick/2,thick/2]) difference(){
		torus(r1=thick/2,r2=dist/2);
		translate([-gap,0,-thick]) cube([2*gap,2*gap,3*thick]);
	}	
	translate([-brimW,-brimW,0]) cube([gap+thick+2*brimW,length-tipRadius+2*brimW,brimH]);
}
module base(){
	difference(){
		union(){
			translate([0,0,height/2]) hull() torus(r2=dist/2+thick/2,r1=height/2);	
			translate([thick/2,0,0]) catchPair();
			translate([-thick/2,0,0]) rotate([0,0,180]) catchPair();
			translate([0,thick/2,0]) rotate([0,0,90]) catchPair();
			translate([0,-thick/2,0]) rotate([0,0,270]) catchPair();
			
			rotate([0,0,0]) fillGap();
			rotate([0,0,90]) fillGap();
			rotate([0,0,180]) fillGap();
			rotate([0,0,-90]) fillGap();
		}
		
		english_thread (diameter=3/8, threads_per_inch=16, length=height/inch+1, internal=true);
	}
}

module fillGap(){
	translate([0,-dist/2+thick/2,0]) cube([dist/2+thick/2,dist/2-thick/2,thick]);
}

module catch(){
		difference(){
			translate([0,0,thick/2]) rotate([90,0,0]) cylinder(h=catchLength, d=thick);
			translate([0,-catchLength,0]) hingeNegative();
		}
		translate([0,-catchLength,0]) hinge();
}

module catchPair(){
	translate([dist/2,0,0]) catch();
	translate([-dist/2,0,0])catch();
}

module torus(r1=1, r2=5){
	rotate_extrude(convexity = 10)
	translate([r2, 0, 0])
	circle(r = r1);
}

module cylinderRounded(d=10,h=10,r1=1,r2=2){
	module torusQuart(r1=10,r2=1){
		rotate_extrude(convexity = 10)
		intersection(){
			translate([r1, 0, 0]) circle(r = r2);
			translate([r1, 0, 0]) square([2*r2,2*r2]);
		}
	}

	not = 0.000001;
	difference(){
		hull(){
			if (r1>0){
				translate([0,0,r1]) mirror([0,0,1]) torusQuart(r1=d/2-r1,r2=r1);
			} else {
				translate([0,0,0]) cylinder(d=d,h=not);
			}
			if (r2>0){
				translate([0,0,h-r2]) torusQuart(r1=d/2-r2,r2=r2);
			} else {
				translate([0,0,h]) cylinder(d=d,h=not);
			}
		}
	}
}


function segments (diameter) = min (50, ceil (diameter*6));
// ----------------------------------------------------------------------------
module metric_thread (diameter=8, pitch=1, length=1, internal=false, n_starts=1,
                      thread_size=-1, groove=false, square=false, rectangle=0,
                      angle=30, taper=0, leadin=0, leadfac=1.0)
{
   // thread_size: size of thread "V" different than travel per turn (pitch).
   // Default: same as pitch.
   local_thread_size = thread_size == -1 ? pitch : thread_size;
   local_rectangle = rectangle ? rectangle : 1;

   n_segments = segments (diameter);
   h = (square || rectangle) ? local_thread_size*local_rectangle/2 : local_thread_size / (2 * tan(angle));

   h_fac1 = (square || rectangle) ? 0.90 : 0.625;

   // External thread includes additional relief.
   h_fac2 = (square || rectangle) ? 0.95 : 5.3/8;

   tapered_diameter = diameter - length*taper;

   difference () {
      union () {
         if (! groove) {
            metric_thread_turns (diameter, pitch, length, internal, n_starts,
                                 local_thread_size, groove, square, rectangle, angle,
                                 taper);
         }

         difference () {

            // Solid center, including Dmin truncation.
            if (groove) {
               cylinder (r1=diameter/2, r2=tapered_diameter/2,
                         h=length, $fn=n_segments);
            } else if (internal) {
               cylinder (r1=diameter/2 - h*h_fac1, r2=tapered_diameter/2 - h*h_fac1,
                         h=length, $fn=n_segments);
            } else {

               // External thread.
               cylinder (r1=diameter/2 - h*h_fac2, r2=tapered_diameter/2 - h*h_fac2,
                         h=length, $fn=n_segments);
            }

            if (groove) {
               metric_thread_turns (diameter, pitch, length, internal, n_starts,
                                    local_thread_size, groove, square, rectangle,
                                    angle, taper);
            }
         }
      }

      // chamfer z=0 end if leadin is 2 or 3
      if (leadin == 2 || leadin == 3) {
         difference () {
            cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);

            cylinder (r2=diameter/2, r1=diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
                      $fn=n_segments);
         }
      }

      // chamfer z-max end if leadin is 1 or 2.
      if (leadin == 1 || leadin == 2) {
         translate ([0, 0, length + 0.05 - h*h_fac1*leadfac]) {
            difference () {
               cylinder (r=diameter/2 + 1, h=h*h_fac1*leadfac, $fn=n_segments);
               cylinder (r1=tapered_diameter/2, r2=tapered_diameter/2 - h*h_fac1*leadfac, h=h*h_fac1*leadfac,
                         $fn=n_segments);
            }
         }
      }
   }
}

module metric_thread_turns (diameter, pitch, length, internal, n_starts,
                            thread_size, groove, square, rectangle, angle,
                            taper)
{
   // Number of turns needed.
   n_turns = floor (length/pitch);

   intersection () {

      // Start one below z = 0.  Gives an extra turn at each end.
      for (i=[-1*n_starts : n_turns+1]) {
         translate ([0, 0, i*pitch]) {
            metric_thread_turn (diameter, pitch, internal, n_starts,
                                thread_size, groove, square, rectangle, angle,
                                taper, i*pitch);
         }
      }

      // Cut to length.
      translate ([0, 0, length/2]) {
         cube ([diameter*3, diameter*3, length], center=true);
      }
   }
}

module metric_thread_turn (diameter, pitch, internal, n_starts, thread_size,
                           groove, square, rectangle, angle, taper, z)
{
   n_segments = segments (diameter);
   fraction_circle = 1.0/n_segments;
   for (i=[0 : n_segments-1]) {
      rotate ([0, 0, i*360*fraction_circle]) {
         translate ([0, 0, i*n_starts*pitch*fraction_circle]) {
            //current_diameter = diameter - taper*(z + i*n_starts*pitch*fraction_circle);
            thread_polyhedron ((diameter - taper*(z + i*n_starts*pitch*fraction_circle))/2,
                               pitch, internal, n_starts, thread_size, groove,
                               square, rectangle, angle);
         }
      }
   }
}

// Input units in inches.
// Note: units of measure in drawing are mm!
module english_thread (diameter=0.25, threads_per_inch=20, length=1,
                      internal=false, n_starts=1, thread_size=-1, groove=false,
                      square=false, rectangle=0, angle=30, taper=0, leadin=0,
                      leadfac=1.0)
{
   // Convert to mm.
   mm_diameter = diameter*25.4;
   mm_pitch = (1.0/threads_per_inch)*25.4;
   mm_length = length*25.4;

   echo (str ("mm_diameter: ", mm_diameter));
   echo (str ("mm_pitch: ", mm_pitch));
   echo (str ("mm_length: ", mm_length));
   metric_thread (mm_diameter, mm_pitch, mm_length, internal, n_starts,
                  thread_size, groove, square, rectangle, angle, taper, leadin,
                  leadfac);
}

// ----------------------------------------------------------------------------
module thread_polyhedron (radius, pitch, internal, n_starts, thread_size,
                          groove, square, rectangle, angle)
{
   n_segments = segments (radius*2);
   fraction_circle = 1.0/n_segments;

   local_rectangle = rectangle ? rectangle : 1;

   h = (square || rectangle) ? thread_size*local_rectangle/2 : thread_size / (2 * tan(angle));
   outer_r = radius + (internal ? h/20 : 0); // Adds internal relief.
   //echo (str ("outer_r: ", outer_r));

   // A little extra on square thread -- make sure overlaps cylinder.
   h_fac1 = (square || rectangle) ? 1.1 : 0.875;
   inner_r = radius - h*h_fac1; // Does NOT do Dmin_truncation - do later with
                                // cylinder.

   translate_y = groove ? outer_r + inner_r : 0;
   reflect_x   = groove ? 1 : 0;

   // Make these just slightly bigger (keep in proportion) so polyhedra will
   // overlap.
   x_incr_outer = (! groove ? outer_r : inner_r) * fraction_circle * 2 * PI * 1.02;
   x_incr_inner = (! groove ? inner_r : outer_r) * fraction_circle * 2 * PI * 1.02;
   z_incr = n_starts * pitch * fraction_circle * 1.005;

   /*
    (angles x0 and x3 inner are actually 60 deg)

                          /\  (x2_inner, z2_inner) [2]
                         /  \
   (x3_inner, z3_inner) /    \
                  [3]   \     \
                        |\     \ (x2_outer, z2_outer) [6]
                        | \    /
                        |  \  /|
             z          |[7]\/ / (x1_outer, z1_outer) [5]
             |          |   | /
             |   x      |   |/
             |  /       |   / (x0_outer, z0_outer) [4]
             | /        |  /     (behind: (x1_inner, z1_inner) [1]
             |/         | /
    y________|          |/
   (r)                  / (x0_inner, z0_inner) [0]

   */

   x1_outer = outer_r * fraction_circle * 2 * PI;

   z0_outer = (outer_r - inner_r) * tan(angle);
   //echo (str ("z0_outer: ", z0_outer));

   //polygon ([[inner_r, 0], [outer_r, z0_outer],
   //        [outer_r, 0.5*pitch], [inner_r, 0.5*pitch]]);
   z1_outer = z0_outer + z_incr;

   // Give internal square threads some clearance in the z direction, too.
   bottom = internal ? 0.235 : 0.25;
   top    = internal ? 0.765 : 0.75;

   translate ([0, translate_y, 0]) {
      mirror ([reflect_x, 0, 0]) {

         if (square || rectangle) {

            // Rule for face ordering: look at polyhedron from outside: points must
            // be in clockwise order.
            polyhedron (
               points = [
                         [-x_incr_inner/2, -inner_r, bottom*thread_size],         // [0]
                         [x_incr_inner/2, -inner_r, bottom*thread_size + z_incr], // [1]
                         [x_incr_inner/2, -inner_r, top*thread_size + z_incr],    // [2]
                         [-x_incr_inner/2, -inner_r, top*thread_size],            // [3]

                         [-x_incr_outer/2, -outer_r, bottom*thread_size],         // [4]
                         [x_incr_outer/2, -outer_r, bottom*thread_size + z_incr], // [5]
                         [x_incr_outer/2, -outer_r, top*thread_size + z_incr],    // [6]
                         [-x_incr_outer/2, -outer_r, top*thread_size]             // [7]
                        ],

               faces = [
                         [0, 3, 7, 4],  // This-side trapezoid

                         [1, 5, 6, 2],  // Back-side trapezoid

                         [0, 1, 2, 3],  // Inner rectangle

                         [4, 7, 6, 5],  // Outer rectangle

                         // These are not planar, so do with separate triangles.
                         [7, 2, 6],     // Upper rectangle, bottom
                         [7, 3, 2],     // Upper rectangle, top

                         [0, 5, 1],     // Lower rectangle, bottom
                         [0, 4, 5]      // Lower rectangle, top
                        ]
            );
         } else {

            // Rule for face ordering: look at polyhedron from outside: points must
            // be in clockwise order.
            polyhedron (
               points = [
                         [-x_incr_inner/2, -inner_r, 0],                        // [0]
                         [x_incr_inner/2, -inner_r, z_incr],                    // [1]
                         [x_incr_inner/2, -inner_r, thread_size + z_incr],      // [2]
                         [-x_incr_inner/2, -inner_r, thread_size],              // [3]

                         [-x_incr_outer/2, -outer_r, z0_outer],                 // [4]
                         [x_incr_outer/2, -outer_r, z0_outer + z_incr],         // [5]
                         [x_incr_outer/2, -outer_r, thread_size - z0_outer + z_incr], // [6]
                         [-x_incr_outer/2, -outer_r, thread_size - z0_outer]    // [7]
                        ],

               faces = [
                         [0, 3, 7, 4],  // This-side trapezoid

                         [1, 5, 6, 2],  // Back-side trapezoid

                         [0, 1, 2, 3],  // Inner rectangle

                         [4, 7, 6, 5],  // Outer rectangle

                         // These are not planar, so do with separate triangles.
                         [7, 2, 6],     // Upper rectangle, bottom
                         [7, 3, 2],     // Upper rectangle, top

                         [0, 5, 1],     // Lower rectangle, bottom
                         [0, 4, 5]      // Lower rectangle, top
                        ]
            );
         }
      }
   }
}