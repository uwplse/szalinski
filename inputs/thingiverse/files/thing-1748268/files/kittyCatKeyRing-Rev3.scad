//Customizable Remix of Key-kitty Key Ring
//9/1/2016  By: David Bunch
//Remixed from: http://www.thingiverse.com/thing:51350
//
//1. Height of Key Ring (3.5 Original)
Ht = 2;             //[.2:.2:5]

//2. Diameter of Key Ring Hole (2.87 Original)
Hole_ID = 3.5;      //[2.5:.25:6]

//3. Thickness around Key Ring Hole (1.07 Original)
Thk = 2.0;          //[1:.2:3]

//4. Add Text to Key Ring
AddText = "no";        //[yes,no]

//5. Text to Add to Key Ring
Name = "Cat";       //Text to Add

//6. Text Height to use
Ft_Size = 5;        //[3:.2:7]

//7. Font
Ft_Name = "Liberation Sans";    //[Liberation Mono, Liberation Sans, Liberation Sans Narrow,Liberation Serif]

//8. Font Style
Ft_Style = "Bold";           //[Narrow, Narrow Italic, Narrow Bold, Italic, Bold, Bold Italic]

//9. Thickness of Text above Key Ring
Text_Ht = .5;       //[.2:.1:2]

//10. Text Y Offset
Text_Y_Offset = 8;         //[4:.2:12]

//11. Character Spacing
Text_Spacing = 1; //[.5:.1:2]

/* [Hidden] */
//Diameter of Eyes (8.94 Original)
Eye_OD = 9;         //[5:.5:12]

//Scale of Eyes in Y-axis to make oval
Eye_Scale_Y = .5;   //[.2:.05:1]

//Rotation of Oval Eyes
Eye_Rot = 15;       //[0:1:30]
Whisker_OD = 1;     //[.7:.1:2] (.77 Original)
Whisker_Res = 10;   //Originally 24;

Ft_Type = str(Ft_Name,":style=",Ft_Style);              //Create complete Font Style

Hole_OD = Hole_ID + (2 * Thk);      //Outer Diameter of Key Ring Hole
Hole_Rad = Hole_ID / 2;
Hole_OD_Res = (round(((Hole_OD * 3.14)/4) / .7)*4);     //About .7mm segments
Eye_OD_Res = (round(((Eye_OD * 3.14)/4) / .7)*4);       //Resolution of Eyes, about .7mm segments
echo(Hole_OD_Res = Hole_OD_Res);
echo(Eye_OD_Res = Eye_OD_Res);

echo(Ft_Type = Ft_Type);
module CatOutline()
{
    union()
    {
        color("cyan")
        {
            linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
            [[-2.82,-0.23],[-3.35,-0.29],[-3.82,-0.27],[-4.02,-0.2],[-4.1,-0.16],
            [-4.18,-0.1],[-4.32,0.06],[-4.43,0.25],[-4.7,1.26],[-5.3,3.2],
            [-6.08,4.92],[-9.53,11.82],[-10.2,10.43],[-10.7,8.97],[-11.55,6],
            [-12.36,3.03],[-12.99,0.02],[-13.81,-6.09],[-14.06,-9.16],[-14.13,-12.23],
            [-13.98,-15.33],[-13.79,-16.87],[-13.5,-18.4],[-13.07,-19.88],[-12.48,-21.3],
            [-11.7,-22.63],[-10.77,-23.87],[-9.72,-25],[-8.56,-26.03],[-7.31,-26.95],
            [-5.97,-27.73],[-4.56,-28.38],[-3.09,-28.87],[-1.57,-29.15],[-0.03,-29.19],
            [1.51,-29.15],[3.03,-28.87],[4.5,-28.38],[5.91,-27.73],[7.25,-26.95],
            [8.5,-26.03],[9.65,-25],[10.71,-23.87],[11.64,-22.63],[12.41,-21.3],
            [13.01,-19.88],[13.44,-18.4],[13.73,-16.87],[13.92,-15.33],[14.07,-12.23],
            [14,-9.16],[13.75,-6.09],[12.93,0.02],[12.3,3.03],[11.49,6],
            [10.64,8.97],[10.14,10.43],[9.47,11.82],[6.03,4.95],[5.26,3.24],
            [4.65,1.31],[4.38,0.3],[4.28,0.09],[4.15,-0.07],[4.08,-0.13],
            [3.99,-0.19],[3.8,-0.26],[3.58,-0.29],[3.34,-0.3],[2.82,-0.24],
            [1.89,-0.11],[0.95,-0.03],[0,0],[-0.95,-0.03],[-1.89,-0.1],
            [-2.82,-0.23]]);
            translate([0,Hole_Rad,0])
            {
                difference()
                {
                    cylinder(d=Hole_OD,h=Ht,$fn=Hole_OD_Res);
                    translate([0,0,-1])
                    cylinder(d=Hole_ID,h=Ht+2,$fn=Hole_OD_Res);
                }
            }
        }
        if (AddText == "yes")
        {
            translate([0,-Text_Y_Offset,Ht-.1])
            color("red")
            linear_extrude(height = Text_Ht + .1) {
            {
                text(Name, size = Ft_Size, halign = "center",spacing = Text_Spacing, font = Ft_Type);
            }
        }
        }
    }
}
module Ear()
{
    translate([0,0,-1])
    linear_extrude(height = Ht+2, center = false, convexity = 10)polygon(points = 
    [[8.9,5.8],[8.46,5.1],[8.16,4.32],[7.51,2.79],[6.39,-0.35],
    [5.78,-1.89],[5.68,-2.09],[5.65,-2.19],[5.64,-2.29],[5.64,-2.34],
    [5.65,-2.39],[5.7,-2.48],[5.76,-2.57],[5.84,-2.64],[6.01,-2.75],
    [6.21,-2.82],[6.61,-2.96],[7.35,-3.32],[8.03,-3.81],[9.39,-4.77],
    [9.98,-5.31],[10.34,-5.56],[10.54,-5.67],[10.59,-5.68],[10.62,-5.68],
    [10.64,-5.67],[10.66,-5.67],[10.68,-5.65],[10.72,-5.62],[10.75,-5.57],
    [10.77,-5.52],[10.8,-5.42],[10.8,-5.21],[10.8,-4.79],[10.76,-3.96],
    [10.44,-0.65],[9.9,2.63],[9.48,4.24]]);
}
module Whiskers()
{
//Top Whisker to the Right
    hull()
    {
        translate([4.57,-19.83,-1])
        cylinder(d=Whisker_OD,h=Ht+2,$fn=Whisker_Res);
        translate([9.41,-18,-1])
        cylinder(d=Whisker_OD,h=Ht+2,$fn=Whisker_Res);
    }
//Bottom Whisker to the Right
    hull()
    {
        translate([3.9,-22.36,-1])
        cylinder(d=Whisker_OD,h=Ht+2,$fn=Whisker_Res);
        translate([9.07,-22.68,-1])
        cylinder(d=Whisker_OD,h=Ht+2,$fn=Whisker_Res);
    }
}
module Eye()
{
    translate([6.5,-11.7,-1])
    rotate([0,0,Eye_Rot])                           //Rotate a little
    scale([1,Eye_Scale_Y,1])                        //Make eye thinner in the vertical
    cylinder(d=Eye_OD,h=Ht+2,$fn=Eye_OD_Res);       //Right Eye
}
difference()
{
    CatOutline();

    Whiskers();                         //Right Whiskers
    mirror([1,0,0])
    Whiskers();                         //Left Whiskers

    translate([0,-25.3,-1])
    scale([1.5,1,1])
    cylinder(d=4.2,h=Ht+2,$fn=4);       //Mouth 

    translate([0,-16.75,-1])
    scale([1,1.5,1])
    rotate([0,0,90])
    cylinder(d=3.9,h=Ht+2,$fn=3);       //Nose

    Eye();                              //Right Eye
    mirror([1,0,0])
    Eye();                              //Left Eye

    Ear();                              //Right Ear
    mirror([1,0,0])
    Ear();                              //Left Ear
}