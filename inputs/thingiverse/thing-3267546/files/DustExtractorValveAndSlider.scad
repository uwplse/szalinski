// Which one would you like to see?
part = "Valve"; // [Valve, Slider]


$fa=1*1;
$fs=0.25*1;

/* [ Global ] */

// Add tube on top 
connector_top_mode=1; // [0:Female,1:Male with Tube Outer diameter,2:Male with tube inner diameter]

// Add tube on top 
connector_bottom_mode=0; // [0:Female,1:Male with Tube Outer diameter,2:Male with tube inner diameter]

// size of valve cube on y, i.e. slit opening side
valve_width_y=70;

// size of valve cube on x, i.e. closed side 
valve_width_x=65;

// height of valve cube
valve_height=20;

// height of the slider opening
slider_opening_height=5;

// width of slider opening, recommended: tube_inner_diameter+10
slider_opening_width=56.1;

// adjust printing precision for inner cut-outs
cutout_adjust = 0.4;


/* [Tube/Connector] */

// outer tube diameter 
tube_outer_diameter=50.0;

// inner tube diameter
tube_inner_diameter=46.1;

// connector length top side
connector_length_top = 25;

// connector length top bottomside
connector_length_bottom = 25;


/* [Slider] */

// slider should be a little smaller than slider opening
slider_height_delta = 0.4;

// slider should be a little smaller than slider opening
slider_width_delta = 0.4;


/* [ End stop ] */

// width of stop block preventing slider to go in
end_stop_width = 5;

// height of stop block preventing slider to go in
end_stop_height = 5;


/* [ Hidden ] */

slider_length = valve_width_x + tube_inner_diameter + 15 + end_stop_width;
slider_width = slider_opening_width - slider_width_delta;
slider_height = slider_opening_height - slider_height_delta;
tube_thickness = (tube_outer_diameter - tube_inner_diameter)/2;
do_top = connector_outer_diameter(connector_top_mode);
di_top = connector_inner_diameter(connector_top_mode);
do_bottom = connector_outer_diameter(connector_bottom_mode);
di_bottom = connector_inner_diameter(connector_bottom_mode);
inspect_inside = 0;
echo("DO top:", do_top);
echo("DI top:", di_top);
echo("DO bottom:", do_bottom);
echo("DI bottom:", di_bottom);

print_part();

function connector_outer_diameter( mode ) = mode == 0 ? tube_outer_diameter+10 : mode == 1 ? tube_outer_diameter : tube_inner_diameter;

function connector_inner_diameter( mode ) = mode == 0 ? tube_outer_diameter : mode == 1 ? tube_inner_diameter : tube_inner_diameter-2*tube_thickness;

module print_part() {
    if (part == "Valve") {
        valve();
    } else {
        slider();
    }
}



module valve() {
    difference() {
        union() {
            if (connector_top_mode == 0) {
                hull() {
                    cube([valve_width_x, valve_width_y, valve_height], center=true);
                    translate([0,0, valve_height/2])
                        cylinder(connector_length_top, d=do_top);
                }
            } else {
                union() {
                    cube([valve_width_x, valve_width_y, valve_height], center=true);
                    translate([0,0, valve_height/2])
                        cylinder(connector_length_top, d=do_top);
                }
            }
            if (connector_bottom_mode == 0) {
                hull() {
                    cube([valve_width_x, valve_width_y, valve_height], center=true);
                    translate([0,0, -valve_height/2-connector_length_bottom])
                        cylinder(connector_length_bottom, d=do_bottom);
                }
            } else {
                union() {
                    cube([valve_width_x, valve_width_y, valve_height], center=true);
                    translate([0,0, -valve_height/2-connector_length_bottom])
                        cylinder(connector_length_bottom, d=do_bottom);
                }
            }
        }

        cube([valve_width_x, slider_opening_width, slider_opening_height], center=true);
        
        di_top2 = di_top+cutout_adjust - (connector_top_mode == 0 ? 2*tube_thickness : 0);
        cylinder(connector_length_top+valve_height/2, d=di_top2);
        if (connector_top_mode == 0) {
            translate([0,0, valve_height/2])
                cylinder(connector_length_top, d=di_top+cutout_adjust);
        }
        
        di_bottom2 = di_bottom+cutout_adjust - (connector_bottom_mode == 0 ? 2*tube_thickness : 0);
        echo("DI2 bottom:", di_bottom2);
        translate([0,0,-(connector_length_bottom+valve_height/2)])
            cylinder(connector_length_bottom+valve_height/2, d=di_bottom2);
        if (connector_bottom_mode == 0) {
            translate([0,0, -(connector_length_bottom+valve_height/2)])
                cylinder(connector_length_bottom, d=di_bottom+cutout_adjust);
        }
    
        if (inspect_inside == 1) {
            translate([0,0,-100])
                cube([100,100,200]);
        }
    }
}


module slider() {
    union() {
        difference() {
            translate([slider_width/4, 0, 0])
                cube([slider_length-slider_width/2, slider_width, slider_height], center=true);
            translate([slider_length/2-end_stop_width-valve_width_x/2, 0, 0])
                cylinder(slider_height, d=tube_inner_diameter, center=true);
        }
        
        // round edge + hole for end stop
        difference() {
            translate([-slider_length/2+slider_width/2, 0, 0])
                cylinder(slider_height, d=slider_width, center=true);
            
            translate([-slider_length/2+5, 0, 0])
                cylinder(slider_height, d=5, center=true);
        }
        
        // endstop
        translate([slider_length/2-end_stop_width/2, 0, slider_height])
            cube([end_stop_width, slider_width, end_stop_height], center=true);
    }
}


