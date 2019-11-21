// Parameters:

// Hole Diameter (19 for 18650 Li-ion Battery)
holesize = 19; // [5:0.1:25]
// Support Height
alt = 4; // [2:6]
// End Support Height
supalt = 1; // [1:2]

// Number of X Batteries
varx = 4; // [1:9]
// Number of Y Batteries
vary = 5; // [1:9]

// Filler Type between Batteries
filler=0; // [0:None, 1:Circle, 2:Star]
// Level of Detail
$fn=50; // [20:Low Res, 50:Normal Res, 100:Hi Res]
// Connector
connector=1; // [0:No, 1:Yes]
position=1; // [0:Top, 1:Bottom]

unitspace= holesize+holesize/10;

difference () {
    sc=4;
    union () {
        bateria(varx,vary);
        if(connector) {
            for (i = [1 : 1 : vary-1]) {
                if(position==0) translate([-(varx*unitspace+0.25),i*unitspace,-(alt+supalt)]) cylinder(alt+supalt,sc*0.9,sc*0.9,$fn=3);
                if(position==1) translate([0.25,i*unitspace,-(alt+supalt)]) rotate([0,0,180]) cylinder(alt+supalt,sc*0.9,sc*0.9,$fn=3);
            }
            for (i = [1 : 1 : varx-1]) {
                translate([-i*unitspace,vary*unitspace+0.25,-(alt+supalt)]) rotate([0,0,-90]) cylinder(alt+supalt,sc*0.9,sc*0.9,$fn=3);
            }

        }
    }
    if(connector==1) {
        for (i = [1 : 1 : vary-1]) {
            if(position==0) translate([0,i*unitspace,-(alt+supalt+0.5)]) cylinder(alt+supalt+1,sc,sc,$fn=3);
            if(position==1) translate([-(varx*unitspace),i*unitspace,-(alt+supalt+0.5)]) rotate([0,0,180]) cylinder(alt+supalt+1,sc,sc,$fn=3);
        }
        for (i = [1 : 1 : varx-1]) {
            translate([-i*unitspace,0,-(alt+supalt+0.5)]) rotate([0,0,-90]) cylinder(alt+supalt+1,sc,sc,$fn=3);
        }
    }
}
    

module bateria(x,y) {
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

