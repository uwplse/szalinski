/**
 ** CONFIGURATION / GLOBALS
 **/

// Generation mode. Possible modes: board_with_pegs, board, pegs, letters.
mode = "board_with_pegs"; //[board_with_pegs, board, pegs, letters]

// The number of peg sectors ("combination tags"). 12 sectors = 3^12 = 531441 possible peg combinations.
peg_sectors = 12;

// Peg size mm, [x, y, [ z1 (letter), z2 (solid), z3 (combination) ]].
peg_size = [ 40, 40, [3, 3, 6] ];

// We multiply peg_size.x with this to place the letters.
peg_spacing_x_ratio = 1.1;

// Size of the board.
board_size = [ 320, 50, 20 ];

// Text to generate
text = "TIFFANY";

// Font name and style (example "Liberation Sans:style=Bold Italic")
font = "Impact";

// Font size (inaccurate, mm).
font_size = 25;

// Tolerance between peg pattern and board slot [xy (mm), z (mm)].
peg_vs_slot_tolerance_xy_z = [0.5, 1];

// For mode board_with_pegs, this Z distance (mm) will be put between the board slot bottom and peg bottom.
spacing_z = 2;

// Extension edges. If you want to hook multiple boards together you can enable it here. Valid values are: "m" (male edge), "f" (female edge), "" (plain edge). Vector is [left, right, front, back]. For example [ "f", "", "", "m" ].
board_ext_edges = [ "", "", "", "" ];

// Extenision edge depth (mm).
ext_edge_depth = 10;

// Extension edges tolerance (mm).
ext_edge_tolerance = 0.5;

// Preset combinations (use this if you want to generate board and pegs separatly, and keep the combinations).
preset_combinations =  [];


/**
 ** MAIN LOGIC / ASSEMBLY
 **/

{
    // If combinations are not preset, create random ones.
    combinations = len(preset_combinations)==0 ?
        [ for (letter = [0:len(text)-1]) peg_combination(peg_sectors) ]
        : preset_combinations;
    echo("COMBINATIONS-DUMP: ", combinations);
    
    // Trick to let the combination of identical letters be the same.
    deduped_combination_indexes = [ for (letter = [0:len(text)-1]) search(text[letter], text, 1)[0] ];
    
    // The polygon profile per letter of the text.
    text_combination_profiles = [ 
        for (letter = [0:len(text)-1])
        let (combination_index = deduped_combination_indexes[letter])
        peg_profile(combinations[combination_index])
    ];
 
    // Some common values used across various modes.
    pegs_offset = [
        (board_size[0] - peg_size[0] * len(text) * peg_spacing_x_ratio) / 2,
        (board_size[1] - peg_size[1]) / 2,
        board_size[2] - peg_size[2][2] + 1/1000
    ];      
    
    
    //    
    // Assemblies
    //
        
    if (mode == "board_with_pegs") {   
        // pegs        
        translate([pegs_offset[0], pegs_offset[1],  pegs_offset[2] + spacing_z])
            pegs(text_combination_profiles, peg_vs_slot_tolerance_xy_z);
        
        // board (with slots)
        board(text_combination_profiles, pegs_offset);
    }
    
    else if (mode == "board") {
        board(text_combination_profiles, pegs_offset);
//        translate([-1 * board_size[0] + ext_edge_depth, 1, 0])
//            board(text_combination_profiles, pegs_offset);
    }
    
    else if (mode == "pegs") {
        pegs(text_combination_profiles, peg_vs_slot_tolerance_xy_z);
    }
    
    else if (mode == "letters") {
        letters();
    }
}

// Builds the board with scaled-up peg bottoms subtracted.
module board(text_combination_profiles, pegs_offset) {
    union() {
        difference() {
            cube(board_size);
            translate(pegs_offset)
                pegs(text_combination_profiles, [0, 0]);

            // extension edges (left, right, front, back)
            if (board_ext_edges[0] != "")
                cube([ext_edge_depth, board_size[1], board_size[2]]);
            if (board_ext_edges[1] != "")
                translate([board_size[0] - ext_edge_depth, 0, 0])
                    cube([ext_edge_depth, board_size[1], board_size[2]]);
            if (board_ext_edges[2] != "")
                cube([board_size[0], ext_edge_depth, board_size[2]]);
            if (board_ext_edges[3] != "")
                translate([0, board_size[1] - ext_edge_depth, 0])
                    cube([board_size[0], ext_edge_depth, board_size[2]]);
            
            
        }
        difference() {
            union() {
                // left
                translate([0, board_size[1], 0]) rotate([90,0,0])                
                    ext_edge(board_ext_edges[0], [ext_edge_depth, board_size[2], board_size[1]]);
                // right                
                translate([board_size[0], 0, 0]) rotate([90,0,180])                
                    ext_edge(board_ext_edges[1], [ext_edge_depth, board_size[2], board_size[1]]);
                // front
                translate([0, 0, 0]) rotate([90,0,90])                
                    ext_edge(board_ext_edges[2], [ext_edge_depth, board_size[2], board_size[0]]);
                // back
                translate([board_size[0], board_size[1], 0]) rotate([90,0,-90])                
                    ext_edge(board_ext_edges[3], [ext_edge_depth, board_size[2], board_size[0]]);
            }
            // corner: left+front
            if (board_ext_edges[0] != "" && board_ext_edges[2] != "")
            difference() {
                cube([ext_edge_depth, ext_edge_depth, board_size[2]]);
                intersection() {
                    // left
                    translate([0, board_size[1], 0]) rotate([90,0,0])                
                        ext_edge(board_ext_edges[0], [ext_edge_depth, board_size[2], board_size[1]]);
                    // front
                    translate([0, 0, 0]) rotate([90,0,90])                
                        ext_edge(board_ext_edges[2], [ext_edge_depth, board_size[2], board_size[0]]);
                }
            }
            // corner: front+right
            if (board_ext_edges[2] != "" && board_ext_edges[1] != "")
            difference() {
                translate([board_size[0]-ext_edge_depth, 0, 0]) 
                    cube([ext_edge_depth, ext_edge_depth, board_size[2]]);
                intersection() {
                    // front
                    translate([board_size[0]/2, 0, 0]) rotate([90,0,90])                
                        ext_edge(board_ext_edges[2], [ext_edge_depth, board_size[2], board_size[0]]);
                    // right
                    translate([board_size[0], board_size[1]/-2, 0]) rotate([90,0,180])                
                        ext_edge(board_ext_edges[1], [ext_edge_depth, board_size[2], board_size[1]]);
                }
            }
            // corner: right+back
            if (board_ext_edges[1] != "" && board_ext_edges[3] != "")
            difference() {
                translate([board_size[0]-ext_edge_depth, board_size[1]-ext_edge_depth, 0])
                    cube([ext_edge_depth, ext_edge_depth, board_size[2]]);
                intersection() {
                    // right
                    translate([board_size[0], board_size[1]/2, 0]) rotate([90,0,180])                
                        ext_edge(board_ext_edges[1], [ext_edge_depth, board_size[2], board_size[1]]);
                    // back
                    translate([board_size[0]*1.5, board_size[1], 0]) rotate([90,0,-90])                
                        ext_edge(board_ext_edges[3], [ext_edge_depth, board_size[2], board_size[0]]);
                }
            }
            // corner: back+left
            if (board_ext_edges[3] != "" && board_ext_edges[0] != "")
            difference() {
                translate([0, board_size[1]-ext_edge_depth, 0])
                    cube([ext_edge_depth, ext_edge_depth, board_size[2]]);
                intersection() {
                    // back
                    translate([board_size[0]/2, board_size[1], 0]) rotate([90,0,-90])                
                        ext_edge(board_ext_edges[3], [ext_edge_depth, board_size[2], board_size[0]]);
                    // left
                    translate([0, board_size[1]*1.5, 0]) rotate([90,0,0])                
                        ext_edge(board_ext_edges[0], [ext_edge_depth, board_size[2], board_size[1]]);
                }
            }
        }
    }
}

module ext_edge(gender, size) {
    translate([0, size[1]/2, 0])
    union() {
        ext_edge_half(gender, size);
        mirror([0, -1, 0])
            ext_edge_half(gender, size);
    }
}

module ext_edge_half(gender, size) {
    xu = size[0]/2;
    yu = size[1]/2/10;
    if (gender == "f") {
        linear_extrude(size[2])
            union() {
                translate([0, 3*yu]) square([xu, 7*yu], false);
                translate([xu, 6*yu]) square([xu, 4*yu], false);
            }
    }
    else if (gender == "m") {
        linear_extrude(size[2])
            union() {
                translate([ext_edge_tolerance, 0])
                    square([xu-2*ext_edge_tolerance, 6*yu-ext_edge_tolerance], false);
                translate([xu-ext_edge_tolerance, 0]) 
                    square([xu+ext_edge_tolerance, 3*yu-ext_edge_tolerance], false);
            }
    }
}

// Builds all the pegs.
module pegs(text_combination_profiles, tolerance_xy_z = [0, 0]) {
    for (letter = [0:len(text)-1]) {
        translate([letter * peg_size[1] * peg_spacing_x_ratio, 0, 0])
            peg(text[letter], text_combination_profiles[letter], tolerance_xy_z);
    }
}

// Builds a single peg.
module peg(letter, combination_profile, tolerance_xy_z) {
    combination_height = peg_size[2][2] - tolerance_xy_z[1];
    union() {
        linear_extrude(combination_height)
            offset(delta=-tolerance_xy_z[0], chamfer=true)
            scale([peg_size[0], peg_size[1]])
            polygon(combination_profile);
        translate([0, 0, combination_height])
            difference() {
                cube([ peg_size[0], peg_size[1], peg_size[2][0] + peg_size[2][1] ]);
                translate([peg_size[0] / 2, peg_size[1] / 2, peg_size[2][1]])
                    letter(letter, peg_size[2][0] + peg_size[2][0]/1000);
            }
    }
}

// Builds all the letters.
module letters() {
    for (letter = [0:len(text)-1]) {
        translate([letter*peg_size[1]*peg_spacing_x_ratio, 0 ,0])
            letter(text[letter], peg_size[2][0]);
    }    
}

// Builds single letter
module letter(letter, height) {
    linear_extrude(height)
        text(text = letter, size = font_size, font = font, halign = "center", valign = "center");
}

// Generates a random peg combination. Each sector is given a value of 0, 1 or 2.
function peg_combination(sector_count) =
    let(r = rands(0, 3, sector_count))
    [ for (sector = [0:sector_count - 1]) floor(r[sector]) ];
        
// Generate a polygon profile for a combination.    
function peg_profile(combination, res = 8) =
    let (sector_a = 360 / len(combination))
    [      
        for (a = [0:sector_a/res:359.9])
        let (sector = floor(a / sector_a))
        let (r = 0.4 + (combination[sector] - 1) * 0.1)
            [0.5 + r * cos(a), 0.5 + r * sin(a)]
            
    ];

// Copied from: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks#Add_all_values_in_a_list        
function vsum(v) = [ for(p=v) 1 ] * v;
    