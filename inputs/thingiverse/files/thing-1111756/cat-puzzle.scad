radius = 55;
number_of_tower = 10;
tower_size = 10;
max_tower_height = 150;
disk_height = 3;

cylinder(disk_height,   radius, radius,true);
for(i=[0:number_of_tower]) {
    
    height = rands(0,max_tower_height,1)[0];
    tx = rands(tower_size-radius,radius-tower_size,1)[0];
    maxy = sqrt(pow(radius-tower_size, 2) - pow(tx, 2));
    ty = rands(-maxy,maxy,1)[0];
    
    translate([tx,ty,height/2]) cube([tower_size,tower_size,height], true);
}