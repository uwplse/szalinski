//Catan Number Towers by Nathaniel Garst. Feel free to modify and redistribute, though credit is appreciated.


diam = 25;
height = 25;

top_diam = diam-5;

word_thickness = 2;
pip_separation = 3.6;
pip_size = 2;

/*
Number distribution
2 each of 12s and 2s (1 pip)
3 each of the rest:
3 and 11 (2 pips)
4 and 10 (3 pips)
5 and 9 (4 pips)
6 and 8 (5 pips)
*/

nums = [["2",1], ["2",1],
        ["3",2], ["3",2], ["3",2],
        ["4",3], ["4",3], ["4",3],
        ["5",4], ["5",4], ["5",4],
        ["6",5], ["6",5], ["6",5],
        ["8",5], ["8",5], ["8",5],
        ["9",4], ["9",4], ["9",4],
        ["10",3],["10",3],["10",3],
        ["11",2],["11",2],["11",2],
        ["12",1],["12",1]          ];

//make_whole_object("2", 1);


//create a whole set
for (i = [0:len(nums)-1]) {
    spacing = 30;
    row_length = 5;
    //space it out on a grid
    xmov = (i % row_length) * spacing;
    ymov = floor(i / row_length) * spacing;
    translate([xmov,ymov,0])
    make_whole_object(nums[i][0], nums[i][1]);
}

//creates a single number tower
module make_whole_object(text, num_pips) {       
    make_body();
    
    for (r = [0,120,240]) {
        rotate([0,0,r]) 
        side_number(text, num_pips);
    }

}



module make_body() {
    //base
    cylinder(d = diam, h = 2);

    //body
    intersection() {
        cylinder(d1 = diam, d2 = top_diam, h = height, $fn=3);
        cylinder(d1 = diam-2, d2 = top_diam-2, h = height);
    }
    
    
}


module side_number(text, num_pips = 2) {
    translate([-5,0,16]) 
    rotate([0,-87,0]) {
        make_number(text);
        make_pips(num_pips);
    }
}

module make_number(text) {
    rotate([0,0,-90])
    color("grey") linear_extrude(word_thickness)
    text(text, halign="center", valign="center", font = "Comic Sans MS:style=Regular");
}

module make_pips(num_pips) {
    pips = num_pips;
    starting_offset = ((pips * pip_separation) / 2) - pip_separation / 2;
    color("gray")
    translate([-9,0,0])
    for (i = [0:pips-1]) {
        translate([0,-starting_offset+i*pip_separation,0])
        cylinder(d=2,h=word_thickness);
    }
}