$fn = 0;

//$fs = 0.1; // HQ cylinders
//$fa = 4; // HQ spheres/hulls
render_hinges = true;

//$fs = 2; // default
//$fa = 12; // default
//render_hinges = false;

clamp_height = 30;
pole_diam = 25 +0.5;
screw_hole_diam = 4.5;
screw_recess_diam = 9;
nut_type = 4; // 4=square, 6=hex
horiz_pole_diam = 13 +0.2;

hinged_pole_clamp(
  height=clamp_height,
  hole_diam=screw_hole_diam,
  hole_recess_diam=screw_recess_diam,
  horiz_diam=horiz_pole_diam,
  nut_type=nut_type,
  pole_diam=pole_diam);


module hinged_pole_clamp(
    height,
    hole_diam,
    pole_diam,
    hole_recess_diam,
    horiz_diam,
    horiz_tab_angle=40,
    horiz_thick=3,
    nut_type=6
){
  hinge_fill_x = 23.6; //hardcoded to fit the hinge footprint
  hinge_fill_y = 20;
  hinge_fill_z = height;
  hole_r = hole_diam/2;
  pole_r = pole_diam/2;
  hole_recess_r = hole_recess_diam/2;

  hpole_r = horiz_diam/2;

  half_space = 0.5; // gap between the two halfs
  half_width = pole_diam * 1.2;
  half_depth = pole_diam * 0.6;

  flap_width = 1;
  flap_height = hole_recess_diam*1.5;

  hinge_r1 = 5;
  num_hinges = clamp_height/(hinge_r1*2) - 1;

  difference (){

    union(){


      //one half
      hull(){
        translate([
            hinge_fill_x,
            0-(half_depth-((hinge_fill_y+half_space)/2)),
            0])
            cube(size=[half_width*0.8, half_depth, hinge_fill_z]);

        translate([
            hinge_fill_x+(half_width*0.8),
            (0-(half_depth-((hinge_fill_y+half_space)/2)))+half_depth-flap_width,
            0])
            cube(size=[
              (half_width*0.2)+(hole_recess_diam*1.5),
              flap_width,
              hinge_fill_z
            ]);

      }

      difference(){
        hull(){
          translate([
            hinge_fill_x,
            0-(half_depth-((hinge_fill_y+half_space)/2)),
            0])
              cube(size=[half_width*0.8, half_depth, hinge_fill_z]);

          translate([
              hinge_fill_x,
              0-(pole_diam/2)+(horiz_thick)-(hpole_r),
              height/2])
            pole_with_tabs_neg(
              width=half_width*0.8,
              pole_r=hpole_r,
              pole_thick=horiz_thick,
              hole_diam=screw_hole_diam,
              tab=false,
              tab_angle=horiz_tab_angle);
        }

        translate([
            hinge_fill_x-(pole_diam*0.1),
            0-(pole_diam/2)+(horiz_thick)-(hpole_r),
            height/2])
          pole_with_tabs_neg(
            width=half_width*0.9,
            pole_r=hpole_r,
            pole_thick=horiz_thick,
            hole_diam=screw_hole_diam,
            tab=true,
            tab_angle=horiz_tab_angle);

      }
      //hinge fill
      translate([0, 0, 0])
          cube(size=[hinge_fill_x, hinge_fill_y+half_space, hinge_fill_z]);

      //the other half
      hull(){
        translate([
          hinge_fill_x, (0-(half_depth-((hinge_fill_y+half_space)/2)))+half_depth+half_space,
          0
        ])
          cube(size=[half_width*0.8, half_depth, hinge_fill_z]);

        translate([
          hinge_fill_x+(half_width*0.8),
          (0-(half_depth-((hinge_fill_y+half_space)/2)))+half_depth+half_space,
          0
        ])
          cube(size=[
            (half_width*0.2)+(hole_recess_diam*1.5),
            flap_width,
            hinge_fill_z
          ]);
      }

      translate([
          hinge_fill_x,
          //0-(hinge_fill_y/2)-(hinge_fill_y-half_depth)+(horiz_thick/2),
          0-(pole_diam/2)+(horiz_thick)-(hpole_r),
          height/2])
        pole_with_tabs(
          width=half_width*0.8,
          pole_r=hpole_r,
          pole_thick=horiz_thick,
          hole_diam=screw_hole_diam,
          hole_recess_diam=screw_recess_diam,
          nut_type=nut_type,
          tab_angle=horiz_tab_angle);

    }

    translate([
        hinge_fill_x+(half_width*1)+(hole_recess_diam*0.75),

        (0-(half_depth-((hinge_fill_y+half_space)/2)))+half_depth+half_space,
        height/2]){

      rotate(a=90, v=[1,0,0]){
        cylinder(h=pole_diam*1.5, r=hole_r, center=true);

        translate([0,0,0+(half_depth/2)+3])
          cylinder(h=half_depth, r=hole_recess_r, center=true, $fn=nut_type);

        translate([0,0,0-(half_depth/2)-3])
          cylinder(h=half_depth, r=hole_recess_r, center=true);
      }
    }

    //pole hole
    translate([hinge_fill_x+(half_width/2), (hinge_fill_y+half_space)/2, -(((height*1.1)-hinge_fill_z)/2)]) {
      rotate(a=90, v=[0,0,0])
        cylinder(h=(height*1.1), r=pole_r);
    }

    //hinges
    if(render_hinges)
      translate([10, (hinge_fill_y+(half_space*2))/2 ,0])
        rotate(a=(-45/2), v=[0,0,1])
          vertical_hinge_negative(theta0=45, height=(hinge_fill_z/num_hinges), n=num_hinges, r1=hinge_r1);

  }
}

/*
* tol - the smallest distance allowable between interlocking parts of your 3d printer. This gap is the vertical (and horizontal) distance between the cones inside the hinge and is also the diameter and height of the small support structure between hinge elements
* r1 - the outer radius of the hinge. the surface of your part should not be farther away from the center of the hinge than this disntace.
* r2 - the furthest radius from the hinge where material is removed from the part.
* height - the height of each hinge element. The total height of the hinge is n*height. (the cut will extent beyond this distance by height/2 on both sides. The part where you are creating the hinge should have a height of n*height) the height must be greater than 2*r1
* n - the number of hinge elements. One hinge element is divided between the top and bottom.
* theta0 - the angle at which the hinge is printed
* theta1 - the internal angle formed when the hinge is turned to its limit in one direction (the x- part of the hinge_test_1 example when rotated clockwise as viewed from above)
* theta2 - the internal angle formed when the hinge is turned to its limit in the opposite direction
*/
module vertical_hinge_negative(tol=0.5,r1=5,r2=15,height=15,n=2,theta0=180,theta1=45,theta2=45) {

    arm_width=2*r1;
    union() {
        for(i=[0:n])
            translate([0,0,(i-0.5)*height])
                difference() {

                    //cone between hinges and cuts around the hinge
                    rotate_extrude()
                        polygon([[r1,0],[r1,height],[tol/2,height-r1+tol/2],
                                [tol/2,height-r1+1.5*tol],[r1,height+tol],
                                [r2,height+tol],[r2,0]]);


                    //exclude a rectangular shape for the arm the connects the hinge to the body
                    rotate((i%2)*theta0)
                        difference() {
                            translate([0,-arm_width/2,-height])
                                cube(size=[r2*2,arm_width,height*2]);

                            translate([0,0,height-r1])
                                cylinder(r1=0,r2=height,h=height);
                        }

                    //exclude a triangular shape that limits the motion of the arms on the side of the hinge
                    for(i=[0,1])
                        mirror([0,i,0])
                            rotate(-i*theta0)
                                translate([0,0,-tol])
                                    linear_extrude(height=height+3*tol)
                                        intersection() {
                                            circle(r=2*r2);

                                            rotate(theta0+180+theta2)
                                                translate([0,r2*3+arm_width/2+tol])
                                                    square(size=[r2*6,r2*6],center=true);

                                            rotate(theta0-theta1)
                                                translate([0,r2*3+arm_width/2+tol])
                                                    square(size=[r2*6,r2*6],center=true);

                                            rotate(theta0)
                                                translate([r2*3,0])
                                                    square(size=[r2*6,r2*6],center=true);
                                        }
            }
       }
}




//*********************************************************

module pole_with_tabs_neg(width, pole_r, pole_thick, hole_diam, tab=false, tab_angle=0, gap=1){
  rotate(a=90, v=[0,1,0]){
    cylinder(h=width, r=pole_r+pole_thick);
  }

  if(tab==true){
    // screw hole in tab
    rotate(a=tab_angle, v=[1,0,0])
      translate([width/2,
                 0,
                 pole_r+(pole_thick)+hole_diam ]) {
        // tab gap
        cube([width*1.1, gap, (hole_diam*2)+(pole_thick*3)], center=true);
      }
  }
}

module pole_with_tabs(width, pole_r, pole_thick, hole_diam, hole_recess_diam, nut_type=6, tab_angle=0, gap=1){
  hole_r = hole_diam/2;
  difference(){
    union(){
      rotate(a=90, v=[0,1,0]){
        cylinder(h=width, r=(pole_r+pole_thick)*1.01);
      }

      // tab block
      hull(){
        rotate(a=90, v=[0,1,0]){
          cylinder(h=width, r=(pole_r+pole_thick)*1.01);
        }
        rotate(a=tab_angle, v=[1,0,0])
          translate([width/2, 0, ((hole_recess_diam)+(pole_thick*2)+pole_r)/2]){
            cube([
              hole_recess_diam,
              (pole_thick*2)+gap,
              (hole_recess_diam)+(pole_thick*2)+pole_r],
              center=true);
          }
        }
    }

    // pole hole
    translate([0-(width*0.5), 0, 0])
      rotate(a=90, v=[0,1,0]){
        cylinder(h=width*2.0, r=pole_r);
      }

    // screw hole in tab
    rotate(a=tab_angle, v=[1,0,0])
      translate([width/2,
                 0,
                 pole_r+(pole_thick)+(hole_recess_diam/2) ]) {

        // screw hole
        rotate(a=90, v=[1,0,0]){
          cylinder(h=pole_r*3, r=hole_r, center=true);

          //nut/screw recesses
          translate([0, 0, 0+(pole_r/2)+(pole_thick+gap)]){
            cylinder(h=pole_r, r=hole_recess_diam/2, center=true);
          }
          translate([0, 0, 0-(pole_r/2)-(pole_thick+gap)]){
            cylinder(h=pole_r, r=hole_recess_diam/2, center=true, $fn=nut_type);
          }
        }

        // tab gap
        cube([width*1.1, gap, (hole_recess_diam*2)+(pole_thick*3)], center=true);
      }
  }

}
