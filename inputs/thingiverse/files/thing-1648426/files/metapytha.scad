max_iteration=3;
taille=20;
taille2=40;
visco=30;
qual=64;
angle1=45;//[0:360]
angle2=45;//[0:360]
toto(it=1,mit=max_iteration);

module toto()
{
    union()
    {
    branche();
    if(it<=mit)
    {
        translate([0,0,taille2])
        scale([sqrt(0.5),sqrt(0.5),sqrt(0.5)])
        rotate([angle1,0,angle2])
        toto(it=it+1,mit=mit);

        translate([0,0,taille2])
        scale([sqrt(0.5),sqrt(0.5),sqrt(0.5)])
        rotate([-angle1,0,angle2])
        toto(it=it+1,mit=mit);        
    }
}
    
}



module branche()
{
    rotate_extrude($fn=qual)
    difference()
    {
        offset(-visco,$fn=qual*2)
        {
            offset(visco,$fn=qual*2)
            {
                circle(d=taille,$fn=qual);
                translate([0,taille2,0])
                circle(d=sqrt(0.5)*taille,$fn=qual);
            }
        }
    translate([0,-(taille2*2+2*taille)/2,0])
    square([taille*2,taille2*2+2*taille]);
    }
}