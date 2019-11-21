do = 11;

d1 = 8.75;
d2 = 7.0;
l = 10;

$fn = 50;

intersection(){
difference(){
    cylinder(d = do, h = l * 2, center=true);

    cylinder(d = d1, h = l);

    mirror([0,0,1])    
        cylinder(d = d2, h = l);
}

translate([0,do/3,0])
    cube(size=[do,do,l*2], center=true);
}