// Customisable E3D Titan Motor Spacer Plate

// Thickness of spacer plate
thickness = 2; // [1,1.5,2,2.5,3,3.5,4,5,6,7]

// Overall width of motor
nema_width = 42.3;

// Spacing between M3 holes
nema_hole_spacing = 31;

// Clearance hole size for M3
nema_hole_size = 3.5;

// Clearance hole for motor boss
nema_boss_size = 27;


chamfer = (nema_width - 34)/2;
H = pow(2 * pow(nema_width/2,2), 1/2);
h = chamfer * pow(2, 1/2) / 2;
x = (H - h) * 2;
echo(x);

difference(){
    intersection(){
        cube(size = [nema_width, nema_width, thickness], center = true);

        rotate([0,0,45]) cube(size = [x, x, thickness], center = true);
    }


    for (x = [-0.5:1:0.5])
    for (y = [-0.5:1:0.5])
    translate([x * nema_hole_spacing, 
               y * nema_hole_spacing, 
               0])
        cylinder(h = thickness * 2, 
                 r = nema_hole_size / 2, 
                 center = true,
                 $fn=150);
    cylinder(h = thickness * 2,
             r = nema_boss_size / 2, 
             center = true,
             $fn = 250);
        
}