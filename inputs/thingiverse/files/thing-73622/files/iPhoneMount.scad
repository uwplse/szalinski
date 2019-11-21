// Phone width in mm (iPhone4/S=9.3, iPhone5=7.6, iPhone6=7.05)
phone_width=7.05;

// Width of the base of your tripod mount
base_width=43.25;

// Height of the slanted area of your tripod mount
base_height=9.1;

// Difference in width between the base and top of the mount
base_inset=4.1;

// Difference in width between the base bottom width and width if it hadn't been chopped off
base_cutout = 0.8;

// Width of the holder bars
holder_width=10;

// Height of the holder bars
holder_height=20;

base_width_2 = base_width + base_cutout;

phone_width_2 = phone_width + 0.05; // add a tiny bit of extra so phone can slide in

union() {

// base
intersection() {
    //slanted cube
	polyhedron(points=[[-base_cutout,-base_cutout,0],
                   [base_inset,base_inset,base_height],
                   [-base_cutout,base_width+base_cutout,0],
                   [base_inset,base_width-base_inset,base_height],
                   [base_width+base_cutout,base_width+base_cutout,0],
                   [base_width-base_inset,base_width-base_inset,base_height],
                   [base_width+base_cutout,-base_cutout,0],
                   [base_width-base_inset,base_inset,base_height]],
           triangles=[[2,1,0],[1,2,3],[4,3,2],[3,4,5],[6,5,4],[5,6,7],[0,7,6],[7,0,1],
				     [4,2,0],[0,6,4],[1,3,5],[5,7,1]]
           );
	
	//whatever the bigger shape, clip it to base_width
	cube([base_width,base_width,50]);
}

// phone holder
translate([base_inset,base_width-base_width/2-holder_width-phone_width/2,base_height]) 
	cube([base_width-base_inset*2,holder_width,holder_height]);
translate([base_inset,base_width-base_width/2+phone_width/2,base_height])
	cube([base_width-base_inset*2,holder_width,holder_height]);

}

