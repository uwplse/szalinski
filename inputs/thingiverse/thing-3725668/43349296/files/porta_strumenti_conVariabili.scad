dia=25.5; //diametro esterno tubo
h=100; //altezza totale

difference(){
    union(){
cylinder(2,d1=dia+6,d2=dia+6);
cylinder(h-dia/2,d1=dia,d2=dia);
translate([0,0,h-dia/2])sphere(dia/2);
    }
cylinder(h-dia/2,d1=dia-1.6,d2=dia-1.6);
translate([0,0,h-dia/2])sphere((dia-1.6)/2);
}