
Nombre_de_tours=3;

Diametre_de_base_d_une_tour=100;
Hauteur_de_la_base=40;
Hauteur_du_raccord=10;
Diametre_d_une_tour_apres_raccord=90;
Nombre_de_briques_horizontalement_pour_une_tour=16;
Nombre_de_briques_verticalement_pour_une_tour=10;
Hauteur_des_briques=12;
Taille_des_joints=2;
Fenetres_aux_tours="oui";//[oui,non]
Diametre_du_balcon=120;
Nombre_de_briques_verticalement_pour_le_balcon=4;


Diametre_partie_haute_de_la_tour=70;
Nombre_de_briques_verticalement_pour_partie_haute_de_la_tour=8;


Hauteur_du_toit=100;
Diametre_du_toit=100;

MUR_Nombre_de_briques_verticalement=Nombre_de_briques_verticalement_pour_une_tour;
Nombre_de_briques_horizontalement_pour_les_murs=10;

Largeur_des_briques_des_murs=25;
Epaissseur_du_mur=20;

Grille="ouverte";//[ouverte,fermee]

EPAIS_RACMUR=Diametre_de_base_d_une_tour-Diametre_d_une_tour_apres_raccord;

TOUR_HP2=Hauteur_de_la_base+Hauteur_du_raccord+(Nombre_de_briques_verticalement_pour_une_tour*(Hauteur_des_briques+Taille_des_joints)+Hauteur_des_briques);

TOUR_TOIT=Hauteur_de_la_base+Hauteur_du_raccord+(Nombre_de_briques_verticalement_pour_une_tour*(Hauteur_des_briques+Taille_des_joints)+Hauteur_des_briques)+(Nombre_de_briques_verticalement_pour_partie_haute_de_la_tour*(Hauteur_des_briques+Taille_des_joints));
MUR_TAILLE=Nombre_de_briques_horizontalement_pour_les_murs*(Largeur_des_briques_des_murs+Taille_des_joints);


MaTourEtMonMur(it=1,mit=Nombre_de_tours);


module MaTourEtMonMur()
{
    tour();
    union()
    {
        rotate([0,0,360/Nombre_de_tours])    
        difference()
        {    
            mur();
            hull()
            {
                translate([0,MUR_TAILLE/2,0])
                cube([Epaissseur_du_mur*4,MUR_TAILLE/4,50],center=true);

                translate([0,MUR_TAILLE/2,TOUR_HP2*2/4])
                rotate([0,90,0])
                cylinder(d=MUR_TAILLE/4,h=Epaissseur_du_mur*2,center=true);
            }
        }
        color([0.9,0.1,0.1,1])
        rotate([0,0,360/Nombre_de_tours])
        difference()
        {
            hull()
            {
                translate([0,MUR_TAILLE/2,1])
                cube([Diametre_de_base_d_une_tour-Diametre_d_une_tour_apres_raccord+Epaissseur_du_mur,MUR_TAILLE/4+Epaissseur_du_mur,2],center=true);
    
                translate([0,MUR_TAILLE/2,TOUR_HP2*2/4])
                rotate([0,90,0])
                cylinder(d=MUR_TAILLE/4+Epaissseur_du_mur,h=Diametre_de_base_d_une_tour-Diametre_d_une_tour_apres_raccord+Epaissseur_du_mur,center=true);
            }
            hull()
            {
                translate([0,MUR_TAILLE/2,-1])
                cube([Diametre_de_base_d_une_tour-Diametre_d_une_tour_apres_raccord+Epaissseur_du_mur,MUR_TAILLE/4,4],center=true);
    
                translate([0,MUR_TAILLE/2,TOUR_HP2*2/4])
                rotate([0,90,0])
                cylinder(d=MUR_TAILLE/4,h=Diametre_de_base_d_une_tour-Diametre_d_une_tour_apres_raccord+Epaissseur_du_mur*2,center=true);
            }
        }
    }
    if(Grille=="ouverte")
    {
        rotate([0,0,360/Nombre_de_tours])    
        translate([0,MUR_TAILLE/2,TOUR_HP2*1/2])
        color([0.3,0.3,0.3,1])
        difference()
        {
            grille();
            translate([0,0,TOUR_HP2*3/4])
            cube([MUR_TAILLE/2,MUR_TAILLE/2,TOUR_HP2],center=true);
        }
        
    }

    if(Grille=="fermme")
    {
             rotate([0,0,360/Nombre_de_tours])    
             translate([0,MUR_TAILLE/2,10])
            color([0.3,0.3,0.3,1])
            grille();
    }
    
    
    if(it<=mit)
    {
        rotate([0,0,360/Nombre_de_tours])
        translate([0,MUR_TAILLE,0])
        MaTourEtMonMur(it=it+1,mit=mit);
    }
}


module grille()
{
    union()
    {
    cylinder(d=MUR_TAILLE/4/8/2,h=TOUR_HP2*2/4+MUR_TAILLE/4/2);
    translate([0,MUR_TAILLE/4/4,0])
    cylinder(d=MUR_TAILLE/4/8/2,h=TOUR_HP2*2/4+MUR_TAILLE/4/2);
    translate([0,-MUR_TAILLE/4/4,0])
    cylinder(d=MUR_TAILLE/4/8/2,h=TOUR_HP2*2/4+MUR_TAILLE/4/2);


    translate([0,0,-10])
    cylinder(d1=0,d2=MUR_TAILLE/4/8+MUR_TAILLE/4/8/10,h=10);
    translate([0,MUR_TAILLE/4/4,-10])
    cylinder(d1=0,d2=MUR_TAILLE/4/8+MUR_TAILLE/4/8/10,h=10);
    translate([0,-MUR_TAILLE/4/4,-10])
    cylinder(d1=0,d2=MUR_TAILLE/4/8+MUR_TAILLE/4/8/10,h=10);

rotate([0,90,90])
cylinder(d=MUR_TAILLE/4/8/2,h=MUR_TAILLE/4,center=true);

translate([0,0,TOUR_HP2*2/4])
rotate([0,90,90])
cylinder(d=MUR_TAILLE/4/8/2,h=MUR_TAILLE/4,center=true);

translate([0,0,TOUR_HP2*2/4*1/2])
rotate([0,90,90])
cylinder(d=MUR_TAILLE/4/8/2,h=MUR_TAILLE/4,center=true);

translate([0,0,TOUR_HP2*2/4*1/4])
rotate([0,90,90])
cylinder(d=MUR_TAILLE/4/8/2,h=MUR_TAILLE/4,center=true);
   
translate([0,0,TOUR_HP2*2/4*3/4])
rotate([0,90,90])
cylinder(d=MUR_TAILLE/4/8/2,h=MUR_TAILLE/4,center=true);

}
}

module mur()
{


    color([0.9,0.1,0.1,1])
    {
        
        translate([-Epaissseur_du_mur/2,0,Hauteur_de_la_base+Hauteur_du_raccord])        
        for(j=[0:MUR_Nombre_de_briques_verticalement-1])
        {
            translate([0,0,(Hauteur_des_briques+Taille_des_joints)*j])
            
            if((j/2)==floor(j/2))
            {
                translate([0,(Largeur_des_briques_des_murs+Taille_des_joints)/2,0])
                for(i=[0:Nombre_de_briques_horizontalement_pour_les_murs-1])
                {
                    translate([0,i*(Largeur_des_briques_des_murs+Taille_des_joints),0])
                    cube([Epaissseur_du_mur,Largeur_des_briques_des_murs,Hauteur_des_briques]);
                }
            }
            else
            {
                translate([0,(Largeur_des_briques_des_murs+Taille_des_joints),0])
                for(i=[0:Nombre_de_briques_horizontalement_pour_les_murs-1])
                {
                    translate([0,i*(Largeur_des_briques_des_murs+Taille_des_joints),0])
                    cube([Epaissseur_du_mur,Largeur_des_briques_des_murs,Hauteur_des_briques]);
                }

            }
            
            
            }
        
        
         hull()
        {
            rotate([0,0,90])
            translate([0,-(Epaissseur_du_mur+EPAIS_RACMUR)/2,0])        
            cube([MUR_TAILLE,(Epaissseur_du_mur+EPAIS_RACMUR),Hauteur_de_la_base]);

            rotate([0,0,90])
            translate([0,-(Epaissseur_du_mur)/2,0])        
            cube([MUR_TAILLE,(Epaissseur_du_mur),Hauteur_de_la_base+Hauteur_du_raccord]);
        }

        rotate([0,0,90])        
        translate([0,-Diametre_du_balcon/4,TOUR_HP2-Hauteur_des_briques])
        cube([MUR_TAILLE,Diametre_du_balcon/2,Hauteur_des_briques]);

        difference()
        {
            
            HautRouge();
            translate([0,0,TOUR_HP2])
            cylinder(d=Diametre_du_balcon,h=Nombre_de_briques_verticalement_pour_le_balcon*(Hauteur_des_briques+Taille_des_joints));        
            
            rotate([0,0,90])
            translate([MUR_TAILLE,0,TOUR_HP2])
            cylinder(d=Diametre_du_balcon,h=Nombre_de_briques_verticalement_pour_le_balcon*(Hauteur_des_briques+Taille_des_joints));        

            rotate([0,0,90])        
            translate([0,-(Diametre_du_balcon/2-(Taille_des_joints*2)-Taille_des_joints)/2,TOUR_HP2-Hauteur_des_briques])
            cube([MUR_TAILLE,Diametre_du_balcon/2-(Taille_des_joints*2)-Taille_des_joints,Hauteur_des_briques*(Nombre_de_briques_verticalement_pour_le_balcon+Taille_des_joints)]);


            }







    }
    color([00,0,0,1])
    {
        rotate([0,0,90])
        translate([0,-(Epaissseur_du_mur-Taille_des_joints)/2,0])
        cube([MUR_TAILLE,(Epaissseur_du_mur-Taille_des_joints),TOUR_HP2-1]);

        difference()
        {
            rotate([0,0,90])        
            translate([0,-(Diametre_du_balcon/2-Taille_des_joints)/2,TOUR_HP2-1])
            cube([MUR_TAILLE,Diametre_du_balcon/2-Taille_des_joints,(Nombre_de_briques_verticalement_pour_le_balcon-1)*(Hauteur_des_briques+Taille_des_joints)]);

            rotate([0,0,90])        
            translate([0,-(Diametre_du_balcon/2-Taille_des_joints*2)/2,TOUR_HP2-5])
            cube([MUR_TAILLE,Diametre_du_balcon/2-Taille_des_joints*2,(Nombre_de_briques_verticalement_pour_le_balcon-1)*(Hauteur_des_briques+Taille_des_joints*2)+10]);
            
            translate([0,0,TOUR_HP2-5])
            cylinder(d=Diametre_du_balcon-Taille_des_joints,h=100);
            rotate([0,0,90])
            translate([MUR_TAILLE,0,TOUR_HP2-5])
            cylinder(d=Diametre_du_balcon-Taille_des_joints,h=100);


        }

    }


}



















module tour()
{
    color([0.9,0.1,0.1,1])
    {
        if(Fenetres_aux_tours=="non")
        {
            TourRouge();
        }
        else
        {
            difference()
            {
                TourRouge();
                //rotate([0,0,360/Nombre_de_tours/2-(360/Nombre_de_briques_horizontalement_pour_une_tour/2)])
                rotate([0,0,-(360/Nombre_de_briques_horizontalement_pour_une_tour/2)])
                for(i=[0:Nombre_de_tours-1])
                {
                rotate([0,0,360/Nombre_de_tours*i])
                translate([0,0,TOUR_HP2*2/3])
                brique(
                    aa=Diametre_d_une_tour_apres_raccord*2,
                    bb=Diametre_de_base_d_une_tour,
                    cc=Nombre_de_briques_horizontalement_pour_une_tour,
                    dd=((Hauteur_des_briques+Taille_des_joints)*3)-Taille_des_joints*2,
                    ee=Taille_des_joints);
                }
                rotate([0,0,-(360/Nombre_de_briques_horizontalement_pour_une_tour/2)])
                for(i=[0:Nombre_de_tours-1])
                {
                rotate([0,0,360/Nombre_de_tours*i])
                translate([0,0,TOUR_HP2+(TOUR_TOIT-TOUR_HP2)*2/3])
                brique(
                    aa=Diametre_d_une_tour_apres_raccord*2,
                    bb=Diametre_de_base_d_une_tour,
                    cc=Nombre_de_briques_horizontalement_pour_une_tour,
                    dd=((Hauteur_des_briques+Taille_des_joints)*2)-Taille_des_joints*2,
                    ee=Taille_des_joints);
                }                
            }

        }
        
    }
    color([0,0,0,1])
    {
        cylinder(d=Diametre_d_une_tour_apres_raccord-Taille_des_joints,h=Hauteur_de_la_base+Hauteur_du_raccord+(Nombre_de_briques_verticalement_pour_une_tour*(Hauteur_des_briques+Taille_des_joints)));
                translate([0,0,Hauteur_de_la_base+Hauteur_du_raccord+(Nombre_de_briques_verticalement_pour_une_tour*(Hauteur_des_briques+Taille_des_joints)+Hauteur_des_briques)])
        
        linear_extrude(height=(Hauteur_des_briques+Taille_des_joints)*(Nombre_de_briques_verticalement_pour_le_balcon-1))
        difference()
        {
            circle(d=Diametre_du_balcon-Taille_des_joints,h=((Hauteur_des_briques+Taille_des_joints)*Nombre_de_briques_verticalement_pour_le_balcon));
            circle(d=Diametre_du_balcon-Hauteur_des_briques+Taille_des_joints,h=((Hauteur_des_briques+Taille_des_joints)*Nombre_de_briques_verticalement_pour_le_balcon));
        }
        
        translate([0,0,TOUR_HP2])
        cylinder(d=Diametre_partie_haute_de_la_tour-Taille_des_joints,h=Nombre_de_briques_verticalement_pour_partie_haute_de_la_tour*(Hauteur_des_briques+Taille_des_joints));

    }
    color([0.2,0.6,0.8,1])
    {
        translate([0,0,TOUR_TOIT])
        MonToit();
    }
}



module brique()
{
    linear_extrude(height=dd)
    intersection()
    {
        circle(d=aa);
        offset(-ee/2)
        polygon([[0,0],[bb*1.1,0],[cos(360/cc)*bb*2,sin(360/cc)*bb*2]], paths=[[0,1,2]]);
    }
}

module TourRouge()
{
    cylinder(d=Diametre_de_base_d_une_tour,h=Hauteur_de_la_base,$fn=64);    
        translate([0,0,Hauteur_de_la_base])
        cylinder(d1=Diametre_de_base_d_une_tour,d2=Diametre_d_une_tour_apres_raccord,h=Hauteur_du_raccord,$fn=64);
        translate([0,0,Hauteur_de_la_base+Hauteur_du_raccord])
        for(j=[0:Nombre_de_briques_verticalement_pour_une_tour-1])
        {
            translate([0,0,j*(Hauteur_des_briques+Taille_des_joints)])
            for(i=[1:Nombre_de_briques_horizontalement_pour_une_tour])
            {
                    if((j/2)==floor(j/2))
                    {
                        rotate([0,0,360/Nombre_de_briques_horizontalement_pour_une_tour*i])
                        brique(
                            aa=Diametre_d_une_tour_apres_raccord,
                            bb=Diametre_de_base_d_une_tour,
                            cc=Nombre_de_briques_horizontalement_pour_une_tour,
                            dd=Hauteur_des_briques,
                            ee=Taille_des_joints);
                    }
                    else
                    {
                        rotate([0,0,360/Nombre_de_briques_horizontalement_pour_une_tour*i+(360/Nombre_de_briques_horizontalement_pour_une_tour/2)])
                        brique(
                            aa=Diametre_d_une_tour_apres_raccord,
                            bb=Diametre_de_base_d_une_tour,
                            cc=Nombre_de_briques_horizontalement_pour_une_tour,
                            dd=Hauteur_des_briques,
                            ee=Taille_des_joints);                      
                    }
            }
        }
        translate([0,0,Hauteur_de_la_base+Hauteur_du_raccord+(Nombre_de_briques_verticalement_pour_une_tour*(Hauteur_des_briques+Taille_des_joints))])
        cylinder(d=Diametre_du_balcon,h=Hauteur_des_briques);

        difference()
        {
            translate([0,0,Hauteur_de_la_base+Hauteur_du_raccord+(Nombre_de_briques_verticalement_pour_une_tour*(Hauteur_des_briques+Taille_des_joints)+Hauteur_des_briques)])
            for(j=[0:Nombre_de_briques_verticalement_pour_le_balcon-1])
            {
                translate([0,0,j*(Hauteur_des_briques+Taille_des_joints)])
                for(i=[1:Nombre_de_briques_horizontalement_pour_une_tour])
                {
                    if((j/2)==floor(j/2))
                    {
                        if(j<Nombre_de_briques_verticalement_pour_le_balcon-1)
                        {
                            rotate([0,0,360/Nombre_de_briques_horizontalement_pour_une_tour*i])
                            brique(
                                aa=Diametre_du_balcon,
                                bb=Diametre_de_base_d_une_tour,
                                cc=Nombre_de_briques_horizontalement_pour_une_tour,
                                dd=Hauteur_des_briques,
                                ee=Taille_des_joints);
                        }
                        else
                        {
                            rotate([0,0,(360/Nombre_de_briques_horizontalement_pour_une_tour*i)*2])
                            brique(
                                aa=Diametre_du_balcon,
                                bb=Diametre_de_base_d_une_tour,
                                cc=Nombre_de_briques_horizontalement_pour_une_tour,
                                dd=Hauteur_des_briques,
                                ee=Taille_des_joints);
                        }
                    }
                    else
                    {
                        if(j<Nombre_de_briques_verticalement_pour_le_balcon-1)
                        {
                            rotate([0,0,360/Nombre_de_briques_horizontalement_pour_une_tour*i+(360/Nombre_de_briques_horizontalement_pour_une_tour/2)])
                            brique(
                                aa=Diametre_du_balcon,
                                bb=Diametre_de_base_d_une_tour,
                                cc=Nombre_de_briques_horizontalement_pour_une_tour,
                                dd=Hauteur_des_briques,
                                ee=Taille_des_joints);
                        }
                        else
                        {
                            rotate([0,0,720/Nombre_de_briques_horizontalement_pour_une_tour*i+(360/Nombre_de_briques_horizontalement_pour_une_tour/2)])
                            brique(
                                aa=Diametre_du_balcon,
                                bb=Diametre_de_base_d_une_tour,
                                cc=Nombre_de_briques_horizontalement_pour_une_tour,
                                dd=Hauteur_des_briques,
                                ee=Taille_des_joints);
                        }
                    }
                }
            }        
        translate([0,0,Hauteur_de_la_base+Hauteur_du_raccord+(Nombre_de_briques_verticalement_pour_une_tour*(Hauteur_des_briques+Taille_des_joints)+Hauteur_des_briques)])
        cylinder(d=Diametre_du_balcon-Hauteur_des_briques,h=((Hauteur_des_briques+Taille_des_joints)*Nombre_de_briques_verticalement_pour_le_balcon));
        
            
        }

        translate([0,0,TOUR_HP2])
        for(j=[0:Nombre_de_briques_verticalement_pour_partie_haute_de_la_tour-1])
        {
            translate([0,0,j*(Hauteur_des_briques+Taille_des_joints)])
            for(i=[1:Nombre_de_briques_horizontalement_pour_une_tour])
            {
                if((j/2)==floor(j/2))
                {
                    rotate([0,0,360/Nombre_de_briques_horizontalement_pour_une_tour*i])
                    brique(
                        aa=Diametre_partie_haute_de_la_tour,
                        bb=Diametre_de_base_d_une_tour,cc=Nombre_de_briques_horizontalement_pour_une_tour,
                        dd=Hauteur_des_briques,
                        ee=Taille_des_joints);
                }
                else
                {
                    rotate([0,0,360/Nombre_de_briques_horizontalement_pour_une_tour*i+(360/Nombre_de_briques_horizontalement_pour_une_tour/2)])
                    brique(
                        aa=Diametre_partie_haute_de_la_tour,
                        bb=Diametre_de_base_d_une_tour,
                        cc=Nombre_de_briques_horizontalement_pour_une_tour,
                        dd=Hauteur_des_briques,
                        ee=Taille_des_joints);                      
                }
            }
        }
    }

module HautRouge()
    {
        union(){translate([0,-Diametre_du_balcon/4,TOUR_HP2-Hauteur_des_briques])
        for(j=[0:Nombre_de_briques_verticalement_pour_le_balcon-1])
        {
            translate([0,0,(Hauteur_des_briques+Taille_des_joints)*j])
            
            if((j/2)==floor(j/2))
            {
                translate([0,(Largeur_des_briques_des_murs+Taille_des_joints)/2,0])
                for(i=[0:Nombre_de_briques_horizontalement_pour_les_murs-1])
                {
                    translate([-Diametre_du_balcon/2/2,i*(Largeur_des_briques_des_murs+Taille_des_joints),0])
                    cube([Diametre_du_balcon/2,Largeur_des_briques_des_murs,Hauteur_des_briques]);
                }
            }
            else
            {
                translate([-Diametre_du_balcon/2/2,(Largeur_des_briques_des_murs+Taille_des_joints),0])
                for(i=[0:Nombre_de_briques_horizontalement_pour_les_murs-1])
                {
                    translate([0,i*(Largeur_des_briques_des_murs+Taille_des_joints),0])
                    cube([Diametre_du_balcon/2,Largeur_des_briques_des_murs,Hauteur_des_briques]);
                }

            }
            
            


    }

}

   
}

module MonToit()
{
    cylinder(d1=Diametre_du_toit,d2=0,h=Hauteur_du_toit);
    translate([0,0,Hauteur_du_toit])
    sphere(d=10);
    
}