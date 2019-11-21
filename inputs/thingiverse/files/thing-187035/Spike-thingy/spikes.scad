// Diameter of center sphere
diameter = 30; // [10:100]
spikes = 200; // [100:500]
spike_length = 60; // [10:150]
entropy = 10; // [0:10]

sphere(diameter);

range = entropy/10 * (spike_length - diameter) / 2;
length_diffs = rands(-range, range, spikes);
union() {
	for(i = [0: spikes]) {
		rotate(rands(0,360,3)) cylinder(spike_length + length_diffs[i],2,false);
		rotate(rands(0,360,3)) cylinder(spike_length + length_diffs[i],2,false);
	}
}
