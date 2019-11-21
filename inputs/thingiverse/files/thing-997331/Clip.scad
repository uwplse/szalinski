length=10; //length of clip
//width=23; //width for sternum strap
width=29; //width for shoulder strap
wall_thickness=1.5; //wall thickness
gap_height=2.75; //height of gap
clip_entrance_width=width/2-5; //clip entrance

cube([length,width,wall_thickness]);
translate([0,0,wall_thickness])
    cube([length,wall_thickness,gap_height+wall_thickness]);
translate([0,width-wall_thickness,wall_thickness])
    cube([length,wall_thickness,gap_height+wall_thickness]);
translate([0,0,gap_height+2*wall_thickness])
    cube([length,clip_entrance_width,wall_thickness]);
translate([0,width-clip_entrance_width,gap_height+wall_thickness+wall_thickness])
    cube([length,clip_entrance_width,wall_thickness]);