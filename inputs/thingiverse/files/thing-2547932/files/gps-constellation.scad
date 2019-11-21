module orbit_plane(inc,ra,arg)
{
    rad=50;
    rotate([0,0,ra]) rotate([inc,0,0]) rotate([0,0,arg])
    {        
        linear_extrude(height = 0.8) circle(rad,$fn=100);
        translate([rad*cos(0),rad*sin(0),0]) sphere(r=5);
        translate([rad*cos(30),rad*sin(30),0]) sphere(r=5);
        translate([rad*cos(135),rad*sin(135),0]) sphere(r=5);
        translate([rad*cos(255),rad*sin(255),0]) sphere(r=5);
    }
}

sphere(r=10);
translate([0,0,-.2]) linear_extrude(height = 0.4) circle(11,$fn=100);
orbit_plane(55,0);
orbit_plane(55,60,0);
orbit_plane(55,120,0);
orbit_plane(55,180,0);
orbit_plane(55,240,0);
orbit_plane(55,300,0);
