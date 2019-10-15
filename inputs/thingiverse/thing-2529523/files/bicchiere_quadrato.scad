// bicchiere quadrato
base_larghezza = 70;
base_lunghezza = base_larghezza;
base_altezza = 90;
spessore = 5;
rialzo = 10;
top_larghezza = base_larghezza - spessore;
top_lunghezza = base_lunghezza - spessore;
top_altezza = base_altezza - rialzo;

difference() {
    // esterno
    cube([base_larghezza, base_lunghezza, base_altezza], center = true);

    // interno
    translate([0,0,rialzo])
    cube([top_larghezza, top_lunghezza, top_altezza], center = true);

}
