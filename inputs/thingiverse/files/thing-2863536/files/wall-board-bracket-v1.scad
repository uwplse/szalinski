board_height=16;
thickness = 2;
spacing = 10;
size=100;
screwdiameter=3;
screwspacing=spacing*0.75;

module bracket() {
    difference()
    {
        difference()
        {
            minkowski()
            {cylinder(r=thickness,h=thickness,$fn=20);
            linear_extrude(board_height+thickness*2)
            {
               polygon([[size+(thickness*5),0],[0,size+(thickness*5)],[0,0]]);
            }
        }

            minkowski()
            {cylinder(r=thickness,h=thickness,$fn=20);
            translate([0,0,-thickness]) {
                linear_extrude(board_height+thickness)
                {
                polygon([[size+(thickness*4)+spacing,thickness*5+spacing],[thickness*5+spacing,size+(thickness*4)+spacing],[thickness*5+spacing,thickness*5+spacing]]);
                }
            }
        }
        }
    }
}

    

difference()
{
    bracket();
    translate([thickness-spacing/2,thickness-spacing/2,thickness*2])
        {
    bracket();
    }
    
    //holes
translate([screwspacing,screwspacing,-thickness])
    linear_extrude(thickness*3)
        circle(screwdiameter,$fn=20);

translate([screwspacing*(size/screwspacing*0.75),screwspacing,-thickness])
    linear_extrude(thickness*3)
        circle(screwdiameter,$fn=20);

translate([screwspacing,screwspacing*(size/screwspacing*0.75),-thickness])
    linear_extrude(thickness*3)
        circle(screwdiameter,$fn=20);

}
