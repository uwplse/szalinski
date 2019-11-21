d_egg=45; // [40:1:50]
l_egg=66; // [60:1:70]
wall=2;   // [1:0.2:3]
gap=2;    // [1:0.2:3]
upper=0.6;// [0.5:0.1:0.7]
choice=3;    // [1:cup, 2:lid, 3:both]

$fn=72;

//egg();
//egg_cup();
//egg_top();
//stand(d_egg);
main();

module main()
{
    if(choice==1)
        egg_cup();
    
    if(choice==2)
        egg_top();
    
    if(choice==3)
    {
        translate([2*d_egg,0,(l_egg+2*wall+gap)*(1-upper)+3.5]) egg_cup();
        egg_top();
    }
    
}

module egg(delta=0)
{
    intersection()
    {
        translate([0,0,(l_egg+delta)*0.05]) resize([(d_egg+delta),(d_egg+delta),(l_egg+delta)*0.9*upper*2]) sphere(d=1);
        cylinder(d=(d_egg+delta), h=(l_egg+delta));
    }
    cylinder(d=(d_egg+delta),h=(l_egg+delta)*0.05);
    resize([(d_egg+delta),(d_egg+delta),(l_egg+delta)*(1-upper)*2]) sphere(d=1);
}

module egg_cup()
{
    d_cup=d_egg+2*wall+gap;
    difference()
    {
        egg(delta=2*wall+gap);
        translate([0,0,10*0.75]) cylinder(d=d_cup+1, h=d_cup);
        egg(delta=-1*gap);
        cylinder(d=d_egg+gap, h=10);
        translate([0,0,-gap]) cylinder(d1=d_egg-gap, d2=d_egg+gap, h=gap);
        for(a=[0:30:180])
            translate([0,0,10*0.75]) rotate([45,0,a]) cube([2*d_egg+1,10,10], center=true);
    }
    translate([0,0,-(l_egg+2*wall+gap)*(1-upper)-3.5]) stand(d_egg);
}

module stand(d_stand)
{
    intersection()
    {
        translate([0,0,-wall])
        minkowski()
        {
            cylinder(d=d_stand-2*wall, h=wall);
            sphere(wall);
        }
        cylinder(d=d_stand, h=wall);
    }
    translate([0,0,wall])
    rotate_extrude()
    difference()
    {
        square([10,3.5]);
        translate([10,2]) scale([0.8,1]) circle(d=4);
    }
}

module egg_top()
{
    d_cup_top=d_egg+2*wall+gap-0.2;
    difference()
    {
        egg(delta=2*wall+gap);
        egg(gap);
        egg_cup();
        //cylinder(d=d_egg, h=10);
    }
}