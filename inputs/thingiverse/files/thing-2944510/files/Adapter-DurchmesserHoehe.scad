//Adapter für hohe Orchideentöpfe
//height adjuster for orchid plant pots
//20180603 P. de Graaff

$fn=100;
Durchmesser=85; //outer diameter of adjuster
Hoehe=20;       //height of adjuster
difference(){
    cylinder(d=Durchmesser,h=Hoehe);
    cylinder(d=Durchmesser-20,h=Hoehe+1);
    translate([0,0,10])for (i =[0:8]){
        rotate([0,0,i*45])cube([50,10,50]);
    }
}