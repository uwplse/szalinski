// by Les Hall

length = 50;
width = 0.7*length;
step = 0.1;
max = 100;


translate([0, -length/4, 0])
styx(length);
rotate(90, [0, 0, 1])
styx(width);

module styx(length=100)
{
	for(i=[max/2:max-1])
	assign(delta=i*step)
	cube([step+delta, length+delta, max*step-delta], center=true);
}


