lens_diameter = 71.5;       // outer diameter of cap

mount_height = 3;         // height of lip
mount_width = 4;          // width of ring
mount_base = 5;           // height of buckle
mount_lip_height = 0.1;   // lip tip height (to help secure cap)
mount_lip_width = 0.2;    // width of lip tip (to help secure cap)

buckle_gap = 7;           // gap for strap
buckle_width = 40.5;      // strap width
buckle_thickness = 6;     // thickness of buckle

filled_buckle = false;    // fill the buckle center?
circle_sides = 360;        // number of sides for circles, values below 150 make fillets choppy when printed

inside_lens = true;     //add place for second, smaller lens inside
inside_lens_diameter = 64.5;     //outer diameter of smaller cap
inside_mount_height = 3;

outer_fillets_radius = 15;  //radius of fillets on outside of buckle
inner_fillets_radius = 3;   //radius of fillets on inside of buckle
top_fillets_radius = 5;   //radius of fillets on top of buckle, should be maximized for strength, but no larger than the distance between the top of the buckle and the very top of part

union()
{
    buckle();
    capmount();
    fillets();
}

module buckle()
{
    buckle_inner = lens_diameter/2 + mount_width + buckle_gap;
    buckle_outer = buckle_inner + buckle_thickness;

    squared_inner = buckle_width;
    squared_outer = buckle_width + 2*buckle_thickness;

    squared_offset = sqrt(pow(buckle_outer,2) - pow(squared_outer/2,2));

    linear_extrude(height=mount_base) union()
    {
        // the arc portion of the buckle
        intersection()
        {
            square([buckle_outer*4, squared_outer], center=true);
            difference()
            {
                circle(buckle_outer, $fn=circle_sides);
                circle(buckle_inner, $fn=circle_sides);
            }
        }

        // the squared-length portion of the buckle
        difference()
        {
            square([squared_offset*2, squared_outer], center=true);
            square([squared_offset*2, squared_inner], center=true);
        }
    }
}

module capmount()
{   
    // add extra height if second lens holder is used
    if (inside_lens) {
        lip_height = mount_base + mount_height +     inside_mount_height;
        inside_lip_height = mount_base + inside_mount_height;
        cap_inner = inside_lens_diameter/2 - mount_width;
        cap_outer = lens_diameter/2 + mount_width;
        inside_cap_outer = inside_lens_diameter/2 + mount_width;
        
        difference(){
        union(){
            // the base of the lens cap mount
            linear_extrude (height = inside_lip_height) 
            difference(){
                circle(cap_outer, $fn=circle_sides);
                if (!filled_buckle){
                    circle(cap_inner, $fn=circle_sides);
                }
            }
            
            // generate extra base support if it's not filled
            if (!filled_buckle) for(i=[-45,45])
                linear_extrude(height=mount_base) rotate(i)
                    square([lens_diameter, mount_width], center=true);

            // generate the cap friction mount and extra securing lip
            difference()
            {
                linear_extrude(height=lip_height) 
                    circle(cap_outer, $fn=circle_sides);
                linear_extrude(height=lip_height) 
                    circle(lens_diameter/2 - mount_lip_width, $fn=circle_sides);
                linear_extrude(height=lip_height - mount_lip_height) 
                    circle(lens_diameter/2, $fn=circle_sides);
            }
        }
            // generate inner cap friction mount
            translate([0,0,mount_base])
            union(){
            cylinder(h = inside_mount_height, d = inside_lens_diameter- mount_lip_width, $fn = circle_sides);
            cylinder(h = inside_mount_height - mount_lip_height, d = inside_lens_diameter, $fn = circle_sides);
            }
        }
    }
    else {
        lip_height = mount_base + mount_height;
        inside_lip_height = mount_base;
        cap_inner = lens_diameter/2 - mount_width;
        cap_outer = lens_diameter/2 + mount_width;

        union(){
            // the base of the lens cap mount
            linear_extrude (height = inside_lip_height) 
            difference(){
                circle(cap_outer, $fn=circle_sides);
                if (!filled_buckle){
                    circle(cap_inner, $fn=circle_sides);
                }
            }
            
            // generate extra base support if it's not filled
            if (!filled_buckle) for(i=[-45,45])
                linear_extrude(height=mount_base) rotate(i)
                square([lens_diameter, mount_width], center=true);

            // generate the cap friction mount and extra securing lip
            difference()
            {
                linear_extrude(height=lip_height) 
                    circle(cap_outer, $fn=circle_sides);
                linear_extrude(height=lip_height) 
                    circle(lens_diameter/2 - mount_lip_width, $fn=circle_sides);
                linear_extrude(height=lip_height - mount_lip_height) 
                    circle(lens_diameter/2, $fn=circle_sides);
            }    
        }
    }
}


module fillets()
{
    //variables needed for fillets on outside corners
r1 = outer_fillets_radius;
mount_radius = lens_diameter/2 + mount_width;

outer_corner_y = buckle_width/2 + buckle_thickness;
outer_corner_x = sqrt(pow(mount_radius,2) - pow(outer_corner_y,2));

outer_circle_y = outer_corner_y + r1;
outer_circle_x = sqrt(pow(mount_radius + r1,2) - pow(outer_circle_y,2));
    
outer_polygon_x = (outer_circle_x/2)*((pow(outer_fillets_radius,2)-pow(mount_radius,2))/(pow(outer_circle_x,2) + pow(outer_circle_y,2))-1);
outer_polygon_y = (outer_circle_y/2)*((pow(outer_fillets_radius,2)-pow(mount_radius,2))/(pow(outer_circle_x,2) + pow(outer_circle_y,2))-1);


    //fillets on outside corners
    //quadrant I
linear_extrude(height = mount_base)
difference()
    {
    polygon([[outer_corner_x,outer_corner_y],[outer_circle_x,outer_corner_y],[-outer_polygon_x,-outer_polygon_y]]);
    translate([outer_circle_x,outer_circle_y,0])
        circle(r1, $fn=circle_sides);
    }
 //quadrant II
linear_extrude(height = mount_base)
difference()
    {
    polygon([[-outer_corner_x,outer_corner_y],[-outer_circle_x,outer_corner_y],[outer_polygon_x,-outer_polygon_y]]);
    translate([-outer_circle_x,outer_circle_y,0])
        circle(r1, $fn=circle_sides);
    }
    //quadrant III
linear_extrude(height = mount_base)
difference()
    {
    polygon([[-outer_corner_x,-outer_corner_y],[-outer_circle_x,-outer_corner_y],[outer_polygon_x,outer_polygon_y]]);
    translate([-outer_circle_x,-outer_circle_y,0])
        circle(r1, $fn=circle_sides);
    }   
    //quadrant IV
linear_extrude(height = mount_base)
difference()
    {
    polygon([[outer_corner_x,-outer_corner_y],[outer_circle_x,-outer_corner_y],[-outer_polygon_x,outer_polygon_y]]);
    translate([outer_circle_x,-outer_circle_y,0])
        circle(r1, $fn=circle_sides);
    }    

    //variables needed for fillets on inside of buckle gap
r2 = inner_fillets_radius;
    
inner_corner_y = buckle_width/2;
inner_corner_x = sqrt(pow(mount_radius,2) - pow(inner_corner_y,2));

inner_circle_y = inner_corner_y - r2;
inner_circle_x = sqrt(pow(mount_radius + r2,2) - pow(inner_circle_y,2));   

inner_polygon_x = (inner_circle_x/2)*(((pow(inner_fillets_radius,2))-(pow(mount_radius,2)))/((pow(inner_circle_x,2)) + (pow(inner_circle_y,2)))-1);
inner_polygon_y = (inner_circle_y/2)*((pow(inner_fillets_radius,2)-pow(mount_radius,2))/(pow(inner_circle_x,2) + pow(inner_circle_y,2))-1);     

    //fillets on inside of buckle gap
    //quadrant I
linear_extrude(height = mount_base)
difference()
    {
    polygon([[inner_corner_x,inner_corner_y],[inner_circle_x,inner_corner_y],[-inner_polygon_x,-inner_polygon_y]]);
    translate([inner_circle_x,inner_circle_y,0])
        circle(r2, $fn=circle_sides);
    }
    //quadrant II
linear_extrude(height = mount_base)
difference()
    {
    polygon([[-inner_corner_x,inner_corner_y],[-inner_circle_x,inner_corner_y],[inner_polygon_x,-inner_polygon_y]]);
    translate([-inner_circle_x,inner_circle_y,0])
        circle(r2, $fn=circle_sides);
    }
    //quadrant III
linear_extrude(height = mount_base)
difference()
    {
    polygon([[-inner_corner_x,-inner_corner_y],[-inner_circle_x,-inner_corner_y],[inner_polygon_x,inner_polygon_y]]);
    translate([-inner_circle_x,-inner_circle_y,0])
        circle(r2, $fn=circle_sides);
    }
    //quadrant IV
linear_extrude(height = mount_base)
difference()
    {
    polygon([[inner_corner_x,-inner_corner_y],[inner_circle_x,-inner_corner_y],[-inner_polygon_x,inner_polygon_y]]);
    translate([inner_circle_x,-inner_circle_y,0])
        circle(r2, $fn=circle_sides);
    }

    //variables for fillets on top of buckle
r3 = top_fillets_radius;
   
a = atan(outer_polygon_y/outer_polygon_x) - atan(inner_polygon_y/inner_polygon_x);
    
    //fillets on top of buckle
z_rotation1 = atan(inner_polygon_y/inner_polygon_x);
    
//quadrant I
difference(){
    translate([0,0,mount_base])
    rotate([0,0,z_rotation1])
    rotate_extrude(angle = a, $fn=circle_sides)
        translate([mount_radius,0])
        difference()
        {
            polygon([[0,0],[0,r3],[r3,0]]);
            translate([r3,r3])
                circle(r3, $fn = circle_sides);
        }
    linear_extrude(height = mount_base + mount_height + inside_mount_height)
    union(){
        difference()
    {
        difference()
        {
            intersection()
            {
                circle(r = lens_diameter/2 + mount_width + buckle_gap, $fn = circle_sides);
                square([lens_diameter + mount_width*2 + buckle_gap*2, buckle_width], center = true);
            }
            circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
        }
            difference()
            {
                polygon([[inner_corner_x,inner_corner_y],[inner_circle_x,inner_corner_y],[-inner_polygon_x,-inner_polygon_y]]);
                translate([inner_circle_x,inner_circle_y])
                    circle(r2, $fn=circle_sides);
            }
    }
    difference()
    {
        translate([0,buckle_width + buckle_thickness]) 
            square([lens_diameter + mount_width*2 + buckle_gap*2,buckle_width], center = true);
        difference()
        {
            polygon([[outer_corner_x,outer_corner_y],[outer_circle_x,outer_corner_y],[-outer_polygon_x,-outer_polygon_y]]);
            translate([outer_circle_x,outer_circle_y])
                circle(r1, center = true, $fn=circle_sides);
        }
        circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
    }
    }
}
        
    //quadrant II
z_rotation2 = 180 - atan(inner_polygon_y/inner_polygon_x);
difference(){
    translate([0,0,mount_base])
    rotate([0,0,z_rotation2])
    rotate_extrude(angle = -a, $fn=circle_sides)
        translate([mount_radius,0])
        difference()
        {
            polygon([[0,0],[0,r3],[r3,0]]);
            translate([r3,r3])
                circle(r3, $fn = circle_sides);
        }
        linear_extrude(height = mount_base + mount_height + inside_mount_height)
        union(){
        difference()
        {
        difference()
        {
            intersection()
            {
                circle(r = lens_diameter/2 + mount_width + buckle_gap, $fn = circle_sides);
                square([lens_diameter + mount_width*2 + buckle_gap*2, buckle_width], center = true);
            }
            circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
        }
            difference()
            {
                polygon([[-inner_corner_x,inner_corner_y],[-inner_circle_x,inner_corner_y],[inner_polygon_x,-inner_polygon_y]]);
                translate([-inner_circle_x,inner_circle_y])
                    circle(r2, $fn=circle_sides);
            }
}
difference()
{
    translate([0,buckle_width + buckle_thickness]) 
    square([lens_diameter + mount_width*2 + buckle_gap*2, buckle_width], center = true);
    difference()
    {
    polygon([[-outer_corner_x,outer_corner_y],[-outer_circle_x,outer_corner_y],[outer_polygon_x,-outer_polygon_y]]);
    translate([-outer_circle_x,outer_circle_y])
        circle(r1, center = true, $fn=circle_sides);
    }
    circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
}
    }
}

    //quadrant III
z_rotation3 = 180 + atan(inner_polygon_y/inner_polygon_x);
difference(){
    translate([0,0,mount_base])
    rotate([0,0,z_rotation3])
    rotate_extrude(angle = a, $fn=circle_sides)
        translate([mount_radius,0])
        difference()
        {
            polygon([[0,0],[0,r3],[r3,0]]);
            translate([r3,r3])
                circle(r3, $fn = circle_sides);
        }
        linear_extrude(height = mount_base + mount_height + inside_mount_height)
        union(){
        difference()
        {
        difference()
        {
            intersection()
            {
                circle(r = lens_diameter/2 + mount_width + buckle_gap, $fn = circle_sides);
                square([lens_diameter + mount_width*2 + buckle_gap*2, buckle_width], center = true);
            }
            circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
        }
            difference()
            {
                polygon([[-inner_corner_x,-inner_corner_y],[-inner_circle_x,-inner_corner_y],[inner_polygon_x,inner_polygon_y]]);
                translate([-inner_circle_x,-inner_circle_y])
                    circle(r2, $fn=circle_sides);
            }
}
difference()
{
    translate([0,-buckle_width - buckle_thickness]) 
    square([lens_diameter + mount_width*2 + buckle_gap*2, buckle_width], center = true);
    difference()
    {
    polygon([[-outer_corner_x,-outer_corner_y],[-outer_circle_x,-outer_corner_y],[outer_polygon_x,outer_polygon_y]]);
    translate([-outer_circle_x,-outer_circle_y])
        circle(r1, center = true, $fn=circle_sides);
    }
    circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
}
    }
}
    
        //quadrant IV
z_rotation4 = atan(inner_polygon_y/-inner_polygon_x);
difference(){
    translate([0,0,mount_base])
    rotate([0,0,z_rotation4])
    rotate_extrude(angle = -a, $fn=circle_sides)
        translate([mount_radius,0])
        difference()
        {
            polygon([[0,0],[0,r3],[r3,0]]);
            translate([r3,r3])
                circle(r3, $fn = circle_sides);
        }
        linear_extrude(height = mount_base + mount_height + inside_mount_height)
    union(){
        difference()
        {
        difference()
        {
            intersection()
            {
                circle(r = lens_diameter/2 + mount_width + buckle_gap, $fn = circle_sides);
                square([lens_diameter + mount_width*2 + buckle_gap*2, buckle_width], center = true);
            }
            circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
        }
            difference()
            {
                polygon([[inner_corner_x,-inner_corner_y],[inner_circle_x,-inner_corner_y],[-inner_polygon_x,inner_polygon_y]]);
                translate([inner_circle_x,-inner_circle_y])
                    circle(r2, $fn=circle_sides);
            }
}
difference()
{
    translate([0,-buckle_width - buckle_thickness]) 
    square([lens_diameter + mount_width*2 + buckle_gap*2, buckle_width], center = true);
    difference()
    {
    polygon([[outer_corner_x,-outer_corner_y],[outer_circle_x,-outer_corner_y],[-outer_polygon_x,outer_polygon_y]]);
    translate([outer_circle_x,-outer_circle_y])
        circle(r1, center = true, $fn=circle_sides);
    }
    circle(r = lens_diameter/2 + mount_width, $fn = circle_sides);
}
    }
}
}
