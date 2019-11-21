
ID = 8; //Inner Diameter
OD = 22; //Outer Diameter
W = 8; //Width
tolerance=0.35; //Bushing tolerance

chamtype = "a"; // Chamfer type [a,b,c]
cuttype = "a"; //Cut placement type [a,b,c]

cham = 0.25; //Chamfer on OD and ID
Btolerance=0.0; //ID and OD offset[+shrink,-expand])
margin = 2; //Margin for cuts position


viewmode = "3D"; //[3D,2D]


//Constants
pythA = sqrt(pow(tolerance,2)+pow(tolerance,2));
pythB = sqrt(pow(Btolerance,2)+pow(Btolerance,2));
pythC = sqrt(pow(cham,2)+pow(cham,2));
GAC = 0.0001; // Gap Closer, Not to change this

if(viewmode == "3D")
gen();
else if (viewmode == "2D")
twodee();

module twodee()
{
    body();
    cuts();
    echo(((OD-2)+(ID+2)+sqrt(tolerance/2))/4);
    echo((OD/2)-(ID/2)+sqrt(tolerance/2));
    echo(((OD-2))/4);
}

module gen(){
    union(){
        rotate_extrude(angle = 360,$fn = 100)
        {
            difference(){
            body();
            cuts();
            }
        }
        mirror([0,0,1])rotate_extrude(angle = 360,$fn = 100)
        {
            difference(){
            body();
            cuts();
            }
        }
    }
}


module cuts()
{
    color("red")square([ID/2+Btolerance,W/2]);

    if (cuttype == "a")
    {
        sept(((OD)/2-margin)-1-Btolerance);
        chamfer(((OD)/2-margin)-1-Btolerance);
    }
    else if (cuttype == "b")
    {
        sept(((OD-margin-Btolerance)+(ID+margin+Btolerance)+sqrt(tolerance/2))/4);
        chamfer(((OD-margin-Btolerance)+(ID+margin+Btolerance)+sqrt(tolerance/2))/4);
    }
    else if (cuttype == "c")
    {
        sept((OD/margin)-(ID/margin)+sqrt(tolerance/2));
        chamfer((OD/margin)-(ID/margin)+sqrt(tolerance/2));
    }
}

module sept(XP)
{
    translate([XP,0,0])
        {
        hull(){
        translate([1-tolerance,(W/2)-tolerance*2,0])color("magenta")rotate([0,0,0])square(size=[tolerance,0.001]);
        translate([-1,tolerance,0])color("magenta",0.25)rotate([0,0,0])square(size=[tolerance,0.001]);
        }
        translate([1-tolerance,(W/2)-tolerance*2,0])color("magenta",0.5)rotate([0,0,0])square(size=[tolerance,tolerance*2]);
        color("magenta",0.5)translate([-1,0,0])rotate([0,0,0])square(size=[tolerance,tolerance]);
    }
}
module body()
{
    color("lime")translate([0,-GAC,0])square(size=[OD/2-(Btolerance/2),W/2+GAC]);
}
module chamfer(XP)
{
//    echo(ID/2+Btolerance);
//    echo((ID/2)+pythB/1.4);
    translate([(ID/2)+pythB/1.4,(W/2)-pythC,0])color("white")rotate([0,0,45])square(size=[cham*2,cham*2]);
    translate([(OD/2)-pythB/2.8,(W/2)-pythC,0])color("white")rotate([0,0,45])square(size=[cham*2,cham*2]);
    
        //type a
    if(chamtype == "a")
    translate([XP+((2/2)-tolerance)+pythA/2.75,(W/2)-pythA,0])color("red")rotate([0,0,45])square(size=[tolerance*2,tolerance*2]);
    
    //type b
    else if(chamtype == "b")
    translate([XP+((2/2)-tolerance),(W/2)-pythC,0])color("red")rotate([0,0,45])square(size=[cham*2,cham*2]);
    
    //type c
    else if(chamtype == "c")
    {
    translate([XP+((2/2)-tolerance),(W/2)-pythC,0])color("red")rotate([0,0,45])square(size=[cham*2,cham*2]);
    translate([XP+((2/2)),3.5-pythC,0])color("red")rotate([0,0,45])square(size=[cham*2,cham*2]);
    }
}