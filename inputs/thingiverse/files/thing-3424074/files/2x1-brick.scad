
//Spacing factor between pieces
gap_factor = .15; //.05 to .2


/* No need to modify anything else */

/* [Hidden] */

lego_unit = 1.6;

brick_height=6 * lego_unit;
unit_span = (5 * lego_unit);



//wide edges
cube([(2*unit_span)-gap_factor,lego_unit-(gap_factor/2),brick_height],0);

translate([0,(4*lego_unit),0])
{
    cube([(2*unit_span)-gap_factor, lego_unit-(gap_factor/2),brick_height],0);
};

//top
translate([0,unit_span-gap_factor, brick_height-lego_unit])
{
    rotate([90,0,0])
    {
          cube([(2*unit_span)-gap_factor, lego_unit,unit_span- gap_factor],0);  
    }
};
//short edges
translate([lego_unit-(gap_factor/2), 0, 0])
{
    rotate([0,0,90])
    {
        cube([unit_span-gap_factor, lego_unit-(gap_factor/2),brick_height],0);
    }
};


translate([unit_span*2 - gap_factor,0,0])
{
    rotate([0,0,90])
    {
        cube([unit_span-gap_factor, lego_unit-(gap_factor/2),brick_height],0);
    }
}

//studs
stud_dia = (lego_unit*1.5) - (gap_factor/4);
translate([(unit_span/2)+(gap_factor/2),(unit_span-gap_factor)/2,brick_height])
{
    cylinder(lego_unit,stud_dia, stud_dia, $fn=40);
};

translate([unit_span*1.5 - (gap_factor/2),(unit_span-gap_factor)/2,brick_height])
{
    cylinder(lego_unit,stud_dia, stud_dia, $fn=40);
};
