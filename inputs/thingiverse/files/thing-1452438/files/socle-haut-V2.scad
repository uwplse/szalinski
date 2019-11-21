include <K.scad>

// Variables pouvant être modifiés

//
modele = "ambidextre"; // [droitier,gaucher,ambidextre]

// mm : longueur du socle
L = 130; // [130 : 200]

// mm : largeur du socle
l = 90; // [90 : 160]

// mm : hauteur du socle
h = 35; // [35 : 100]

//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////

// Variable pour la conception

// TOUT EST EN MILIMETRES (il faut faire un calcul pour que les valeur ne puisse pas être modifié sous Thingiverse, d'où les divions par 1)

// rayon de la sphère utilisé pour les congé et à retiré 2 fois pour les cotes du cube //
    s = 2/1;
    
// Epaisseur du socle en mm
    e = 4/1;

/*------------------------------------------------------------------------*/        
    
// Dimension du cube intérieur :Longueur cube ext. - 2 * epaisseur
    L2 = (L-2*s/2)-2*e;
    l2 = (l-2*s/2)-2*e;
    h2 = (h-2*s/2)-2*e;

/*------------------------------------------------------------------------*/
    
// Tranchées  sur le tour pour emboiter

    ht = 4.01/1;// Profondeur de la tranchee -1.01mm
    s2=0.5/1;// Rayon des spheres utilisés pour les congés de la tranchée

/*------------------------------------------------------------------------*/

// Cote trous pour les 4 vis  :
    // Rayon + hauteur en fonction de la vis choisie
        
        rv=1.45/1;
        //si vis = 0 rv = 4 sinon si vis = 1 rv = 6 sinon si vis = 2 rv = 8

/*------------------------------------------------------------------------*/

// Adaptation des mesures pour placer les vis

        r4=rv+rv; // 4 : cylindre plein
        h4=3/4*h; // accueillant la vis
    
        r42=rv;      // 42 : cylindre pour
        h42=h; // percer 4 et le socle

/*------------------------------------------------------------------------*/

//  Variables utilisé pour arrondire les coins
        
        x=2/1; // Coté d'un cube utilisé pour remplir les bord, pour découpé avec un cylindre pour arrondir
        
        h1=3/4*h; // Hauteur des cube = cylindres        
        
/*------------------------------------------------------------------------*/

// Hauteur Fente Cable USB

    hfc = ht+0.02;

/*------------------------------------------------------------------------*/

// Rayon et coordonnées du joystick

    rj = 11.5;
    Lj = -1/4*L-2;
    lj = -(-l2/4+8);

/*------------------------------------------------------------------------*/

// Coordonnée [x,y] des trous pour les jack et des rondelle de serrage

Lj1 = L/2-65;
lj1 = l/2-e/2;
Lj11 = Lj1;
lj11 = l/2-0.99;

Lj4 = L/2-e/2;
lj4 = -l/2+25;
Lj41 = L/2-0.99;
lj41 = lj4;

/*------------------------------------------------------------------------*/

module enveloppe_socle_haut () // Gris
{    
    color("grey")
    translate ([0,0,h/2]) // On remonte la base du socle au niveau du repère
    difference()
    {
        minkowski()
        {        
            cube ([L-2*s,l-2*s,h-2*s], center = true);
            sphere(s,$fn=100);
        }
        minkowski()
        {   
            cube ([L2,l2,h2], center = true);
            sphere(s/2,$fn=100);
        }
        
         //Division du haut et du bas du socle   
        translate ([0,0,3/4*h]) cube([L+1,l+1,h],center = true);
        
        // Diminution de l'épaisseur du haut
        minkowski()
        {   
            cube ([L2,l2,h-2*s/2-e], center = true);
            sphere(s/2,$fn=100);
        }
    }
}
//////////////////////////////////////////

module vis_fixation() // Jaune
{
    color ("yellow")
        for (i = [-1:2:1],
         j = [-1:2:1])    
            {
            difference()
            {
                translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h4/2])
                cylinder (r=r4,h=h4,center = true, $fn=100);
                translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1])
                cylinder (r=r42,h=h42,center = true, $fn=100);
            }
        }
}
//////////////////////////////////////////

module tranchee() // Bleue
{
    color ("blue")
    for (i = [-1:2:1])
    {
        
        // Sur la largeur
        minkowski ()
        {
            translate ([i*(L/2-s),0,(-(ht/2-2*s-s2-3/4*h+1))]) cube ([e-2*s2-1.8,3/4*l2,ht], center = true);
            sphere(s2, $fn=40);
        }
        
        // Sur la longueur
        minkowski ()
        {
            translate ([0,i*(l/2-s),(-(ht/2-2*s-s2-3/4*h+1))]) cube ([3/4*L2,e-2*s2-1.8,ht], center = true);
            sphere(s2, $fn=40);
        }
    }
}
//////////////////////////////////////////

module coins () // Rouge
{
 color("red")
    for (i = [-1:2:1],
        j = [-1:2:1])
    {
        difference()
        {        
            linear_extrude(height=h4)
            polygon(points = 
            [[i*(L2/2-r4+2*s2),j*(l2/2+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2-r4+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2+2*s2)]],
            paths = [[0,1, 2,3]]);
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1])       
            cylinder (r=r42,h=h42,center = true, $fn=100);
        }
        difference() 
        {        
            linear_extrude(height=h4)
            polygon(points = 
            [[i*(L2/2-2*r4+2*s2),j*(l2/2+2*s2)],
            [i*(L2/2+2*s2-2*r4),j*(l2/2-r4+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2+2*s2)]],
            paths = [[0,1, 2,3]]);
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1]) 
            cylinder (r=r42,h=h42,center = true, $fn=100);
        }
        difference()
        {        
            linear_extrude(height=h4)
            polygon(points = 
            [[i*(L2/2-r4+2*s2),j*(l2/2+2*s2-2*r4)],
            [i*(L2/2+2*s2),j*(l2/2-r4+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2+2*s2-2*r4)]],
            paths = [[0,1, 2,3]]);
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1]) 
            cylinder (r=r42,h=h42,center = true, $fn=100);
        }
        difference()
        {
            translate ([i*(L2/2-2*r4+2*s2),j*(l2/2+2*s2),h1/2])
            cube ([x,x,h1], center = true);
           translate ([i*(L2/2-2*r4+2*s2),j*(l2/2+2*s2+1.7),h1/2+0.01])
            cube ([x+1,x,h1], center = true);
            translate ([i*(L2/2-2*r4+2*s2-x/2),j*(l2/2+2*s2-x/2),h1/2+0.01])
            cylinder (r=x/2, h=h1, center = true, $fn=100);
        }
        difference()
        {
            translate ([i*(L2/2+2*s2),j*(l2/2-2*r4+2*s2),h1/2])
            cube ([x,x,h1], center = true);
            translate ([i*(L2/2+2.2),j*(l2/2-2*r4+1),h1/2+1])
            cube ([x,x+1,h1], center = true);
            translate ([i*(L2/2+2*s2-x/2),j*(l2/2-2*r4+2*s2-x/2),h1/2+0.01])
            cylinder (r=x/2, h=h1, center = true, $fn=100);
        }
    }
}
//////////////////////////////////////////

module joystick () // Trou
{
    if (modele == "ambidextre")
    {
        translate ([Lj,0,0]) cylinder (r=rj,h=15, $fn =100, center = true);
    }
    else if (modele=="droitier")
    {
        translate ([Lj,lj,0]) cylinder (r=rj,h=15, $fn =100, center = true); 
    }
    else if (modele == "gaucher")
    {
       translate ([Lj,-lj,0]) cylinder (r=rj,h=15, $fn =100, center = true);
    }
}
//////////////////////////////////////////

module fente_cable ()
{
    translate ([-(L/2-e/2),0,hfc/2+3/4*h-0.01]) cube ([e+0.01,6,hfc], center = true);
}
//////////////////////////////////////////

module placement_trous_jack1(x,y,x1,y1)
{
    // Ce 1er trou accueil la fiche femelle jack
    translate ([x,y,2+3/4*h/2]) rotate ([90,0,0]) cylinder(r=5.8/2,h=4+0.01,center = true, $fn = 50);
    
    // Celui-ci permet de passer la rondelle pour serrer la fiche
    translate ([x1,y1,2+3/4*h/2]) rotate ([90,0,0]) cylinder(r=8.1/2,h=2,center = true, $fn = 50);
}
//////////////////////////////////////////

module placement_trous_jack2(x,y,x1,y1)
{
    translate ([x,y,2+3/4*h/2]) rotate ([0,90,0]) cylinder(r=2.5,h=4+0.01,center = true, $fn = 50);
    translate ([x1,y1,2+3/4*h/2]) rotate ([0,90,0]) cylinder(r=8.1/2,h=2,center = true, $fn = 50);
}
//////////////////////////////////////////

module trou_jack()
{
    if (modele == "droitier")
    {
        placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([20,0,0]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([40,0,0]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        placement_trous_jack2(Lj4,-lj4,Lj41,-lj41);
        translate ([0,-20,0]) placement_trous_jack2(Lj4,-lj4,Lj41,-lj41);
        translate ([0,-40,0]) placement_trous_jack2(Lj4,-lj4,Lj41,-lj41);
    }
    if (modele == "gaucher")
    {
        rotate ([0,0,180]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([20,0,0]) rotate ([0,0,180]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([40,0,0]) rotate ([0,0,180]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        placement_trous_jack2(Lj4,-lj4,Lj41,-lj41);
        translate ([0,-20,0]) placement_trous_jack2(Lj4,-lj4,Lj41,-lj41);
        translate ([0,-40,0]) placement_trous_jack2(Lj4,-lj4,Lj41,-lj41);
    }
    else if (modele == "ambidextre")
    {
        placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([20,0,0]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([40,0,0]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        rotate ([0,0,180]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([20,0,0]) rotate ([0,0,180]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
        translate ([40,0,0]) rotate ([0,0,180]) placement_trous_jack1(Lj1,lj1,Lj11,lj11);
    }
}
//////////////////////////////////////////

module socle_haut() // Ensembe
{
union()
{
    difference()
    {
        enveloppe_socle_haut();
        joystick();
        trou_jack();
    }
    difference()
    {
        tranchee();
        fente_cable ();
    }
    vis_fixation();
    coins();    
}
}
//////////////////////////////////////////
difference()
{
    socle_haut();
    minkowski()
    {
        K([-6,4,0],[0,0,-90],[1.5,1.5]);
        sphere(1);
    }
}