// Curve Subdivision:
$fn=90;
// Cable Diameter:
diametro_cavo = 8;
// Base Lenght:
base_dim = 14;
// Base Height:
base_alt = 3;
// Fillet Radius:
raggio_smussatura = 3;
// Hole Diameter:
diametro_foro = 4;
// Tie Height:
altezza_fascetta = 1.5;
// Tie Width:
larghezza_fascetta = 4.5;


// This is just to make differences...
addendum = 0.1;

ferma_cavo();

module ferma_cavo() {
    difference() {
        // Base:
        translate([0,0,base_alt/2]) cube([base_dim, base_dim, base_alt*2], center = true);
        // Smussi:
        for (i=[0,90,180,270]) {
            rotate([0,0,i]) difference() {
                translate([base_dim/2-raggio_smussatura/2+addendum, base_dim/2-raggio_smussatura/2+addendum, 0]) cube([raggio_smussatura, raggio_smussatura, base_alt*4], center=true);
                translate([base_dim/2-raggio_smussatura, base_dim/2-raggio_smussatura, 0]) cylinder(h=base_alt*4, r=raggio_smussatura,center=true);
            }
        }
        // Svaso:
        cylinder(h=base_alt+addendum, d=diametro_foro, center=true);
        cylinder(h=base_alt/2+addendum, r1=diametro_foro/2, r2=diametro_foro);
        // Foro Cacciavite:
        translate([0,0,base_alt/2]) cylinder(h=base_alt, d=diametro_foro*2.0);
        // Passaggi Fascette:
        translate([0,0,base_alt/2+altezza_fascetta/2]) {
            cube([base_dim*2, larghezza_fascetta, altezza_fascetta], center=true);
            translate([0,0,base_alt]) rotate([90,0,0]) cylinder(d=diametro_cavo, h=base_dim*2, center=true);
        }
        // Smussature Fascette:
        difference() {
            translate([0,0,base_alt*1.5+altezza_fascetta/2]) rotate([90,0,0]) difference() {
                cylinder(d=base_dim+altezza_fascetta*2, h=larghezza_fascetta, center=true);
                cylinder(d=base_dim+addendum, h=larghezza_fascetta+addendum, center=true);
            }
            translate([0,0,0]) cube([base_dim*2, base_dim*2,base_alt], center=true);
        }
    }
}