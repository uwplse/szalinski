// Upload your image flile
image_file = "test.dxf"; // [image_surface:100x100]

/*[basic settings]*/
// set the position of the handle (depends on the picture colour, so you have to set it manually!
offset = 30;
// handle radius in mm
radius = 5;
//handle height in mm
handle_height= 40;
/*[Image cutter]*/
//set the factor for the cutouts
cut = 2;
//set the height of the cutter tool(not autmatic unless you download it and follow the instructions in the description)
height = 5;
/*[Hidden]*/

translate([0, 0, 0]) scale([1,1,cut]) surface(file=image_file, center=true, convexity=10);
translate([0,0,offset]) cylinder(r1 = radius,r2 = radius, h = handle_height, center = true);


