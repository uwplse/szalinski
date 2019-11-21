$fn=64*1;

function sumv(v,i,s=0) = (i<=s ? v[i] : v[i] + sumv(v,i-1,s));

// (ugh, i'm using base 1 to make the UI readable and it's making me sad)

// Inner diameter #1 (mm). You can have up to 8 inner diameters in this pack; if you want fewer, just set the others to zero.
id1 = 4;
// Inner diameter #2 (mm). Zero to ignore.
id2 = 7;
// Inner diameter #3 (mm). Zero to ignore.
id3 = 9;
// Inner diameter #4 (mm). Zero to ignore.
id4 = 0;
// Inner diameter #5 (mm). Zero to ignore.
id5 = 0;
// Inner diameter #6 (mm). Zero to ignore.
id6 = 0;
// Inner diameter #7 (mm). Zero to ignore.
id7 = 0;
// Inner diameter #8 (mm). Zero to ignore.
id8 = 0;

inner_dias = [ for (id = [id1, id2, id3, id4, id5, id6, id7, id8]) if (id>0) id ];

// Height #1 (mm). Set to zero to ignore; heights will be evenly distributed among spacers created. If you just want one height, set all others to zero.
height1 = 2;
// Height #2 (mm). Zero to ignore.
height2 = 5;
// Height #3 (mm). Zero to ignore.
height3 = 10;
// Height #4 (mm). Zero to ignore.
height4 = 0;

heights = [ for (h = [height1, height2, height3, height4]) if (h>0) h ];
echo (heights);

// Approximately how much of the Y build space to fill with spacers (mm). This indirectly picks how many of each diameter are made.
max_y = 100; 

// Thickness of the tube for each spacer (mm).
shell_thickness = 2;

// Distance between each spacer (mm).
spacing = 1; 

outer_dias =  [ for ( id = inner_dias ) id+shell_thickness*2 ];
x_positions = [ for ( i=[0:len(outer_dias)-1] ) (i>0?sumv(outer_dias,i-1):0)+outer_dias[i]/2+spacing*i ];

for (i = [0:len(inner_dias)-1]) {
    id = inner_dias[i];
    od = outer_dias[i];
    px = x_positions[i];
    for (py = [0:od+spacing:max_y-1]) {
        y_frac = py/max_y;
        height = heights[floor(y_frac*len(heights))];
        translate([px,py,0]) linear_extrude(height) difference() {
            circle(d=od); circle(d=id); 
        }
    }
}