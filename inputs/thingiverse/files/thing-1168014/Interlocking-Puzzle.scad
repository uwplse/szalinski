/* [Global] */
/* [Settings] */
part="assembled"; //[first:Piece 1,second:Piece 2,third:Piece 3,assembled:All assembled]
//of the assembled cube
total_size=18;
cube_size=total_size/3;
//between the parts
gap=0.2;//[0:0.01:0.5]
//reciprocal size of the chamfer
chamfer_size=20; //[4:50]
corner=cube_size/chamfer_size; //<=cube_size/4

/* [Hidden] */
eps=0.01;

print_part();


module print_part() {
	if (part == "first") {
		final_piece1();
	} else if (part == "second") {
		final_piece2();
	} else if (part == "third") {
		final_piece3();
	} else {
		assembled();
	}
}

module piece1(chamfer=true)
{
    set_cube(1,1,-1,chamfer);
    set_cube(1,0,-1,chamfer);
    set_cube(1,-1,-1,chamfer);
    set_cube(0,-1,-1,chamfer);
    set_cube(-1,-1,-1,chamfer);
    set_cube(-1,0,-1,chamfer);
    set_cube(-1,1,-1,chamfer);
    set_cube(1,-1,0,chamfer);
    set_cube(-1,-1,0,chamfer);
    set_cube(-1,1,0,chamfer);
    set_cube(-1,1,1,chamfer);
}
module piece2(chamfer=true)
{
    set_cube(-1,1,-1,chamfer);
    set_cube(0,1,-1,chamfer);
    set_cube(0,0,-1,chamfer);
    set_cube(1,-1,-1,chamfer);
    set_cube(0,-1,-1,chamfer);
    set_cube(-1,-1,-1,chamfer);
    set_cube(0,1,0,chamfer);
    set_cube(0,-1,0,chamfer);
    set_cube(0,1,1,chamfer);
}
module piece3(chamfer=true)
{
    set_cube(1,0,-1,chamfer);
    set_cube(1,-1,-1,chamfer);
    set_cube(-1,-1,-1,chamfer);
    set_cube(-1,0,-1,chamfer);
    set_cube(0,0,-1,chamfer);
    set_cube(0,1,-1,chamfer);
    set_cube(1,0,0,chamfer);
}

module assembled()
{
    color("red")
    final_piece1();
    color("green")
    rotate([180,0,180])
    final_piece2();
    color("blue")
    translate([0,cube_size,0])
    rotate([-90,0,0])
    final_piece3();
}

module set_cube(x,y,z,chamfer=true)
{
    translate([x*cube_size,y*cube_size,z*cube_size])
    if (chamfer)
        chamfer_cube(cube_size+eps,cube_size+eps,cube_size+eps,corner);
    else
        cube([cube_size+eps,cube_size+eps,cube_size+eps],center=true);
}

module chamfer_cube(x,y,z,delta)
{
    intersection()
    {
    size=x;
        linear_extrude(z,center=true)
            chamfer_square(x,y,delta);
        rotate([0,90,0])
            linear_extrude(x,center=true)
            chamfer_square(z,y,delta);
        rotate([90,0,0])
            linear_extrude(y,center=true)
            chamfer_square(x,z,delta);
    }
}

module chamfer_square(x,y,delta)
{
    offset(r=-delta,chamfer=true){
        square([x,y+2*delta],center=true);
        square([x+2*delta,y],center=true);
    }
}

module final_piece1()
{
    difference() //for the gap
    {
        piece1();
        scale(1+gap/cube_size)
        {
        rotate([180,0,180])
            piece2(chamfer=false);
        translate([0,cube_size,0])
            rotate([-90,0,0])
                piece3(chamfer=false);
        }
    }
}

module final_piece2()
{
    difference() //for the gap
    {
        piece2();
        rotate([180,0,180])
        scale(1+gap/cube_size)
        {
            piece1(chamfer=false);
            translate([0,cube_size,0])
                rotate([-90,0,0])
                    piece3(chamfer=false);
        }
    }
}

module final_piece3()
{
    difference() //for the gap
    {
        piece3();
        translate([0,0,-cube_size])
        rotate([90,0,0])
        scale(1+gap/cube_size)
        {
            piece1(chamfer=false);
        rotate([180,0,180])
            piece2(chamfer=false);
        }
    }
}