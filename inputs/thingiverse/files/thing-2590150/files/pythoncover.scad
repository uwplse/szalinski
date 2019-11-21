python_od = 51.4; 
grid_spacing = 5; 
grid_w = 1.0;
python_ht = 15; 
grid_ht = 0.8; 
outer_wall_w = 1.5;
eps = 0.01; 

$fn=100; 

module mesh(x, y, spacing, ht, th){ 
  total_x = x*spacing; 
  total_y = y*spacing; 
  for (xdir = [-total_x/2:spacing:total_x/2]) {
     translate([-th/2+xdir,-total_y/2,0]) 
        cube([th,total_y,ht]);  
  }
  for (ydir = [-total_y/2:spacing:total_y/2]) {
    translate([-total_x/2,-th/2+ydir,0]) 
        cube([total_x,th,ht]); 
  }
}

num_mesh = round(python_od/grid_spacing+1);
echo(num_mesh);

module cover() {
  difference() {
    cylinder(h=python_ht, d=python_od+2*outer_wall_w); 
    translate([0,0,-eps]) cylinder(h=python_ht+2*eps, d=python_od); 
  }
  intersection(){
    cylinder(h=python_ht, d=python_od+2*outer_wall_w);
    mesh(num_mesh, num_mesh,grid_spacing,grid_ht,grid_w);  
  }
}

cover(); 