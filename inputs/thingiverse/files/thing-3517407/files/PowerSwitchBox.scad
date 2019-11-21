//PowerSwitchBox OpenSCAD Version 1.1
//Started on 2019.03.13.
//Updated on 2019.03.24.
//by MicroWizard

box_width		= 40;
box_depth		= 30;
box_height		= 45;
switch_width	= 33;	//full
switch_depth	= 22;
switch_height	= 27;
stand_top_dia	= 5;
stand_bot_dia	= 15;
stand_dist		= 11;
//extrusion 20x20
holder_depth	= 20;
holder_width	= box_width+2*(holder_depth);
holder_height	= 4;

wire_dia		= 8;
hole_dia		= 5;
fastener_dia	= 3;
x_wall			= (box_width-switch_width)/2;

adjust			= 0.01;
stand_height	= box_height - switch_height;
switch_off_x	= (box_width - switch_width)/2;
switch_off_y	= (box_depth - switch_depth)/2;
switch_off_z	= box_height - switch_height+adjust;

module SwitchBox(){
	union(){
		difference(){
			union(){
				//box
				translate([	-box_width/2,
							-box_depth/2,
							0]){
					cube(	size=[	box_width,
									box_depth,
									box_height],
							center=false);
				}
				//holder
				translate([	-holder_width/2,
							-holder_depth/2,
							0]){
					cube(	size=[	holder_width,
									holder_depth,
									holder_height],
							center=false);
				}
			}
			//--
			union(){
				//switch
				translate([	-switch_width/2,
							-switch_depth/2,
							holder_height+adjust]){
					cube(	size=[	switch_width,
									switch_depth,
									box_height-holder_height],
							center=false);
				}
				//wire holes
				translate([	-box_width/2+wire_dia/2+x_wall,
							0,
							holder_height+wire_dia/2]){
					rotate([90,0,0]){
						cylinder(	d=wire_dia,
									h=100,
									center=true
						);
					}
				}
				translate([	box_width/2-wire_dia/2-x_wall,
							0,
							holder_height+wire_dia/2]){
					rotate([90,0,0]){
						cylinder(	d=wire_dia,
									h=100,
									center=true
						);
					}
				}
				//holder holes
				translate([	-(holder_width-holder_depth)/2,
							0,
							-adjust]){
					cylinder(	d=hole_dia,
								h=holder_depth+2*adjust
							);
				}
				translate([	(holder_width-holder_depth)/2,
							0,
							-adjust]){
					cylinder(	d=hole_dia,
								h=holder_depth+2*adjust
							);
				}
			}
		}
		union(){
			//stands
			translate([	-stand_dist/2,0,0])
			cylinder(	d1=stand_bot_dia,
						d2=stand_top_dia,
						h=stand_height
					);
			translate([	stand_dist/2,0,0])
			cylinder(	d1=stand_bot_dia,
						d2=stand_top_dia,
						h=stand_height
					);
			//fasteners
			translate([	-switch_width/2,
							0,
							box_height-(fastener_dia/2)]){
				rotate([	90,0,0]){
					cylinder(	d=fastener_dia,
								h=box_depth,
							center=true
						);
				}
			}
			translate([	switch_width/2,
							0,
							box_height-(fastener_dia/2)]){
				rotate([	90,0,0]){
					cylinder(	d=fastener_dia,
								h=box_depth,
							center=true
						);
				}
			}
		}
	}
}

SwitchBox();

