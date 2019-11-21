length = 170;

width = 40;

height = 4;

hole_size = 4;

hole_spacing = 1;

difference() {
    //main body
    cube([length, width, height]);
    
    //calculate how many rows of holes there can be
    rows = floor((length-hole_spacing) / (hole_size+hole_spacing));
    
    startlength = (length - hole_spacing - rows*(hole_size+hole_spacing)) / 2 + hole_spacing;
    
    //calculate how many columns of holes there can be
    columns = floor((width-hole_spacing) / (hole_size+hole_spacing));
    startwidth = (width - hole_spacing - columns*(hole_size+hole_spacing)) / 2 + hole_spacing;
    
    //holes
    for(i = [0 : rows-1]) {
        for(j = [0 : columns-1]) {
            translate([startlength + i * (hole_size+hole_spacing),
            startwidth + j * (hole_size+hole_spacing), -1])
            cube([hole_size,hole_size,height+2]);
        }
    }
}