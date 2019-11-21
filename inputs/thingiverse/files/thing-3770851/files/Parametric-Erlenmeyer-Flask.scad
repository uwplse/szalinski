//All code by Patrick Gaston, 7/2019.

// preview[view:south, tilt:side]

epsilon = 1*0.01;
pi = 1*3.14159;
rez_lo = 1*16;
rez_mid = 1*48;
rez_high = 1*96;
width_gradient_line = 1*10;
height_gradient_line = 1*1;
depth_gradient_line = 1*5;

//How thick is the wall and floor?
thickness_wall = 1.2; // [0.4:0.4:2.4]

//Set the radius of the flat part of base.
radius_base = 40; //[20:1:50]

//Curved radius relative to flat part of base.
base_curve_factor = .55;// [0:0.1:3]

//Cone height relative to flat part of base.
cone_height_factor = 5.0; // [0.1:0.1:10]

//Neck radius relative to flat part of base.
neck_radius_factor = 0.45; // [0.1:0.1:1]

//Neck height relative to flat part of base.
neck_height_factor = 0.6; // [0:0.25:5]

radius_quartercircle = radius_base * base_curve_factor;
height_body_cone = radius_base * cone_height_factor;
radius_neck = radius_base * neck_radius_factor;
height_neck = radius_base * neck_height_factor;
cone_angle = atan((radius_base + radius_quartercircle)/height_body_cone);
height_cone_neck_intersection = height_body_cone - (radius_neck/tan(cone_angle));
include_gradient_lines = 1*1; // [0,1]
include_gradient_text = 1*1; // [0,1]


Assemble_Flask();
//Partial_Fill();

module Assemble_Flask()
{
 Simple_Lip();
    
 difference()
    {
     union()
        {
         Build_Outer_Volume();
         Draw_Gradient_Lines();
        }
     translate([0,0, thickness_wall]) 
        Build_Inner_Volume();
    }
}


module Partial_Fill()
{
 //Model fluid filling flask part way.
 fill_fraction = 0.4; //Percent of cone height filled.   
 difference()
    {
     Build_Inner_Volume();
     translate([0,0, radius_quartercircle + fill_fraction*height_body_cone])
        cylinder(r = 2*(radius_base + radius_quartercircle), h = 2* height_body_cone);
    }
    
}

module Draw_Gradient_Lines()
    {
     for (current_line = [1:Count_Gradiation_Lines()])
        {
         current_target_volume = 1000*Min_Fifty_Milliliters_Above_Base() + ((current_line - 1) * 50000);
         current_height = Height_at_Total_Volume(current_target_volume);
         current_number = (current_line - 1) * 50 + Min_Fifty_Milliliters_Above_Base();

         if (include_gradient_lines == 1)
            {
             translate([-width_gradient_line/2,
                - Radius_At_Height(current_height - (radius_quartercircle + thickness_wall)) - thickness_wall,
                current_height])
             cube([width_gradient_line, depth_gradient_line, height_gradient_line]);
            }

         if (include_gradient_text == 1)
            {
             text_Z_rotation = 5 + atan(width_gradient_line / 
                Radius_At_Height(current_height - (radius_quartercircle + thickness_wall)));
             rotate([0,0,text_Z_rotation])
             translate([0, 5 - Radius_At_Height(current_height - (radius_quartercircle + thickness_wall)) - thickness_wall, current_height])
             rotate([90 - cone_angle,0,0])   
             linear_extrude(height = 5)
                text(str(current_number), 
                font = "Liberation Sans:style=Bold", 
                size = 5, 
                valign = "center",
                halign = "center");   
            }
        }
    }

module Simple_Lip()
{
 translate([0,0,radius_quartercircle + height_cone_neck_intersection + height_neck + thickness_wall])
 rotate_extrude($fn = rez_mid)   
 translate([radius_neck + thickness_wall,0,0])
 circle(r = thickness_wall, $fn = rez_lo);
}

module Build_Inner_Volume()
{
 //base cylinder
 cylinder(r = radius_base + epsilon, h = radius_quartercircle, $fn =rez_high);   
    
 //base quartercircle
 rotate_extrude(angle = 360, $fn = rez_high)
 translate([radius_base,0,0])
 intersection()
    {
     translate([0,radius_quartercircle,0])
        circle(r = radius_quartercircle, $fn = rez_mid);
     square(radius_quartercircle);
    }
    
 //neck cylinder
 translate([0,0,radius_quartercircle + height_cone_neck_intersection - epsilon])
    cylinder(r = radius_neck  + epsilon, h = height_neck, $fn =rez_high);

 //body cone
  translate([0,0,radius_quartercircle - epsilon])
  difference()
    {
     linear_extrude(height = height_body_cone, scale = 0.01)
        circle(r = radius_base + radius_quartercircle, $fn = rez_high);
     translate([0,0,height_cone_neck_intersection + 2* epsilon])
        cylinder(r = radius_neck * 2, h = 100);
    }
}

module Build_Outer_Volume()
{    
 //base cylinder
 cylinder(r = radius_base + epsilon, h = radius_quartercircle + thickness_wall, $fn =rez_high);   
    
 //base quartercircle
 rotate_extrude(angle = 360, $fn = rez_high)
 translate([radius_base,0,0])
 intersection()
    {
     translate([0,radius_quartercircle + thickness_wall,0])
        circle(r = radius_quartercircle + thickness_wall, $fn = rez_mid);
     square(radius_quartercircle + thickness_wall);
    }
    
 //neck cylinder
 translate([0,0,radius_quartercircle + height_cone_neck_intersection - epsilon])    
    cylinder(r = radius_neck + thickness_wall, h = height_neck + thickness_wall - epsilon, $fn =rez_high);

 //body cone
  translate([0,0,radius_quartercircle + thickness_wall - epsilon])
  difference()
    {    
     linear_extrude(height = height_body_cone, scale = thickness_wall / (radius_base + radius_quartercircle + thickness_wall))
       circle(r = radius_base + radius_quartercircle + thickness_wall, $fn = rez_high);
     translate([0,0,height_cone_neck_intersection + 2* epsilon])
       cylinder(r = radius_neck * 2, h = 100);
    }
}



function Volume_Cone_Total() = 
    (pi * height_body_cone * pow(radius_base + radius_quartercircle,2))/3;

function Volume_Base_Cylinder() =
    pi * pow(radius_base,2) * radius_quartercircle;

function Volume_Quartercircle() = 
    (2 * pi * (radius_base + ((4*radius_quartercircle) / (3*pi)))) * (pow(radius_quartercircle,2) * pi / 4);

function Volume_Cone_Above_Neck() = 
    (pi * (height_body_cone - height_cone_neck_intersection) * pow(radius_neck,2))/3;

function Volume_Cone_Below_Neck() = 
    Volume_Cone_Total() - Volume_Cone_Above_Neck();

function Volume_Total_Below_Neck() = 
    Volume_Cone_Below_Neck() + Volume_Base_Cylinder() + Volume_Quartercircle();

function Volume_Base() = 
    Volume_Base_Cylinder() + Volume_Quartercircle();
    
function Height_at_Cone_Volume(target_cone_volume) = 
    (height_body_cone - (pow(3* tan(cone_angle) * (Volume_Cone_Total() - target_cone_volume) / pi,1/3)/tan(cone_angle)));

function Height_at_Total_Volume(target_volume) =
    Height_at_Cone_Volume(target_volume - Volume_Base()) + radius_quartercircle + thickness_wall;
    
function Max_Fifty_Milliliters_Below_Neck() = 
    50 * floor(Volume_Total_Below_Neck()/50000);
    
function Min_Fifty_Milliliters_Above_Base() = 
    50 * ceil(Volume_Base()/50000);    
    
function Count_Gradiation_Lines() = 
    1 + (Max_Fifty_Milliliters_Below_Neck() - Min_Fifty_Milliliters_Above_Base()) / 50;

function Radius_At_Height(height) = 
    (height_body_cone - height) * tan(cone_angle);

function Radius_Cone_At_Height(height) = 
    tan(cone_angle) * (height_body_cone - height);