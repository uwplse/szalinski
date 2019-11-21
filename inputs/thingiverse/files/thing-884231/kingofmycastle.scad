taille=15;
IterMax=2;

toto(it=1,mit=IterMax);


module toto()
{
    difference()
    {
        cylinder(r=taille,$fn=6,h=taille/2);
        
        for(i=[1:3])
        {
            rotate([0,0,i*60])
            hull()
            {
                rotate([90,0,00])
                translate([0,0,0])
                cylinder(r=taille/8,h=taille*4,$fn=32,center=true);

                rotate([90,0,00])
                translate([0,taille/3,0])    
                cylinder(r=taille/8,h=taille*4,$fn=32,center=true);
            }
        }
    cylinder(r=taille-taille/10,$fn=6,h=taille/2-taille/20);

    }
    if(it<=mit)
    {
        for(i=[1:6])
        {
            rotate([00,00,i*360/6])
            translate([taille/1.5,0,taille/2])
            scale(2/6,2/6,1/2)
            rotate([0,0,0])
            toto(it=it+1,mit=mit);
        }
        
        intersection()
        {
        union()
        {
            translate([0,0,taille/2])
            rotate([0,0,30])
            cylinder(r=taille/1.75,$fn=3,h=taille*1.5);

            translate([0,0,taille/2])
            rotate([0,0,90])
            cylinder(r=taille/1.75,$fn=3,h=taille*1.5);
        }
        hull()
        {
            translate([0,0,taille*1.5])
            sphere(r=taille/2,$fn=6);
            translate([0,0,taille/2])
            sphere(r=taille/2,$fn=6);
        }
        
        
    }
    }
}