mi=3;
ta=100;
mt1=sqrt(2)-1;
mt2=1-(2*mt1);

toto(it=1,taille=ta);


module toto()
{
union()
    {
    if(it==mi)
    {

    cube([taille,taille,taille],center=true);
    }
    
    if(it<=mi)
    {
        translate([taille/2,taille/2,taille/2])
        translate([-taille/2*mt1,-taille/2*mt1,-taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);

        translate([-taille/2,taille/2,taille/2])
        translate([taille/2*mt1,-taille/2*mt1,-taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);

        translate([taille/2,-taille/2,taille/2])
        translate([-taille/2*mt1,taille/2*mt1,-taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);

        translate([-taille/2,-taille/2,taille/2])
        translate([taille/2*mt1,taille/2*mt1,-taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);

        translate([taille/2,taille/2,-taille/2])
        translate([-taille/2*mt1,-taille/2*mt1,taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);

        translate([-taille/2,taille/2,-taille/2])
        translate([taille/2*mt1,-taille/2*mt1,taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);

        translate([taille/2,-taille/2,-taille/2])
        translate([-taille/2*mt1,taille/2*mt1,taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);

        translate([-taille/2,-taille/2,-taille/2])
        translate([taille/2*mt1,taille/2*mt1,taille/2*mt1])
        toto(it=it+1,taille=taille*mt1);


        translate([-taille/2,-taille/2,0])
        translate([taille/2*mt2,taille/2*mt2,0])
        toto(it=it+1,taille=taille*mt2);

        translate([-taille/2,taille/2,0])
        translate([taille/2*mt2,-taille/2*mt2,0])
        toto(it=it+1,taille=taille*mt2);

        translate([taille/2,-taille/2,0])
        translate([-taille/2*mt2,taille/2*mt2,0])
        toto(it=it+1,taille=taille*mt2);

        translate([taille/2,taille/2,0])
        translate([-taille/2*mt2,-taille/2*mt2,0])
        toto(it=it+1,taille=taille*mt2);

        translate([-taille/2,0,-taille/2])
        translate([taille/2*mt2,0,taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);

        translate([-taille/2,0,taille/2])
        translate([taille/2*mt2,0,-taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);

        translate([taille/2,0,-taille/2])
        translate([-taille/2*mt2,0,taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);

        translate([taille/2,0,taille/2])
        translate([-taille/2*mt2,0,-taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);

        translate([0,-taille/2,-taille/2])
        translate([0,taille/2*mt2,taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);

        translate([0,-taille/2,taille/2])
        translate([0,taille/2*mt2,-taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);

        translate([0,taille/2,-taille/2])
        translate([0,-taille/2*mt2,taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);

        translate([0,taille/2,taille/2])
        translate([0,-taille/2*mt2,-taille/2*mt2])
        toto(it=it+1,taille=taille*mt2);


    }
}
}