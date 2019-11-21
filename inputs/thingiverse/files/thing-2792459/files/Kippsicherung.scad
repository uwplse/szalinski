/*Ender_Lock
Befestigung für PSU Gerüst
20180204 P. de Graaff
*/
Bohrung = 3;//Loch für M3
Hoehe = 72;//Licht Höhe
Wand = 3; //Wandstärke

//Bodenplatte
plate();
//obere Platte
translate([15,0,Hoehe])rotate([0,180,0])plate();
//Streben
cube([Wand,Wand,Hoehe]);
translate([15-Wand,0,0])cube([Wand,Wand,Hoehe]);

//Schraubenplatte
module plate(){
    difference(){
        cube([15,15,Wand]);
        translate([7.5,7.5,Wand-2])cylinder(d1=Bohrung, d2=Bohrung+3,h=2,$fn=20);//Senkloch
        translate([7.5,7.5,-Wand/2])cylinder(d=Bohrung,h=Wand+2,$fn=20);
    }
}