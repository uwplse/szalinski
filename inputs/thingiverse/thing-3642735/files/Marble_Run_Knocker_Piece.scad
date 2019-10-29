marble_radius=7;//radius of the marble holes
peg_radius=3.5;//radius of the peg holes
marble_spacing=12.5;//spacing between centers of marble holes
holes=10;//radius of holes
piece_width=19.5;//width of block
piece_height=10;//half of block's height(full one is 20)
cylinder_height=12;//height of holes
peg_translate=90;//far peg y translate amount
cube_x=5;//peg block x dimensions(now z due to rotate)
cube_y=10;//peg block y dimensions
cube_z=20;//peg block z dimensions(now x due to rotate)
peg_hole_height=10;//height of peg
cylinder_translate=30;//translate of peg hole
spacing_subtract=0.5;//add this to the bottom block
Z_translate=15;//translate the main block
extra_space_hole=1;//extra space for the hole
$fn=50;//it's $fn, you don't need an explanation


translate([0,0,Z_translate]){
rotate([0,180,0]){
difference(){
    translate([0-(piece_width/2),0-marble_radius,0-(piece_height/2)])
    cube([piece_width,(marble_spacing-0.5)*holes,piece_height]);//main block (with holes)

for(i=[0:holes]){//holes
    translate([0, marble_spacing*i,0-(cylinder_height/2)])
    cylinder(r=marble_radius-2,h=cylinder_height);
}
}

difference(){
    
    translate([0-(piece_width/2),0-marble_radius,(piece_height/2)])
    cube([piece_width,(marble_spacing-spacing_subtract)*holes,piece_height]);//block that covers bottom of holes
    
translate([(-piece_width/2)+3,0,piece_height/2])
cube([cube_x+extra_space_hole,cube_y+extra_space_hole,cube_z]);//hole for peg block1

translate([(-piece_width/2)+3,peg_translate,piece_height/2])
cube([cube_x+extra_space_hole,cube_y+extra_space_hole,cube_z]);//hole for peg block2
}
}
}

rotate([0,90,0]){
difference(){
translate([(-piece_width/2)+5,0,piece_height*2])
cube([cube_x,cube_y,cube_z]);//cube for peg block1
translate([(-piece_width/2),5,(piece_height/2)+cylinder_translate])
rotate([0,90,0])
cylinder(r=peg_radius,h=peg_hole_height);//cylinder for peg block1
}

difference(){
translate([(-piece_width/2)+5,peg_translate,piece_height*2])
cube([cube_x,cube_y,cube_z]);//cube for peg block2
translate([(-piece_width/2),(peg_translate+5),(piece_height/2)+cylinder_translate])
rotate([0,90,0])
cylinder(r=peg_radius,h=peg_hole_height);//cylinder for peg block2
}
}

rotate([270,0,0])
translate([(-piece_width/2)+1,-piece_height*2,(-Z_translate/2)+0.5])
cylinder(r=1,h=(marble_spacing-0.5)*holes);
