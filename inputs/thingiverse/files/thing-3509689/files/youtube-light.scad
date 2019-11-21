
$fn=64;
case_radius         = 99 / 2;
case_height         = 22;
case_thickness      = 1.6;
tolerance           = 0.2;

support_radius      = 5;
support_hole        = 1.3;
supoort_offset      = 0;

bracket_width       = 20;
bracket_height      = 50;
bracket_nut         = 11;
bracket_nut_height  = 5.6;

make_top();

//make_case();

// top
module make_top()
{
    // ring
    translate([0,0,case_height+case_thickness])
    rotate([0,180,0])
    union()
    {
        translate([0,0,-case_thickness])
        {
            // outer ring
            intersection()
            {
                make_all_support(h=case_thickness,r=3);
                cylinder(h=case_thickness,r=case_radius-tolerance-0.4);

            }
        }
        
        // Hole plate top
        difference()
        {
            linear_extrude(case_thickness)
            difference()
            {
                circle(case_radius-tolerance);
                make_holes(cr=(case_radius+case_thickness)*0.9,r=1.4);
            }      
            make_support_ring_cuts_out(sr=support_hole-case_thickness,h=50);
        }
    }
}

// case
module make_case()
{
    union()
    {
        // bottom
        union()
        {
            cylinder(r=20,h=case_thickness);
            difference()
            {
                cylinder(r=case_radius+case_thickness,h=case_thickness);
                rotate([0,0,45])
                cube([case_radius*2.0*0.9,3,case_thickness*3],center=true);
                rotate([0,0,-45])
                cube([case_radius*2.0*0.9,3,case_thickness*3],center=true);
                
                translate([30,0,0])
                cylinder(r=7,h=case_thickness);
            }
            
        }

        // side
        translate([0,0,case_thickness])
        difference()
        {
            
            linear_extrude(case_height)
            difference()
            {
                circle(case_radius+case_thickness);
                circle(case_radius);
            }

            // wire hole
            translate([0,0,(case_height-6)/2])
            rotate([90,0,26])
            cube([4,6,100]);

        }
        
        // support
        translate([0,0,case_thickness])
        make_all_support(sr=support_radius,h=case_height-case_thickness-tolerance,r=support_hole);
        
        // BRACKET
        rotate([0,0,45])
        {
            
            
            
            difference()
            {
                linear_extrude(case_height)
                {
                    difference()
                    {
                        translate([-bracket_width/2,-case_radius-40,0])
                        {
                            
                            difference()
                            {
                                // Nut Hole
                                square([bracket_width,bracket_height]);
                                //translate([(bracket_width-bracket_nut)/2,3,0])
                                //    square([bracket_nut,bracket_nut_height]);
                                
                                // 장식??
                                for(i=[1:3])
                                {
                                    translate([(bracket_width-bracket_nut)/2,3 + (bracket_nut_height*i*2),0])
                                        square([bracket_nut,bracket_nut_height]);
                                }
                            }
                        }
                        circle(r=case_radius+case_thickness);
                    }
                }
                // 여기 좀 지저분
                // Camera Nut Hole
                translate([0,-85,(case_height)/2])
                rotate([90,90,0])
                cylinder(r=6.5/2,h=20);
                
                // Camera Nut Cap
                translate([0,-80.9,(case_height)/2])
                rotate([90,90,0])
                cylinder(r=14/2,h=bracket_nut_height+tolerance,$fn=6);

                // Camera Nut Cap 2
                translate([0,-80.9,case_height*0.75])
                rotate([90,90,0])
                cylinder(r=14/2,h=bracket_nut_height+tolerance,$fn=6);
                
                // Camera Nut Cap 2
                translate([0,-80.9,case_height])
                rotate([90,90,0])
                cylinder(r=14/2,h=bracket_nut_height+tolerance,$fn=6);
            }
        }

    }
    
}

module make_all_support(h,r)
{
    // support
    translate([0,case_radius-support_radius+case_thickness,0])
    make_support(h=h,r=r);

    translate([0,-case_radius+support_radius-case_thickness,0])
    make_support(h=h,r=r);

    translate([case_radius-support_radius+case_thickness,0,0])
    make_support(h=h,r=r);

    translate([-case_radius+support_radius-case_thickness,0,0])
    make_support(h=h,r=r);

}

module make_support_ring_cuts_out(sr,h)
{
    translate([0,case_radius-support_radius+case_thickness,0])
    cylinder(h=h,r=sr + case_thickness);

    translate([0,-case_radius+support_radius-case_thickness,0])
    cylinder(h=h,r=sr + case_thickness);

    translate([case_radius-support_radius+case_thickness,0,0])
    cylinder(h=h,r=sr + case_thickness);

    translate([-case_radius+support_radius-case_thickness,0,0])
    cylinder(h=h,r=sr + case_thickness);
}



module make_support(h,r)
{
    linear_extrude(h)
    {
        difference()
        {
            circle(support_radius);
            circle(r);
        }    
    }       
}

module make_holes(cr=50,r=3/2,f=16)
{
    // step 
    step_count = cr / r * 0.25 * 0.95;   // 0.9 == offset
    for (step=[1:step_count])
    {
        hole_radius = step * r * 4.0;
        hole_num = 8*step;
        for (i=[1:hole_num])  
        {
            translate([hole_radius*cos(i*(360/hole_num)),hole_radius*sin(i*(360/hole_num)),0]) circle(r,$fn=f);
        }
    }
}