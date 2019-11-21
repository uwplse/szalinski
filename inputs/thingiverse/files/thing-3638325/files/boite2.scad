//boite pour batterie et objectif lumix


$fn = 128;
tol = 0.1;
tol2 = 0.2;
lg_1 = 47;
lg_2 = 64.0;
lg_3 = 65-0.4;
x4 = 176;
y4 = 106; 
d_obj = 55.6;
z4 = d_obj+2;
z5 = 5;
angle = 0.0;
    
//color("red") matos(4,95,z4-0.1);
fond(0,0,0);

//pour imprimer en 2 parties
//rotate([90,0,0])
//{
capot(0,0,z4+0.2,lg_1);
capot(lg_1+0.2,0,z4+0.2,lg_2);
capot(lg_1+lg_2+0.4,0,z4+0.2,lg_3);
//}

module capot(x,y,z,lr)
{
    
    translate([x,y,z])
    {
     union()
     {
        charniere(0,0,0,lr+0.1);
        translate([0,z5,0])
        rotate([90-angle,0,0])
        translate([0,z5+1,0])
        difference()
         {
             cube([lr,y4-2*z5-1,z5]);
             aimant(lr*0.5,y4-4-2*z5,-0.08);
         }
     }
    }
}
module trou_capot(x,y,z,lr)
{
    translate([x-tol-0.5,y-1,z-5.2])
    {
        cube([lr+1+2*tol,z5+1,6]);
    }
}

module charniere(x,y,z,lr)
{
    include <hinge.scad>
    
    hinge_width = 30;
    leaf_height = lr;
    leaf_gauge = z5;
    knuckle_gusset_type = 0;
    throw_angle = angle;
    //component_color = "none";
    
    translate([x+leaf_height*0.5,y+leaf_gauge,z])
    rotate([180,-90,90])
    {
     rotate ( [ 0.0, 0.0, ( m_flip_model ) ? 180.0 : 0.0 ] )
    {
        if ( m_female_leaf_enabled ) rotate ( [ 0.0, -m_throw_angle, 0.0 ] ) leaf ( C_FEMALE );
        if ( m_male_leaf_enabled )   leaf ( C_MALE );     
    }   
    }
}

module fond(x,y,z)
{
    creu = 15;    
    
    translate([x,y,z])
    {
        difference()
        {
        cube([x4,y4,z4]);
        union()
            {
            matos(4,95,z4);
            translate([5,6,z4-creu])
            cube([x4-10,y4-12,creu+0.1]);
            
            //cylindre pour la charnière
            translate([-0.5,5,z4+0.3])
            rotate([0,90,0])
            cylinder(x4+1,z5+0.3,z5+0.3);
            
            //trou pour les aimants
            aimant(lg_1*0.5,y4-3,z4-1.7);
            aimant(lg_1+0.2+lg_2*0.5,y4-3,z4-1.7);
            aimant(lg_1+0.2+lg_2+0.2+lg_3*0.5,y4-3,z4-1.7);
            
            
            //si on imprrime en 2 modules séparés à coller :
            trou_capot(0,0,z4+0.2,lg_1);
trou_capot(lg_1+0.2,0,z4+0.2,lg_2);
trou_capot(lg_1+lg_2+0.4,0,z4+0.2,lg_3);
        }
        }
    }
}

module matos(x,y,z)
{
    translate([x,y,z])
    rotate([180,0,0])
    {
        batterie(28,2,2);

        batterie(28,45,2);
        
        cables(3,2,0);

        chargeur(47,0,1);

        objectif(139,10,0);
        
        doigt(100, 62,20,10);
        carte_SD(103,50,4);
        
        doigt(100, 17,20,10);
        carte_SD(103,5,4);
        
        //marques de doigts pour prendre les batteries
        doigt(44,62,20,10);
        doigt(44,17,20,10);
        doigt(26,62,20,10);
        doigt(26,17,20,10);
        
        
        //marques des doigts pour prendre l'objectif
        doigt(140,10,40,38);
        doigt(140,74,40,38);
        
    }
}

module batterie(x,y,z)
{
    x1 = 37.2+tol;
    y1 = 14.2+tol;
    z1 = 42.25;
    
    translate([x,y,z])
    {
        cube([y1,x1,z1]);
    }
}

module chargeur(x,y,z)
{
    x2 = 54.2+tol2;
    y2 = 85.2+tol2;
    z2 = z4-4;    //23;
    
    translate([x,y,z])
    {
        cube([x2,y2,z2]);
        
    }
}

module objectif(x,y,z)
{
    lg = 64+tol2;
    r = (d_obj*0.5)+tol2;
    
    translate([x,y,z+r])
    {
        union()
        {
        rotate([-90,0,0])
        cylinder(lg,r,r);
        translate([-r,0,-r])
        cube([r*2,lg,r]);
        }
    }
}

module cables(x,y,z)
{
    x3 = 20;
    y3 = 80;
    z3 = 55;
    
    translate([x,y,z])
    {
        cube([x3,y3,z3]);
    }
}


module doigt(x,y,z,ht)
{
    r2 = 17*0.5;
        
    translate([x,y,z])
    {
        rotate([180,0,0])
        union()
        cylinder(ht,r2,r2);
        sphere(r2);
        
    }
}

module carte_SD(x,y,z)
{
    x5 = 2.2+tol2;
    y5 = 24+tol2;
    z5 = 32;
    
    translate([x,y,z])
    {
        cube([x5,y5,z5]);
    }
}

module aimant(x,y,z)
{
    da = 4.4;
    ra = da*0.5;
    epa = 1.78;
    
    translate([x,y,z])
    {
        rotate([0,0,0])
        cylinder(epa,ra,ra);
    }
}

    

