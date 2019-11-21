$fn = 100;

stabDurchmesser = 5;
wandStaerke = 1.4;
fotoDicke = 1.5;
fotoBreite = 40;
fotoTiefe = 4;

difference(){
    resize([0,fotoBreite,0])
        translate([0,0,stabDurchmesser+fotoTiefe/2+wandStaerke/2])
            cylinder(h = stabDurchmesser*2+fotoTiefe+wandStaerke, r1 = wandStaerke + stabDurchmesser/2, r2 = fotoDicke/2 + wandStaerke + stabDurchmesser/2, center = true);
    translate([0,0,2*stabDurchmesser+wandStaerke+fotoTiefe/2])
        cube([fotoDicke, fotoBreite+1, fotoTiefe], center = true);
    translate([0,0,stabDurchmesser])    
        cylinder(h = 2*stabDurchmesser, d = stabDurchmesser, center = true);
}