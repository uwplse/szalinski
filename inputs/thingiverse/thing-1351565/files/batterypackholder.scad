//
// Parametric Battery Pack Holder
// ------------------------------
//
// Created by Joao Alves (jpralves@gmail.com)
// ------------------------------------------
//
// Parameters:

// Hole Diameter (19 for 18650 Li-ion Battery)
holesize = 19; // [5:0.1:25]
// Support Height
alt = 4; // [2:6]
// End Support Height
supalt = 1; // [1:2]

// Number of X Batteries
varx = 2; // [1:9]
// Number of Y Batteries
vary = 3; // [1:9]

// Filler Type between Batteries
filler=2; // [0:None, 1:Circle, 2:Star]
// Level of Detail
$fn=100; // [20:Low Res, 50:Normal Res, 100:Hi Res]

bateria(varx,vary);

module bateria(x,y) {

  unitspace= holesize+holesize/10;

  rotate([0,180,0])
  for (i = [0 : 1 : x-1]) {
    for (j = [0 : 1 : y-1]) {
        translate([i*unitspace,j*unitspace,0]) {

        difference() {
          union() {
              difference() {
                cube([unitspace,unitspace,alt]);
                translate([(unitspace)/2,(unitspace)/2,-0.1])
                  cylinder(h=alt+1,d=holesize);
              }
              difference() {
                union() {
                  translate([0,0,alt]) 
                    cube([holesize/2,holesize/2,supalt]);
                  translate([unitspace-holesize/2,0,alt]) 
                    cube([holesize/2,holesize/2,supalt]);
                  translate([0,unitspace-holesize/2,alt]) 
                    cube([holesize/2,holesize/2,supalt]);
                  translate([unitspace-holesize/2,unitspace-holesize/2,alt]) 
                    cube([holesize/2,holesize/2,supalt]);
                }
                union() {
                  translate([(unitspace)/2,(unitspace)/2,-0.1])   
                    cylinder(h=alt+supalt+2,d=holesize-holesize/5);
                }
              }
          }
            
          if (filler==1) {
              union() {        
                translate([0,0,-0.1]) 
                  cylinder(h=alt+supalt+2,d=holesize/3);
                translate([unitspace,0,-0.1]) 
                  cylinder(h=alt+supalt+2,d=holesize/3);
                translate([0,unitspace,-0.1]) 
                  cylinder(h=alt+supalt+2,d=holesize/3);
                translate([unitspace,unitspace,-0.1]) 
                  cylinder(h=alt+supalt+2,d=holesize/3);
              }
          } else if (filler==2){
              union() {
                translate([-(holesize/3)/2,-(holesize/3)/2,-0.1]) 
                  peca(holesize/3,alt+supalt+2);
                translate([-(holesize/3)/2,unitspace-holesize/3/2,-0.1]) 
                  peca(holesize/3,alt+supalt+2);
                translate([unitspace-holesize/3/2,-(holesize/3)/2,-0.1]) 
                  peca(holesize/3,alt+supalt+2);
                translate([unitspace-holesize/3/2,unitspace-holesize/3/2,-0.1]) 
                  peca(holesize/3,alt+supalt+2);
                
              }
          }
        }
      }
    }
  }
}

module peca(dimensao,alt) {
    
    difference() {
      cube([dimensao,dimensao,alt]);
      translate([0,0,-0.1]) cylinder(h=alt,d=dimensao/1.2); 
      translate([dimensao,0,-0.1]) cylinder(h=alt,d=dimensao/1.2); 
      translate([0,dimensao,-0.1]) cylinder(h=alt,d=dimensao/1.2); 
      translate([dimensao,dimensao,-0.1]) cylinder(h=alt,d=dimensao/1.2); 
    }
}

