// 10in by 8 in

//25.4 x 20.32 cm  

// 32.5 cm at most diagonal

thickness=3;
height=20;
size=300;

difference()
{
hull()
{
translate([(size/2)-height,0,0])
cylinder(r=height/2 , h=thickness);

translate([(-size/2)+height,0,0])
cylinder(r=height/2 , h=thickness);
}

//center hole
translate([0,0,-1])
cylinder(r=3.5, h=thickness*2);

for(i=[-13:13])
{
    translate([i*10,0,-1])
   cylinder(r=3.5, h=thickness*2);
}
}