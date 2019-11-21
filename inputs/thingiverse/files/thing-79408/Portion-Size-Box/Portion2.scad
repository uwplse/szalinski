container_size_dimension=61;//[10:100]
container_size_z=61;//[13:100]
serving();
module serving(){

container_x=container_size_dimension;
container_y=container_size_dimension;
container_z= container_size_z;
handle_x=2*container_x/3;
handle_y=15;
handle_z=2;

difference(){
	cube([container_x,container_y,container_z], center=true);
	
	cube([container_x-2,container_x-2,container_z+1], center=true);
}
translate([0,-container_y/2-handle_y/2,container_z/2-1])
cube([handle_x,handle_y,handle_z], center=true);
translate([0,container_y/2+handle_y/2,container_z/2-1])
cube([handle_x,handle_y,handle_z], center=true);
}

