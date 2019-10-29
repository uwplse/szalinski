$fn=50;

//COB LED holder
dHolder=36;
hHolder=3.1; // Adjust for first layer  h=0.3mm
dCOB=27.6; // Specified size =26mm but actually a bit bigger
rCOB=dCOB/2;
dRetain=dCOB-2;

rRetain=dRetain/2;
hCOB=0.8; 
adjust=2.6; // To adjust the position of the notch

dNotch=2.6;
yNotch=dHolder/2-rCOB+adjust;

dHole=3.4; //Mounting hole for M3 screw
pHole=4; //Mount hole distance from the edge

difference () {
cube([dHolder,dHolder,hHolder]);
    translate([dHolder/2,dHolder/2,0]){
        cylinder(h=hHolder,d=dRetain);
    }
    translate([dHolder/2,dHolder/2,hHolder-hCOB]){    
    cylinder(h=hCOB,d=dCOB);
    }
    translate([pHole,pHole,0]){cylinder(h=hHolder,d=dHole);}
    translate([dHolder-pHole,pHole,0]){cylinder(h=hHolder,d=dHole);}
    translate([pHole,dHolder-pHole,0]){cylinder(h=hHolder,d=dHole);}
    translate([dHolder-pHole,dHolder-pHole,0]){cylinder(h=hHolder,d=dHole);}
  }
translate([dHolder/2,dHolder/2-rCOB+adjust,0]) {
    cylinder(h=hHolder,d=dNotch);
    }
translate([dHolder/2-dNotch/2,0,0]) {    
    cube([dNotch,yNotch,hHolder]);
}