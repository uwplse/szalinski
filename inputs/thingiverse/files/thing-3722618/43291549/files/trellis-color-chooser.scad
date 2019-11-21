
color1 = "yellow"; // [blue, green, red, white, yellow]

color2 = "yellow"; // [blue, green, red, white, yellow]

color3 = "yellow"; // [blue, green, red, white, yellow]

color4 = "yellow"; // [blue, green, red, white, yellow]

color5 = "yellow"; // [blue, green, red, white, yellow]

color6 = "yellow"; // [blue, green, red, white, yellow]

color7 = "yellow"; // [blue, green, red, white, yellow]

color8 = "yellow"; // [blue, green, red, white, yellow]

color9 = "yellow"; // [blue, green, red, white, yellow]

color10 = "yellow"; // [blue, green, red, white, yellow]

color11 = "yellow"; // [blue, green, red, white, yellow]

color12 = "yellow"; // [blue, green, red, white, yellow]

color13 = "yellow"; // [blue, green, red, white, yellow]

color14 = "yellow"; // [blue, green, red, white, yellow]

color15 = "yellow"; // [blue, green, red, white, yellow]

color16 = "yellow"; // [blue, green, red, white, yellow]

/* [Hidden] */

colors = [color1, color2, color3, color4, color5, color6, color7, color8, color9, color10, color11, color12, color13, color14, color15, color16];

step = 1;
sideLength = 20;
spacing = 35;

rows = 4;
columns = 4;

for(x = [0 : step : rows-1],
    y = [0 : step : columns-1])
{
    xTranslate = sideLength + (x * spacing);
    yTranslate = sideLength + (y * spacing);

    index = x * rows + y;
    echo("index: ", index);

    color( colors[index] )
    translate([xTranslate, yTranslate, 0])
    cube([sideLength, sideLength, 1]);
}

backgroundWidth = 170;
color("white")
translate([0, 0, -2])
cube([backgroundWidth, backgroundWidth, 1]);
