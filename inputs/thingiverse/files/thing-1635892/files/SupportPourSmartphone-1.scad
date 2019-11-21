/*

            _________________-----_________________
           /                 \___/                 \
          |     _______________________________     |
          | || |                               |    |
          | || | Support pour smartphone pour  |    |_
          |    | Fiat Punto v.sqrt(2)-1        |   |  |
          | || | Ecrit en OpenSCAD par         | <>|  |
          | || | Vanlindt Marc (c) 2016        |   |__|
          |    | CC-BY-SA - www.vanlindt.be    |    |
          | || | marc@vanlindt.be              |    |
          | || |_______________________________|    |
          |                  ___                    |
           \________________/   \__________________/
                            -----



*/

Modele_de_smartphone="Huawei SCL-L01"; //[Google Nexus 6, Huawei SCL-L01, HTC One,iPhone 4,iPhone 5, iPhone 6, OnePlus One, Samsung Galaxy S4, Samsung Galaxy S5, Sony XPeria Z3, custom]
Visualisation="paysage";//[paysage,portrait]
Trou_pour_alimentation="oui";//[oui,non]
Largeur_du_smartphone=100;
Longueur_du_smartphone=200;
Epaisseur_du_smartphone=10;
Epaisseur_du_support=5; //[2:15]

ObjetFinal();




module ObjetFinal(){
modele=
[
    ["Huawei SCL-L01",72,143,10],
    ["iPhone 4",58.6,115.2,9.3],
    ["iPhone 5",58.6,123.8,7.6],
    ["iPhone 6",67,138.1,6.9],
    ["HTC One",70.6,146.4,9.4],
    ["Samsung Galaxy S4",69.8,136.6,7.9],
    ["Samsung Galaxy S5",72.5,142,8.1],
    ["Sony XPeria Z3",72,146,7.3],
    ["OnePlus One",75.9,152.9,8.9],
    ["Google Nexus 6",83,159.3,10.1],
    
    ["custom",Largeur_du_smartphone,Longueur_du_smartphone,Epaisseur_du_smartphone]    
];
        for(i=[0:len(modele)])
        {
            if (Modele_de_smartphone==modele[i][0]&&Visualisation=="paysage"){
            ToutLeSupport(LASM=modele[i][1],LOSM=modele[i][2],HASM=modele[i][3]);}
        
            if (Modele_de_smartphone==modele[i][0]&&Visualisation=="portrait"){
            ToutLeSupport(LASM=modele[i][2],LOSM=modele[i][1],HASM=modele[i][3]);}        
        }
      

}


module ToutLeSupport()
{
    union()
    {
        accroches();
        support(LASM=LASM,LOSM=LOSM,HASM=HASM);
    }    
}

module support()
{ 
union()
    {
    difference()
    {
        union()
        {
    
            if(Trou_pour_alimentation=="oui"&&Visualisation=="portrait")
            {
                translate([0,10,HASM/2+Epaisseur_du_support])
                cube([LASM+Epaisseur_du_support*2,20+Epaisseur_du_support*2,HASM+Epaisseur_du_support*2],center=true);

                translate([0,(LOSM/2+Epaisseur_du_support)/2,HASM/2+Epaisseur_du_support])
                cube([20,LOSM/2+Epaisseur_du_support,HASM+Epaisseur_du_support*2],center=true);} 
            
            if(Trou_pour_alimentation=="oui"&&Visualisation=="paysage")
            {
                translate([0,10,HASM/2+Epaisseur_du_support])
                cube([LASM+Epaisseur_du_support*2,20,HASM+Epaisseur_du_support*2],center=true);
                                
                translate([0,(LOSM/2+Epaisseur_du_support)/2,HASM/2+Epaisseur_du_support])
                cube([20+20,LOSM/2+Epaisseur_du_support,HASM+Epaisseur_du_support*2],center=true);} 
            
            if(Trou_pour_alimentation=="non")
                { translate([0,10,HASM/2+Epaisseur_du_support])
                cube([LASM+Epaisseur_du_support*2,20,HASM+Epaisseur_du_support*2],center=true);
                    
                    translate([0,(LOSM/2+Epaisseur_du_support)/2,HASM/2+Epaisseur_du_support])
                cube([20,LOSM/2+Epaisseur_du_support,HASM+Epaisseur_du_support*2],center=true);}

        }
        union()
        {
            translate([0,0,HASM/2+Epaisseur_du_support])
            cube([LASM,LOSM,HASM],center=true);
    
            translate([0,0,HASM+Epaisseur_du_support*2])
            cube([LASM-Epaisseur_du_support*2,LOSM-Epaisseur_du_support*2,HASM+Epaisseur_du_support*2],center=true);

            if(Trou_pour_alimentation=="oui" && Visualisation=="paysage")
            {
                translate([0,0,(HASM/2+Epaisseur_du_support)])
                cube([20,LOSM*2,HASM],center=true);
            }
            if(Trou_pour_alimentation=="oui" && Visualisation=="portrait")
            {
                
                translate([0,20/2,(HASM/2+Epaisseur_du_support)])
                rotate([0,0,90])
                cube([20,LOSM*4,HASM],center=true);
            }



        }
        if(Visualisation=="paysage")
        {
            signature(aa=2,oo=0,t=LOSM/2*20/42);
        }
        else
        {
            
            translate([LASM/5,20/2,0])
            rotate([0,0,90])
            signature(aa=2,oo=0,t=LASM/2*20/42);
        }

    }

    if(Visualisation=="paysage")
    {
        signature(aa=3,oo=0,t=LOSM/2*20/42);
    }
    else
    {
        translate([LASM/5,20/2,0])
        rotate([0,0,90])
        signature(aa=3,oo=0,t=LASM/2*20/42);}
    }

}












module accroches()
{
    rotate([0,0,180])
    translate([0,0,-31])
    {
        translate([-2,-13,0])
        accroche();
        translate([-2,-13-23,0])
        accroche();
    }
}
module accroche()
{
    union()
    {
        cube([4,13,30]);

        translate([0,0,1])
        rotate([-90,0,0])
        cylinder(d=2,h=13,$fn=16);

        translate([-6,13,25])
        rotate([90,0,0])
        linear_extrude(13)
        offset(-4)
        offset(4)
        square([15,7]);
    }
}

module signature(oo)
{
    rotate([0,0,90])
    translate([10,0,Epaisseur_du_support-aa])
    linear_extrude(height=aa)
    offset(oo)

    resize([t,t/4.2])
    {text("www.vanlindt.be");
    translate([0,-12,0])
    text("CC-BY-SA");
    }
}