
// How big should the sphere be the bowl is made from
sphere_diameter = 50; // [ 15 : 500 ]

// How tall should the bowl be from that sphere
bowl_height = 8; // [ 3 : 200 ]

// How thick do you want the bowl to be
bowl_thick = 2; // [ 1 : 15 ]

// How tall should the spikes be
spike_height = 25; // [ 3 : 50 ]

// What's the diameter of the contact pad
spike_tip_diameter = 0.5; // [ 0.1 : 10 ]

// How many rings of spikes
spike_rings = 3; // [ 2 : 10 ]

// How many spikes in each ring (always 1 in center)
spike_ring_count = [1, 4, 8];

echo("Sphere Diameter: ", sphere_diameter);
echo("Bowl Height: ", bowl_height);
echo("Bowl Thick: ", bowl_thick);
echo("Spike Height: ", spike_height);
echo("Spike Tip Diameter: ", spike_tip_diameter);

$fn = 64; // faces/facets

// https://math.stackexchange.com/questions/753880/sphere-plane-intersection-circle-radius
// Do some math -- distance between center and our slice plane
math_R = (sphere_diameter / 2); // Radius
math_d = math_R - bowl_height; // Distance from center of sphere to nearest plane point
bowl_diameter = sqrt(pow(math_R,2) - pow(math_d,2));
echo("Bowl diameter = ", bowl_diameter);

//spikes();
bowl();

function random(min, max) = round(rands(min, max, 1)[0]);

// create the bowl
module bowl()
{
    difference()
    {
        translate([0,0,-((sphere_diameter/2)-(bowl_height))])   
            difference()
            {
                union()
                {
                    sphere(d = sphere_diameter); 
                    translate([0,0,((sphere_diameter/2)-(bowl_height))])   
                        spikes();
                }
                sphere(d = sphere_diameter - bowl_thick);
            }
        translate([-sphere_diameter/2, -sphere_diameter/2, -sphere_diameter])
            cube(size = sphere_diameter);   
    }
}

// create the spikes
module spikes()
{
    spike_diameter = bowl_diameter / spike_rings;
    echo("Spike diameter = ", spike_diameter);
    union() {
        for (i=[0 : 1 : spike_rings-1])
        {
            for (j=[1 : 1 : spike_ring_count[i]])
            {
                dist_from_center = i * spike_diameter;
                degree_rotation = 360 / spike_ring_count[i];
                rotate(a = (degree_rotation * j))
                    translate([i*spike_diameter,0,0])
                        cylinder(h = spike_height, d1=spike_diameter, d2=spike_tip_diameter);
            }
        }
    }
}