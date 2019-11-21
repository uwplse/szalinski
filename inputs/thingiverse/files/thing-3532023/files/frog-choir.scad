text = "GOOD JOB"; 
frog_dist = 2; 
seat_height = 6; 
font = "Arial Black";
font_size = 4;

/**
* sub_str.scad
*
* Returns a new string that is a substring of the given string.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-sub_str.html
*
**/ 

function sub_str(t, begin, end, result = "") =
    end == undef ? sub_str(t, begin, len(t)) : (
        begin == end ? result : sub_str(t, begin + 1, end, str(result, t[begin]))
    );

/**
* split_str.scad
*
* Splits the given string around matches of the given delimiting character.
* It depends on the sub_str function so remember to include sub_str.scad.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-split_str.html
*
**/ 
   
function _split_t_by(idxs, t, ts = [], i = -1) = 
    i == -1 ? _split_t_by(idxs, t, [sub_str(t, 0, idxs[0])], i + 1) : (
        i == len(idxs) - 1 ? concat(ts, sub_str(t, idxs[i] + 1)) : 
            _split_t_by(idxs, t, concat(ts, sub_str(t, idxs[i] + 1, idxs[i + 1])), i + 1)
    );        

function split_str(t, delimiter) = 
    len(search(delimiter, t)) == 0 ? 
        [t] : _split_t_by(search(delimiter, t, 0)[0], t);  

module one_random_frog() {
    n = round(rands(1, 8, 1)[0]); 
    translate([0, 0, -10]) import(str("frog_", n, ".stl"));
} 

module one_line_frogs(text, frog_dist, seat_height, font, font_size) {
    $fn = 24; 
    frog_width_x = 100.64;
    frog_width_y = 96.93;
    frog_height = 105.87;
    
    seat_width = 100.64 + frog_dist;
    leng = len(text);
    width = seat_width * leng;
     
    rotate([-5, 0, 0]) translate([-width / 2 + seat_width / 2, 0, seat_height]) 
    for(i = [0:leng - 1]) {  
        translate([i * seat_width, 0, 0]) one_random_frog(); 
        translate([i * seat_width, -1, 44]) rotate([71, 0, 0]) linear_extrude(45, scale = 4.5)  
            text(text[i], font = font, valign = "center", size = font_size, halign = "center");
    }    
    translate([0, frog_width_y / 3, seat_height / 2]) 
        cube([seat_width * leng, frog_width_y, seat_height], center = true);
}

module multi_line_frogs(texts, seat_height, frog_dist, font, font_size) {
    frog_width_x = 100.64;
    frog_width_y = 96.93;
    frog_height = 105.87;

    t_len = len(texts);
    
    for(i = [0: t_len - 1]) { 
        translate([0, -frog_width_y * i, 0]) 
            one_line_frogs(texts[i], frog_dist, seat_height * (t_len - i), font, font_size);
    }

}

    
multi_line_frogs(split_str(text, " "), 
    frog_dist = frog_dist, 
    seat_height = seat_height, 
    font = font, 
    font_size = font_size
);
 

 