$fn=30;

//Masse (nicht zu knapp!):
//Mass, not too short
x=27; //Laenge
y=20; //Breite
z=1.5;  //Hoehe - 1.5 dürfte das Minimum sein
f="Arial";
s=12;  //Size
text1="Su";
text2="We";

difference() {
    //Aussenkoerper
    cube([x,y,z],false);
    translate([x/2,(y-s)/2,4*(z/5)]) {
        cube([1,1,0],false); //nur Ausrichtung
        linear_extrude(height = z) {
        text(text1,font=f,s,halign="center");
        }
    }
    //die Berechnung stimmt nicht so ganz... aber irgendwie passts schon
    translate([x/2,(y-s)/2,-(z/3)*2]) {
        cube([1,1,0],false); //nur Ausrichtung
        mirror([1, 0, 0]) {
            linear_extrude(height = z) {
                text(text2,font=f,s,halign="center");
            }
        }
    }
}
