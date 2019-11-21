module fin() {
rotate(a = [-90,0,0])
linear_extrude(height = 10, scale = 0)
translate([0,-5,0])
square([1,10], center = true);
}

module booster() {
linear_extrude(height = 10)
circle(r = 1);

translate([0,0,10])
linear_extrude(height = 2, scale = 0)
circle(r = 1);
}

module rocket() {
fin();

rotate(a = [0,0,-90])
fin();

rotate(a = [0,0,180])
fin();

rotate(a = [0,0,90])
fin();

color("green",0.5)
linear_extrude(height = 10)
circle(r = 3);

color("red",0.5)
translate([0,0,10])
linear_extrude(height = 5, scale = .9)
circle(r = 3);

color("blue",0.5)
translate([0,0,15])
linear_extrude(height = 10)
circle(r = 2.7);

color("black",0.5)
translate([0,0,25])
linear_extrude(height = 5, scale = 0)
circle(r = 2.7);

translate([2.5,2.5,5])
booster();

translate([-2.5,-2.5,5])
booster();
}

color("white")
square([220,220], center = true);

for (y = [-100 : 20 : 100])
{

for (x = [-100 : 20 : 100])
{
translate([x,y,rands(0,25,1)[0]])
rocket();
}
}