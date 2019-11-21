/* [Global] */
//Lenght of the coupler in mm
c_coupler_length=20;

//Lenght of the nose cone minus the coupler in mm
c_length_nose_cone=180;

//External diameter in mm
c_diam_ext=63;
//Internal diameter
c_diam_int=58;

//Slide: How much your nose cone is strait, depends on the nose cone lenght. You should try multiple values to find the one you like.
c_slide=60;

//Face number: number of faces in a circle
c_fn=360;
/* [Hidden] */
longueur_manchon=c_coupler_length;//mm
longueur=c_length_nose_cone-longueur_manchon;//mm ogive seul
pente=c_slide;//      - de pente=rond +  de pente=conique
rayon=c_diam_ext/2;//mm
rayon_interne=c_diam_int/2;//mm
ep=rayon-rayon_interne;//epaisseur mm
$fn=c_fn;//qualité de rendu

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