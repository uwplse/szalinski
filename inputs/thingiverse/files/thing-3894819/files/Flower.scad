//flower center
r=12;
//petal length
x=145;
//petal width
y=25;
//# of petals
z=15;
//number of layers
l=4;

//DO NOT CHANGE UNLESS YOU ARE OK WITH FLOATING PETALS OR ADDING SUPPORTS TO DESIGN
//petal angle
a=5;
module makeFlowerBase()
{
    //flower center
    difference()
    {
        sphere(r);
        translate([0,0,-r]){cube([2*r,2*r,2*r],center=true);}
    }
    //add flat petals
    for(i=[0:z])
    {
        rotate([0,0,(360*i)/z])
        {
            difference()
            {   
                cube([x,y,1],center=false);
                translate([x-y,-y/2,-1]){makePetalMold();}
            }        
        }
        
    }
}
module makePetalMold()
{
    difference()
    {   
        cube([2*y,2*y,15]);
        translate([0,y,-1]){scale([2,1,10]){cylinder(15,y/2,y/2);}}
    }
}
module makePetals()
{
    for(j=[0:l-1])
    {
        x = x-(j*x*.15);
        for(i=[0:z])
        {
            rotate([j*a,-j*a,((360*i)+90*j)/z])
            {
                difference()
                {   
                    translate([0,0,-2*j]){cube([x,y,2.5*j],center=false);}
                    translate([x-y,-y/2,-10]){makePetalMold();}
                }
            }
            
        }
    }
}
module makeFlower()
{
    makeFlowerBase();
    
    difference()
    {
        makePetals();
        translate([0,0,-50]){cube([2*x,2*x,100],center=true);}
    }
}
makeFlower();