translate (0,0,0);
Laenge_Fuss_unten = 40;
Laenge_Fuss_oben = 31;
Versatz = (Laenge_Fuss_unten - Laenge_Fuss_oben)/2;
Gesamtdicke = 10;
Breite_Fuss = 24;
Dicke_Fuss = 6.25;
Breite_Oberteil = 30;
Laenge_Oberteil = 42;
Dicke_Oberteil = Gesamtdicke - Dicke_Fuss;
Rand_gerade = (Breite_Fuss - Breite_Oberteil)/2;
Rand_schraeg = (Laenge_Fuss_oben - Laenge_Oberteil)/2;
Kerbenbreite = 0;
Kerbenlaenge = 0;
Kerbentiefe = 0;
$fn=50 + 50;
module schuh (){
    CubePoints = [
  [  0,  0,  0 ],  //0
  [ Breite_Fuss,  0,  0 ],  //1
  [ Breite_Fuss,  Laenge_Fuss_unten,  0 ],  //2
  [  0,  Laenge_Fuss_unten,  0 ],  //3
  [  0,  Versatz,  Dicke_Fuss ],  //4
  [ Breite_Fuss,  Versatz, Dicke_Fuss ],  //5
  [ Breite_Fuss,  Versatz + Laenge_Fuss_oben , Dicke_Fuss],  //6
  [  0, Versatz + Laenge_Fuss_oben , Dicke_Fuss]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
polyhedron( CubePoints, CubeFaces);
};

module platte() {
   minkowski () {
        cube([Breite_Oberteil-6 , Laenge_Oberteil-6, Dicke_Oberteil]);
        translate ([3,3,0])cylinder(r=3,0.001);
    }
}

module Adapter_voll() {schuh();
translate ([Rand_gerade, Rand_schraeg+Versatz, Dicke_Fuss])
platte();
}
difference()
{
Adapter_voll();
translate([Breite_Fuss/2, Laenge_Fuss_unten/2,-0.5]) cylinder(r=3,Gesamtdicke+1);
translate([Breite_Fuss/2, Laenge_Fuss_unten/2,-0.5]) cylinder(r1=10.5, r2=8,(Dicke_Fuss-1));
translate([Breite_Fuss/2, Laenge_Fuss_unten/2,-0.5]) cylinder(r=3.5,Dicke_Fuss+2);    
  
translate([0,0,Dicke_Fuss-Kerbentiefe]) cube([Kerbenbreite,Kerbenlaenge,Kerbentiefe]);
translate([Breite_Fuss-Kerbenbreite,0,Dicke_Fuss-Kerbentiefe]) cube([Kerbenbreite,Kerbenlaenge,Kerbentiefe]);    
}



