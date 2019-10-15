echo ("the f^ck?");
//////
// --0 This my experimantal spherical convex hull strutting.
// ---  with ball/socket alignment helpers for glue-together seams
//


//
// --| this be Mark I ball/socket fitting strut ends and half struts
//////

// origin to center of vertex spheres
distance = 150;

// strut thickness
diameter = 20;

negcube = distance*10;

// free leg angle (try 45)
ang=45;//[0:90]

//if you set the angle to anything other than 45, you won't be able to simply print two of them and expect them to fit together.
// you'll have to duplicate section #43b with ang=90-ang (or something like that...

module node(x,y,z,d)
{
    translate([x,y,z]) sphere(d);
}

//the nodal "balls"
module a(){
    node(distance,0,0,diameter);}

module b(){
    node(0,distance,0,diameter);}
    
module c(){
    node(0,0,distance,diameter);}
    
module d(){
    node(-distance*cos(ang),-distance*sin(ang),0,diameter);}


//section #43b
difference (){
    union(){//of the struts
        hull(){a();b();}//struts
        hull(){b();c();}
        hull(){c();a();}
        hull(){c();d();}}    
    translate([-negcube / 2,-negcube/2,-negcube]) cube(negcube);//cut the struts off below the ground plane
    translate([0,distance,0]) sphere(diameter/2);//socket on split strut
    translate([(diameter/3)*cos(ang-90)-distance*cos(ang),
        (diameter/3)*sin(ang-90)-distance*sin(ang),0]) sphere(diameter/3);}//socket on free strut end
translate([(diameter/3)*cos(ang+90)-distance*cos(ang),(diameter/3)*sin(ang+90)-distance*sin(ang),0]) sphere(diameter/3);//ball on free strut end
translate([distance,0,0]) sphere(diameter/2);//ball on split strut
//endsection #43b

///
echo("what?");