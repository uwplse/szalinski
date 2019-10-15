/* [user roll dimensions] */
    diametre_rouleau=200;// [150:200]
    epaisseur_rouleau=71;// [30:77]
    diametre_trou=53;// [32:60]

/* [Hidden] */
    es=6;//epaisseur structure
    Hauteur_z=19;
    GR=3;//grands rayons
    pr=1;//petits rayons
    preview_tab = "";

//Calculs dimensionnels
    epaulement=((diametre_rouleau/2)-(diametre_trou/2));//extérieur rouleau à bord trou du rouleau
    portee=(epaisseur_rouleau+2+es);//jeu=2
    longueur_renfort=sqrt((portee*portee)+((diametre_trou-es)*(diametre_trou-es)));//du bout de la portee au bord inférieur du trou du rouleau
    ang=atan(portee/(diametre_trou-es));//angle de rotation du renfort
    angsmall=180-(90+ang);//angle de la pointe de la portée
    sx=2*(sin (angsmall));//localisation en x du point de tangence du rayon sur le renfort
    sy=2*(cos (angsmall));//localisation en y du point de tangence du rayon sur le renfort
    lx=(sy+2)/(tan (angsmall));//localisation en x du point de tangence du rayon sur la portée
    decalage=es/(sin (angsmall));//longueur du chevauchement de la portée et du renfort

//Dessin du support mural
 union() {
        //Dessin de la partie au mur
        //Example: translate(v = [x, y, z]) { ... }
        //x=es;
        y=epaulement+diametre_trou+(es*3);
        z=Hauteur_z;
        //echo(box=[es, y, z]);
     
        difference () {
            translate([0,-(diametre_trou+(es*3)),0])
                cube([es,y,z],false);
            translate([-a4,epaulement/3,z/2])
                rotate ([0,90,0]) 
                    cylinder(es+2,r=2, $fn=100,center=false);
            translate([-a4,(epaulement/3)*2,z/2])
                rotate ([0,90,0]) 
                    cylinder(es+2,r=2, $fn=100,center=false);
         };
     
        //Dessin de la portee
        a=portee;
        translate([-a,-es,0])
            cube([a,es,z],false);
        
        //Dessin de la butée d'extrémité
        translate ([-a,0,0]) 
            cube([es,es,z],false);
        
        //Dessin du renfort
        b2=longueur_renfort;
        translate([0,-(diametre_trou),0])
            rotate([0,0,ang])
                cube([es,b2,z]);
        
        //Dessin du rayon mur-dessous portee
        a3=3;
        b3=3;
        translate([-a3,-(es+b3),0])
            difference(){
                cube([a3,b3,z],false);
                translate([0,0,-1])
                cylinder(z+2,r=a3,$fn=100,center=false);
            };//fin de la difference
        
        //Dessin du rayon mur-dessus portee
        a4=1;
        b4=1;
        r=a4;
        L4=z+2;
        
        difference(){
            translate([-a4,0,0])
                cube([a4,b4,z],false);
            translate([-a4,b4,-1])
                cylinder(L4,r, $fn=100,center=false);
            };//fin de la difference
        
        difference(){
            translate([-(a-es),0,0]) 
                cube([a4,b4,z],false);
            translate([-(a-es-a4),b4,-1])
                cylinder(L4,r, $fn=100,center=false);
            };//fin de la difference
        
        difference(){
            union (){
                translate([-(a-lx-decalage-sx),-es-2,0])
                    rotate ([0,0,90])
                        cube([2,lx+sx,z],false);
                translate([-(a-lx-decalage),-(es+2+sy),0])
                    rotate ([0,0,ang])
                        cube([2,lx+sx,z],false);
            };//fin de l'union
            translate ([-(a-lx-decalage-sx),-es-2,-1]) 
                cylinder (h=(z+2),r=2,$fn=100,center=false);
        };//fin de la difference
        
};//fin de l'union
// preview[view:south east, tilt:top diagonal]