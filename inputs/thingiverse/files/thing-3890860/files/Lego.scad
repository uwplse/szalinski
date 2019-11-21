// Length of Lego
a = 150;

// Number of pegs across
b = 5;

cube([a,a/2.5,a/6], center = true);

for ( i =[0:b-1])
{
    translate([(-(a/2)+(a/10)+((a/b)*i)), a/10, a/12]) cylinder(a/15, a/25, a/24
    , center = true);
    translate([(-(a/2)+(a/10)+((a/b)*i)), -a/10, a/12])cylinder (a/15, a/25, a/24, center = true);
}


    

