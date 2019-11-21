/* Base Parameters */
x_size = 2; //[1:1:25]
y_size = 2; //[1:1:25]
wall_thickness = 7.5; //[5:0.1:25]
base_height = 6; //[0:100]
magnet_hole_diameter = 5.7; 
filament_connector_hole_diameter = 2; //[0:None,2:1.75mm,3.25:3mm]
magnet_eject_hole_diameter = 0; //[0:.5:2]
ledge_depth = .5; // [0:.1:1]
ledge_height =.5; // [0:.1:1]
weld_tab_size = 1; //[0:None,1:Standard,1.5:Large]
decorative_cut = 1; //[0:None,1:Cut Edges]


/* [Hidden] */
unit_size = 25; // [25:OpenForge Standard,25.4:Exact Inch]
floor_thickness = .5;
filament_connector_separation = 4;
filament_connector_lift = 2;
weld_tab_width = 2; 

module wall(units) {
    union() {
        difference() {
            cube([unit_size*units,wall_thickness,base_height]);
            translate([-ledge_depth,-ledge_depth,base_height-ledge_height]) cube([unit_size*units+2*ledge_depth,2*ledge_depth,2*ledge_height]);
            translate([-ledge_depth,-ledge_depth,base_height-ledge_height]) cube([2*ledge_depth,wall_thickness+2*ledge_depth,2*ledge_height]);
            translate([unit_size*units-ledge_depth,-ledge_depth,base_height-ledge_height]) cube([2*ledge_depth,wall_thickness+2*ledge_depth,2*ledge_height]);
            for( i = [1:units]) {
                translate([((i-.5)*unit_size),wall_thickness/2,floor_thickness])
                    cylinder(base_height,magnet_hole_diameter/2,magnet_hole_diameter/2,,$fn=60);
                translate([((i-.5)*unit_size),wall_thickness/2,-floor_thickness])
                    cylinder(base_height,magnet_eject_hole_diameter,magnet_eject_hole_diameter,$fn=60);
                translate([((i-.75)*unit_size)-(decorative_cut/2),-.5,-.5])
                    cube([decorative_cut,decorative_cut+.5,base_height+1]);
                translate([((i-.25)*unit_size)-(decorative_cut/2),-.5,-.5])
                    cube([decorative_cut,decorative_cut+.5,base_height+1]);
            }
            translate([-.5,.25*unit_size-(decorative_cut/2),-.5])
                cube([decorative_cut+.5,decorative_cut,base_height+1]);
            translate([-decorative_cut+(units*unit_size),0.25*unit_size,-.5])
                cube([decorative_cut+.5,decorative_cut-(decorative_cut/2),base_height+1]);
            if(units>1) {
                for(i=[1:units-1]) {
                    translate([(i*unit_size)-((filament_connector_separation+filament_connector_hole_diameter)/2),-1,filament_connector_lift+(filament_connector_hole_diameter/2)])
                        rotate([-90,0,0])
                            cylinder(wall_thickness+2,filament_connector_hole_diameter/2,filament_connector_hole_diameter/2,$fn=60);
                    translate([(i*unit_size)+((filament_connector_separation+filament_connector_hole_diameter)/2),-1,filament_connector_lift+(filament_connector_hole_diameter/2)])
                        rotate([-90,0,0])
                            cylinder(wall_thickness+2,filament_connector_hole_diameter/2,filament_connector_hole_diameter/2,$fn=60);
                }
            }
        }
        for(i=[0:units-1]) {
            translate([-weld_tab_size/2+unit_size/2-magnet_hole_diameter/2+unit_size*i,wall_thickness,base_height-weld_tab_size]) weld_tab();
            translate([-weld_tab_size/2+unit_size/2+magnet_hole_diameter/2+unit_size*i,wall_thickness,base_height-weld_tab_size]) weld_tab();
        }
    }
}

module weld_tab() {
    scale([weld_tab_width,weld_tab_size,weld_tab_size]) polyhedron(
        [[0,0,0], //0
        [1,0,0],  //1
        [1,0,1],  //2 
        [0,0,1],  //3
        [0,1,1],  //4
        [1,1,1]],//5
        [[0,3,2,1],
        [3,4,5,2],
        [0,1,5,4],
        [0,4,3],
        [1,2,5]]);
}

module base(x,y) {
    union() {
        wall(x);
        translate([x*unit_size,(y*unit_size),0]) rotate([0,0,180]) wall(x);
        translate([(x*unit_size),0,0]) rotate([0,0,90]) {
            wall(y);
            translate([y*unit_size,(x*unit_size),0]) rotate([0,0,180]) wall(y);
        }
    }
}


base(x_size,y_size);
