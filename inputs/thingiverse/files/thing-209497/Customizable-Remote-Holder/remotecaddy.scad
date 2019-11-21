include <write/Write.scad>

/* [Config] */
smallest_height=45;
tallest_height=110;

num_rows=3;

compartment_width=59;
compartment_depth=30;
remotes_per_row=3;

/* [Advanced] */
wall_thickness=2;
front_text="TV TIME !";
font_size=12;
font_spacing=2;
//TODO: mouse ears

/* [Hidden] */
height_increase_per_row=(tallest_height-smallest_height)/num_rows;
total_width=remotes_per_row*compartment_width+(remotes_per_row+1)*wall_thickness;
total_depth=num_rows*compartment_depth+(num_rows+1)*wall_thickness;


//floor
cube([total_width,total_depth,wall_thickness]);

//x walls
for ( i = [0:num_rows]){
	translate([0,i*(compartment_depth+wall_thickness),0])cube([total_width,wall_thickness,smallest_height+i*height_increase_per_row]);

}
   writecube(front_text,[total_width/2,0,smallest_height/2],[total_width,wall_thickness,smallest_height],face="front",h=font_size,space=font_spacing);

//y walls
for ( i = [0:remotes_per_row]){
 translate([i*(compartment_width+wall_thickness),0,0])cube([wall_thickness,total_depth,smallest_height]);
}
