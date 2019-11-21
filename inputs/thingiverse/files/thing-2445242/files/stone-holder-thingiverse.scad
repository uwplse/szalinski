
/* [Common] */

//Which part to customize
part=2; //[1:End Piece,2:Mid Piece]
//Distance between the holes for the threaded rods. Should be the same for all pieces.
rod_hole_distance = 30;
//Radius for the threaded rod holes. I found a radius of 4.3mm (8.6 diameter) worked for M8 rod in PLA.
rod_hole_radius = 4.3;
//Number of fragments for the curved surfaces.
curve_resolution = 30; // [10:60]
//Overall width of the piece. Limits the maximum width of a "cut out" on a Mid Piece. Can be different for different pieces.
base_width = 75;

/* [Mid Piece] */

//Height before any stone cut-outs.
base_height = 15;
//"Extra" depth for the middle piece, if this is 0 the last cut-out won't have a back.
base_extra_depth = 10;
//Series of numbers for each stones cut-out of the form: Width1,Depth1,Height1;Width2,Depth2,Height3... Hint: if you have two stones near in size (say 6" and 7") you can put the shorter stone in as the first "cut" and then the second with a depth of half the difference (7" - 6" = 1" / 2 = 12.7ish) (some prototyping may be necessary though)
cut_outs = "50.8,10,5;60.8,14.2,5";

/* [End Piece] */
//Height of the end piece
end_height = 45;
//Depth of the end piece.
end_depth = 50;

//Depth of the notch cut out for fitting in the sink
notch_depth = 25;
//Height of the notch cut out for fitting in the sink
notch_height=28;

/* [Hidden] */



if (part == 1) end_piece();
else mid_piece();

/* ----- Modules/Functions ----- */

//These functions are (shamelessly) copy/pasted from jepler's reply at:
//https://www.thingiverse.com/groups/openscad/topic:10294
function substr(s, st, en, p="") =
    (st >= en || st >= len(s))
        ? p
        : substr(s, st+1, en, str(p, s[st]));

function split(h, s, p=[]) =
    let(x = search(h, s)) 
    x == []
        ? concat(p, s)
        : let(i=x[0], l=substr(s, 0, i), r=substr(s, i+1, len(s)))
                split(h, r, concat(p, l));


//Functions for getting the sum of values inside a 2 dimensional array
function vector_vector_sum(vector, sub_index) = vector_vector_sum_s(vector,sub_index, 0);
function vector_vector_sum_s(vector, sub_index, index) = 
    index == len(vector) - 1 ? vector[index][sub_index] : vector[index][sub_index] + vector_vector_sum_s(vector,sub_index,index+1);
function vector_vector_sum_range(vector, sub_index, start_index, end_index) = 
    start_index == end_index ? vector[start_index][sub_index]
                             : vector[start_index][sub_index] 
                               + vector_vector_sum_range(vector, 
                                    sub_index, 
                                    start_index + 1,
                                    end_index);

//Functions to (painfully) convert strings to floats
function str_to_float(string) =
    let(dec_point = search(".",string), 
        pow= dec_point == [] ? len(string) - 1 : dec_point[0] - 1)
        stf(string,pow,0);
    
function stf(string, power, val) =
    len(string) == 0 ? val : 
        string[0] == "." ? stf(substr(string,1,len(string)),power,val) : 
            stf(substr(string,1,len(string)), power-1, val + (pow(10,power) * chr_to_int(string[0])));
function chr_to_int(char) =
    len(char) != 1 ? 0 :
        char == "0" ? 0 :
        char == "1" ? 1 :
        char == "2" ? 2 :
        char == "3" ? 3 :
        char == "4" ? 4 :
        char == "5" ? 5 :
        char == "6" ? 6 :
        char == "7" ? 7 :
        char == "8" ? 8 :
        char == "9" ? 9 :
        0;
function find_bad_cuts(cuts, i) =
    i >= len(cuts) ? -1 : len(cuts[i]) != 3 ? i : find_bad_cuts(cuts, i + 1);

module mid_piece() {
    cuts = [for (i = split(";",cut_outs)) [for (j = split(",",i)) str_to_float(j)] ];
    bad_cut= find_bad_cuts(cuts,0);
    
    if (bad_cut >= 0) {
        linear_extrude(height=10) {
            text(text=str("Bad cut format at ", bad_cut),size=20,font="Liberation Sans");
        }
    }
    else {
        total_height = base_height + vector_vector_sum(cuts,2);
        total_depth = base_extra_depth + vector_vector_sum(cuts,1);

        translate([0,total_height,0])
        rotate([90,0,0])
        difference() {
            rounded_cube([base_width,total_depth, total_height],$fn=curve_resolution);
            
            translate([(base_width-rod_hole_distance)/2,0, base_height/2 ])
            rotate([-90,0,0])
            cylinder_outer(total_depth,rod_hole_radius,curve_resolution);

            translate([(base_width-rod_hole_distance)/2+rod_hole_distance,0, base_height/2 ])
            rotate([-90,0,0])
            cylinder_outer(total_depth,rod_hole_radius,curve_resolution);

            for (i = [0:len(cuts)-1]) {
                translate([(base_width - cuts[i][0])/2, 
                           total_depth - vector_vector_sum_range(cuts,1,0,i),
                           base_height + (i-1 >= 0 ? vector_vector_sum_range(cuts,2,0,i-1) : 0)])
                color("red")
                cube([cuts[i][0],total_depth,total_height]);
                           
            }

        }
    }
}

module end_piece() {
    translate([0,0,end_depth])
    rotate([-90,0,0])
    difference() {
        rounded_cube([base_width,end_depth,end_height],$fn=curve_resolution);
        translate([(base_width-rod_hole_distance)/2,0,end_height - (end_height - notch_height)/2 ])
        rotate([-90,0,0])
        cylinder_outer(end_depth,rod_hole_radius,curve_resolution);
        translate([(base_width-rod_hole_distance)/2 + rod_hole_distance,0,end_height - (end_height - notch_height)/2 ])
        rotate([-90,0,0])
        cylinder_outer(end_depth,rod_hole_radius,curve_resolution);
        translate([-0.5*base_width,notch_depth,-notch_height])
        rotate([0,0,-90])
        rounded_cube([end_depth,base_width*2,notch_height*2],$fn=curve_resolution);
    }
}

/**
 * Creates a cube with the edges that run parrallel to the y-axis are rounded. Cube is un-centered.
 * @param xyz 3 length array, dimensions in x, y, and z planes
 * @param r_edge Optional. How far from the corner to start rounding the edge. Default is 1/8 of the x dimension.
 * @param r Optional. Radius of the cylinder that is used to round the edge. default is equal to r_edge.
 */
module rounded_cube(xyz = [1,1,1], r_edge = -1,r = -1) {
    if (len(xyz) == 3) {
        i_edge = r_edge < 0 ? xyz[0] * 0.125 : r_edge;
        i_rad = r < 0 ? i_edge : r;
        i_c = sqrt(2*pow(i_edge,2));
        i_ang = 45 - asin(i_c/(2*i_rad));
        i_cyl_d = i_rad*sin(i_ang);
        difference() {
            cube(size = xyz);
            //bottom left
            difference() {
                cube(size=[i_edge,xyz[1],i_edge]);

                translate([i_edge+i_cyl_d,0,i_edge+i_cyl_d])
                rotate([-90,0,0])
                cylinder(r=i_rad,h=xyz[1]);
            }
            //bottom right
            translate([xyz[0]-i_edge,0,0]) {
            difference() {
                cube(size=[i_edge,xyz[1],i_edge]);

                translate([-i_cyl_d,0,i_edge+i_cyl_d])
                rotate([-90,0,0])
                cylinder(r=i_rad,h=xyz[1]);
            }}
            //top right
            translate([xyz[0]-i_edge,0,xyz[2]-i_edge]) {
            difference() {
                cube(size=[i_edge,xyz[1],i_edge]);

                translate([-i_cyl_d,0,-i_cyl_d])
                rotate([-90,0,0])
                cylinder(r=i_rad,h=xyz[1]);
            }}
            //top right
            translate([0,0,xyz[2]-i_edge]) {
            difference() {
                cube(size=[i_edge,xyz[1],i_edge]);

                translate([i_edge+i_cyl_d,0,-i_cyl_d])
                rotate([-90,0,0])
                cylinder(r=i_rad,h=xyz[1]);
            }}
        }
    }
    else
    {
        echo("WARN: module rounded_cube, expected xyz len 3 got", len(xyz));
    }
}

/**
 * Creates a cylinder that is at minimum radius in all angles. 
 * Default cylinders are "inscribed" where the points of their approximations lie on the circle at radius, leading to a slightly smaller than defined cylinder.
 * @param height Height of the cylinder.
 * @param radius Radius of the cylinder.
 * @fn Number of facets. Required because the extra length of the radius depends on how many sides the cylinder approximation uses.
 */
module cylinder_outer(height,radius,fn){
   extra_r = 1/cos(180/fn);
   cylinder(h=height,r=radius*extra_r,$fn=fn);
}
