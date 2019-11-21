use <parametric_star.scad>
font="Ladislav:style=BOLD";

diameter=40;
ring_thickness=1.2;
hole_diameter=5;
hole_offset=15;
height=1.2;
company_text="VERTIX";
company_text_size=7;

PF_Text_1 = "PF 2018";
PF_Text_1_size=7;
PF_Text_height=0.6;

PF_Text_2 = "2018";
PF_Text_2_size=6;

star_offset_x=8;
star_offset_y=10;

star_points_number=6;
star_inner_radius=2;
star_re=5;

$fn=100;

Assembly();

module Assembly()
{
    union(){
        //Hole
        difference(){
            cylinder(d=diameter, h=height);
            translate([0,hole_offset,0]) cylinder(d=hole_diameter, h=height);
        }
        
        //
        difference(){
            translate([0,0,height]) cylinder(d=diameter, h=PF_Text_height);
            translate([0,0,height]) cylinder(d=diameter-2*ring_thickness, h=PF_Text_height);
        }
        //text PF
        translate([0,0,height])linear_extrude(height=PF_Text_height, $fn=150){
            text(PF_Text_1, font=font, size=PF_Text_1_size, halign = "center", valign="center" );
        };
        //text Company
        translate([0,-10,height])linear_extrude(height=PF_Text_height, $fn=150){
            text(company_text, font=font, size=company_text_size, halign = "center", valign="center" );
        };
        //stars
    translate([-star_offset_x,star_offset_y,height]) parametric_star(N=star_points_number,h=PF_Text_height, ri=star_inner_radius, re=star_re);
    translate([star_offset_x,star_offset_y,height]) rotate([0,0,180])parametric_star(N=star_points_number,h=PF_Text_height, ri=star_inner_radius, re=star_re);
};    
     
};