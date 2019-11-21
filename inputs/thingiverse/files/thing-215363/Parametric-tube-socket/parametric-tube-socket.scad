pin_ring_diameter=17;
pin_size=1.75;
pin_count=22;
height=7;

difference()
{
cylinder(r=(pin_ring_diameter/2)+(2*(pin_size/2)),h=height,$fn=64);

cylinder(r=(pin_ring_diameter/2)-(2*(pin_size/2)),h=height+1,$fn=64);

for (i=[0:(360/pin_count):360])
{
	rotate([0,0,i])
	translate([(pin_ring_diameter/2),0,0])
	cylinder(r=(pin_size/2),h=height+1, $fn=16);
}

}