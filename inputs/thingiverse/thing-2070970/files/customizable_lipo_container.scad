//Battery width
lipo_w = 25;
//Battery height
lipo_h = 43;
//Battery thickness
lipo_t = 10.5;

//Number of rows
rows = 1;
//Number of lipos in row
lipos_in_row = 5;

//Container walls height
container_wall_h = 15;
//Container walls thickness
container_wall_t = 3.2;
//Container floor height
container_floor_h = 2.4;


module lipo(){
    cube([lipo_w, lipo_t, lipo_h]);
}

module single_lipo_container(){
    difference(){
        cube([lipo_w+2*container_wall_t, lipo_t+2*container_wall_t, container_wall_h+container_floor_h]);
        translate([container_wall_t, container_wall_t, container_floor_h])
        lipo();
    }
}

module lipo_container(){
    for(row_count=[1 : 1 : rows]){
        for(x=[1 : 1 : lipos_in_row]){
            translate([(lipo_w+container_wall_t)*(row_count-1), (lipo_t+container_wall_t)*(x-1), 0])
            single_lipo_container();
        }
    }
}

lipo_container();