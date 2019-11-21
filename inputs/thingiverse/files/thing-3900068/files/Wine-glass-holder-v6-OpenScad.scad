Glass_opening_outer_diameter = 54;//this is the outer diameter of your glass at the opening (from where you drink). Adding one or two millimeters will not cause issue and reduce fitting risks (in mm)
Glass_holding_to_hole_distance = 20;//choose to have the holder top position to fit your glass where you want (as long as the corresponding diameter is larger than opening diameter), defining it with a distance from the opening. The higher the better for stability but it increases holder size and printing cost (in mm)
Glass_holding_position_diameter =64;// this is the diameter of your glass at this holding position (in mm)
Glass_max_diameter = 84 ;//this is the maximum outer diameter of your glass. We choose to use this as the holder basis diameter too for maximum stability while not increasing storage space (in mm)
bottom_residual_thickness = 2.5;// this is the thickness of the holders under the glass and it allows drying (in m)
min_wall_thickness=2;//this is the minimum thickness for strength of the holding walls under the glass (in mm)
holder_top_blade_thickness=0.1;//the thickness at the top of the holder. I prefer to have it as thin as possible (in mm)

//internal calculations to turn diameter in radius
Glass_hole_radius =Glass_opening_outer_diameter * 0.5;//mm
Glass_holding_position_radius =Glass_holding_position_diameter * 0.5;//mm
Glass_max_radius = Glass_max_diameter *0.5;//mm

//internal calculations to define number of drying holes
inner_radius=Glass_hole_radius*0.75;
min_width_per_hole_and_wall=min_wall_thickness*(1+1.618);//1.618 is golden ratio
nb_drying_holes=floor(2*PI*inner_radius/min_width_per_hole_and_wall);
holes_inner_radius=min_wall_thickness*1.618*0.5*
(2*PI*inner_radius/min_width_per_hole_and_wall / floor(2*PI*inner_radius/min_width_per_hole_and_wall));//1.618 is golden ratio
holes_outer_radius=holes_inner_radius*Glass_max_radius/inner_radius;


difference(){
    rotate_extrude($fn=200) polygon( points=
        [[0,0],
        [Glass_max_radius,0],
        [Glass_holding_position_radius+holder_top_blade_thickness,bottom_residual_thickness+Glass_holding_to_hole_distance],
        [0,bottom_residual_thickness+Glass_holding_to_hole_distance]] );
    union(){
        rotate_extrude($fn=200) polygon( points=
            [[0,0],
            [inner_radius,0],
            [inner_radius,bottom_residual_thickness],
            [Glass_hole_radius,bottom_residual_thickness],
            [Glass_holding_position_radius,bottom_residual_thickness+Glass_holding_to_hole_distance*0.2],
            [Glass_holding_position_radius,bottom_residual_thickness+Glass_holding_to_hole_distance],
            [0,bottom_residual_thickness+Glass_holding_to_hole_distance]] );
        for (n=[0:nb_drying_holes-1]){
            rotate([0,0,n*360/nb_drying_holes]){
                translate([0,0,bottom_residual_thickness])rotate([90,0,0])cylinder(h = Glass_max_radius, r1 = 0, r2 = holes_outer_radius, center = false,$fn=50);
                polyhedron( points = [ [0, 0, 0],
                    [holes_outer_radius, -Glass_max_radius, 0], 
                    , [-holes_outer_radius, -Glass_max_radius, 0],
                    , [-holes_outer_radius, -Glass_max_radius, bottom_residual_thickness],
                    , [holes_outer_radius, -Glass_max_radius, bottom_residual_thickness],
                    , [0, 0, bottom_residual_thickness]], 
                    faces = [ [0, 2, 1], 
                    [3,5,4],
                    [5,3,2,0],
                    [4,5,0,1],
                    [1,2,3,4] ], convexity = 10); 
            }
        }

        
    } 
}
