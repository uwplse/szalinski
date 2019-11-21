/* [Global] */
/* [Settings] */
part="assembled"; //[first:Piece 1,second:Piece 2,third:Piece 3,forth:Piece 4,fifth:Piece 5,sixth:Piece 6,assembled:All assembled]
//of the assembled cube
total_size=24;
cube_size=total_size/4;
//between the parts
gap=0.15;//[0:0.01:0.5]
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
	} else if (part == "forth") {
		final_piece4();
	} else if (part == "fifth") {
		final_piece5();
	} else if (part == "sixth") {
		final_piece6();
	} else {
		assembled();
	}
}

module piece1(chamfer=true)
{
    set_cube(-1.5,-0.5,0.5,chamfer);
    set_cube(-1.5,0.5,0.5,chamfer);
    set_cube(-1.5,0.5,1.5,chamfer);
    set_cube(-0.5,-0.5,0.5,chamfer);
    set_cube(0.5,-0.5,0.5,chamfer);
    set_cube(1.5,-0.5,0.5,chamfer);
    set_cube(1.5,0.5,0.5,chamfer);
}
module piece2(chamfer=true)
{
    set_cube(-1.5,0.5,-1.5,chamfer);
    set_cube(-1.5,0.5,-0.5,chamfer);    
    set_cube(-1.5,0.5,0.5,chamfer);
    set_cube(-1.5,0.5,1.5,chamfer);
    set_cube(-0.5,0.5,-1.5,chamfer);
    set_cube(0.5,0.5,-1.5,chamfer);
    set_cube(1.5,0.5,-1.5,chamfer);
    set_cube(1.5,-0.5,-1.5,chamfer);
    set_cube(-0.5,-0.5,-1.5,chamfer);
    set_cube(-0.5,-0.5,-0.5,chamfer);
    set_cube(0.5,0.5,-0.5,chamfer);
}
module piece3(chamfer=true)
{
    set_cube(-0.5,1.5,0.5,chamfer);
    set_cube(-0.5,1.5,-0.5,chamfer);
    set_cube(-1.5,1.5,-0.5,chamfer);
    set_cube(-1.5,0.5,-0.5,chamfer);
    set_cube(-1.5,-0.5,-0.5,chamfer);
    set_cube(-1.5,-1.5,-0.5,chamfer);
    set_cube(-1.5,-1.5,0.5,chamfer);
    set_cube(-0.5,-1.5,-0.5,chamfer);
    set_cube(0.5,-1.5,-0.5,chamfer);
    set_cube(1.5,-1.5,-0.5,chamfer);
    set_cube(1.5,-1.5,0.5,chamfer);
    set_cube(1.5,-0.5,-0.5,chamfer);
    set_cube(1.5,-0.5,0.5,chamfer);
    set_cube(1.5,0.5,-0.5,chamfer);
}
module piece4(chamfer=true)
{
    set_cube(-0.5,1.5,-0.5,chamfer);
    set_cube(-1.5,1.5,-0.5,chamfer);
    set_cube(-1.5,1.5,0.5,chamfer);
    set_cube(-1.5,0.5,-0.5,chamfer);
    set_cube(-1.5,-0.5,-0.5,chamfer);
    set_cube(-1.5,-1.5,-0.5,chamfer);
    set_cube(-0.5,-1.5,-0.5,chamfer);
    set_cube(-0.5,-1.5,0.5,chamfer);
    set_cube(0.5,-1.5,-0.5,chamfer);
    set_cube(1.5,-1.5,-0.5,chamfer);
    set_cube(1.5,-0.5,-0.5,chamfer);
    set_cube(1.5,0.5,-0.5,chamfer);
}
module piece5(chamfer=true)
{
    set_cube(-0.5,1.5,-0.5,chamfer);
    set_cube(-0.5,1.5,0.5,chamfer);
    set_cube(0.5,1.5,-0.5,chamfer);
    set_cube(0.5,1.5,0.5,chamfer);
    set_cube(1.5,1.5,-0.5,chamfer);
    set_cube(0.5,0.5,-0.5,chamfer);
    set_cube(0.5,-0.5,-0.5,chamfer);
    set_cube(-0.5,-0.5,-0.5,chamfer);
    set_cube(-1.5,-1.5,-0.5,chamfer);
    set_cube(-0.5,-1.5,-0.5,chamfer);
    set_cube(0.5,-1.5,-0.5,chamfer);
    set_cube(1.5,-1.5,-0.5,chamfer);
}
module piece6(chamfer=true)
{
    set_cube(-1.5,0.5,-0.5,chamfer);
    set_cube(-1.5,-0.5,-0.5,chamfer);
    set_cube(-1.5,-0.5,0.5,chamfer);
    set_cube(-0.5,-0.5,-0.5,chamfer);
    set_cube(0.5,-0.5,-0.5,chamfer);
    set_cube(1.5,-0.5,-0.5,chamfer);
    set_cube(1.5,0.5,-0.5,chamfer);
    set_cube(1.5,0.5,0.5,chamfer);
}

module assembled()
{
    color("darkgreen")
    translate([0,0,-cube_size])
    rotate([-90,0,90])
    final_piece1();
    
    color("red")
    translate([-cube_size,0,0])
    rotate([180,0,-90])    
    final_piece2();
    
    color("pink")
    translate([0,-cube_size,0])
    rotate([90,-90,0])
    final_piece3();
    
    color("white")
    translate([0,cube_size,0])
    rotate([-90,180,0])
    final_piece4();
    
    color("purple")
    translate([0,0,cube_size])
    rotate([0,0,0])
    final_piece5();
    
    color("yellow")
    translate([cube_size,0,-cube_size])
    rotate([180,0,90])
    final_piece6();    
    
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
// Thanks to TheFisherOne (https://www.thingiverse.com/TheFisherOne)
{
    offset(delta=2*delta, chamfer=true)
        square(x-4*delta, y-4*delta,center=true);
}

module final_piece1()
{
    translate([0,-cube_size,0])
    rotate([0,90,-90])
    difference() //for the gap
    {
        translate([0,0,-cube_size])
        rotate([-90,0,90])
        piece1();
        
        scale(1+gap/cube_size)
        {
        translate([-cube_size,0,0])
        rotate([180,0,-90])    
        piece2(chamfer=false);
        
        translate([0,-cube_size,0])
        rotate([90,-90,0])
        piece3(chamfer=false);
        
        translate([0,cube_size,0])
        rotate([-90,180,0])
        piece4(chamfer=false);
        
        translate([0,0,cube_size])
        rotate([0,0,0])
        piece5(chamfer=false);
        
        translate([cube_size,0,-cube_size])
        rotate([180,0,90])
        piece6(chamfer=false);
        }
    }
}

module final_piece2()
{
    translate([0,-cube_size,0])
    rotate([180,0,-90])
    difference() //for the gap
    {
        translate([-cube_size,0,0])
        rotate([180,0,-90])    
        piece2();
        
        scale(1+gap/cube_size)
        {
        translate([0,0,-cube_size])
        rotate([-90,0,90])
        piece1(chamfer=false);
        
        translate([0,-cube_size,0])
        rotate([90,-90,0])
        piece3(chamfer=false);
        
        translate([0,cube_size,0])
        rotate([-90,180,0])
        piece4(chamfer=false);
        
        translate([0,0,cube_size])
        rotate([0,0,0])
        piece5(chamfer=false);
        
        translate([cube_size,0,-cube_size])
        rotate([180,0,90])
        piece6(chamfer=false);
        }
    }
}

module final_piece3()
{
    translate([0,0,-cube_size])
    rotate([-90,0,-90])
    difference() //for the gap
    {
        translate([0,-cube_size,0])
        rotate([90,-90,0])
        piece3();
        
        scale(1+gap/cube_size)
        {
        translate([0,0,-cube_size])
        rotate([-90,0,90])
        piece1(chamfer=false);
        
        translate([-cube_size,0,0])
        rotate([180,0,-90])    
        piece2(chamfer=false);
        
        translate([0,cube_size,0])
        rotate([-90,180,0])
        piece4(chamfer=false);
        
        translate([0,0,cube_size])
        rotate([0,0,0])
        piece5(chamfer=false);
        
        translate([cube_size,0,-cube_size])
        rotate([180,0,90])
        piece6(chamfer=false);
        }
    }
}

module final_piece4()
{
    translate([0,0,-cube_size])
    rotate([-90,180,0])
    difference() //for the gap
    {
        translate([0,cube_size,0])
        rotate([-90,180,0])
        piece4();
        
        scale(1+gap/cube_size)
        {
        translate([0,0,-cube_size])
        rotate([-90,0,90])
        piece1(chamfer=false);
        
        translate([-cube_size,0,0])
        rotate([180,0,-90])    
        piece2(chamfer=false);
        
        translate([0,-cube_size,0])
        rotate([90,-90,0])
        piece3(chamfer=false);
        
        translate([0,0,cube_size])
        rotate([0,0,0])
        piece5(chamfer=false);
        
        translate([cube_size,0,-cube_size])
        rotate([180,0,90])
        piece6(chamfer=false);
        }
    }
}

module final_piece5()
{
    translate([0,0,-cube_size])
    rotate([0,0,0])
    difference() //for the gap
    {
        translate([0,0,cube_size])
        rotate([0,0,0])
        piece5();
        
        scale(1+gap/cube_size)
        {
        translate([0,0,-cube_size])
        rotate([-90,0,90])
        piece1(chamfer=false);
        
        translate([-cube_size,0,0])
        rotate([180,0,-90])    
        piece2(chamfer=false);
        
        translate([0,-cube_size,0])
        rotate([90,-90,0])
        piece3(chamfer=false);
        
        translate([0,cube_size,0])
        rotate([-90,180,0])
        piece4(chamfer=false);
        
        translate([cube_size,0,-cube_size])
        rotate([180,0,90])
        piece6(chamfer=false);
        }
    }
}

module final_piece6()
{
    translate([0,-cube_size,-cube_size])
    rotate([180,0,90])
    difference() //for the gap
    {
        translate([cube_size,0,-cube_size])
        rotate([180,0,90])
        piece6();
        
        scale(1+gap/cube_size)
        {
        translate([0,0,-cube_size])
        rotate([-90,0,90])
        piece1(chamfer=false);
        
        translate([-cube_size,0,0])
        rotate([180,0,-90])    
        piece2(chamfer=false);
        
        translate([0,-cube_size,0])
        rotate([90,-90,0])
        piece3(chamfer=false);
        
        translate([0,cube_size,0])
        rotate([-90,180,0])
        piece4(chamfer=false);
        
        translate([0,0,cube_size])
        rotate([0,0,0])
        piece5(chamfer=false);
        }
    }
}