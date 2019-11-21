/* [Mute Dimensions] */
//the radius of the top of the mute, that is inside the bell
mute_top_radius=25;// [5:0.5:100]
//the radius of the widest part of the mute
mute_wide_radius=49;// [5:0.5:200]
//the radius of the base/bottom of the mute that sticks out of the bell
mute_base_radius=25;// [5:0.5:100]

//the flare of the mute. Changes the shape.
mute_flare=0.6; // [0:0.02:8]

//the flare of the bottom of the mute. Changes the shape
mute_bottom_flare=-0.6; // [-4:0.02:0]
//the height of the top part of the mute
mute_top_height=108;
//the height of the bottom part of the mute
mute_bottom_height=40;

/* [Muting tube] */
//the diameters of the small tube used to mute
hole_diameter_top = 3.8;
//It contains a smaller area, the diameter of that is configurable here
hole_diameter_small=3.5;
//the diameter of the bottom of the muting tube
hole_diameter_bottom = 4.6;

/* [Bell fit] */
//sometimes the taper of the bell is different than that of the mute. Set to true for a different fit area of the mute, false to remove it.
render_better_fit_area="yes"; // [yes, no]
//the height of the tapered area that fits the bell. It's the outside shape only
tapered_area_height = 20;
tapered_area_width=3.55;
tapered_area_flare=0.6;

/* [Wall thicknesses] */
//the wall thickness of the mute. If you increase the diameter, you might want to increase this.
bell_wall_thickness = 1.2;

/* [DETAIL PARAMETERS] */
//steps for all rotate_extrude calls. For development: 20 is enough. For printing set to 300
$fn = 300;
//steps of the bessel curve for loop. Increases mute detail.
steps=100;

/* [Text on mute] */
//write text on mute
write_text="no"; // [no, yes]
//the text on the mute
text_to_write="PrintBone";
//the height of the text on the mute from the bottom
letter_height=52;
//rotation of the text so it fits well on the mute
letter_rotation=-21;

/* [Hidden]*/
//the mute, as a series of bessel curves
mute_input = [
    ["BESSEL", mute_top_radius, mute_wide_radius, mute_flare, mute_top_height],
    ["BESSEL", mute_wide_radius, mute_base_radius, mute_bottom_flare, mute_bottom_height]
];
//the thickness of the cork used, for visualization
render_cork = false;
cork_thickness = 1.6;



//the curve (not yet a polygon, just a set of points on a line for now!) of the mute
bell_profile = create_bell_profile(mute_input, steps);

//it's possible to render a bell profile of a trombone to check the fit of the mute.
// This is the printbone, but you can render any trombone you want of course
render_bell_profile = false;



bell_input = [
//part of the printbone, for reference
    ["BESSEL", 15.07, 22.28, 0.894, 150.42],
    ["BESSEL", 22.28, 41.18, 0.494, 96.85],
    ["BESSEL", 41.18, 8.5*25.4/2, 1.110, 55.93]
];
bell_height = sum_length(mute_input, 0);
bell_profile_full = create_bell_profile(bell_input, 50);


cork_bessel = [
    ["BESSEL", bell_profile[0][0], bell_profile[0][0]+tapered_area_width, tapered_area_flare, tapered_area_height],
    ["CONE", bell_profile[0][0]+tapered_area_width, bell_radius_at_height(bell_profile, bell_height-tapered_area_height-2.2), 2.2]
];

cork_profile = create_bell_profile(cork_bessel, 50);

render_bell_profile=false;


//tests if the mute will fit. should fit both of these
/* approximation (not perfect) of a german style trumpet*/
bell_input = [
["BESSEL", 29.9/2, 35.8/2, 0.9, 40],
["BESSEL", 35.8/2, 45.8/2, 0.9, 30],
["BESSEL", 45.8/2, 78.2/2, 0.7, 30],
["BESSEL", 78.2/2, 139/2, 0.9, 20]
];

/* rough generic modern trumpet */
bell_input = [
["BESSEL", 11.2/2, 130/2, 0.6, 606]
];
bell_height = sum_length(mute_input, 0);
bell_profile_full = create_bell_profile(bell_input, 200);


//for(i = [80:-5:0]) {
//    echo(i, "mm ", bell_radius_at_height(bell_profile_full, i)*2);
//}


cork_bessel = [
    ["BESSEL", bell_profile[0][0], bell_profile[0][0]+tapered_area_width, tapered_area_flare, tapered_area_height],
    ["CONE", bell_profile[0][0]+tapered_area_width, bell_radius_at_height(bell_profile, bell_height-tapered_area_height-2.2), 2.2]
];

cork_profile = create_bell_profile(cork_bessel, 50);



/**
 *gives a [start:step:end] array that guarantees to include end. uglyness :)
 */
function array_iterator(start, step, end) =
    let(result = [for (i=[start:step:end]) i ]) 
    result[len(result)-1] == end ? result :
    concat(
        result,
        [end]
    );
    

/*
Module to render a bell based on multiple bessel curves
 To create a bessel curve:
 bessel_curve(throat_radius=10.51, mouth_radius=108.06, length=200, flare=0.78, wall_thickness=3)
 
 To create a bell profile, do the following:
Array of input. First element defines type:
["CYLINDER", radius, length]
["CONE", r1, r2, length]
["BESSEL", r_small, r_large, flare, length]

bell_input = [
    ["CYLINDER", 10/2, 40],
    ["CONE", 10.2/2, 10.3/2, 15],
    ["CONE", 10.3/2, 12.7/2, 44],
    ["BESSEL", 14.7/2, 23/2, 1.260, 223],
    ["BESSEL", 23/2, 37/2, 0.894, 72],
    ["BESSEL", 37/2, 61.8/2, 0.7, 36.6],
    ["BESSEL", 61.8/2, 8.5*25.4/2, 1, 14.37], 
];

bell_polygon = create_bell_profile(bell_input, steps=100);

rotate_extrude()
extrude_line(bell_polygon, wall_thickness=2, solid=false, normal_walls=true);
*/


/*
#rotate_extrude()
bessel_curve(throat_radius=6.51, mouth_radius=94/2, length=400, flare=0.9, wall_thickness=3, solid=true, steps=100);

bell_input = [
    ["CYLINDER", 10.3/2, 40],
    ["CONE", 10.2/2, 10.3/2, 15],
    ["CONE", 10.3/2, 12.7/2, 44],
    ["BESSEL", 12.7/2, 23/2, 1.260, 223],
    ["BESSEL", 23/2, 37/2, 0.894, 72],
    ["BESSEL", 37/2, 61.8/2, 0.7, 36.6],
    ["BESSEL", 61.8/2, 94/2, 1, 14.37], 
];

bell_polygon = create_bell_profile(bell_input, steps=200);

rotate_extrude($fn=200)
extrude_line(bell_polygon, wall_thickness=2, solid=false);*/

function create_bell_profile(input, steps=100) =
    concat_array(
        [  
            for (i =[0:len(input)-1]) 
                translate_cylinder_input(input, i, steps)
        ]
    );

function concat_array(input, i=0) = 
    i >= len(input) ?
        [] :
        concat(input[i], concat_array(input, i+1));
            ;

// Haven't found a better way to define this in openscad. It works...
function translate_cylinder_input(input, i, steps) =
    let(value=input[i])
    value[0] == "CYLINDER" ?
            [
                [value[1], -sum_length(input, i)],
                [value[1], -sum_length(input, i+1)]
            ]
            : translate_cone_input(input, i, steps);
            ;

function translate_cone_input(input, i, steps) =
    let(value=input[i])
    value[0] == "CONE" ?
            [
                [value[1], sum_length(input, i)],
                [value[2], sum_length(input, i+1)]
            ]
            : translate_bessel_input(input, i, steps);
            ;

function translate_bessel_input(input, i, steps) =
    let(value=input[i])
    value[0] == "BESSEL" ?
//            [value[1], -sum_length(input, i)]
            2d_bessel_polygon(translation=sum_length(input, i+1),  throat_radius=value[1], mouth_radius=value[2], length=value[4], flare=value[3], steps=steps)
            : "ERROR";
            ;
     
// sum the length parameter of all input curves of point i and later. Length is always last
// input is array of instructions
function sum_length(input, i, sum = 0) =
    i >= len(input) ? sum : sum_length(input, i+1, sum + input[i][len(input[i])-1]);
    


function cut_curve(curve, min_height, max_height) = 
    cut_curve_at_height2( //bell_polygon,
        cut_curve_at_height(curve, min_height, max_height)
        , min_height, max_height);

/* 
Renders a cone shaped tube.
wall is wall thickness
*/
module conic_tube(h, r1, r2, wall, center = false) {
  difference() {
          cylinder(h=h, r1=r1+wall, r2=r2+wall, center=center);
          cylinder(h=h, r1=r1, r2=r2, center=center);
  }
}

module conic_tube_conic_wall(h, r1, r2, wall1, wall2, center = false) {
  difference() {
          cylinder(h=h, r1=r1+wall2, r2=r2+wall1, center=center);
          cylinder(h=h, r1=r1, r2=r2, center=center);
  }
}

/*
* Bessel horn bell equation from
* http://www.acoustics.ed.ac.uk/wp-content/uploads/Theses/Braden_Alistair__PhDThesis_UniversityOfEdinburgh_2006.pdf
*/


module bessel_curve(translation=0, throat_radius, mouth_radius, length, flare, wall_thickness, solid=true, steps=100) {    

   2d_bessel = 2d_bessel_polygon(translation, throat_radius, mouth_radius, length, flare, steps);
   extrude_line(2d_bessel, wall_thickness, solid);

}

EPSILON = 0.00000000001;
function abs_diff(o1, o2) =
    abs(o1-o2);
    
//from a single line, make a wall_thickness wide 2d polygon.
//translates along the normal vector without checking direction, so be careful :)
module extrude_line(input_curve, wall_thickness, solid=false, remove_doubles=true, normal_walls=true) {
    //remove consecutive points that are the same. Can't have that here or we'll have very strange results

    extrude_curve = remove_doubles ? concat([input_curve[0]], [for (i = [1:1:len(input_curve)-1]) if(abs_diff(input_curve[i][1], input_curve[i-1][1]) > EPSILON || abs_diff(input_curve[i][0], input_curve[i-1][0]) > 0.001) input_curve[i]]) : input_curve;
//        echo("walls normal?", normal_walls);
    outer_wall =  [for (i = [len(extrude_curve)-1:-1:1]) 
                    extrude_curve[i] + get_thickness_vector(normal_walls, wall_thickness, extrude_curve, i)
                    ];


    //make sure we have a horizontal edge both at the top and bottom
    //to ensure good printing and gluing possibilities
    bottom_point = [extrude_curve[len(extrude_curve)-1]+[wall_thickness, 0]];
    top_point = [extrude_curve[0]+[wall_thickness, 0]];

    outer_curve = concat(
            bottom_point,
            outer_wall,
            top_point
    );
    
    if(!solid) {
        // a bug in openscad causes small polygons with many points to render a MUCH lower resolution.
        //so scale up by factor 100 
        scale([0.01, 0.01, 0.01])   
        polygon( points=
           concat(
            [ for (x=extrude_curve) [x[0]*100, x[1]*100]],
            [ for (x=outer_curve) [x[0]*100, x[1]*100]]
            )
        );
    } else {
        scale([0.01, 0.01, 0.01])
      polygon( points=
       concat(
          [[0, bottom_point[0][1]*100]],
          [ for (x=outer_curve) [x[0]*100, x[1]*100]],
          [[0, top_point[0][1]*100]]
        )
    );
    }
}

function get_thickness_vector (normal_walls, wall_thickness, extrude_curve, i) =
        let( normal_vector = unit_normal_vector(extrude_curve[i-1], extrude_curve[i]))
        (normal_walls) ? 
            normal_vector * wall_thickness 
        : (
                //horizontal walls need special treatment in this case
                normal_vector == [0,1] ? [0,-wall_thickness]:
                [wall_thickness, 0]
        );

function 2d_bessel_polygon(translation=0, throat_radius, mouth_radius, length, flare, steps=30) =    

    //inner curve of the bell
    let(
        b = bessel_b_parameter(throat_radius, mouth_radius, length, flare),
        x_zero = bessel_x_zero_parameter(throat_radius, b, flare),
        step_size = (length)/steps
    )

    [for (i = array_iterator(x_zero, step_size, x_zero + length)) 
         [bell_diameter(b, i, flare), -(i-(x_zero+length))] + [0, translation]
    ];


function bell_diameter(B, y, a) =
//   B/pow(y + y_zero,a);
   B*pow(-y,-a);
    
    
function bessel_b_parameter(r0, r1, d, gamma) =
    pow(
    (d/
        (
            pow(r0, -1/gamma) - 
            pow(r1, -1/gamma)
        )
    ), gamma);
 
function bessel_x_zero_parameter(r0, b, gamma) =
    - pow(r0/b, -1/gamma);
    
    
function unit_normal_vector(p1, p2) =
    let(
        dx = p2[0]-p1[0],
        dy = p2[1]-p1[1]
        ) 
        [-dy, dx]/norm([-dy,dx]);

function cut_curve_at_height(curve, min_height, max_height) =
    concat(
        [
            for (i = [0:1:len(curve)-2])
                if(curve[i+1][1] >= min_height)// && curve[i][1] <= max_height)
                   curve[i]             
        ],
        [for (i = [len(curve)-1]) if(curve[i][1] >= min_height) curve[i]]
    );
            
function cut_curve_at_height2(curve, min_height, max_height) =

    concat(
        [for (i = [0]) if(curve[i][1] <= max_height) curve[0]],
        [
        for (i = [1:1:len(curve)-1])
            if( curve[i][1] <= max_height)
               curve[i]             
        ]
    );
    
            
function radius_at_height(curve, height) =
        lookup(-height, reverse_key_value(curve));
      /* [for (i = [1:1:len(curve)-1])
            if( curve[i-1][1] <= height && curve[i][1] >= height)
               curve[i][0]            
        ][0]
            ;*/
            
function reverse_key_value(array) = 
    [for (i = [len(array)-1:-1:1])
        [-array[i][1], array[i][0]]
    ];



if(render_bell_profile) {
    translate([0, 0, 35])
rotate([90,0,0])
//rotate_extrude()
    extrude_line(input_curve=bell_profile_full, wall_thickness=bell_wall_thickness, solid=false, remove_doubles=true, normal_walls=true);
}


if(write_text == "yes") {
    translate([0,0,letter_height])
        rotate([0,0,0])
        writeOnMute(
            text=text_to_write, 
            radius=radius_at_height(bell_profile, letter_height)+bell_wall_thickness-0.4, 
            letter_rotation=letter_rotation,
            h=8.5);
}

module writeOnMute(text,radius,letter_rotation, h=5, t=1, east=0, west=0, space =1.0, font){
    bold=0;
	center=false;
	rotate=0;			// text rotation (clockwise)

    pi2=PI*2;
    up =0;		 //mm up from center on face of cube
	down=0;
    
	wid=(.125* h *5.5 * space);
	widall=wid*(text_width(text, 0, len(text)-1))/2; 
	//angle that measures width of letters on sphere
	function NAngle(radius)=(wid/(pi2*radius))*360*(1-abs(rotate)/90);
	//angle of half width of text

	function mmangle(radius)=(widall/(pi2*radius)*360);
    translate([0,0,up-down])
    rotate(east-west,[0,0,1])
    for (r=[0:len(text)-1]){
        rotation_width = text_width(text, 0, r);
        letter_width = text_width_one_letter(text, r);
        
        rotate(-90+(rotation_width*NAngle(radius)),[0,0,1])
        translate([radius,0,-r*((rotate)/90*wid)+(text_width(text, 0, len(text)-1))/2*((rotate)/90*wid)])
        rotate([0,letter_rotation,0])
        rotate(90,[1,0,0])
        //this might look like it should be 90 + letter_width/2, but
        //letter width includes a bit of spacing. Not nice, but hey, I'm not doing a full
        //font kerning implementation here :)
        rotate(93, [0,1,0]) 
        linear_extrude(height=t)
        text(text[r], center=true, size=h, font=font);
//echo("zloc=",height/2-r*((rotate)/90*wid)+(len(text)-1)/2*((rotate)/90*wid));
    }

}
//the text/write module does not provide spacing or kerning data
//so here it is for the default font. Set to 1 for monospaced fonts for all letters :)
font_spacing_data = [
["a", 1.15],
["b", 1.12],
["c", 1.1],
["d", 1.1],
["e", 1.2],
["f", 0.7],
["g", 1],
["h", 1.1],
["i", 0.55],
["j", 0.7],
["k", 1],
["l", 0.6],
["m", 1.75],
["n", 1.24],
["o", 1.17],
["p", 1.2],
["q", 1],
["r", 0.83],
["s", 1.1],
["t", 0.8],
["u", 1.3],
["v", 1],
["w", 1],
["x", 1.2],
["y", 1],
["z", 1],
["A", 1.4],
["B", 1.4],
["C", 1.4],
["D", 1.4],
["E", 1.4],
["F", 1.4],
["G", 1.4],
["H", 1.4],
["I", 1.4],
["J", 1.2],
["K", 1.4],
["L", 1.35],
["M", 1.8],
["N", 1.4],
["O", 1.4],
["P", 1.45],
["Q", 1.4],
["R", 1.4],
["S", 1.4],
["T", 1.3],
["U", 1.3],
["V", 1.3],
["W", 1.3],
["X", 1.3],
["Y", 1.3],
["Z", 1.3],
[" ", 0.8],
["'", 0.42]
];

function text_width(string, index, max_len) =
    max_len == 0 ? 0 :
    (index >= max_len-1 ? 
        text_width_one_letter(string, index) : 
        text_width_one_letter(string, index) + text_width(string, index+1, max_len));

function text_width_one_letter(string, index) =
    font_spacing_data[search(string[index], font_spacing_data)[0]][1];
    

rotate_extrude()
union(){
    extrude_line(bell_profile, bell_wall_thickness, solid=false, remove_doubles=true, normal_walls=false);
    muting_tube();
    //bottom
    mute_bottom();
    if(render_better_fit_area == "yes") {
        difference() {       
            cork_profile();    
        
            solid_mute_profile();
        }
    }

}   

//render the cork to test fit
if(render_cork) {
    %rotate_extrude()
    difference() {
        cork_profile(bell_wall_thickness+cork_thickness);
    solid_mute_profile();
   }
}



module mute_bottom(){
    radius_at_top_of_bottom = bell_radius_at_height(bell_profile, bell_wall_thickness)+bell_wall_thickness;
    radius_a_bit_higher = bell_radius_at_height(bell_profile, bell_wall_thickness*2.5)+bell_wall_thickness;
    polygon(points=[[hole_diameter_bottom,0], [mute_base_radius,0],
        [radius_a_bit_higher, bell_wall_thickness*2.5],
        [radius_at_top_of_bottom-4, bell_wall_thickness], 
//[radius_at_top_of_bottom, bell_wall_thickness], 
        [hole_diameter_bottom, bell_wall_thickness]]);
}

module muting_tube() {
    tube_outside_radius = hole_diameter_top+bell_wall_thickness*1.5;
    polygon([
        //bottom edge of tube
        [hole_diameter_bottom, 0], [tube_outside_radius+bell_wall_thickness*2, 0], 
        [tube_outside_radius, 5], 
        //top edge of tube
        [tube_outside_radius, mute_bottom_height], [hole_diameter_top, mute_bottom_height],
        //and slightly smaller part near bottom
        [hole_diameter_top, 6], [hole_diameter_small, 2]
   ]);
}

module cork_profile(thickness=bell_wall_thickness) {
    translate([0, bell_height-sum_length(cork_bessel, 0)])
        //rotate_extrude()
        extrude_line(input_curve=cork_profile, wall_thickness=thickness, solid=true, remove_doubles=true, normal_walls=false);
}

module solid_mute_profile() {
    extrude_line(bell_profile, bell_wall_thickness, solid=true, normall_walls=false);
}

function bell_radius_at_height(curve, height) =
    radius_at_height( curve, height);