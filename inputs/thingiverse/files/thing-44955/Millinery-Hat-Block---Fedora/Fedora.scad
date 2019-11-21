$fn = 60;

//Measure the circumference of your head in inches
head_size = 18; // [15:25]

scale([head_size/22,head_size/22,head_size/22]){ // scale block set for hat size
  scale([25.4,25.4,25.4]){ // scale mm to inches
    difference(){ // crown
      translate([-0.875,0,0]) difference(){ 
        union(){	
          intersection(){	
            difference(){
              hull(){ // crown block solid
                linear_extrude(height=4) hull(){ // top of crown shape
                  circle(2.75);
                  translate([2.5,0,0]) circle(1.5);	
                }
                translate([1-0.125,0,0]) scale([7.5/6.5,1,1]) sphere(3.25); // base of crown, head shape
              }
              rotate([0,7,0]) translate([-0.6,0,5]) hull(){ // depression on top of crown
                sphere(2.75);
                translate([2.5,0,0]) sphere(1.5);	
              }
            }
            translate([-5,-5,0]) cube(10); // cut off negative z values
          }
          intersection(){ // head curve in the crown
            linear_extrude(height=6) hull(){
              circle(2.75);
              translate([2.5,0,0]) circle(1.5);	
            }
            translate([0,0,-2]) rotate([0,-7,0]) scale([1.25,1,1]) sphere(6);
          }
        }
        translate([4.75,4.5,3.25]) scale([1,1,0.9]) sphere(3.5); // side depressions on front of crown
        translate([4.75,-4.5,3.25]) scale([1,1,0.9]) sphere(3.5);
      }
      translate([1.5,0,-0.5]) cylinder(r=0.25,h=1.5); // dowel holes
      translate([-1.5,0,-0.5]) cylinder(r=0.25,h=1.5);
      translate([0,-2,-0.5]) cylinder(r=0.5,h=3.5); // hand holds
      translate([0,0,-0.5]) cylinder(r=0.75,h=3.5);
      translate([0,2,-0.5]) cylinder(r=0.5,h=3.5);
    } // end crown

    translate([-10,0,2.125]) union(){ // brim
      difference(){
        difference(){
          translate([0,0,-1]) scale([11/9.25,1,0.30]) sphere(4.625); // curve of the brim
          translate([-6,-4.625,-11]) cube([12,9.25,10]); // cut off top and bottom
          translate([-6,-4.625,0]) cube([12,9.25,10]);
		}
        translate([1.5,0,-1]) cylinder(r=0.25,h=1.5); // dowel holes
        translate([-1.5,0,-1]) cylinder(r=0.25,h=1.5);
      }
      difference(){
        union(){
          scale([11/9.25,1,1]) translate([0,0,-1.125]) cylinder(r=4.625-0.125,h=0.125); // rope line
          scale([11/9.25,1,1]) translate([0,0,-2.125]) cylinder(r=4.625,h=1); // base
        }
        scale([11/9.25*0.75,0.75,1]) translate([0,0,-2.25]) cylinder(r=4.625,h=0.75); // hollow bottom
      }
    } // end brim

    translate([9,0,5]) rotate([0,180,180]) union(){ // top piece
      intersection(){
        difference(){
          rotate([0,7,0]) translate([-0.6,0,5]) hull(){ // opposite of depression on top of crown
            sphere(2.75);
            translate([2.5,0,0]) sphere(1.5);	
          }
          translate([0,0,-2]) rotate([0,-7,0]) scale([1.25,1,1]) sphere(6); // opposite of head shape
        }
        linear_extrude(height=5) hull(){ // crown shape, limits size of top piece
          circle(2.75);
          translate([2.5,0,0]) circle(1.5);	
        }
      }
      difference(){
        translate([-4.5,-1,4.5]) cube([10,2,0.5]); // hand hold bar
        translate ([-1,0,0])scale([4,1,1]) rotate([0,0,45]) translate([1,-2,0]) cube([1,1,6]); // rope cut outs
        translate ([-15,0,0])scale([4,1,1]) rotate([0,0,45]) translate([1,-2,0]) cube([1,1,6]);
      }
    } // end top piece

  }
}


