// Drew Browning 2018
// originally based on https://www.thingiverse.com/thing:56910/attribution_card

// part to build
_part = "base"; // [base,base-for-strap,retainer,button-cc,button-cv]
// outside diameter in mm (55 - 65)
// preview[view:south, tilt:top]
_outsideDiameter = 65;// [55:65]

/*[Hidden]*/
_outsideHeight = 22;
_partGap = 0.2;
_switchHeight = 15.2;
_interiorHeight = _switchHeight+1;
_topBottomThickness = 2;
_lipHeight = 3;
_resolution = 100; // [30:Low, 60:Medium, 120:High]

////////////////////////////////////////////////////////////////////////
make();

module make($fn=_resolution) {
    outsideDiameter = _outsideDiameter;
	baseHeight = _interiorHeight - _topBottomThickness - _lipHeight;
	retainerHeight = _outsideHeight-baseHeight-_lipHeight+3;

    // call respective modules
	if (_part == "base") {
		makeBase( outsideDiameter, baseHeight,_topBottomThickness,_lipHeight,_partGap);
	} else if (_part == "base-for-strap") {
		makeBaseForStrap( outsideDiameter, baseHeight,_topBottomThickness,_lipHeight,_partGap);
	} else if (_part == "retainer") {
		makeRetainer(outsideDiameter,retainerHeight,_topBottomThickness,_lipHeight,_partGap);
	} else if (_part == "button-cc") {
        makeButton_cc(outsideDiameter,retainerHeight,_topBottomThickness,_lipHeight, _partGap);
	} else if (_part == "button-cv") {
        makeButton_cv(outsideDiameter,retainerHeight,_topBottomThickness,_lipHeight, _partGap);
	} else if (_part == "allx") {//cross-section - oriented - together      --------------------------------------------------
        difference(){
            union(){
                color("Purple"){
                    makeBase(outsideDiameter,baseHeight,_topBottomThickness,_lipHeight,_partGap);}
                *color("Purple"){
                    makeBaseForStrap(outsideDiameter,baseHeight,_topBottomThickness,_lipHeight,_partGap);}
                color("Green"){rotate([0,180,61]){translate([0,0,(-retainerHeight-11.3)]){
                    makeRetainer( outsideDiameter, retainerHeight,_topBottomThickness,_lipHeight,_partGap);
                    }}}
                *color("Blue"){
                    rotate([0,0,90]){translate([0,0,18.325]){
                    makeButton_cc(outsideDiameter,retainerHeight,_topBottomThickness,_lipHeight, _partGap);
                    }}}
                color("Blue"){rotate([0,0,90]){translate([0,0,18.325]){
                    makeButton_cv(outsideDiameter,retainerHeight,_topBottomThickness,_lipHeight, _partGap);
                    }}}
            }
            translate([0,-outsideDiameter/2-1,_outsideHeight/2]){
                cube([outsideDiameter+2,outsideDiameter+2,_outsideHeight+22],true);}//XZ cross-section cube
            *translate([-outsideDiameter/2-1,0,_outsideHeight/2]){
                cube([outsideDiameter+2,outsideDiameter+2,_outsideHeight+22],true);}//YZ cross-section cube
            *translate([0,0,_outsideHeight+9.4]){
                cube([outsideDiameter+2,outsideDiameter+2,_outsideHeight+1.5],true);}//XY cross-section cube
        }
    }
}
module makeBase(diameter,height, base,lipHeight,partGap) {
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius - 5.6 - partGap;
	innerRadiusB = radius - 5.6;
	fullHeight = height + lipHeight;
	rounding = 2.0;
	eps = 0.1;
    standoff = height+3;//standoff height
    buttonstop = height+3.25;
    translate([0,0,0]){union(){
        difference(){
            union(){
                // body
                roundCylinder(radius, 11.1, rounding);
                // lower clamp stop
                translate([0,0,11.1+lipHeight]){cylinder(r=innerRadius+3-partGap,h=height/3+.4);}
                //threads
                translate([0,0,11.1]){
                    metric_thread (diameter=(diameter-2.5-partGap), pitch=2, length=lipHeight);}
            }
            color("Purple"){union() {
                // inner cutout
                translate([0,0,base]){cylinder(r=innerRadius, h=fullHeight*2);}//innermost cutout
                //cable cutout
                translate([1.5,0,height-1.5]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-1.5]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
                //translate([0,-radius-1,0]){cube(diameter+2,true);}//cross-section cube
            }}
        }
        // lower button stop
        rotate([0,0,0]){translate([-.5,innerRadius-3.75,2]){cube([1,2.9,buttonstop],false);}}
        rotate([0,0,120]){translate([-.5,innerRadius-3.75,2]){cube([1,2.9,buttonstop],false);}}
        rotate([0,0,240]){translate([-.5,innerRadius-3.75,2]){cube([1,2.9,buttonstop],false);}}
        difference(){
            // button stop
            difference(){
                translate([0,0,2]){cylinder(r=innerRadius-3.6, h=buttonstop);}//OD of cutter (23.1x15))
                translate([0,0,1]){cylinder(r=innerRadius-4.6, h=height+8);}//ID of cutter
            }
            union() {
                //cable cutout
                translate([1.5,0,height-1.5]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-1.5]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
            }
        }
        // PCB standoff/posts
        color("Pink"){translate([3.1,0,-2]){union(){
            translate([0,4.3,13/2+3.4]){cube([20.5,2,13],true);}//standoff box back
            translate([-9.5,-4.3,13/2+3.4]){cube([1.5,2,13],true);}//standoff box front left
            translate([9.5,-4.3,13/2+3.4]){cube([1.5,2,13],true);}//standoff box front right
            translate([11.25,0,13/2+3.4]){cube([2,10.6,13],true);}//standoff box right
            translate([-11.25,0,13/2+3.4]){cube([2,10.6,13],true);}//standoff box left
            translate([-3.7,2,13/2-.5]){cube([1,3,13-8],true);}//standoff left
            translate([4.4,2,13/2-.5]){cube([1,3,13-8],true);}//standoff right
            translate([-4.8,4.1,13-1.15]){sphere(r=1);}//bumps
            translate([4.75,4.1,13-1.15]){sphere(r=1);}//bumps
        }}}
    }}
}
module makeBaseForStrap(diameter,height,base,lipHeight,partGap){
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius - 5.6 - partGap;
	fullHeight = height + lipHeight;
	rounding = 2.0;
	eps = 0.1;
    standoff = height+3;//standoff height
    buttonstop = height+3.25;
    union(){
        difference(){
            union(){
                // body
                roundCylinder(radius, 11.1, rounding);
                // lower clamp stop
                translate([0,0,11.1+lipHeight]){cylinder(r=innerRadius+3-partGap,h=height/3+.4);}
                //threads
                translate([0,0,11.1]){
                    metric_thread (diameter=(diameter-2.5-partGap), pitch=2, length=lipHeight);}
            }
            color("Purple"){union() {
                // inner cutout
                translate([0,0,base+.5]){cylinder(r=innerRadius, h=fullHeight*2);}//innermost cutout
                //cable cutout
                translate([1.5,0,height-1.5]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-1.5]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
                //translate([0,-radius-1,0]){cube(diameter+2,true);}//cross-section cube
            }}
        }
        // lower button stop
        rotate([0,0,0]){translate([-.5,innerRadius-3.75,2]){cube([1,2.9,buttonstop],false);}}
        rotate([0,0,120]){translate([-.5,innerRadius-3.75,2]){cube([1,2.9,buttonstop],false);}}
        rotate([0,0,240]){translate([-.5,innerRadius-3.75,2]){cube([1,2.9,buttonstop],false);}}
        difference(){
            // button stop
            difference(){
                translate([0,0,2]){cylinder(r=innerRadius-3.6, h=buttonstop);}//OD of cutter (23.1x15))
                translate([0,0,1]){cylinder(r=innerRadius-4.6, h=height+8);}//ID of cutter
            }
            union() {
                //cable cutout
                translate([1.5,0,height-1.5]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-1.5]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
            }
        }
        // PCB standoff/posts
        color("Pink"){translate([3.1,0,-2]){union(){
            translate([0,4.3,13/2+3.4]){cube([20.5,2,13],true);}//13bx back
            translate([-9.5,-4.3,13/2+3.4]){cube([1.5,2,13],true);}//13 box front left
            translate([9.5,-4.3,13/2+3.4]){cube([1.5,2,13],true);}//standoff box front right
            translate([11.25,0,13/2+3.4]){cube([2,10.6,13],true);}//standoff box right
            translate([-11.25,0,13/2+3.4]){cube([2,10.6,13],true);}//standoff box right
            translate([-4,0,13/2-.5]){cube([3,7,13-8],true);}//standoff
            translate([4.5,0,13/2-.5]){cube([3,7,13-8],true);}//standoff
            translate([-4.8,4,13-1.15]){sphere(r=1);}//bumps
            translate([4.75,4,13-1.15]){sphere(r=1);}//bumps
        }}}
        // strap/mounting plate
        rotate([0,0,90]){
            difference(){
                //cylinder(r=innerRadius+10,h=2);//circular base plate
                translate([-(diameter+12)/2,-18,0]){
                    rounded_cube([diameter+12,36,2.5],1);}//rect. base plate (rounded)
                    //rounded_cubeNilsR(diameter+12,36,3,60,1);}
                union(){//1" strap slots
                    translate([(radius+2)*-1,0,1]){//front slot
                        translate([0,-13,0]){cylinder(r=1.5,h=6,center=true);}//right end
                        translate([0,13,0]){cylinder(r=1.5,h=6,center=true);}//left end
                        translate([0,0,0]){cube([3,26,6],true);}//slot
                        //top bevels
                        translate([0,0,2.5]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                        translate([0,-13,1.17]){cylinder(r=1,r2=2,h=1,center=true);}//right end bevel
                        translate([0,13,1.17]){cylinder(r=1,r2=2,h=1,center=true);}//left end bevel
                        //bottom bevels
                        translate([0,0,-2]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                        translate([0,-13,-.67]){cylinder(r=2,r2=1,h=1,center=true);}//right end bevel
                        translate([0,13,-.67]){cylinder(r=2,r2=1,h=1,center=true);}//left end bevel
                    }
                    translate([(radius+2),0,1]){//back slot
                        translate([0,-13,0]){cylinder(r=1.5,h=6,center=true);}//right end
                        translate([0,13,0]){cylinder(r=1.5,h=6,center=true);}//left end
                        translate([0,0,0]){cube([3,26,6],true);}//slot
                        //top bevels
                        translate([0,0,2.5]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                        translate([0,-13,1.17]){cylinder(r=1,r2=2,h=1,center=true);}//right end bevel
                        translate([0,13,1.17]){cylinder(r=1,r2=2,h=1,center=true);}//left end bevel
                        //bottom bevels
                        translate([0,0,-2]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                        translate([0,-13,-.67]){cylinder(r=2,r2=1,h=1,center=true);}//right end bevel
                        translate([0,13,-.67]){cylinder(r=2,r2=1,h=1,center=true);}//left end bevel
                    }
                }
            }
        }
    }
}
module makeRetainer(diameter,height,base,lipHeight,partGap) {
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius - 2.5;
	innerRadiusB = radius - 2.5 - partGap;
	rounding = 2.0;
	eps = 0.1;
    difference(){
        // body
        roundCylinder(radius,height,rounding);
        // inner cutout
        translate([0,0,height-lipHeight-5.1]){cylinder(r=innerRadius,h=height+1,center=false);}//upper rimstop
        *translate([0,0,base+.5]) {cylinder(r=innerRadius-7, h=height+1, center = false);}//upper rim stop
        // button hole through top
        translate([0,0,base-2]) {cylinder(r=innerRadius-9.5, h=height*2, center = true);}
        // threads
        translate([0,0,height-lipHeight]){rotate([0,0,-120]){
            metric_thread (internal=true,diameter=diameter-2.5+partGap+.4,pitch=2,length=lipHeight+.1);}}
    }
}
module makeButton_cv(diameter, height, base, lipHeight, partGap){
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius-3.1-partGap;
	rounding = 1.5;
    translate([0,0,6]){rotate([0,180,0]){
        for (i = [0:45:337.5]){
            rotate([0, 0, i])
            makeArcDB(_outsideDiameter-2.75);
        }
        difference(){
            union(){
                // convex button
                translate([0,0,-height+9]){roundCylinder(innerRadius-9.3,height-3.5,rounding);}
                // rim for clamping
                translate([0,0,5]){cylinder(r=innerRadius+.55, h=1.1);}//rim
            }
            //rim-slot-cutter
            difference(){
                translate([0,0,4]){cylinder(r=innerRadius-2.5, h=3);}//OD of cutter
                translate([0,0,4]){cylinder(r=innerRadius-6.1, h=5);}//ID of cutter
            }
        }
    }}
}
module makeButton_cc(diameter, height, base, lipHeight, partGap){
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius-3.1-partGap;
	rounding = 1.5;
    translate([0,0,6]){rotate([0,180,0]){
        for (i = [0:45:337.5]){
            rotate([0, 0, i])
            makeArcDB(_outsideDiameter-2.75);
        }
        difference(){
            union(){
                // concave recessed button
                difference(){
                    // body (roundCylinder has artifacts if height is greater than 3 (height-7.8))
                    translate([0,0,-height+13.03]){cylinder(r=innerRadius-9.3,h=height-7.8);}
                    // concavity
                    translate([0,0,-diameter/(cos(diameter)*2)+4.75]){sphere(r=diameter/(cos(diameter)*2));}
                }
                // rim for clamping
                translate([0,0,5]){cylinder(r=innerRadius+.55, h=1.1);}//rim
            }
            //rim-slot-cutter
            difference(){
                translate([0,0,4]){cylinder(r=innerRadius-2.5, h=3);}//OD of cutter
                translate([0,0,4]){cylinder(r=innerRadius-6.1, h=5);}//ID of cutter
            }
        }
    }}
}
////////////// Utility Functions ///////////////////

module makeArcDB(diameter){
	radius = diameter/2;
    translate([4.1,0,3.2]){
            difference(){
                translate([0,0,2.5]){cylinder(r=radius-4, h=.4);}//OD of cutter
                translate([0,0,0]){cylinder(r=radius-4.6, h=5);}//ID of cutter
                translate([0,-radius,0]){cube([diameter,diameter,10]);}//rectangular cutter
                translate([-radius,-diameter,0]){cube([diameter,diameter,10]);}//rectangular cutter
            }
    }
}
module torus(r1, r2) {
	rotate_extrude(convexity = 4)
	translate([r1, 0, 0])
	circle(r = r2);
}

module roundCylinder(radius, height, rounding) {
	if (rounding == 0) {
		cylinder(r=radius, h=height);
	} else {
		hull() {
			translate([0,0,height-rounding]) {
				cylinder(r=radius, h=rounding);
			}
			translate([0,0,rounding]) {
				torus(radius-rounding, rounding);
			}
		}
	}
}
module rounded_cube(d,r) {
    hull() for(p=[[r,r,r], [r,r,d[2]-r], [r,d[1]-r,r], [r,d[1]-r,d[2]-r],
                  [d[0]-r,r,r], [d[0]-r,r,d[2]-r], [d[0]-r,d[1]-r,r], [d[0]-r,d[1]-r,d[2]-r]])
        translate(p) sphere(r);
}
// ----------------------------------------------------------------------------
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
// ----------------------------------------------------------------------------
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
// ----------------------------------------------------------------------------
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

