// Round Casting Form by Willie Beckmann 2016
//
heightoverall=50; // height over all mm - change to your needs, not < 20
diameter=70; // diameter mm - change to your needs
//
tolerance=0.2; // change accordingly to your printer
height=heightoverall+10;
wandstaerke=3; // normaly no need to change
wandhalb=wandstaerke/2+tolerance; // do not change

// Ring1
rotate([0,180,0]) {
translate([diameter/2+5,0,-height/2]) {
        difference() {
            difference() {
                cylinder(height/2,diameter/2+wandstaerke,diameter/2+wandstaerke,$fn=50);
                cylinder(height/2+1,diameter/2,diameter/2,$fn=50);
                         }
            difference() {   
                cylinder(10,diameter/2+wandstaerke,diameter/2+wandstaerke,$fn=50);
                cylinder(11,diameter/2+wandhalb,diameter/2+wandhalb,$fn=50);
                         }
                      }
                    }
            }


// Ring2
rotate([0,180,0]) {
translate([-diameter/2-5,0,-height/2]) {
        difference() {
            difference() {
                cylinder(height/2,diameter/2+wandstaerke,diameter/2+wandstaerke,$fn=50);
                cylinder(height/2+1,diameter/2,diameter/2,$fn=50);
                         }
            difference() {   
                cylinder(10,diameter/2+wandhalb,diameter/2+wandhalb,$fn=50);
                cylinder(11,diameter/2,diameter/2,$fn=50);
                         }
                      }
                    }
            }