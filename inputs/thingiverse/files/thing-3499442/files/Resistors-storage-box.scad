// Author: Gilad Raz 18mar19

/* [Main] */
part = "box"; // [box, lid, both]
cells = 10;
cell_width = 70;
cell_length = 10;
cell_height = 10;

if (part == "box")
    box(cells, cell_length, cell_width, cell_height);
else if (part == "lid")
    lid(cells, cell_length, cell_width, cell_height);
else
    box_and_lid(cells, cell_length, cell_width, cell_height);

//box_and_lid(10, 10, 70, 10);
//box_and_lid(10, 10, 70, 10);
//box_and_lid(1, 18, 20, 10);           // mini test

/* [Advanced] */
btm = 1;
wl = 1.6;
sep = 0.8;
bracketLen = wl*2;
bracketWd = wl*1.2;
brackets = 3;
bracketMargin = 0.4;

module box_and_lid(cells, cllen, wd, ht) {
    box(cells, cllen, wd, ht);
    translate([wd+wl*5,0,0])
        lid(cells, cllen, wd, ht);
}

module box(cells, cllen, wd, ht) {
    boxlen = wl*2 + cllen*cells + sep*(cells-1);
    difference() {
        hull() {
            translate([wl/2,wl/2,0])
                cube([wd+wl, boxlen -wl, wl]);
            translate([0,0,wl/2])
                cube([wd+wl*2, boxlen, btm + ht]);
        }
        bracket_all(wd, ht, boxlen, 0);
        translate([0, bracketLen+wl-0.1, 0])
            bracket_all(wd, ht, boxlen, 1);
        difference() {
            for (i=[0: 1: cells-1])
                translate([wl, wl+ i*cllen + i*sep, btm])
                    cube([wd, cllen, ht]);
            translate([0, -wl/2, 0])
                bracket_all(wd, ht, boxlen, 3);
        }
        hull() {
            translate([wl/2,wl/2,btm+ht])
                cube([wd+wl, boxlen, wl]);
            translate([0,0,btm+ht+wl/2])
                cube([wd+wl*2, boxlen+wl, 1]);
        }
    }
    translate([0, bracketLen+wl, btm+ht])
        bracket_all(wd, ht, boxlen, 2);
    translate([0, 0, btm+ht-wl/2])
        bracket_all(wd, ht, boxlen, 4);
}

module lid(cells, cllen, wd, ht) {
    ht = bracketWd+wl/2 - btm;
    boxlen = wl*2 + cllen*cells + sep*(cells-1);
    difference() {
        union() {
            hull() {
                translate([wl/2,wl/2,0])
                    cube([wd+wl, boxlen -wl, wl]);
                translate([0,0,wl/2])
                    cube([wd+wl*2, boxlen, btm + ht]);
            }
        }
        difference() {
            translate([wl, wl, btm])
                cube([wd, boxlen - wl*2, ht*2]);
            translate([0, -wl/2, 0])
                bracket_all(wd, ht, boxlen, 3);
        }
        bracket_all(wd, ht, boxlen, 0);
        translate([0, bracketLen+wl-0.1, 0])
            bracket_all(wd, ht, boxlen, 1);
        hull() {
            translate([wl/2,wl/2,btm+ht])
                cube([wd+wl, boxlen, wl]);
            translate([0,0,btm+ht+wl/2])
                cube([wd+wl*2, boxlen+wl, 1]);
        }
    }
}

module bracket_all(wd, ht, boxlen, type) {
    preBracket = bracketLen*2;
    totalBracket = bracketLen*2 + wl;
    bracketDist = (boxlen - preBracket*2 - totalBracket) / (brackets-1);
//    bracketDist = (boxlen - bracketLen*4) / (brackets-1);
//    echo(bracketDist);
//    for (dist=[bracketLen/2: max(bracketDist, bracketLen*2+wl*2) : boxlen-bracketLen*3]) {
    for (dist=[preBracket: max(bracketDist, totalBracket+wl) : boxlen-preBracket-wl]) {
        translate([0,dist,0])
                bracket(type);
        translate([wl*2+wd,dist,0])
            mirror()
               bracket(type);
    }
}

module bracket(type) {
    if (type == 0)          // bracket opening
        cube([bracketWd*1.5, bracketLen+wl, bracketWd]);
    else if (type == 1)     // bracket catcher
        rotate([270,0,0]) {
            hull() {
                linear_extrude(0.1)
                    polygon([[0,0], [bracketWd*1.5, 0], [bracketWd*1.5, -bracketWd], [0, -bracketWd]]);
                linear_extrude(bracketWd/2)
                    polygon([[0,0], [bracketWd, 0], [bracketWd*1.5, -bracketWd], [0, -bracketWd]]);
            }
            linear_extrude(bracketLen +bracketMargin*2)
                polygon([[0,0], [bracketWd, 0], [bracketWd*1.5, -bracketWd], [0, -bracketWd]]);
        }
    else if (type == 2)     // bracket
        rotate([270,0,0])
            linear_extrude(bracketLen)
                polygon([[0,0], [bracketWd-bracketMargin, 0], [bracketWd*1.5-bracketMargin, -bracketWd+bracketMargin], [0, -bracketWd+bracketMargin]]);
    else if (type == 3)     // filler for opening
        cube([bracketWd*1.5+wl/2, bracketLen*2+wl*2, bracketWd+wl/2]);
    else // if (type == 4)  // top cover for bracket opening
        cube([bracketWd*1.5, bracketLen+wl, wl/2]);
}
