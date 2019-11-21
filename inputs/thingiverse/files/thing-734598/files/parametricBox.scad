// CUSTOMIZER VARIABLES

// in mm. Dimensions of space inside of container. Final outside box height & width depends on wall & lip thickness.
x_width = 149.0;
y_width = 87.0;

// The height of both the bottom and lid is the total height of the space inside the container.
bottom_height = 140.0;
lid_height = 85.0;

// Wall thickness in mm. This adds to the outside dimensions of the box.
thickness = 1.8;

// Height of lip above box top, used for the friction fit.
lip_height = 8;

// Height of the lip going below and attached to bottom. Default works well.
lip_overlap_height = 2.0;

// Wall thickness of the attachment lip.
lip_thickness = 0.8;

// Lip outer dimension offset. The larger the number the looser the friction fit.
looseness_offset = 0.15;

// Corner radius in mm (0 = sharp corner).
radius = 5; 

// Generate the bottom.
generate_box = 1; // [0:no,1:yes]

// Generate a lid.
generate_lid = 1; // [0:no,1:yes]

//CUSTOMIZER VARIABLES END

// resolution
$fn=100; 


x_width_outside = x_width + thickness*2 + lip_thickness*2 + looseness_offset*2;
y_width_outside = y_width + thickness*2 + lip_thickness*2 + looseness_offset*2;
bottom_height_outside = bottom_height + thickness;
lid_height_outside = lid_height + thickness;

corner_radius = min(radius, x_width/2, y_width/2);

// Adjust for cube size after minowski corner union is taken into account
xadj = x_width_outside - (corner_radius*2);
yadj = y_width_outside - (corner_radius*2);

// ---- Generate bottom
box_height_total = bottom_height_outside + lip_height;
lip_overlap_cut_total = bottom_height - lip_overlap_height;

if (generate_box == 1 ) {
	translate([-((x_width_outside/2+2) * generate_lid), 0, 0]) difference() 
	{
		union() 
		{
            // Outer body
            translate([0,0,bottom_height_outside/4]) minkowski()
            {
                cube([xadj,yadj,bottom_height_outside/2],center=true);
                cylinder(r=corner_radius,h=bottom_height_outside/2);
            }
          
            corner_lip = max(0.1, corner_radius - thickness - looseness_offset);
            
            // Inner body that forms lip
			translate([0,0,box_height_total/4]) minkowski()
			{
			 cube([x_width_outside - thickness*2 - corner_lip*2 - looseness_offset*2,
                   y_width_outside - thickness * 2 - corner_lip*2 - looseness_offset*2,
                   box_height_total/2],
                   center=true);
			 cylinder(r=corner_lip,h=box_height_total/2);
			}
		}

		// Cut out inside
		union() 
		{
            inside_lip_radius = max(0.1, corner_radius - thickness - lip_thickness - looseness_offset);
                   
			translate([0,0,(box_height_total)/4 + thickness]) minkowski()
			{
			 cube([x_width - inside_lip_radius*2, 
                   y_width - inside_lip_radius*2, 
                   (box_height_total)/2],
                   center=true);
			 cylinder(r=inside_lip_radius,h=box_height_total/2);
			}

            c_radius = max(0.1, corner_radius - thickness);
			// cut out even more to make connector lip only go so deep
			translate([0,0,((lip_overlap_cut_total)/4)  + thickness  ]) minkowski()
			{
			 cube([x_width_outside - thickness*2 - c_radius*2,y_width_outside - thickness*2 - c_radius*2, lip_overlap_cut_total/2],center=true);
			 cylinder(r=c_radius,h=lip_overlap_cut_total/2);
			}
            

		}
	};
}

// Generate the lid
if (generate_lid==1) {
	translate([(x_width_outside/2+1) * generate_box, 0, lid_height_outside/4]) {
		difference() 
		{
			// Body
			minkowski()
			{
			 cube([xadj,yadj,lid_height_outside/2],center=true);
			 cylinder(r=corner_radius,h=lid_height_outside/2);
			}
            
            corner_inner = max(0.1, corner_radius - thickness);
			
            // Cut out inside
			translate([0,0,thickness]) minkowski()
			{
			 cube([x_width_outside-corner_inner*2-thickness*2,y_width_outside-corner_inner*2-thickness*2,lid_height/2],center=true);
			 cylinder(r=corner_inner,h=lid_height/2);
			}
		}
	};
}


