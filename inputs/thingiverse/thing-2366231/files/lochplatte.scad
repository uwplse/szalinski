// variable description
breite = 80; // [30:200]
tiefe  = 40; // [30:100]
hoehe = 2; // [2.0:4.0]
durchm1 = 4; // [2,3,4,5]
steghoehe = 5; // [0:20]
bohrung = 0; //[1:Nein,0:ja]
/* [Hidden] */
rundung=durchm1; steg = steghoehe+hoehe; $fn=50;
translate ([-tiefe/2,-breite/2,0])     {
lochplatte (breite,tiefe,hoehe);      
if (bohrung==1) {ecksteg1(breite,tiefe,hoehe,durchm1);}
else {ecksteg(breite,tiefe,steg,durchm1);}   }
module lochplatte (breite,tiefe,hoehe) {
difference() {
cube([tiefe,breite,hoehe], center=false);
   for (b =[10:5:tiefe-15]) {
    for (a =[4:4:breite-6]) {
    translate ([b,a,-1]) {cube ([4,2,hoehe+2], center=false);}
    }}}}   
module ecksteg1 (breite,tiefe,hoehe,rundung) { 
    translate ([rundung,rundung,0]){steg1 (breite,tiefe,hoehe,rundung);    }
    translate ([tiefe-rundung,rundung,0]){steg1 (breite,tiefe,hoehe,rundung);}
    translate ([tiefe-rundung,breite-rundung,0]){steg1 (breite,tiefe,hoehe,rundung);}    
    translate ([rundung,breite-rundung,0]){steg1 (breite,tiefe,hoehe,rundung);}    }
    module ecksteg (breite,tiefe,hoehe,rundung) { 
    translate ([rundung,rundung,0]){steg (breite,tiefe,hoehe,rundung);    }
    translate ([tiefe-rundung,rundung,0]){steg (breite,tiefe,hoehe,rundung);}
    translate ([tiefe-rundung,breite-rundung,0]){steg (breite,tiefe,hoehe,rundung);}    
    translate ([rundung,breite-rundung,0]){steg (breite,tiefe,hoehe,rundung);}       }
    module steg (breite,tiefe,hoehe,rundung) { union(){    
    difference(){        
        cylinder(steghoehe+1,rundung,rundung,center=false);    
    cylinder(steghoehe+2,rundung/2,rundung/2,center=false);}}}
     module steg1 (breite,tiefe,hoehe,rundung) { union(){           
        cylinder(steghoehe+1,rundung,rundung,center=false);    
    cylinder(steghoehe+4,rundung/2,rundung/2,center=false);}
}