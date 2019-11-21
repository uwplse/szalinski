use <threads.scad>

/**
 * Blau:
 ********************************
 * cal_size                = 22;
 * outer_d                 = 50;
 * wall_size               = 2;
**/

/**
 * Rot:
 ********************************
 * cal_size                = 20;
 * outer_d                 = 60;
 * wall_size               = 3;
 * deflector_count         = 6;
**/

/**
 * Rosa:
 ********************************
 * cal_size                = 20;
 * outer_d                 = 60;
 * wall_size               = 3;
 * deflector_count         = 8;
**/

$fa                     = 1;
$fs                     = 0.2;
wall_size               = 5;
outer_d                 = 55;
inner_d                 = outer_d-(2*wall_size);
cal_size                = 22;
deflector_count         = 7;
barrel_cover_length     = 30;
barrel_threat_length    = 8;
barrel_threat           = 22.5;
barrel_outer_size       = 26.5; //25.8
main_chamber_hight      = deflector_count*(2*cal_size)+cal_size;
deflector_start_hight   = barrel_cover_length+barrel_threat_length+cal_size;
total_hight             = barrel_cover_length + barrel_threat_length + main_chamber_hight+4;
air_hole_d              = 5;

difference()
{
    supressor();
    
    translate([0,0,40])             rotate_extrude() translate([(outer_d/2)+3,0,0]) circle(d=8);      
    translate([0,0,total_hight-40]) rotate_extrude() translate([(outer_d/2)+3,0,0]) circle(d=8);
    translate([0,0,total_hight-70]) rotate_extrude() translate([(outer_d/2)+3,0,0]) circle(d=8);
    
    for(y=[0:18])
    {
        rotate([0,0,(y*20)]) translate([(outer_d/2)+(wall_size-2),0,50]) rising(250,5);
    }
    
}


//rising(15, 5);

module air_hole()
{
    cylinder(d=air_hole_d, h=(10));
}

module rising(hoehe, durchmesser)
{
    union()
    {
        translate([0,0,0]) sphere(d=durchmesser);
        translate([0,0,0]) cylinder(d=durchmesser, h=hoehe-(durchmesser));
        //translate([0,0,hoehe-(3*durchmesser)]) cylinder(d1=durchmesser, d2=0, h=hoehe-(3*durchmesser));
        translate([0,0,(hoehe-(durchmesser))]) sphere(d=durchmesser);  
    }
}

module supressor()
{
    union()
    {
        difference()
        {
            basetube();
            
            cylinder(d=barrel_outer_size, h=barrel_cover_length);
            translate([0,0,barrel_cover_length]) metric_thread(barrel_threat, 1, barrel_threat_length);
            translate([0,0,barrel_cover_length+barrel_threat_length]) mainchamber();
            translate([0,0,total_hight-4]) cylinder(d1=cal_size, d2=cal_size+2, h=10);
            
            air_hole_pos = (cal_size+((outer_d-cal_size)/2))/13;
            
            for(x=[0:5])
            {
                rotate([air_hole_pos,0,x*60]) translate([0,0,total_hight-5])  air_hole();
            }
        }
        
        difference()
        {
            translate([0,0,barrel_cover_length+barrel_threat_length]) cylinder(d=inner_d,h=10);
            translate([0,0,barrel_cover_length+barrel_threat_length]) cylinder(d1=barrel_threat,d2=inner_d,h=10);
        }
        
        
        for(x=[0:deflector_count-1])
        {
            translate([0,0,deflector_start_hight+(x*(2*cal_size))]) deflector();
        }
    }
    
}

module mainchamber()
{
    cylinder(d=inner_d, h=main_chamber_hight);
    /**
    
    **/
}

module basetube()
{
    translate([0,0,total_hight-2]) plate();
    translate([0,0,2]) cylinder(d=outer_d, h=total_hight-4);
    translate([0,0,2]) plate();
}

module topplate()
{
    translate([0,0,total_hight-2]) cylinder(h=4, d=outer_d-4);
    translate([0,0,total_hight]) rotate_extrude() translate([(outer_d-4)/2,0,0]) circle(d=4);
}

module plate()
 {
     translate([0,0,-2]) cylinder(h=4, d=outer_d-4);
     rotate_extrude() translate([(outer_d-4)/2,0,0]) circle(d=4);
 }

module deflector()
{
    translate([0,0,cal_size])
    {
        rotate([0,180,0])
        {
            union()
            {
                difference()
                {
                    cylinder(d1=inner_d+(2*wall_size), d2=cal_size+(2*wall_size), h=cal_size);
                    cylinder(d1=inner_d, d2=cal_size, h=cal_size);
                }
                
                difference()
                {
                    translate([0,0,-cal_size]) cylinder(d=inner_d+(2*wall_size), h=cal_size);
                    translate([0,0,-cal_size]) cylinder(d=inner_d, h=cal_size);   
                }
            }
        }
    }
}