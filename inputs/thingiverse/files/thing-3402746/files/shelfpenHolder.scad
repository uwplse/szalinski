// Parameteric Shelf-hanging pen holder - made to work with shelves from the Container Store
// Created by Michael S. Scherotter 
// @Synergist on Thingiverse
// @Synergist on Twitter
// @TravelArtJournalist on Instagram
// Updated 2/4/2019

// preview[view:north west, tilt:bottom]

// Number of rows
rows = 4; // [1:15]


// Number of columns
columns = 10; // [2:15]

// Size of each cell in mm 
size = 12; // [10:20]

// Thickness space between each cell in mm
innerThickness = 1.5; // [1.5:4]

// Depth of each cell in mm
depth = 80; // [40:100]

// Width of each clip in mm
clipWidth = 10; // [10:20]

// Downward tilt angle
angle = 10; // [10:14]

width = (columns * size)  + innerThickness * (columns + 1);
height = (rows * size)  + innerThickness * (rows + 1);

module model()
{
    difference() {
        union()
        {
            body();
            clip();
            translate([width-clipWidth,0,0])
            {
                clip();
            }
        }
        holes();
    }
}

orientForPrint();

module orientForPrint()
{
    rotate([180,0,0])
    {
        translate([-width/2,-height/2,-depth])
        {
            model();
        }
    }
}

module body()
{
    cube([width, height, depth], center=false);
}

module clip(){
    clipHeight = cos(angle) * 40;
    clipDepth = sin(angle) * 40;
    union()    {
        translate([0, -30, depth - clipDepth -3])    {
            rotate([-angle,0,0])            {
                union() {
                    cube([clipWidth, 40, 10], center=false);
                    translate([0,0,-40]) {                    
                        cube([clipWidth, 10, 40], center=false);
                    }
                    translate([0,30,-40]){
                        cube([clipWidth, 10, 40], center=false);
                    }
                }
            }
        }
        translate([0, -clipHeight + 12, depth - 10])
        {
            cube([clipWidth, clipHeight, 10], center=false);
        }
    }
}


module createCell(row, col)
{ 
    translate([
        innerThickness + row * (size + innerThickness), 
        innerThickness + col * (size + innerThickness), 
        innerThickness])
    {
        cube([size, size, depth], center=false);
    }
}

module holes() {
    union()
    {
        for (row = [0: rows-1])
            for (col = [0: columns-1])
                createCell(col, row);
    }
}