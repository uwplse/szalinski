//perameters
organizerHeight = 15;
organizerWidth = 25;

numberOfTools = 10;
toolCutoutWidth = 10;
toolCutoutDepth = 10;
spaceBetweenToolCutouts = 10;

//Find the initial length of the organizer
organizerLength = (numberOfTools*toolCutoutWidth)+(numberOfTools*spaceBetweenToolCutouts);
difference () {
//Generate the base shape
cube(size=[organizerLength,organizerWidth,organizerHeight], center = false);
    for(i = [0:numberOfTools-1]) {
        //Generate a cutout for each number of tools
        cutoutSpot = (spaceBetweenToolCutouts/2) + (i * (toolCutoutWidth+spaceBetweenToolCutouts));
        
        //Cube for the flat sides
        translate([cutoutSpot,-5,organizerHeight-toolCutoutDepth+toolCutoutWidth/2])
        cube([toolCutoutWidth,organizerWidth+10, toolCutoutDepth]);
        
        //Cylinder for the rounded bottom
        rotate([-90,0,0])
        translate([toolCutoutWidth/2+cutoutSpot,-(organizerHeight)+toolCutoutDepth-toolCutoutWidth/2,-10])
        cylinder(h=organizerWidth+20, r=toolCutoutWidth/2, center=false, $fn=100);
    }
}
