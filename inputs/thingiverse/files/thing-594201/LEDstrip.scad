number_of_Leds = 8;

module LED()
{
    cylinder(r=2.95, h=1, $fn=24);
    hull()
    {
    translate([0,0,1])cylinder(r=2.5, h=5.1, $fn=24);
    translate([0,0,6.1])sphere(r=2.5, $fn=24);
    }
}

render(10)
difference()
{
    union(){
        translate([0,-4,0])cube([15*number_of_Leds+15,8,5]);
        translate([0,-4,0])cube([10,8,10]);
        translate([15*number_of_Leds+5,-4,0])cube([10,8,10]);
    }
    for (x=[1:number_of_Leds])
    {
        translate([15*x,0,0])LED();
    }
    translate([0,-1.5,0])cube([15*number_of_Leds+20,3,2]);
    
    //screwholes
    translate([5,5,5])rotate([90,0,0])cylinder(r=1.8,h=10);
    translate([15*number_of_Leds + 10,5,5])rotate([90,0,0])cylinder(r=1.8,h=10);
}
