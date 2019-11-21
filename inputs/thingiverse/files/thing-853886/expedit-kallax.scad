// -------------------------------------------------------------------------------------------------

// Parametric Ikea Expedit/Kallax shelving units scale model

// © anton@cking.be
//   https://www.youmagine.com/users/ant0ni0
//   https://www.thingiverse.com/ant0ni0

// all sizes are in mm

// GLOBAL PARAMETERS -------------------------------------------------------------------------------

/* [Shelves] */

type = "Expedit"; // [Expedit,Kallax]

scale = 0.1; // [1:1/1,0.5:1/2,0.2:1/5,0.1:1/10,0.05:1/20,0.02:1/50,0.01:1/100,0.005:1/200]

color = "White"; // [White,Birch,Green,Pink,Red,Black]

// #compartments in horizontal direction
cols = 4; // [1:5]

// #compartments in vertical direction
rows = 4; // [1:5]

/* [Build] */

build = "Display"; // [Display,Print]

// add some door inserts?
doors = "Yes"; // [Yes,No]

// add some drawers inserts?
drawers = "Yes"; // [Yes,No]

// add some Lekman boxes?
boxes = "Yes"; // [Yes,No]

/* [Hidden] */

yes = true;
no = false;

right = 1;
left  = 2;

white = [1.00, 1.00, 1.00];
birch = [0.82, 0.75, 0.60];
green = [0.75, 0.85, 0.70];
pink  = [0.80, 0.71, 0.74];
red   = [1.00, 0.10, 0.10];
black = [0.12, 0.12, 0.08];

flat  = no;     // use no for display, yes for 3D printing

cubeSize = 335; // same for expedit and kallax
depth    = 385;

// CALCULATED VALUES -------------------------------------------------------------------------------

de = (type == "Expedit") ? 50 : 40; // thickness of outside boards
di = 16; // thickness of shelves

// BUILD -------------------------------------------------------------------------------------------

// uncomment one of the following:
custom(); // whatever what's been chosen in Customizer
//demo1();
//demo2();
//demo3();
//shelves(1,4);
//door();
//drawers();
//lekman();

// FUNCTIONS ---------------------------------------------------------------------------------------

function clr(name) = 
    name == "White" ? white :
    name == "Birch" ? birch :
    name == "Green" ? green :
    name == "Pink"  ? pink  :
    name == "Red"   ? red   :
    name == "Black" ? black : white;

// MODULES -----------------------------------------------------------------------------------------

module custom()
{
    clr = clr(color);
    
    shelves(cols,rows,clr);
    
    if (doors == "Yes")
    {
        row = min(4,rows);
        door(1,row,clr,right);
        if (cols > 1)
            door(cols,row,clr,left);
    }
    
    if (drawers == "Yes")
    {
        row = max(1,min(3,rows-1));
        first = min(2,cols);
        last = max(1,cols-1);
        for (col=[first:last])
            drawers(col,row,clr);
    }
    
    if (boxes == "Yes")
    {
        if (rows > 1 || (doors != "Yes" && drawers != "Yes"))
        {
            for (col=[1:cols])
                lekman(col,1);
        }
    }
}

module demo1()
{
    shelves(5,5);
    
    for (col=[1:1:5])
        lekman(col,2,white);
}

module demo2()
{
    shelves(4,4, birch);

    door(1,3, black, right);
    drawers(2,3, black);
    drawers(3,3, black);
    door(4,3, black, left);

    for (col=[1,4])
        for (row=[1,2])
            lekman(col,row);
}

module demo3()
{
    // shelves(5,1, pink);
    drawers(1);
    door(2);
    lekman(3);
    door(4, open=left);
}

module shelves(w, h, color=color)
{
    wi = w * cubeSize + (w-1) * di;
    hi = h * cubeSize + (h-1) * di;
    
    we = wi + 2 * de;
    he = hi + 2 * di;
    
    color(color)
    scale(scale)
    rotate(build=="Print" ? [0,0,0] : [90,0,0])
    union()
    {
        cube([we,de,depth]);
        translate([0,de,0]) cube([de,hi,depth]);
        translate([wi+de,de,0]) cube([de,hi,depth]);
        translate([0,hi+de,0]) cube([we,de,depth]);
        
        for (i=[1:1:w-1])
            translate([de-di+i*(cubeSize+di),de,0]) cube([di,hi,depth]);
        
        for (i=[1:1:h-1])
            translate([de,de-di+i*(cubeSize+di),0]) cube([wi,di,depth]);
    }
}

module drawers(col=1, row=1, color=color)
{
    slack  = 2; // increase this if the printed part doesn't fit into the space
    margin = 6;
    
    w = cubeSize - 2 * margin;
    h = (cubeSize - 3 * margin) / 2;
    
    x = de + (col-1) * (cubeSize + di);
    y = de + (row-1) * (cubeSize + di);
    
    scale(scale)
    rotate(build=="Print" ? [0,0,0] : [90,0,0])
    {
        union()
        {
            color(color) translate([x+slack,y,0]) cube([cubeSize-2*slack,cubeSize-2*slack,depth-di]);
            for (i=[0,1])
            {
                color(color) translate([x+margin,y+margin+i*(h+margin),depth-di]) cube([w,h,di]);
                color([0.8,0.8,0.8]) translate([x+cubeSize/2,y+margin+h/2+i*(h+margin),depth]) cylinder(d=12,h=12);
            }
        }
    }
}

module door(col=1, row=1, color=color, open=right)
{
    slack  = 2;
    margin = 6;
    
    w = cubeSize - 2 * margin;
    
    x = de + (col-1) * (cubeSize + di);
    y = de + (row-1) * (cubeSize + di);
    
    xKnob = (open==right) ? cubeSize-30 : 30;
    
    scale(scale)
    rotate(build=="Print" ? [0,0,0] : [90,0,0])
    {
        union()
        {
            color(color) translate([x+slack,y,0]) cube([cubeSize-2*slack,cubeSize-2*slack,depth-di]);
            color(color) translate([x+margin,y+margin,depth-di]) cube([w,w,di]);
            color([0.8,0.8,0.8]) translate([x+xKnob,y+margin+w/2,depth]) cylinder(d=12,h=12);
        }
    }
}

module lekman(col=1, row=1, color=[0.3,0.3,0.3,0.8])
{
    w = 330;
    d = 370;
    
    x = de + (col-1) * (cubeSize + di) + ((cubeSize - w) / 2);
    y = de + (row-1) * (cubeSize + di);
    z = (depth - d) / 2;
    
    color(color)
    scale(scale)
    rotate(build=="Print" ? [0,0,0] : [90,0,0])
    {
        difference()
        {
            union()
            {
                for (i=[0,1])
                {
                    translate([x,y,z+i*(d-di)]) cube([w,w,di]);
                    translate([x+i*(w-di),y,z+di]) cube([di,w,d-2*di]);
                }
                translate([x+di,y,z+di]) cube([w-2*di,di,d-2*di]);
            }
            translate([x+cubeSize/2,y+cubeSize/2,0])
            {
                for (dx=[-50:40:40])
                    for (dy=[-50:40:40])
                        translate([dx,dy,-1])
                        cube([20,20,depth+2]);
            }
        }
    }
}

// -------------------------------------------------------------------------------------------------
