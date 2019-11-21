// Parametric screw by carlgval

// Exercise of OpenSCAD: a single configurable screw

echo(version=version());

pitch_radius = 10;
length = 30;
head_radius_1 = 20;
head_radius_2 = 15;
head_depth = 5;

threads = 3;
thread_width_multiplier = 1;

minor_radius = pitch_radius * 0.9;
mayor_radius = pitch_radius * 1.1;

turns_per_mm = 0.2;

color("gray")
difference(){
        rotate_extrude()
            polygon( points=[[0,0],[head_radius_1,0],[head_radius_2,head_depth],[0,head_depth]]);
linear_extrude(3)
union(){
    square([head_radius_1 * 1.5, head_radius_1 * 0.1], center = true);
    rotate(90)
    square([head_radius_1 * 1.5, head_radius_1 * 0.1], center = true);}; };   
            
twist = turns_per_mm * 360 * length;
angle_spacing = 360 / threads;
threads_width = 1 / threads / 2 * (2 * 3.141592 * pitch_radius) * thread_width_multiplier;
    
color("gray")
        translate([0, 0, head_depth])
                linear_extrude(height = length, twist = twist, $fn=50)
                intersection() {
                    union(){
                        circle(minor_radius);
                        for (i = [0:angle_spacing:360]){
                            rotate(i)
                            translate([-threads_width/2,0,0])
                            square([threads_width, mayor_radius]);}; } ;
                    circle(mayor_radius); };

