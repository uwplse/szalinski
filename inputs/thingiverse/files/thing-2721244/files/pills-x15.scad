
// Max Pill Diameter
PR = 8; // [1:15]
 
// Max Pill Length
PF = 8; // [1:15]

// What to print
Thing="cover"; // [cover, inside, insidewithletters, both]

// Circle Fidelity
FN =15; // [15:360]

module dont_customize(){}


WL = 1; // wall thickness
GAP = 2.2;
SW = 2; // sidewall
BW = GAP; // bottom wall

MH = 26;
MXY = 3.6;

AIR = 1;
RND = 3; // rounding for outer container

MW = 1; // magnet wall

CELL = GAP+PR+PF+PR;
INNERY = 2 * (AIR+GAP+PR)+PF;
OUTERY = INNERY + 2 * WL;
INNERX = 2 * (PR+SW)+PF;
INNERZ = GAP+PR;
OUTERZ = INNERZ+2*AIR+2*WL;

$fn = FN;
//thing("both");
//thing("insidewithletters");
//thing("cover");
thing(Thing);

module thing(typ)
{
    if (typ == "inside")
    {

        difference()
        {
             translate([0,-INNERX/2,0]) 
                union()
                {
                        cubeS([MW+MXY+MW+AIR+7*CELL,SW+PR+PF+PR+SW,BW+PR],RND);                    
                        hull()
                    {
                        translate([MW+MXY+MW+AIR+7*CELL,0,0]) cubeS([1,SW+PR+PF+PR+SW,BW+PR],RND);   
                        translate([PR+PF/2+MW+MXY+MW+7*CELL,SW+PR+PF/2,0]) cylinder(d=SW+PR+PF+PR+SW,h=BW+PR);
                    }
                }
                for (i = [0:7])
                {
                    translate([PR+PF/2+MW+MXY+MW+i*CELL,0,PR+BW])minkowski()
                    {
                        cylinder(d=PF,h=PR);
                        sphere(r=PR);
                    }
                }

                translate([PR+PF/2+MW+MXY+MW+7*CELL,0,PR+BW-50])cylinder(d=PF,h=100); // hole through day 8

                translate([MW,-MH/2,(GAP+PR)/2-MXY/2]) cube([MXY,MH+100,MXY]); // magnet
        }
    }

    if (typ == "cover")
    {
        rotate([180,0,180])
        {

            difference()
            {
                cubeR([WL+AIR+BW+PR+AIR+WL,WL+AIR+SW+PR+PF+PR+SW+AIR+WL,2*(MW+MXY+MW)+7*CELL],RND);
                translate([WL,WL,0]) cubeR([AIR+BW+PR+AIR,AIR+SW+PR+PF+PR+SW+AIR,MW+MXY+MW+7*CELL],RND);
                translate([OUTERZ/2-MXY/2,-MH/2+OUTERY/2,MW+MXY+MW+MW+7*CELL]) cube([MXY,MH+100,MXY]);
            }
        }  
    }

    if (typ == "insidewithletters")
    {
        difference()
        {
            thing("inside");
            //thing("cover");
            days = ["M", "T", "W", "T", "F", "S", "S" ];
            for (i=[0:6])
            {
                translate([PR+PF/2+MW+MXY+MW+i*CELL,0,1]) linear_extrude(height = 10)
                {
                    text(font="Arial:style=bold", size = 12, text=days[i],halign="center",valign="center");
                }
            }
        }
    }

    if (typ == "both")
    {
        rotate([0,90,0]) translate([0,0,7*CELL+AIR+MW+MXY+MW]) thing("cover");
        translate([0,WL+AIR+SW+PR+PF/2,WL+AIR]) thing("insidewithletters");
    }
    
}

module cubeR(v,vr)
{
    translate([vr,vr,0]) minkowski()
    {
       cube([v[0]-vr-vr,v[1]-vr-vr,v[2]-1]);
       cylinder(h=1,r=vr); 
    }
    
}

module cubeS(v,vr)
{
        
    translate([0,vr-0.5,vr]) minkowski()
     {
       cube([v[0],v[1]-vr-vr+1,v[2]-vr-vr]);
       rotate([0,90,0])cylinder(h=1,r=vr); 
    }
 }


