Knob_thickness=7; //[1:1:30]
Knob_radius=7; //[1:1:30]
Center_hole_radius=1.7; //[0.1:0.1:15]
Nut_cave_radius=6.4;     // [0.1:0.1:15]
Nut_cave_height=4;     // [1:0.5:30]
Spikes_number=12; //[0:1:200]
Spike_width_internal=5; //[0.1:0.5:30]
Spike_width_external=2; //[0.1:0.5:30]
Spike_length=10; //[1:1:50]
Spikes_twist=0; //[0:1:30]



difference()
    {
    union()
        {
        translate([0,0,0])
         rotate([0,0,0])
          linear_extrude(Knob_thickness)
            {
            circle(Knob_radius,$fn=36);
            for(k=[0:1:Spikes_number])
                {
                rotate([0,0,360/Spikes_number*k])
                polygon(points=[[Spikes_twist/2,Spike_width_internal/2],[Spike_length,Spike_width_external/2+Spikes_twist],[Spike_length,-Spike_width_external/2+Spikes_twist],[Spikes_twist/2,-Spike_width_internal/2]]);
                }
            }
        translate([0,0,Knob_thickness])
        cylinder(r=Nut_cave_radius,h=1,$fn=36);
        }
    translate([0,0,-0.1])
    cylinder(r=Nut_cave_radius,h=Nut_cave_height,$fn=6);
    cylinder(r=Center_hole_radius,h=Knob_thickness*2,$fn=36);
    }

