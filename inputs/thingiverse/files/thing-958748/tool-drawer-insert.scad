//This is tool drawer insert
//It is a rectangular box with an optional sloping inner edge on the front or all-round.
outer_height = 25;
outer_width = 35;
outer_length = 130;
wall_thickness = 1;
inner_ramps = "none"; //[none:no ramps,front:front ramp only,all:ramps on all sides]

drawer_insert();

module drawer_insert()
{
    //Print the base 
    linear_extrude(height=wall_thickness)
        square([outer_width, outer_length], center=true);
    //create the wall outer 
    linear_extrude(height=outer_height)
        polygon(
            points=[
                [-1*outer_width/2, -1*outer_length/2],
                [-1*outer_width/2, +1*outer_length/2],
                [+1*outer_width/2, +1*outer_length/2],
                [+1*outer_width/2, -1*outer_length/2],
                [-1*(outer_width/2-wall_thickness), -1*(outer_length/2-wall_thickness)],
                [-1*(outer_width/2-wall_thickness), +1*(outer_length/2-wall_thickness)],
                [+1*(outer_width/2-wall_thickness), +1*(outer_length/2-wall_thickness)],
                [+1*(outer_width/2-wall_thickness), -1*(outer_length/2-wall_thickness)],
            ], 
            paths=[
                [0,1,2,3],
                [4,5,6,7]
            ]
        );
    //Make the inside curve arc
    unit_arc=[
        [1,1],
        [cos(0),sin(0)],
        [cos(5),sin(5)],
        [cos(10),sin(10)],
        [cos(15),sin(15)],
        [cos(20),sin(20)],
        [cos(25),sin(25)],
        [cos(30),sin(30)],
        [cos(35),sin(35)],
        [cos(40),sin(40)],
        [cos(45),sin(45)],
        [cos(50),sin(50)],
        [cos(55),sin(55)],
        [cos(60),sin(60)],
        [cos(65),sin(65)],
        [cos(70),sin(70)],
        [cos(75),sin(75)],
        [cos(80),sin(80)],
        [cos(85),sin(85)],
        [cos(90),sin(90)],
    ];
    if ((inner_ramps == "front")||(inner_ramps=="all"))
    {
        //Scale for the front
        arc_radius = outer_height;
        if (outer_length < outer_height)
        {
            arc_radius = outer_length;
        }
        scaled_arc = unit_arc * arc_radius;
        //
        translate([0,-1* (outer_length/2 - arc_radius-wall_thickness),outer_height])
        rotate([-90,90,90])
        linear_extrude(height=outer_width, center=true)
            polygon(scaled_arc);
    }
    if (inner_ramps=="all")
    {
        //Scale for the rear
        arc_radius = outer_height;
        if (outer_length < outer_height)
        {
            arc_radius = outer_length;
        }
        scaled_arc = unit_arc * arc_radius;
        //
        translate([0,+1* (outer_length/2 - arc_radius-wall_thickness),outer_height])
        rotate([+90,90,90])
        linear_extrude(height=outer_width, center=true)
            polygon(scaled_arc);
        //Scale for the left
        arc_radius = outer_height;
        if (outer_width < outer_height)
        {
            arc_radius = outer_width;
        }
        scaled_arc = unit_arc * arc_radius;
        //
        translate([+1* (outer_width/2 - arc_radius-wall_thickness),0,outer_height])
        rotate([+90,90,0])
        linear_extrude(height=outer_length, center=true)
            polygon(scaled_arc);
       //Scale for the right
        arc_radius = outer_height;
        if (outer_width < outer_height)
        {
            arc_radius = outer_width;
        }
        scaled_arc = unit_arc * arc_radius;
        //
        translate([-1* (outer_width/2 - arc_radius-wall_thickness),0,outer_height])
        rotate([+90,90,180])
        linear_extrude(height=outer_length, center=true)
            polygon(scaled_arc);
    }
       
}
