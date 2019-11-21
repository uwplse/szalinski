// based on https://www.thingiverse.com/thing:56910/attribution_card

// part to build
_part = "all";// [base,base-for-strap,retainer,button_convex,button_concave]
// outside diameter in mm (35 - 65)
_outsideDiameter = 35;// [35:65]

/*[Hidden]*/
_outsideHeight = 15;
_partGap = 0.2;
_interiorHeight = _outsideHeight/2;
_topBottomThickness = 2;
_lipHeight = 3;
_resolution = 100; // [30:Low, 60:Medium, 120:High]

////////////////////////////////////////////////////////////////////////
make();

module make($fn=_resolution) {
    outsideDiameter = _outsideDiameter;
	baseHeight = _interiorHeight + _topBottomThickness - _lipHeight+.5;
	retainerHeight = _interiorHeight + _topBottomThickness - _lipHeight;

    // call respective modules
	if (_part == "base") {
        //cable
        *translate([0,-outsideDiameter*.18,baseHeight-2.3]){rotate([90,0,0]){
            color("black") cylinder(_outsideDiameter*.35,1.5,1.5,false);}}
        // Lily_Tact
        *translate([0,0,_interiorHeight-.7-_partGap]){rotate([90,0,90]){
            import("../../TactSwitches/SparkFun_LilyPad-Button.8mmPCB.stl");}}
        
		makeBase( outsideDiameter, baseHeight,_topBottomThickness,_lipHeight, _partGap);
	} else if (_part == "base-for-strap") {
		makeBaseForStrap( outsideDiameter, baseHeight,_topBottomThickness,_lipHeight, _partGap);
	} else if (_part == "retainer") {
		makeRetainer( outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
	} else if (_part == "button_convex") {
		makeButton_cv(	outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
	} else if (_part == "button_concave") {
		makeButton_cc(	outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
	} else if (_part == "all") {//all three parts oriented - together       --------------------------------------------------
        // US quarter coin for reference
        *color("Silver"){translate([35,-15,0]){rotate([90,0,90]){
            import("Quarter.stl");}}}
        //make parts
        *makeBase( outsideDiameter, baseHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        makeBaseForStrap( outsideDiameter, baseHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        rotate([0,180,0]){translate([0,0,(retainerHeight*-2+.4)]){
            makeRetainer( outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
            }
        }
        rotate([0,0,0]){translate([0,0,(retainerHeight*-2)+22]){
            makeButton_cv(	outsideDiameter, retainerHeight,
                        _topBottomThickness, 
                        _lipHeight, _partGap);
            }
        }
        *rotate([0,0,0]){translate([0,0,(retainerHeight*-2)+22]){
            makeButton_cc(	outsideDiameter, retainerHeight,
                        _topBottomThickness, 
                        _lipHeight, _partGap);
            }
        }
	} else if (_part == "all1") {//all three parts oriented - offset --------------------------------------------------
        makeBase( outsideDiameter, baseHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
		rotate([180,0,0]){translate([0,0,-40]) {
            makeRetainer( outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        }}
		rotate([0,0,90]){translate([0,0,19]) {
            makeButton_cv(	outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        }}
		rotate([0,0,90]){translate([0,0,19]) {
            makeButton_cc(	outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        }}
	} else if (_part == "all2") {//all three parts as built in a stack --------------------------------------------------
        makeBase( outsideDiameter, baseHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
		translate([0,0,32]) {
            makeRetainer( outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        }
		translate([0,0,20]) {
            makeButton_cv(	outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        }
		translate([0,0,20]) {
            makeButton_cc(	outsideDiameter, retainerHeight,
					_topBottomThickness, 
					_lipHeight, _partGap);
        }
	} else if (_part == "allx") {//cross-section - oriented - together      --------------------------------------------------
        //make parts
        difference(){
            union(){
                color("red"){
                    makeBase(outsideDiameter,baseHeight,_topBottomThickness,_lipHeight,_partGap);}
                *color("red"){
                    makeBaseForStrap(outsideDiameter,baseHeight,_topBottomThickness,_lipHeight,_partGap);}
                color("Green"){rotate([0,180,61]){translate([0,0,(retainerHeight*-2.01+.5)]){
                    makeRetainer( outsideDiameter, retainerHeight,_topBottomThickness,_lipHeight, _partGap);
                    }}}
                *color("Blue"){rotate([0,0,90]){translate([0,0,baseHeight+2.1]){//_outsideHeight-9.4
                    makeButton_cv(	outsideDiameter, retainerHeight,_topBottomThickness,_lipHeight, _partGap);
                    }}}
                color("Blue"){rotate([0,0,90]){translate([0,0,baseHeight+2.1]){//_outsideHeight-9.4
                    makeButton_cc(	outsideDiameter, retainerHeight,_topBottomThickness,_lipHeight, _partGap);
                    }}}
                *color("Pink"){rotate([0,0,90]){translate([0,0,baseHeight+2.05]){//_outsideHeight-9.4
                    makeButtonANI(	outsideDiameter, retainerHeight,_topBottomThickness,_lipHeight, _partGap);
                    }}}
            }
            translate([0,-outsideDiameter/2-1,_outsideHeight/2]){
                cube([outsideDiameter+2,outsideDiameter+2,_outsideHeight+2],true);}//XZ cross-section cube
            *translate([-outsideDiameter/2-1,0,_outsideHeight/2]){
                cube([outsideDiameter+2,outsideDiameter+10,_outsideHeight+5],true);}//YZ cross-section cube
            *translate([0,0,_outsideHeight+1.2]){
                cube([outsideDiameter+2,outsideDiameter+2,_outsideHeight+1.5],true);}//XY cross-section cube
        }
        //cable
        *translate([0,-outsideDiameter*.18,baseHeight-2.3]){rotate([90,0,0]){
            color("black") cylinder(_outsideDiameter*.35,1.5,1.5,false);}}
        // Lily_Tact
        translate([0,0,_interiorHeight-.7-_partGap]){rotate([90,0,90]){
            import("../../TactSwitches/SparkFun_LilyPad-Button.8mmPCB.stl");}}
        //test thread gap
        *translate([-outsideDiameter/2+1.73,outsideDiameter/2,baseHeight]){rotate([90,0,0]){
            color("black") cylinder(r=.1,h=outsideDiameter/2);}}
        //test
        *translate([0,0,14]){rotate([0,0,0]){
            color("black") cylinder(r=6.5,h=10);}}
    }
}
module makeBase(diameter, height, base, lipHeight, partGap) {
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius - 5.6 - partGap;
	fullHeight = height + lipHeight;
	rounding = 2.0;
    standoff = height-.2;//standoff height
    translate([0,0,0]){union(){
        difference(){
            union(){
                // body
                roundCylinder(radius, height-1, rounding);
                // Threads
                translate([0,0,height-1]){metric_thread(diameter=diameter-2.5-partGap,pitch=2,length=3);}
            }
            // inner cutout
            translate([0,0,base]){cylinder(r=innerRadius+.3, h=fullHeight);}//innermost cutout
            union() {
                //cable cutout
                translate([1.5,0,height-2.3]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-2.3]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
            }
        }
        difference(){
            // button stop
            difference(){
                translate([0,0,2]){cylinder(r=innerRadius-2.2, h=6.4);}//OD of cutter
                translate([0,0,2]){cylinder(r=innerRadius-3.2, h=8);}//ID of cutter
            }
            union() {
                //cable cutout
                translate([1.5,0,height-2.3]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-2.3]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
            }
        }
        // PCB standoff/posts
        translate([0,0,-2-partGap]){union(){
            translate([0,0,standoff/2+2.75]){cube([8.4,8,standoff-1.5],true);}//standoff box
            translate([-4.2,0,3.5]){cylinder(standoff-1.5,r=4,true);}//standoff-end0
            translate([4.2,0,3.5]){cylinder(standoff-1.5,r=4,true);}//standoff-end1
            translate([-4.2,0,standoff+2]){cylinder(1.5,r=1.25,true);}//post0
            translate([4.2,0,standoff+2]){cylinder(1.5,r=1.25,true);}//post1
        }}
    }}
}
module makeBaseForStrap(diameter, height, base, lipHeight, partGap){
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius - 5.6 - partGap;
	fullHeight = height + lipHeight;
	rounding = 2.0;
    standoff = height - .2;//standoff height
    translate([0,0,0]){union(){
        difference(){
            union(){
                // body
                roundCylinder(radius, height-1, rounding);
                // Threads
                translate([0,0,height-1]){metric_thread(diameter=diameter-2.5-partGap,pitch=2,length=3);}
            }
            // inner cutout
            translate([0,0,base]){cylinder(r=innerRadius+.3, h=fullHeight);}//innermost cutout
            union() {
                //cable cutout
                translate([1.5,0,height-2.3]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-2.3]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
            }
        }
        difference(){
            // button stop
            difference(){
                translate([0,0,2]){cylinder(r=innerRadius-2.2, h=6.4);}//OD of cutter
                translate([0,0,2]){cylinder(r=innerRadius-3.2, h=8);}//ID of cutter
            }
            union() {
                //cable cutout
                translate([1.5,0,height-2.3]){rotate([0,0,180]){cube([3,diameter*.55,12],false);}}
                translate([0,0,height-2.3]){rotate([90,0,0]){cylinder(d=3,h=diameter*.55,center=false);}}
            }
        }
        // PCB standoff/posts
        translate([0,0,-2-partGap]){union(){
            translate([0,0,standoff/2+2.75]){cube([8.4,8,standoff-1.5],true);}//standoff box
            translate([-4.2,0,3.5]){cylinder(standoff-1.5,r=4,true);}//standoff-end0
            translate([4.2,0,3.5]){cylinder(standoff-1.5,r=4,true);}//standoff-end1
            translate([-4.2,0,standoff+2]){cylinder(1.5,r=1.25,true);}//post0
            translate([4.2,0,standoff+2]){cylinder(1.5,r=1.25,true);}//post1
        }}
    }}
    // strap/mounting plate
    rotate([0,0,90]){
        difference(){
            //cylinder(r=innerRadius+10,h=2);//circular base plate
            translate([-(diameter+12)/2,-18,-1]){
                rounded_cubeNilsR(diameter+12,36,3,60,1);}//rect. base plate (rounded)
            union(){//1" strap slots
                translate([(radius+2)*-1,0,1]){//front slot
                    translate([0,0,0]){cube([3,26,6],true);}//slot
                    translate([0,-13,0]){cylinder(r=1.5,h=6,center=true);}//right end
                    translate([0,13,0]){cylinder(r=1.5,h=6,center=true);}//left end
                    //top bevels
                    translate([0,0,2]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                    translate([0,-13,.67]){cylinder(r=1,r2=2,h=1,center=true);}//right end bevel
                    translate([0,13,.67]){cylinder(r=1,r2=2,h=1,center=true);}//left end bevel
                    //bottom bevels
                    translate([0,0,-3]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                    translate([0,-13,-1.67]){cylinder(r=2,r2=1,h=1,center=true);}//right end bevel
                    translate([0,13,-1.67]){cylinder(r=2,r2=1,h=1,center=true);}//left end bevel
                }
                translate([(radius+2),0,1]){//back slot
                    translate([0,0,0]){cube([3,26,6],true);}//slot
                    translate([0,-13,0]){cylinder(r=1.5,h=6,center=true);}//right end
                    translate([0,13,0]){cylinder(r=1.5,h=6,center=true);}//left end
                    //top bevels
                    translate([0,0,2]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                    translate([0,-13,.67]){cylinder(r=1,r2=2,h=1,center=true);}//right end bevel
                    translate([0,13,.67]){cylinder(r=1,r2=2,h=1,center=true);}//left end bevel
                    //bottom bevels
                    translate([0,0,-3]){rotate([0,45,0]){cube([4,26,4],true);}}//slot bevel
                    translate([0,-13,-1.67]){cylinder(r=2,r2=1,h=1,center=true);}//right end bevel
                    translate([0,13,-1.67]){cylinder(r=2,r2=1,h=1,center=true);}//left end bevel
                }
            }
        }
    }
}
module makeRetainer(diameter, height, base, lipHeight, partGap) {
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius - 3.1;
	rounding = 2.0;
    echo(innerRadius-6);
    difference(){
        // body
        roundCylinder(radius,height,rounding);
        // inner cutout
        translate([0,0,height-lipHeight-1]){cylinder(r=innerRadius+.5,h=height+1,center=false);}//upper rimstop
        translate([0,0,base+.5]) {cylinder(r=innerRadius-7, h=height+1, center = false);}//upper rim stop
        // button hole through top
        translate([0,0,base-2]) {cylinder(r=innerRadius-6, h=height*2, center = true);}
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
            makeArcDB(_outsideDiameter);
        }
        difference(){
            union(){
                // convex button
                translate([0,0,-height+6.5]){roundCylinder(innerRadius-6.25,height-1,rounding);}
                // concave recessed button
                // rim for clamping
                translate([0,0,5]){cylinder(r=innerRadius+.35, h=1);}//rim
            }
            //rim-slot-cutter
            difference(){
                translate([0,0,4]){cylinder(r=innerRadius-2.2, h=3);}//OD of cutter
                translate([0,0,4]){cylinder(r=innerRadius-5, h=5);}//ID of cutter
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
            makeArcDB(_outsideDiameter);
        }
        difference(){
            union(){
                // concave recessed button
                difference(){
                    // body (roundCylinder has artifacts if height is greater than 3 (height-7.8))
                    translate([0,0,-height+9]){cylinder(r=innerRadius-6.25,h=height-3.5);}
                    // concavity
                    translate([0,0,-diameter/(cos(diameter)*2)+4]){sphere(r=diameter/(cos(diameter)*2));}//
                }
                // rim for clamping
                translate([0,0,5]){cylinder(r=innerRadius+.35, h=1);}//rim
            }
            //rim-slot-cutter
            difference(){
                translate([0,0,4]){cylinder(r=innerRadius-2.2, h=3);}//OD of cutter
                translate([0,0,4]){cylinder(r=innerRadius-5, h=5);}//ID of cutter
            }
        }
    }}
}
////////////// Utility Functions ///////////////////

module rounded_cubeNilsR(size_x,size_y,size_z,facets,rounding_radius){
	hull()
	{
		translate([rounding_radius,rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,rounding_radius]) sphere (r=rounding_radius,$fn=facets);

		translate([rounding_radius,rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([rounding_radius,size_y-rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
		translate([size_x-rounding_radius,size_y-rounding_radius,size_z-rounding_radius]) sphere (r=rounding_radius,$fn=facets);
	}
}
module makeArcDB(diameter){
	radius = diameter/2;
    translate([3.7,0,3]){
            difference(){
                translate([0,0,2.5]){cylinder(r=radius-4.6, h=.4);}//OD of cutter
                translate([0,0,0]){cylinder(r=radius-5, h=5);}//ID of cutter
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

