base_x = 44;
base_y = 60;

z_min = 70;
z_max = 80;

radio = 3;

cant_x = 3;
cant_y = 3;

profundidad = z_max/2;
diametro = 9;

dist_agujero_x = (base_x - diametro * cant_x)/(cant_x+1) + diametro;

dist_agujero_y = (base_y - diametro * cant_y) / (cant_y+1) + diametro;


//minkowski()
//{
//    translate ([0,0,0]) cylinder(h = z_min ,d = 3);
    
difference()
{

    //cube([base_x,base_y,z_max]);
    translate([radio,radio,0]){
        linear_extrude(height = z_max) {
            offset(r=radio, $fn=10) {
                square([base_x-2*radio,base_y-2*radio]);
            }
        }
    }
    translate ([0,0,z_max]) rotate (a = [-90,0,0]) linear_extrude(height = base_y) polygon(points=[[0,0],[base_x,0],[base_x,z_max-z_min]]);




for(i = [0:1:cant_x-1] )
{

    for(j = [0:1:cant_y-1-1*(i%2)]){
        translate ([dist_agujero_x*i+dist_agujero_x-diametro/2,dist_agujero_y*j+dist_agujero_y-diametro/2+(i%2)*dist_agujero_y/2,z_max-profundidad]) cylinder(h = profundidad, d = diametro, $fn=10);
    }
}

}
//}