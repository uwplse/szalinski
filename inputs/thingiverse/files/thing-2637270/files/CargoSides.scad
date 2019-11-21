//MagCargoHolders
dim_x = 45;
dim_y = 125;
dim_z = 60;
wall_thick = 3;
base_thick = 3;
cutout_x = dim_x;
cutout_y = 40;
cutout_z = 10;
mag_diameter = 32.5;
mag_floor_thick = 0.6;
//
difference()
    {
    linear_extrude(height = dim_z) //inside wall
            square([wall_thick, dim_y]);
    translate([-0.001,dim_y/2-cutout_y/2,-0.001])
        linear_extrude(height=cutout_z+0.001)
        square([cutout_x,cutout_y]);
    }
difference()
    {
    linear_extrude(height = base_thick) // bottom
        square([dim_x, dim_y]);
      translate([-0.001, dim_y/2-cutout_y/2, -0.001])
          linear_extrude(height=cutout_z+0.002)
          square([cutout_x+0.002,cutout_y]);
      translate([mag_diameter/2+2*wall_thick, mag_diameter/2+2*wall_thick,mag_floor_thick])
          cylinder(h = base_thick+0.001,d=mag_diameter);
      translate([mag_diameter/2+2*wall_thick, dim_y-mag_diameter/2-2*wall_thick,mag_floor_thick])
          cylinder(h = base_thick+0.001,d=mag_diameter);
    }
translate([0,wall_thick,0]){
rotate([90,0,0])
linear_extrude(height = base_thick)
    translate([wall_thick,wall_thick,0])
    polygon(points = [[dim_x-wall_thick, 0],[0,dim_z-base_thick],[0,0]]);}
mirror([0,1,0]) translate([0,-dim_y,0])
translate([0,wall_thick,0]){
rotate([90,0,0])
linear_extrude(height = base_thick)
    translate([wall_thick,wall_thick,0])
    polygon(points = [[dim_x-wall_thick, 0],[0,dim_z-base_thick],[0,0]]);}