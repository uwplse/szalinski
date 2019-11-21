longueur=50;//mm ogive seul
longueur_manchon=10;//mm
pente=30;//      - de pente=rond +  de pente=conique
rayon=11;//mm
rayon_interne=9;//mm
ep=rayon-rayon_interne;//epaisseur mm
$fn=150;//qualité de rendu

layer=0.1;
$vpt=[0,0,longueur/2];

function func(x)=(atan( (x/pente) )*(3.1415/180))/(atan( (longueur/pente) )*(3.1415/180))*rayon;

module ogive(){
        points=[
            for(x=[0:layer:longueur])
                [x,func(x)]
        ];
    translate([0,0,longueur])
    rotate_extrude()
    rotate([180,0,-90])
    polygon(points=concat(points,[[longueur,0]]),convexity =100);
}

difference(){
    ogive();
    translate([0,0,-ep/2])
        scale([(func(longueur)-ep)/func(longueur),(func(longueur)-ep)/func(longueur),(longueur-ep)/longueur])
            ogive();
}

translate([0,0,-longueur_manchon/2+1])
difference(){
        cylinder(longueur_manchon,r=rayon_interne,center=true);
        cylinder(longueur_manchon,r=rayon_interne-ep,center=true);
}


echo(func(longueur));