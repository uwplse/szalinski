$fn=100;
innendm=24;
hoehe=60;
randbreite=3;
schnitte=hoehe/2;

dm = 50;
steg = 8;
wellen = 8;
anzahl = 4;
teig = 8;


module segment(zdm,sbr,sho,pz,pw,pd) // Zylinderdm, Stegbreite, Steghöhe, PositionZ, Winkel, Drehung
{
    rotate([0,0,pw]) translate([zdm/2-sho-.3,0,pz]) rotate([90,0,0]) linear_extrude(height = 0.01) polygon( points=[[0,-sbr/2],[sho+.3,-.4],[sho+.3,.4],[0,sbr/2]] );
}

module grissini() {
    
difference() {
union() {
cylinder(d=dm-2*teig,h=hoehe);

}
    translate([0,0,-randbreite]) cylinder(d=innendm,h=hoehe+2*randbreite);    
}
abstand = (hoehe-steg-2)/anzahl;

for(j=[0:anzahl])
 rotate([0,0,j*360/(wellen-1)/2])   
  for(i=[0:359]) hull() { segment(dm,steg,teig,steg/2+j*abstand+sin(i*(wellen-1))+1,i,90); segment(dm,steg,teig,steg/2+j*abstand+sin((i+1)*(wellen-1))+1,i+1,90); }

for(k=[0:anzahl-1])
for(j=[0:wellen-1])
    translate([0,0,steg/2+k*abstand+1]) 
     rotate([0,0,(k % 2 ? -1 : 1) *360/wellen/4+j*360/(wellen-1)])
      linear_extrude(height = abstand, center = false, convexity = 10, twist = (k % 2 ? 1 : -1) * (360/wellen/2), slices = schnitte, scale = 1.0)
      translate([dm/2-teig-.3,0,0]) polygon( points=[[0,-steg/3],[teig/2+.3,-steg/5],[teig/2+.5+.3,0],[teig/2+.3,steg/5],[0,steg/3]] );



}

grissini();