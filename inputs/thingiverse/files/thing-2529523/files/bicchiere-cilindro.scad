// bicchiere cilindro
base_larghezza = 70;
base_lunghezza = base_larghezza;
base_altezza = 90;
spessore = 5;
rialzo = 10;
apertura = 5;
top_larghezza = base_larghezza - spessore;
top_lunghezza = base_lunghezza - spessore;
top_altezza = base_altezza - rialzo;
$fn = 12;

difference() {
    // esterno
    cylinder(h = base_altezza, d1 = base_larghezza, d2 = base_larghezza + apertura, center = true);

    // interno
    translate([0,0,rialzo])
    cylinder(h = top_altezza, d1 = top_larghezza, d2 = top_larghezza + apertura, center = true);
}
