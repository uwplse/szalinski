
flat_or_assembled = "flat"; //[flat,assembled]
include_side_rails = "yes"; //[yes,no]
// measurements of inside of box:
// 116mm high
// 142mm wide
// 50mm deep ('deep' looking down)
// rectangular

//parameters

//Height of the box insert, in mm, looking down
Box_height = 116;

//Width of the box insert
Box_width = 142;

//Depth of the box insert
Box_depth = 50;

//Thickness of the medium; 3mm MDF works well
Wall_thickness = 3;

//Number of horizontal divisions
Boxes_horizontal = 4;

//Number of vertical divisions
Boxes_vertical = 3;
Tab_ratio = 3/5;
Fudge = 1*1; //to hide parameter



// stages:
// 1: divider objects (horiz, vert) with slots up and down
// 2: same divider objects with tab for base
// 3: baseplate

module divider( width, height, thickness, num_across, are_slots_in_top )
{
    difference() {
	cube( [width, height, thickness] );
	 cutouts( width, height, thickness, num_across, are_slots_in_top );
    }
}

function boxwidth( siderails, width, num_across, thickness ) = ((siderails=="yes")?
	(width - (num_across+1)*thickness)/num_across + thickness :
	width/num_across);//(width - (num_across-1)*thickness)/num_across);

module cutouts( width, height, thickness, num_across, are_slots_in_top )
{
    divider_height = height - thickness;
    slot_height = divider_height / 2;
    box_width = boxwidth( include_side_rails, width, num_across, thickness );
    ibound = ((include_side_rails=="yes")?0:1);
    min_x = ((include_side_rails=="yes")?thickness/2:0);
    // cut the slots
    translate( [min_x,0,-Fudge] ) {
	for( i = [ibound:num_across-ibound] ) {
	    if ( are_slots_in_top ) {
		translate( [(i*box_width) - thickness/2, thickness+slot_height, 0] ) {
		    cube([thickness, slot_height+Fudge, thickness+2*Fudge]);
		}
	    } else {
		translate( [(i*box_width) - thickness/2, thickness-Fudge, 0] ) {
		    cube([thickness, slot_height+Fudge, thickness+2*Fudge]);
		}
	    }
	}
    }
    // now cut the bottom tabs
    tab_width = Tab_ratio * box_width;
    tab_hole = box_width - tab_width;
    // if there are n compartments, there are n+1 holes
    translate( [-(tab_hole / 2)+min_x,0,-Fudge] ) {
	for( i = [0:num_across] ) {
	    translate( [i*box_width, -Fudge, 0] ) {
		cube([tab_hole, Fudge+thickness, thickness+2*Fudge] );
	    }
	}
    }
}

module bottom( width, height, num_horiz, num_vert, thickness ) {
    difference() {
	cube( [width, height, thickness] );
	 bottom_slots( width, height, num_horiz, num_vert, thickness );
    }
}

module bottom_slots( width, height, num_horiz, num_vert, thickness ) {
    h_box_width = boxwidth( include_side_rails, width, num_horiz, thickness);
    // tab_width is the amount that will be cut out of the baseplate
    h_tab_width = Tab_ratio * h_box_width;
    h_tab_hole = h_box_width - h_tab_width;
    v_box_width = boxwidth( include_side_rails, height, num_vert, thickness );
    v_tab_width = Tab_ratio * v_box_width;
    v_tab_hole = v_box_width - v_tab_width;
    ibound = ((include_side_rails=="yes")?0:1);
    min_x = ((include_side_rails=="yes")?thickness/2:0);
    translate([0,0,-Fudge]) {
	// horizontal tabs
   
	for ( i = [ibound:num_vert-ibound] ) {
	    translate( [min_x , i*v_box_width - thickness/2 + min_x, 0] ) {
		for( j = [0:num_horiz-1] ) {
		    translate( [j*h_box_width + h_tab_hole/2,0,0] ) {
			cube( [h_tab_width, thickness, thickness+2*Fudge] );
		    }
		}
	    }
	}
	// vertical tabs; cleaner would be to make one routine and rotate but it hurts meh
	for ( i = [ibound:num_horiz-ibound] ) {
	    translate( [ i*h_box_width - thickness/2 + min_x, min_x, 0] ) {
		for( j = [0:num_vert-1] ) {
		    translate( [0, j*v_box_width + v_tab_hole/2,0] ) {
			cube( [thickness, v_tab_width, thickness+2*Fudge] );
		    }
		}
	    }
	}
    }
}

module assembled() {
    bottom( Box_width, Box_height, Boxes_horizontal, Boxes_vertical, Wall_thickness );
    box_v_height = boxwidth( include_side_rails, Box_height, Boxes_vertical, Wall_thickness );
    ibound = ((include_side_rails=="yes")?0:1);
    min_x = ((include_side_rails=="yes")?Wall_thickness:Wall_thickness/2);
    for( i=[ibound:Boxes_vertical-ibound] ) {
	translate([0,i*box_v_height+min_x,0]) {
	    rotate([90,0,0]) {
		divider(Box_width, Box_depth, Wall_thickness, Boxes_horizontal, true );
	    }
	}
    }
    min_y = ((include_side_rails=="yes")?0:-min_x);
    box_h_height = boxwidth( include_side_rails, Box_width, Boxes_horizontal, Wall_thickness );
    for( i=[ibound:Boxes_horizontal-ibound] ) {
	translate([i*box_h_height+min_y,0,0] ) {
	    rotate([0,0,90]) {
		rotate([90,0,0]) {
		    divider(Box_height, Box_depth, Wall_thickness, Boxes_vertical, false );
		}
	    }
	}
    }
}

module exploded() {
    boxbound = ((include_side_rails=="yes")?0:2);
    num_hpieces = (include_side_rails=="yes")?Boxes_vertical+1 : Boxes_vertical-1;
    translate([0,0,-Wall_thickness/2]) {

	for (i = [0:Boxes_vertical-boxbound]) {
	    translate([0, i*(Box_depth+2*Fudge), 0]) {
		divider(Box_width, Box_depth, Wall_thickness, Boxes_horizontal, true);
	    }
	}
	
	translate([0,(num_hpieces)*(Box_depth+2*Fudge),0]) {
	    bottom(Box_width, Box_height, Boxes_horizontal, Boxes_vertical, Wall_thickness);
	    for (i=[0:Boxes_horizontal-boxbound]) {
		translate([ Box_width + 2*Fudge, Box_height, 0] ) {
		    rotate([0,0,-90]) {
			translate([0, i*(Box_depth+2*Fudge),0]) {
			    divider( Box_height, Box_depth, Wall_thickness, Boxes_vertical, false );
			}
		    }
		}
	    }
	}
    }
}
//divider( Box_width, Box_depth, Wall_thickness, 2, true );
module dxf() {
    projection(cut=true) {
	exploded();
    }
}

if (flat_or_assembled == "flat") {
  dxf();
} else {
  assembled();
}
