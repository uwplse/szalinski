$fn=100;
target_size=50;
target_thickness=2;
spike_length=60;
spike_bottom_thickness=.5; //the point of spike
difference()
{
union()
{
cylinder(r1=target_size,r2=target_size/1.1,h=target_thickness);
rotate([90,0,90])translate([0,0,target_size-10])cylinder(r1=target_thickness*2.5,r2=spike_bottom_thickness,h=spike_length);
translate([target_size-10,0,0])sphere(r=target_thickness*2.5);
}
translate([-100,-100,-100.1])cube([1000,1000,100]);//IGNORE THIS this is just to cut the spike in half and make it printable
}

