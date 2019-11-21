//Sofa Rentneranhebung
//Nozzle diamter for wall thickness
nozzle=0.8;
wallNumbers=4;//[2:2:10]
footDiameterTop=58;
footDiameterBottom=45;
footHeight=60;

dowelDiameterBottom=13;
dowelDiameterTop=13;
dowelHeight=25;


difference(){
    minkowski(){
        cylinder(d1=footDiameterBottom,d2=footDiameterTop,h=footHeight,$fn=150);
        sphere(1);
    }
    translate([0,0,wallNumbers])cylinder(d1=footDiameterBottom-(nozzle*wallNumbers)/2,d2=footDiameterTop-(nozzle*wallNumbers)/2,h=footHeight,$fn=150);
}
difference(){
    for(i=[0:1:4]){
        rotate([0,0,i*45])hull(){
            cube([footDiameterBottom,wallNumbers*nozzle,0.01],center=true);
            translate([0,0,footHeight+1])cube([footDiameterTop,wallNumbers*nozzle,0.01],center=true);
        }
    }
    translate([0,0,footHeight-5])cylinder(d=dowelDiameterBottom,h=dowelDiameterBottom,$fn=50);
}
//Dübel
translate([0,0,footHeight-5])cylinder(d1=dowelDiameterBottom,d2=dowelDiameterTop,h=dowelHeight+5,$fn=50);
//Winkel berechnen
b=sqrt(dowelHeight*dowelHeight+(dowelDiameterBottom-dowelDiameterTop)*(dowelDiameterBottom-dowelDiameterTop));
//Länge
echo(b);
gamma=acos(dowelHeight/b);
echo(gamma);
for(i=[0:1:8]){
    rotate([0,0,i*45])translate([dowelDiameterBottom/2,0,footHeight])rotate([0,-gamma/2-1,0])cylinder(d=1,h=dowelHeight-1,$fn=50);
}