/*[Global]*/

//diameter of centrifuge tube (add .5 mm for better fit)
tube_diameter = 28.5;

//how far the tube will fit into the holder (should be longer than the cone at the bottom) 
tube_height = 25;

//thickness of the walls (dont go under 1mm)
wall_thickness = 1.5;

//diameter of base hexagon (at least 1.5x tube_diameter)
base_diameter = 65;

//height of base hexagon
base_height = 3;

//height of the chamfered part that interconnects the tube holder with the base plate (set 0 for no chamfer)
chamfer_height = 10;

//diameter of the centrifuge tube at the conical tip
cone_tip = 8;

// width of the window at the side (set 0 for no window)
window_size = 2;

/*[Hidden]*/
union(){
    difference(){
        difference(){
            cylinder (h =tube_height + chamfer_height + base_height, r = tube_diameter/2 + wall_thickness);
            cylinder (h =tube_height + chamfer_height + base_height, r = tube_diameter/2);
        };
        translate([0, tube_diameter/2 + wall_thickness/2, chamfer_height + base_height + tube_height/2]){
            cube(size = [window_size, wall_thickness + 1, tube_height-4], center = true);
        };
    };
    difference(){
        hull(){
            hex(base_diameter, base_height);
            translate([0,0,chamfer_height-1]){
                cylinder(h=1, r = tube_diameter/2 + wall_thickness);
            };
        };
        translate([0,0,-base_height/2]){
            cylinder(h = base_height + chamfer_height, r = cone_tip/2);
        };
    };
};

module hex(size,tube_height) {
  boxWidth = size/1.75;
  translate([0,0,height/2]){
    for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size,tube_height], true);
  };
  };