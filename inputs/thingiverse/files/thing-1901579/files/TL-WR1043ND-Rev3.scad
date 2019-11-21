distanceBetweenPegs = 122.6; //on center
pegShaftDiameter = 3.9;
pegHeadDiameter = 6.25;
pegShaftHeight = 2.2; //does not include the head
pegHeadHeight = 1.85;
baseThickness = 3.25;
baseWidth = 150;
baseHeight = 40;
screwHoleDiameter = 4;
screwHoleInsetX = 5;
screwHoleInsetY = 5;

module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height=z)
    hull()
    {
    // place 4 circles in the corners, with the given radius
    translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
    circle(r=radius);

    translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);

    translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
    circle(r=radius);
    }
}

module peg(location)
{
    translate(location){
        //shaft
        cylinder(pegShaftHeight,pegShaftDiameter/2,pegShaftDiameter/2, $fn = 200);
        translate([0,0,pegShaftHeight]){
            cylinder(pegHeadHeight,pegShaftDiameter/2,pegHeadDiameter/2, $fn = 200);
        }
    }
}

module screwHole(location)
{
    translate(location){
        translate([0,0,-0.01]){
                cylinder(baseThickness*2,screwHoleDiameter/2,(screwHoleDiameter*1.6/2), $fn = 200);
        }
    }
}

//base
difference(){
    translate([baseWidth/2,baseHeight/2,0]){
        roundedRect([baseWidth-5,baseHeight-5,baseThickness],5);
    }
    union(){
        x1 = screwHoleInsetX+screwHoleDiameter/2;
        x2 = baseWidth-screwHoleInsetX-screwHoleDiameter/2;
        y1 = screwHoleInsetY+screwHoleDiameter/2;
        y2 = baseHeight-screwHoleInsetY-screwHoleDiameter/2;
        
        screwHole([x1,y1,0]);
        screwHole([x1,y2,0]);
        screwHole([x2,y1,0]);
        screwHole([x2,y2,0]);
    }
}


pegOffset = (baseWidth-distanceBetweenPegs)/2;

peg([pegOffset,baseHeight/2,baseThickness]);
peg([baseWidth-pegOffset,baseHeight/2,baseThickness]);