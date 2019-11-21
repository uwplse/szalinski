// bicchiere cilindro
base_larghezza = 70;
base_lunghezza = base_larghezza;
base_altezza = 10;
spessore = 10;
rialzo = 10;
apertura = 5;
top_larghezza = base_larghezza - spessore;
top_lunghezza = base_lunghezza - spessore;
top_altezza = base_altezza - rialzo;
$fn = 100;

size = 40;
riga1 = "GIANLUCA";
riga2 = "PETRILLO";
char1 = len(riga1);
char2 = len(riga2);
correzione = 2;

difference() {
    union() {
        //base
        translate([0,0,base_altezza/2])
        cylinder(h = base_altezza, d1 = base_larghezza, d2 = base_larghezza + apertura, center = true);

        // seconda riga
        for (i = [0:char2-1]) {
            gradi = 360/char2*i;
            dist = base_larghezza/2-spessore*2;
            translate([dist*sin(gradi),dist*-cos(gradi),base_altezza+size/2-correzione])
            rotate([90,0,gradi])
            linear_extrude(spessore*3, convexity=4)
            text(riga2[i], size, font="Times New Roman",
                halign="center",
                valign="center"); }

        // base di mezzo
        translate([0,0,base_altezza/2*3+size-correzione*2])
        cylinder(h = base_altezza, d1 = base_larghezza, d2 = base_larghezza + apertura, center = true);

        // prima riga
        for (i = [0:char1-1]) {
            gradi = 360/char1*i;
            dist = base_larghezza/2-spessore*2;
            translate([dist*sin(gradi),dist*-cos(gradi),base_altezza*2+size/2*3-correzione*3])
            rotate([90,0,gradi])
            linear_extrude(spessore*3, convexity=4)
            text(riga1[i], size, font="Times New Roman",
                halign="center",
                valign="center"); }

        // base in alto
        translate([0,0,base_altezza/2*5+size*2-correzione*4])
        cylinder(h = base_altezza, d1 = base_larghezza, d2 = base_larghezza + apertura, center = true);
    }


    union() {
        // cilindro centrale
        translate([0,0,base_altezza])
        cylinder(h = base_altezza/2*5+size*2-correzione*4, d1 = base_larghezza-spessore, d2 = base_larghezza - spessore + apertura);
        
        difference() {
        //cilindro esterno
        translate([0,0,0])
        cylinder(h = base_altezza*4+size*2-correzione*4, d1 = base_larghezza*2, d2 = base_larghezza*2 + apertura);
        
        //cilindro interno
        translate([0,0,0])
        cylinder(h = base_altezza*4+size*2-correzione*4, d1 = base_larghezza, d2 = base_larghezza + apertura);
        }
    }
}