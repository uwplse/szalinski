/* [Box dimensions] */
// External length (X)
lg = 200;
// External width (Y)
wd = 100;
// External heigth (Z)
ht = 50;

/* [Thickness] */
// External thickness
extTk = 4;
// Internal thickness
intTk = 2;

/* [Dividers] */
// Number divider on axe X
divX = 10;
// Number divider on axe Y
divY = 3;

module box(lg, wd, ht, extTk, intTk, divX, divY)
{
    difference()
    {
        // External box
        cube([lg,wd,ht]);
        
        // Internal length (X)
        sizeX = (lg - extTk*2 - intTk*(divX-1))/divX;
        // Internal width (Y)
        sizeY = (wd - extTk*2 - intTk*(divY-1))/divY;
        // Internal heigth (Z)
        sizeZ = ht - extTk + 0.1;
        
        // Holes
        for (vX=[0:divX-1], vY=[0:divY-1])
            translate([extTk+vX*(sizeX+intTk),extTk+vY*(sizeY+intTk),extTk])
            cube([sizeX, sizeY, sizeZ]);
    }
}

box(lg=lg, wd=wd, ht=ht, extTk=extTk, intTk=intTk, divX=divX, divY=divY);