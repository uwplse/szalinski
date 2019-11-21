hammer_head_diameter = 26;
hammer_head_length = 15;
wall_thickness = 2; // [0:0.1:5]
spike_length = 3.4; // [0:0.1:10]
spikes_per_circle = 12; // [4:20]

/* [Hidden] */
item_diameter = hammer_head_diameter+wall_thickness*2;
$fn=128;

// Hammer base
translate([0,0,-hammer_head_length-wall_thickness])
    difference(){
        cylinder(d=item_diameter, h=hammer_head_length+wall_thickness);
        cylinder(d1=hammer_head_diameter*.95, d2=hammer_head_diameter, h=hammer_head_length*2, center=true);
        for (i=[1:3]) 
            rotate([0,0,i*(360/3)])
                cube([wall_thickness*2, hammer_head_diameter*2, hammer_head_length*2], center=true);
}

module spike(size) { cylinder(r1=size, r2=0, h=size, $fn=4); }

// Central spike
spike(spike_length);

// Inner spike circle, if there's a place for it
if (item_diameter > spike_length*8.5)
    for (i=[0:spikes_per_circle/2]) 
        rotate([0,0,i*(360/spikes_per_circle*2)])
            translate([item_diameter/4-spike_length/2,0,0])
                rotate([0,0,-i*(360/spikes_per_circle*2)])
                    spike(spike_length);

// Outer spike circle
for (i=[0:spikes_per_circle]) 
    rotate([0,0,i*(360/spikes_per_circle)])
        translate([item_diameter/2-spike_length, 0, 0])
            rotate([0,0,-i*(360/spikes_per_circle)])
                spike(spike_length);

