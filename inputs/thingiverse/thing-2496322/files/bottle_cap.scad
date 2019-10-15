//The inner diameter of the hole
inner_diameter = 21.15;
//The outer diameter of the hole's tube (a.k.a. the diameter of the pipe if you are capping a pipe - how far the top of the cap extends around the hole)
outer_diameter = 25.5;
//The height of the actual cap part - the mesh
cap_height = 1;
//How far into the hole the cap extends
lip_depth = 6;
//The thickness of the mesh lines
mesh_width=0.8;
//The size of the square holes in the mesh
gap_size=2;
//Whether the lip extends into the hole on the inside, or caps around it on the outside
lip_type="inner";// ["inner","outer"]
//The thickness of the lip
lip_thickness=2;
//Whether or not to have the mesh
have_mesh=true;

//Advanced: Cylinder segment resolution
res = 128;

rotate([180])
if(lip_type=="inner")
{
    difference(){
        translate([0,0,-lip_depth])
            cylinder(d=outer_diameter, h=cap_height+lip_depth, $fn=res);
        translate([0,0,-lip_depth-1])
            cylinder(d=inner_diameter-lip_thickness*2, h=lip_depth+1, $fn=res);
        if(have_mesh){
            CircularMesh(inner_diameter - lip_thickness*2);
        }
        difference(){
            translate([0,0,-lip_depth-1])
            cylinder(d=outer_diameter+1, h=lip_depth+1, $fn=res);
            translate([0,0,-lip_depth-2])
            cylinder(d=inner_diameter, h=lip_depth+2, $fn=res);
        }
    }
}else if(lip_type=="outer"){
    difference(){
        translate([0,0,-lip_depth])
        cylinder(d=outer_diameter+lip_thickness*2, h=cap_height+lip_depth, $fn=res);
        translate([0,0,-lip_depth-1])
        cylinder(d=outer_diameter, h=lip_depth+1, $fn=res);
        if(have_mesh){
            CircularMesh(inner_diameter);
        }
    }
}


module CircularMesh(diameter){
    translate([0,0,-1])
    intersection(){
    cylinder(d=diameter, h=cap_height+2, $fn=res);
        union(){
            for(i = [-inner_diameter/2-mesh_width:gap_size+mesh_width:inner_diameter/2+mesh_width])
            {
                for(o = [-inner_diameter/2-mesh_width:gap_size+mesh_width:inner_diameter/2+mesh_width])
                {
                    translate([i,o,0])
                    cube(size=[gap_size,gap_size, cap_height+2]);
                }
            }
        }
    }
}