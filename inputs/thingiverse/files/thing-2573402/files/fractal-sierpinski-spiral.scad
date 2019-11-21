// copyright aeropic 2017

// order of sierpinski fractal
order = 4; //[0,1,2,3,4,5,6,7]
// size of smallest pyramid
size = 2.0; //[2:50]

/* [Hidden] */
eps = 0.25;
epsy = 0.12;
epsr = 0.1;
epsh = 2.5*eps;
sq2 = 1.41421356;
epsl = 0.5;

difference() {
    ss(order-1);
    //remove bottom spikes
  #  translate([-120,-120,-3])cube([240,240,3]);
}

      
// sierpinsky recursive code 
module ss(ord){
    k = pow(2,ord);
    w = size *k;
    
    if (k<1){  // end of recursive function
        rotate([0,0,45])cylinder(r1=size,r2 = epsr, h = 1.2*size, $fn=4);
    }
    else {
      difference() {
        union () { // set the five smaller sierpinski pyramids
            // they are shifted so that there is an intersection for spiral vase
            translate([-k*eps+w/sq2,-k*eps+w/sq2,0]) ss(ord-1);  
            translate([k*eps-w/sq2,k*eps-w/sq2,0]) ss(ord-1); 
            translate([k*eps-w/sq2,-k*eps+w/sq2,0]) ss(ord-1); 
            translate([-k*eps+w/sq2,k*eps-w/sq2,0]) ss(ord-1); 
            translate([0,0,-sq2*k*eps+1.2*w]) rotate([180,0,0]) ss(ord-1);
            translate([0,0,-sq2*k*eps+1.2*w]) rotate([0,0,0]) ss(ord-1);    
          
          // petit carré au centre
            cube([0.3,0.3,2], center = true);
             } // end union
     // remove 4 small cubes to allow a sierpinski curve
         # translate([epsl,-epsy/2,0])  cube([sq2*w,epsy,epsh]);
         # rotate([0,0,90]) translate([epsl,-epsy/2,0])  cube([sq2*w,epsy,epsh]);
         # rotate([0,0,180]) translate([epsl,-epsy/2,0])  cube([sq2*w,epsy,epsh]);
         # rotate([0,0,270]) translate([epsl,-epsy/2,0])  cube([sq2*w,epsy,epsh]);
     
    } // end diff    
   } // end else
 } // end module ss