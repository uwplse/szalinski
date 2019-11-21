
A=7.5;        //Durchmesser des Vierkantes
B=43;       //Abstand zwischen den Schrauben im Griff (Standard ist 43)
C=68;       //Länge des Fenstergriffsockel (Standard ist 68)
D=11;       //Durchmesser der Schraubenlöcher
E=32;       //Breite des Fenstergriffsockel(Standard ist 32)

F=4;        //Magnet Durchmesser
G=2;        //Magnet Dicke
X=60;        //Rendertiefe der Bohrungen (guter Wert ist 40)
Y=4;        //Dicke der Platte (Standardwert 4)

translate([((E/2)-6),(E+20),0])ring();
translate([0,0,0])plate();
translate([E,(E+10),0])top();




module top() {
  difference(){
    $fn=50;
    minkowski() {
      translate([0.5,0.5,1])cube([45-1,E-1,9]);
      sphere(1);
    }
    translate([0.5,0.5,1])cube([44,(E-1),9+2]);
    translate([-2,-2,9.5])cube([49,E+4,2]);
  }
}



module ring()
{
difference(){
cylinder($fn=X,h=Y,r=((E/2)-6.5));
cube([(A+0.5),(A+0.5),10],center=true);
translate([(((E/2)-6)-(G+0.5)),0,0])cube([(G+0.5),(F+0.5),10],center=true);
}
}

module plate()
{
difference(){
cube([116,E,8]);
translate([-1,-1,Y])cube([73,(E+5),8]);
translate([73,2,2])cube([41,(E-4),8]);
translate([72,-1,Y])cube([44,2,8]);
translate([72,(E-1),Y])cube([44,2,8]);
translate([115,-1,Y])cube([2,(E+2),8]);
translate([((C-B)/2),(E/2),-1])cylinder($fn=X,h=10,r=(D/2));
translate([(C-((C-B)/2)),(E/2),-1])cylinder($fn=X,h=10,r=(D/2));
translate([((B/2)+((C-B)/2)),(E/2),-1])cylinder($fn=X,h=10,r=((E/2)-5.5));    
translate([75,4,-1])cylinder($fn=X,h=10,r=1);    
translate([77.54,4,-1])cylinder($fn=X,h=10,r=1);
translate([80.08,4,-1])cylinder($fn=X,h=10,r=1);
translate([82.62,4,-1])cylinder($fn=X,h=10,r=1);
translate([((B/2)+((C-B)/2)),2,0])cube([15,3,3]);
translate([((B/2)+((C-B)/2)),(E-2-3),0])cube([15,3,3]);
translate([46,(E-4.5),0])cube([34.08,2,1.8]);
translate([79.08,4,0])cube([2,(E-6.5),1.8]);
translate([20,(E-4.5),0])cube([20,2,1.8]);
translate([20,2.5,0])cube([20,2,1.8]);
translate([20,0.5,0])cube([2,(E-5),1.8]);
translate([20,0.5,0])cube([62.62,1,1.8]);
translate([81.62,0.5,0])cube([2,4,1.8]);
translate([46,2.5,0])cube([31.5,2,1.8]);
translate([38,(E-8),0.5])cube([40,2,3]);
}
translate([73,16,1.5])cube([2,2,3]);
translate([112,16,1.5])cube([2,2,3]);
translate([112,2,1.5])cube([2,2,3]);

}
