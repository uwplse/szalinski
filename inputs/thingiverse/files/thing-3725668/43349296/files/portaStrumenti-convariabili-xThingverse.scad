/*[Dimensioni globali]*/
//Diametro esterno tubo
dia=25.5;
//Altezzo totale
h=100;

/*[Spessori]*/
//Spessore allargamento
sp1=0.8; //[0.8,1.6,2.4]
//Spessore pareti
sp2=0.8; //[0.2:0.2:1]
//Allargamento all'appoggio
t=6; // [2:minimo, 6:medio, 10:abbondante]


difference(){
    union(){
cylinder(sp1,d1=dia+t,d2=dia+t);
cylinder(h-dia/2,d1=dia,d2=dia);
translate([0,0,h-dia/2])sphere(dia/2);
    }
cylinder(h-dia/2,d1=dia-sp2*2,d2=dia-sp2*2);
translate([0,0,h-dia/2])sphere((dia-sp2*2)/2);
}
