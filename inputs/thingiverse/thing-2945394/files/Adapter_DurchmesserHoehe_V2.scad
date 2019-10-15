//Adapter für hohe Orchideentöpfe
//height adjuster for orchid plant pots
//20180604 P. de Graaff

$fn=100;
Durchmesser=85;     //outer diameter of adjuster
DurchmesserTopf=80; //outer diameter plant pot
Hoehe=20;           //total height of adjuster
difference(){
    cylinder(d=Durchmesser,h=10);
    cylinder(d=DurchmesserTopf-20,h=Hoehe+1);
}
translate([0,0,10]) difference(){
    cylinder(d=DurchmesserTopf,h=Hoehe-10);
    cylinder(d=DurchmesserTopf-20,h=Hoehe+1);
    for (i =[0:8]){
        rotate([0,0,i*45])cube([50,10,50]);
    }
}