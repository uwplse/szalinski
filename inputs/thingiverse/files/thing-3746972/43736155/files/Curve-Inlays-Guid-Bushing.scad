// Curve Inlays Guide Bushing
//INPUT:
//Diametro della fresa
d_fresa = 8;
//Gioco tra fresa e cuscinetto
gioco = 3;
//Spessore materiale della guida
spessore = 2;
//Diametro della base dello strumento
d_base = 74;
//Distanza tra i fori sulla base
d_fori = 65;
//Altezza della base della guida
h_base = 2;
//Altezza del cuscinetto
h_cuscinetto = 5;
//Diametro delle viti
d_viti = 4.5;
//Diametro della testa delle viti
d_testa = 7.6;
//Altezza della testa delle viti
h_testa = 1.2;
//Risoluzione del modello
risoluzione = 200;

//CONVERSIONI:
rf = d_fresa/2;
rb = d_base/2;
rfo = d_fori/2;
rv = d_viti/2;
rt = d_testa/2;

//COSTRUZIONE CUSCINETTO GRANDE:
difference(){
    difference(){
    union(){
    cylinder(h = h_base,r = rb,$fn = risoluzione);
    cylinder(h = h_base+h_cuscinetto, r = rf*2+gioco+spessore,$fn = risoluzione);
    }
    translate([0,0,-1]){
        cylinder(h = h_base+h_cuscinetto+2,r = rf*2+gioco,$fn = risoluzione);
    }
    }
    translate([rfo,0,-1]){
        cylinder(h = h_base+2,r = rv,$fn = risoluzione);
    }
    translate([-rfo,0,-1]){
        cylinder(h = h_base+2,r = rv,$fn = risoluzione);
    }
    translate([rfo,0,h_base-h_testa]){
        cylinder(h = h_testa+0.1,r1 = rv,r2 = rt,$fn = risoluzione);
    }
    translate([-rfo,0,h_base-h_testa]){
        cylinder(h = h_testa+0.05,r1 = rv,r2 = rt,$fn = risoluzione);
    }
}

//COSTRUZIONE CUSCINETTO PICCOLO;
translate([d_base*1.2,0,0]){
    difference(){
    difference(){
    union(){
    cylinder(h = h_base,r = rb,$fn = risoluzione);
    cylinder(h = h_base+h_cuscinetto, r = rf+gioco+spessore,$fn = risoluzione);
    }
    translate([0,0,-1]){
        cylinder(h = h_base+h_cuscinetto+2,r = rf+gioco,$fn = risoluzione);
    }
    }
    translate([rfo,0,-1]){
        cylinder(h = h_base+2,r = rv,$fn = risoluzione);
    }
    translate([-rfo,0,-1]){
        cylinder(h = h_base+2,r = rv,$fn = risoluzione);
    }
    translate([rfo,0,h_base-h_testa]){
        cylinder(h = h_testa+0.1,r1 = rv,r2 = rt,$fn = risoluzione);
    }
    translate([-rfo,0,h_base-h_testa]){
        cylinder(h = h_testa+0.05,r1 = rv,r2 = rt,$fn = risoluzione);
    }
    }
}