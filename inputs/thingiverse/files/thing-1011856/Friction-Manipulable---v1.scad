// Science Manipulable - Friction

// Parameters

/* [Parameters] */
base_length = 80;
base_width = 10;
base_height = 15;
teeth_height = 2;
num_teeth = 10;


/* [Hidden] */
teeth_width = base_length/num_teeth;

// isosolese triangle module
module iso_triangle(width,height,thickness)
{
    linear_extrude(height = thickness,center = true)
        polygon(points = [[0,0],[width,0],[width/2,height]],path = [0,1,2]);
}

// Main
cube([base_length,base_width,base_height]);
for(i=[0:num_teeth-1])
{
    echo(i);
    translate([i*teeth_width,base_width/2,base_height])
        rotate([90,0,0])
            iso_triangle(teeth_width,teeth_height,base_width);
}





