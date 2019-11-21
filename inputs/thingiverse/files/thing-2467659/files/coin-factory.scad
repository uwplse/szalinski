/* [Outer] */

//Outer radius of the coin, the size will be roughly 2 times this value depending on other settings.
outer_radius = 18;

//Forms an ellipse instead of a circle by playing this parameter
outer_radius_shape = 1;

//Height of the coin without borders
height = 1;

//The number of sides on the outer edge of the coin. Set to a very high value to make it circular. Values 2 and higher will create meaningful shapes.
outer_sides = 4;

//Type of the outer border. Not all star shapes can be 2 and 3 regular.
outer_mod = 2; //[0:Polygon, 1: Custom, 2: 2-regular star, 3: 3-regular star]

//This parameter controls the distance of the dents that makes the outer shape. Used if the type is set to Custom. Setting this value to 1 will make the shape a polygon.
outer_shape = 1;

//Width of the outer border, set 0 to disable. If outer border is disabled and inner border is enabled, part will either need support or bottom_border should be disabled as well.
outer_border = 1.6;

//Height of the outer borders. Keep inner and outer borders are synchronized, otherwise the part will need support.
outer_border_height = 0.5;

//Rotates the outer border in multiples of half sides
outer_rotation = 0.5;

//Whether to create bottom border. If the settings check out, the bottom part will be bridged. If you have trouble printing the part, or changed border settings to a point where bridging is not possible, then disabling this might help.
bottom_border = 1;//[1:Yes,0:No]

/* [Inner] */

//Radius of the inner hole, excluding the inner border. Set 0 to disable.
inner_radius = 3;

//Forms an ellipse instead of a circle by playing this parameter
inner_radius_shape = 1.3;

//Sides of the inner hole of the coin. Set to a very high value to make it circular. Values 2 and higher will create meaningful shapes.
inner_sides = 5;

//Type of the inner border. Not all star shapes can be 2 and 3 regular.
inner_mod = 2; //[0:Polygon, 1: Custom, 2: 2-regular star, 3: 3-regular star]

//This parameter controls the distance of the dents that makes the inner shape. Used if the type is set to Custom. Setting this value to 1 will make the shape a polygon.
inner_shape = 0.98;

//Radius of the border around the hole, set 0 to disable. If inner border is disabled, outer border is enabled and the inner radius is non-zero, part will either need support or bottom_border should be disabled as well.
inner_border = 3;

//Height of the inner border in terms of the outer border height. Keep this value 1 or disable bottom_border, otherwise the part will need support.
inner_border_height = 1;

//Rotates the inner border in multiples of half sides
inner_rotation = -0.5;

//Only add a border for innersection, no 
inner_border_only = 0;//[1:Yes,0:No]

//Offset the inner hole sideways
inner_offset_x = 0;

//Offset the inner hole up and down
inner_offset_y = 0;

/* [Top text] */
//The text that will be displayed on top of the coin, remember to change bottom text as they are not the same.
top_text = "";

//Second text is rendered below the first one, it will be offset the same amount as the first but to the other direction. Thus if the offset is 0, they will be on top of each other.
second_top_text = "";

//Size of the text, roughly its height
text_size = 5;

//Size of the second text, roughly its height
second_text_size = 4;

//Offset of the text away from the center. Negative offsets work.
text_offset_y = 6;

//Offset of the second text away from the center. Negative offsets work.
second_text_offset_y = -.5;

//Offset of the text to the sideways
text_offset_x = -8;

//Offset of the second text to the sideways
second_text_offset_x = -8;

//How many times the text will be repeated around the coin
text_repeat = 2;


/* [Bottom text] */
//The text that will be displayed on top of the coin
bottom_text = "";

//Second text is rendered below the first one, it will be offset the same amount as the first but to the other direction. Thus if the offset is 0, they will be on top of each other.
second_bottom_text = "";

//Size of the text, roughly its height
bottom_text_size = 4;

//Size of the second text, roughly its height
second_bottom_text_size = 4;

//How many times the text will be repeated around the coin
bottom_text_repeat = 8;

//Offset of the text away from the center. Negative offsets work.
bottom_text_offset_y = 12;

//Offset of the second text away from the center. Negative offsets work.
second_bottom_text_offset_y = 0;

//Offset of the text to the sideways
bottom_text_offset_x = 0;

//Offset of the second text to the sideways
second_bottom_text_offset_x = 0;


/* [Text settings] */

//Height of the text in terms of outer border
text_height = 1;

//Font that will be used to render the text
text_font = "Nunito Sans"; //[Helvetica,Times,Oxygen,Lobster,Pacifico,Nunito Sans,Roboto Mono,Anton,Cabin,Bree Sherif,Cairo,Source Serif Pro,Kanit,Josefin Slab,Cinzel,Julius Sans One,Russo One,Concert One,Orbitron,Kaushan Script,Katibeh,Alfa Slab One,Audiowide,Luckiest Guy,Sigmar One,Press Start 2P,Bowlby One SC,Sedgwick Ave Display,Baloo Chettan,Candal,Carter One,Jockey One,Rammetto One,Bungee Inline,Titan One,Slackey,Lemon,Germania One,Ranchers,Caesar Dressing]

text_style = 1; //[0:Regular, 1:Bold, 2:Italic, 3: Bold Italic]

//rotates the text around, this is per half rotations
text_rotation = 0;

//rotates the text around, this is per half rotations
second_text_rotation = 0;

/* [Smoothing] */
//Divides the lines in the outer edge of the coin, this allows smoothing to smooth locally. Set 1 to not to divide lines. Increase both subdivisions and smooth to make rounded corners softer.
outer_subdivisions = 40;

//Smooths the corners in the outer edge. Set 0 to remove smoothing. Increase to enlarge the effect of smoothing. Generally you should keep this value less then outer subdivisions. If the values are equal you will have a circle.
outer_smooth = 3;

//Divides the lines in the inner edge of the coin, this allows smoothing to smooth locally. Set 1 to not to divide lines. Increase to make rounded corners softer. Increase both subdivisions and smooth.
inner_subdivisions = 7;

//Smooths the corners in the inner edge. Set 0 to remove smoothing. Increase to enlarge the effect of smoothing. Generally you should keep this value less then inner subdivisions. If the values are equal you will have a circle.
inner_smooth = 2;

/* [hidden] */

function pmod(v, mod) = v%mod < 0 ? v%mod + mod : v%mod;

function subdivide(in, times) = 
    let(inlen = len(in))
    [for(i=[0:inlen-1]) for(j=[0:times-1]) 
        (in[pmod(i+1, inlen)] - in[i]) * j/times + in[i]
    ]
;

function sum(in, p, to) = p == to+1 ? [for(i=in[0]) 0] : sum(in, p+1, to) + in[pmod(p, len(in))];

function average(in, from, to) = sum(in, from, to) / (to - from + 1);

function smooth(in, n) = 
    let(inlen = len(in))
    [for(i=[0:inlen-1])
        average(in, i-n, i+n)
    ]
;
        
    
function star(r_out, r_in, sides, shape = 1, angle_off = 0) = 
    let(a = 360 / (sides*2))
    [for(i = [0:(sides*2-1)]) 
        let(rx = i%2 ? r_out : r_in, ry = i%2 ? r_out - r_in + (r_in * shape) : r_in * shape)
        [cos(a*i+angle_off) * rx, sin(a*i+angle_off) * ry]];
    
function ngon(r, sides) = star(r, r, sides / 2);
    
function star_inner(sides, mod, custom) = 
    mod   == 0  ? cos(180/sides) :
    mod   == 1  ? custom * cos(180/sides) :
    sides == 5  ? 0.5 * sqrt(3 - sqrt(5)) :
    sides == 6  ? sqrt(3) / 3 :
    sides == 8  ? (
             mod == 2 ? sqrt(2 - sqrt(2)) 
                      : sin(22.5*3) - sin(22.5) ):
    sides == 10 ? (
             mod == 2 ? sqrt( (5+sqrt(5)) / 10 )
                      : sqrt(5 - 2*sqrt(5)) ):
    sides == 12 ? (
             mod == 2 ? sqrt(2) * (3-sqrt(3)) / 2
                      : sqrt(6) / 3 ):
    custom
;

difference() {
    //rotate([0, 0, outer_rotation * 360 / outer_sides / 2])
    linear_extrude(
        height = height + outer_border_height + bottom_border * outer_border_height, 
        convexity=8)
    polygon(smooth(subdivide(
        star(outer_radius, 
             outer_radius * star_inner(outer_sides, outer_mod, outer_shape), 
             outer_sides, outer_radius_shape, outer_rotation * 360 / outer_sides / 2
        )
    , outer_subdivisions), outer_smooth));

    outer_border_shape = 1 + 
        ((outer_radius_shape - 1) * outer_radius) / (outer_radius - outer_border);
    
    //rotate([0, 0, outer_rotation * 360 / outer_sides / 2])
    translate([0,0,height + (bottom_border * outer_border_height) + 0.1])
    linear_extrude(height = outer_border_height + 0.1, convexity=8)
    polygon(smooth(subdivide(
        star(outer_radius - outer_border, 
             (outer_radius - outer_border) *
                star_inner(outer_sides, outer_mod, outer_shape), 
             outer_sides, outer_border_shape, outer_rotation * 360 / outer_sides / 2
        )
    , outer_subdivisions), outer_smooth));
    
    if(bottom_border) {
        //rotate([0, 0, outer_rotation * 360 / outer_sides / 2])
        translate([0,0,-0.1])
        linear_extrude(height = outer_border_height + 0.1, convexity=8)
        polygon(smooth(subdivide(
            star(outer_radius - outer_border, 
                 (outer_radius - outer_border) *
                    star_inner(outer_sides, outer_mod, outer_shape), 
                 outer_sides, outer_border_shape, outer_rotation * 360 / outer_sides / 2
            )
        , outer_subdivisions), outer_smooth));
    }
 
    inner_border_shape = 1 + 
        ((inner_radius_shape - 1) * inner_radius) / (inner_radius - inner_border);
   
    if(inner_radius > inner_border && !inner_border_only) {
        translate([inner_offset_x,inner_offset_y,0])
        //rotate([0, 0, inner_rotation * 360 / inner_sides / 2])
        translate([0,0,-0.1])
        linear_extrude(
            height = height + outer_border_height * inner_border_height * 2 + 0.2, 
            convexity=8)
        polygon(smooth(subdivide(
            star(inner_radius - inner_border, 
                 (inner_radius - inner_border) * 
                    star_inner(inner_sides, inner_mod, inner_shape), 
                 inner_sides, inner_border_shape, inner_rotation * 360 / inner_sides / 2
            )
        ,inner_subdivisions),inner_smooth));
    }
}

if(inner_radius > 0)
difference() {
    inner_border_shape = 1 + 
        ((inner_radius_shape - 1) * inner_radius) / (inner_radius - inner_border);
    
    translate([inner_offset_x,inner_offset_y,0])
    //rotate([0, 0, inner_rotation * 360 / inner_sides / 2])
    linear_extrude(
        height = height + outer_border_height * inner_border_height + bottom_border * 
        outer_border_height * inner_border_height, 
        convexity=8)
    polygon(smooth(subdivide(
        star(inner_radius, 
             inner_radius * star_inner(inner_sides, inner_mod, inner_shape), 
             inner_sides, inner_radius_shape, inner_rotation * 360 / inner_sides / 2
        )
    ,inner_subdivisions),inner_smooth));
    
    
    if(inner_radius > inner_border) {
        translate([inner_offset_x,inner_offset_y,0])
        //rotate([0,0, inner_rotation * 360 / inner_sides / 2])
        translate([0,0,-0.1])
        linear_extrude(height = height + outer_border_height * inner_border_height * 2 + 0.2, convexity=8)
        polygon(smooth(subdivide(
            star(inner_radius - inner_border, 
                 (inner_radius - inner_border) * 
                    star_inner(inner_sides, inner_mod, inner_shape), 
                 inner_sides, inner_border_shape, inner_rotation * 360 / inner_sides / 2
            )
        ,inner_subdivisions),inner_smooth));
    }
}

text_stylenames = ["", ":style=Bold", ":style=Italic", ":style=Bold Italic"];

font_string = str(text_font, text_stylenames[text_style]);


ang = 360 / text_repeat;
for(i=[0:text_repeat-1]) {

    rotate([0,0,(i+text_rotation/2)*ang])
    translate([text_offset_x, text_offset_y, text_height * outer_border_height + height - 0.1])
    linear_extrude(height = text_height * outer_border_height + 0.1)
    text(text = top_text, size = text_size, 
         font = font_string,
         halign = "center", valign = "center");
    

    rotate([0,0,(i+second_text_rotation/2)*ang])
    translate([second_text_offset_x, -second_text_offset_y, text_height * outer_border_height + height - 0.1])
    linear_extrude(height = text_height * outer_border_height + 0.1)
    text(text = second_top_text, size = second_text_size, 
         font = font_string,
         halign = "center", valign = "center");
}

bang = 360 / bottom_text_repeat;
for(i=[0:bottom_text_repeat-1]) {
    rotate([0,0,(i+text_rotation/2)*bang])
    translate([-bottom_text_offset_x, bottom_text_offset_y, 0])
    mirror(1,0,0)
    linear_extrude(height = text_height * outer_border_height + 0.1)
    text(text = bottom_text, size = bottom_text_size, 
         font = font_string,
         halign = "center", valign = "center");

    
    rotate([0,0,(i+second_text_rotation/2)*bang])
    translate([-second_bottom_text_offset_x, -second_bottom_text_offset_y, 0])
    mirror(1,0,0)
    linear_extrude(height = text_height * outer_border_height + 0.1)
    text(text = second_bottom_text, size = second_bottom_text_size, 
         font = font_string,
         halign = "center", valign = "center");

}

   
