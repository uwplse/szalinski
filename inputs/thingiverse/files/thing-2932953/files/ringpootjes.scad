// montageringetjes voor motortjes CX-10. Klem boven en onder PCB.
$fn=32;
NOZZLE=0.4;
THICKNESS=3; // 3 voor genoeg klemkracht in PETG met diameter 5.8
DIA = 5.8;
LEGLENGTH=7;

// Motor is 6mm diameter, maar bovenring en onderring moeten andere binnendiameter ivm klemkracht

module ring(dia=DIA, dikte=THICKNESS){
    difference(){
        cylinder(d=dia+THICKNESS,h=dikte);
        cylinder(d=dia,h=dikte);    
        translate([-0.5,0.6*THICKNESS,0]) cube([1,THICKNESS,dikte]); // draadjes / klemconstructieonderbreking
        }
    }

// boven
module bovenring(dia=DIA){
    ring(dia);
translate([-0.5,-0.5*dia-0.5,THICKNESS]) cube([1,0.5,1]);  // anti-rotatie pinnetje valt in PCB
}


   //onder, oude
     /*
    translate([0,12,0])
    difference(){
        cylinder(d=6+THICKNESS,h=LEGLENGTH+THICKNESS);
        cylinder(d=6,h=LEGLENGTH+THICKNESS);    
        translate([-0.5*THICKNESS,0.6*THICKNESS,0]) cube([THICKNESS,THICKNESS,LEGLENGTH+THICKNESS]); // draadjes / klemconstructieonderbreking
        }
        */
        
        // onder, nieuwe
module onderring(dia=DIA, dikte=THICKNESS){
    difference(){
        ring(dia, dikte);
        translate([-0.75,-0.5*dia-1,0]) #cube([1.5,1,0.6]); // anti-rotatie uitholling valt over SMD led
        }
        translate([-0.5*THICKNESS,-0.5*(dia+THICKNESS),dikte]) cube([THICKNESS, 0.5*THICKNESS, LEGLENGTH]);
    }

bovenring();
    translate([0,12,0]) onderring(dia=5.9, dikte = 4);
   