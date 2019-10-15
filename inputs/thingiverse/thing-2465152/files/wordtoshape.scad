//Letter 1: make sure all letters are lowercase!
l1 = "";
//Letter 2
l2 = "";
//Letter 3
l3 = "";
//Letter 4
l4 = "";
//Letter 5
l5 = "";
//Letter 6
l6 = "";
//Letter 7
l7 = "";
//Letter 8
l8 = "";
//Letter 9
l9 = "";
//Letter 10
l10 = "";
//Letter 11
l11 = "";

module letter(lett, char) {
    sisi = [5, 5, 5];
 translate([0, 0, char * 5]) {
    if (lett == "a") {
        translate([0, 0, 2.5]) {
    cylinder(5, 2.5, 2.5, true);
        }
}
    if (lett == "b") {
    cylinder(h = 2.5, r1 = 2.5, r2 = 1.5, center = false);
    translate([0, 0, 2.5]) {
        cylinder(h = 2.5, r1= 1.5, r2 = 2.5, center=false);
    }
}
    if (lett == "c") {
    cylinder(h = 2.5, r1 = 1.5, r2 = 2.5, center = false);
        translate([0, 0, 2.5]) {
            cylinder(h = 2.5, r1 = 2.5, r2 = 2.5, center = false);
        }
            
}
if (lett == "d") {
    minkowski(){
    translate([0, 0, 2.5]) {
    cube([2.5, 2.5, 2.5], true);
    }
        cylinder(2.5, 1.25, 1.25, true);
    
}
}
if (lett == "e") {
    translate([0, 0, 0.625]) {
    cylinder(1.25, 2.5, 1.5, true);
    translate([0, 0, 1.25]) {
        cylinder(1.25, 1.5, 2.5, true);
        translate([0, 0, 1.25]) {
            cylinder(1.25, 2.5, 1.5, true);
            translate([0, 0, 1.25]) {
                cylinder(1.25, 1.5, 2.5, true);
            }
        }
    }
}
}
if (lett == "f") {
    pyrpoints = [
    [-2.5, 2.5, 0], //0
    [2.5, 2.5, 0], //1
    [2.5, -2.5, 0], //2
    [-2.5, -2.5, 0], //3
    [-1.25, -1.25, 5], //4
    [-1.25, 1.25, 5], //5
    [1.25, -1.25, 5], //6
    [1.25, 1.25, 5]]; //7
    
    pyrfaces = [
    [3, 2, 1, 0], //bottom
    [5, 4, 3, 0], //left
    [4, 6, 2, 3], //front
    [6, 7, 1, 2], //right
    [7, 5, 0, 1], //back
    [5, 7, 6, 4]]; //top
    
    translate([0, 0, 5]) {
    rotate([0, 180, 0]) {
    polyhedron(pyrpoints, pyrfaces);
    }
}
    
}
if (lett == "g") {
    translate([0, 0, 0.625]) {
    cylinder(1.25, 2.5, 2.5, true);
    translate([0, 0, 1.25]) {
        cylinder(1.25, 2.5, 1.5, true);
        translate([0, 0, 1.25]) {
            cylinder(1.25, 1.5, 2.5, true);
            translate([0, 0, 1.25]) {
                cylinder(1.25, 2.5, 2.5, true);
            }
        }
    }
}
}
if (lett == "h") {
    translate([0, 0, 0.85]) {
    cylinder(1.7, 2.5, 1.5, true);
    translate([0, 0, 1.6]) {
        cylinder(1.6, 1.5, 1.5, true);
        translate([0, 0, 1.6]) {
            cylinder(1.7, 1.5, 2.5, true);
        }
    }
}
}
if (lett == "j") {
    translate([0, 0, 0]) {
    difference() {
        sphere(2.5, true);
        translate([0, 0, -1.25]) {
        cube([5, 5, 2.5], true);
        }
    }
    translate([0, 0, 2.9]) {
        cylinder(1.6, 1.5, 1.5, true);
        translate([0, 0, 1.25]) {
            cylinder(1.7, 1.5, 2.5, true);
        }
    }
}
}
if (lett == "i") {
    translate([0, 0, 0.625]) {
   cube([2.5, 2.5, 1.25], true);
        cube([2.5, 2.5, 1.25], true);
        translate([0, 0, 1.25]) {
            cylinder(1.25, 1.25, 1.25, true);
            translate([0, 0, 1.75]) {
                cylinder(3, 1.15, 2.5, true);
            }
        }
    }
}
if (lett == "k") {
    translate([0, 0, 2]) {
    cylinder(4, 1.5, 2.5, true);
    }
    translate([0, 0, 4.5]) {
        cylinder(1, 2.5, 2.5, true);
    }
}
if (lett == "l") {
    pyrpoints = [
    [-2.5, 2.5, 0], //0
    [2.5, 2.5, 0], //1
    [2.5, -2.5, 0], //2
    [-2.5, -2.5, 0], //3
    [-1.25, -1.25, 2.5], //4
    [-1.25, 1.25, 2.5], //5
    [1.25, -1.25, 2.5], //6
    [1.25, 1.25, 2.5]]; //7
    
    pyrfaces = [
    [3, 2, 1, 0], //bottom
    [5, 4, 3, 0], //left
    [4, 6, 2, 3], //front
    [6, 7, 1, 2], //right
    [7, 5, 0, 1], //back
    [5, 7, 6, 4]]; //top
    
    polyhedron(pyrpoints, pyrfaces);
    translate([1.25, -1.25, 2.5]) {
        cube([0.625, 0.625, 5], true);
    }
    translate([1.25, 1.25, 2.5]) {
        cube([0.625, 0.625, 5], true);
    }
    translate([-1.25, -1.25, 2.5]) {
        cube([0.625, 0.625, 5], true);
    }
    translate([-1.25, 1.25, 2.5]) {
        cube([0.625, 0.625, 5], true);
    }
    translate([0, 0, 3.75]) {
        cylinder(2.5, 1.5, 2.5, true);
    }
    
    
}
if (lett == "m") {
    translate([0, 0, 1.25]) {
        cube([5, 5, 2.5], true);
        translate([0, 0, 2.5]) {
            cylinder(2.5, 2, 2.5, true);
        }
    }
}
if (lett == "n") {
    translate([0, 0, 0.625]) {
        cylinder(1.25, 2, 2.5, true);
        translate([0, 0, 1.25]) {
            cylinder(1.25, 2, 2.5, true);
            translate([0, 0, 1.25]) {
                cylinder(1.25, 2, 2.5, true);
                translate([0, 0, 1.25]) {
                    cylinder(1.25, 2, 2.5, true);
                }
            }
        }
    }
}
if (lett == "o") {
    translate([0, 0, 0.415]) {
        cylinder(0.84, 2, 2.5, true);
        translate([0, 0, 0.83]) {
            cylinder(0.84, 2.5, 2.5, true);
            translate([0, 0, 0.83]) {
                cylinder(0.84, 2.5, 2, true);
                translate([0, 0, 0.83]) {
                    cylinder(0.84, 2, 2.5, true);
                    translate([0, 0, 0.83]) {
                        cylinder(0.84, 2.5, 2.5, true);
                        translate([0, 0, 0.83]) {
                            cylinder(0.84, 2.5, 2.5, true);
                        }}}}}}
}
if (lett == "p") {
    translate([0, 0, 1.25]) {
        cylinder(2.5, 2, 2.5, true);
        translate([0, 0, 2.5]) {
            cylinder(2.5, 2, 2.5, true);
        }
    }
}
if (lett == "q") {
    translate([0, 0, 0.85]) {
        cylinder(1.7, 2, 2.5, true);
        translate([0, 0, 1.7]) {
            cylinder(1.7, 2.5, 2.5, true);
            translate([0, 0, 1.7]) {
                cylinder(1.7, 2, 2.5, true);
            }}}
}
if (lett == "r") {
    lp = [
    [-2.5, 1.25, 0], //bottom top-left
    [-2.5, -1.25, 0], //bottom bottom-left
    [-1.25, 1.25, 0], //bottom top-right
    [-1.25, -1.25, 0], //bottom bottom-right
    [-2.5, 2.5, 5], //top t-l
    [-2.5, -2.5, 5], //tbl
    [-1.25, 2.5, 5], //ttr
    [-1.25, -2.5, 5]]; //tbr
    
    lf = [
    [1, 3, 2, 0], //bottom
    [4, 5, 1, 0], //left
    [5, 7, 3, 1], //front
    [7, 6, 2, 3], //right
    [6, 4, 0, 2], //back
    [4, 6, 7, 5]];
    
    fp = [
    [-1.25, -1.25, 0], //btl-0
    [-1.25, -2.5, 0], //bbl-1
    [1.25, -1.25, 0], //btr-2
    [1.25, -2.5, 0], //bbr-3
    [-2.5, -1.25, 5], //ttl-4
    [-2.5, -2.5, 5], //tbl-5
    [2.5, -1.25, 5], //ttr-6
    [2.5, -2.5, 5]]; //tbr-7
    
    ff = [
    [0, 2, 3, 1], //bottom
    [4, 6, 7, 5], //top
    [5, 7, 3, 1], //front
    [7, 6, 2, 3], //right
    [6, 4, 0, 2], //back
    [4, 5, 1, 0]]; //left
    
    pp = [
    [1.25, 1.25, 0], //btl
    [2.5, 1.25, 0], //btr
    [2.5, -1.25, 0], //bbr
    [1.25, -1.25, 0], //bbl
    [1.25, 2.5, 5], //ttl - 4
    [2.5, 2.5, 5], //ttr
    [2.5, -2.5, 5], //tbr
    [1.25, -2.5, 5]]; //tbl
    
    pf = [
    [3, 2, 1, 0], //bottom
    [4, 5, 6, 7], //top
    [7, 6, 2, 3], //front
    [6, 5, 1, 2], //right
    [5, 4, 0, 1], //back
    [4, 7, 3, 0]];
    
    bp = [
    [-1.25, 2.5, 0], //btl
    [1.25, 2.5, 0], //btr
    [1.25, 1.25, 0], //bbr
    [-1.25, 1.25, 0], //bbl
    [-2.5, 2.5, 5], //ttl
    [2.5, 2.5, 5], //ttr
    [2.5, 1.25, 5], //tbr
    [-2.5, 1.25, 5]]; //tbl
    
    bf = [
    [3, 2, 1, 0], //bottom
    [4, 5, 6, 7], //top
    [7, 6, 2, 3],
    [6, 5, 1, 2],
    [5, 4, 0, 1],
    [4, 7, 3, 0]];
    
    polyhedron(lp, lf);
    polyhedron(fp, ff);
    polyhedron(pp, pf);
    polyhedron(bp, bf);
    translate([0, 0, 2.5]) {
        cube([2.5, 2.5, 5], true);
    }
    
}
if (lett == "s") {
    translate([0, 0, 1.25]) {
        cylinder(2.5, 2, 2.5, true);
        translate([0, 0, 1.75]) {
            cylinder(1, 2, 2.5, true);
            translate([0, 0, 1]) {
                cylinder(1.5, 2.5, 2.5, true);
            }}}
}
if (lett == "t") {
    translate([0, 0, 1.875]) {
        cylinder(3.75, 2, 2.5, true);
        translate([0, 0, 2.5]) {
            cylinder(1.25, 2, 2.5, true);
        }}
}
if (lett == "u") {
    translate([0, 0, 0.625]) {
       cylinder(1.25, 2.5, 3, true);
    }
   translate([-1.25, -1.25, 1.875]) {
       cube([1.25, 1.25, 1.25], true);
       translate([0, 0, 1.25]) {
           cylinder(2.5, 1.25, 2.5, true);
       } 
   }
   translate([1.25, -1.25, 1.875]) {
       cube([1.25, 1.25, 1.25], true);
       translate([0, 0, 1.25]) {
           cylinder(2.5, 1.25, 2.5, true);
       } 
   }
   translate([-1.25, 1.25, 1.875]) {
       cube([1.25, 1.25, 1.25], true);
       translate([0, 0, 1.25]) {
           cylinder(2.5, 1.25, 2.5, true);
       } 
   }
   translate([1.25, 1.25, 1.875]) {
       cube([1.25, 1.25, 1.25], true);
       translate([0, 0, 1.25]) {
           cylinder(2.5, 1.25, 2.5, true);
       } 
   }
}
if (lett == "v") {
    translate([0, 0, 1.25]) {
        cylinder(2.5, 2.5, 3, true);
        translate([0, 0, 1.875]) {
            cylinder(1.25, 2, 2.5, true);
            translate([0, 0, 1.25]) {
                cylinder(1.25, 2.5, 2.5, true);
            }
        }
    }
}
if (lett == "w") {
    translate([0, 0, 0.625]) {
        cylinder(1.25, 2.5, 3, true);
        translate([0, 0, 1.25]) {
            cylinder(1.25, 3, 3, true);
            translate([0, 0, 1.25]) {
                cylinder(1.25, 3, 2.5, true);
                translate([0, 0, 1.25]) {
                    cylinder(1.25, 2.5, 2.5, true);
                }
            }
        }
    }
}
if (lett == "x") {
    translate([0, 0, 0.5]) {
        cylinder(1, 2.5, 2.5, true);
        translate([0, 0, 0.75]) {
            cylinder(0.5, 2.5, 3, true);
            translate([0, 0, 0.5]) {
                cylinder(0.5, 3, 2.5, true);
                translate([0, 0, 0.75]) {
                    cylinder(1, 2.5, 2.5, true);
                    translate([0, 0, 0.75]) {
            cylinder(0.5, 2.5, 3, true);
            translate([0, 0, 0.5]) {
                cylinder(0.5, 3, 2.5, true);
                translate([0, 0, 0.75]) {
                    cylinder(1, 2.5, 2.5, true);
                }
            }
        }
    }
}
}
}
                    
}
if (lett == "y") {
    translate([0, 0, 0.5]) {
        cylinder(1, 2.5, 3, true);
        translate([0, 0, 1]) {
            cylinder(1, 3, 2.5, true);
            translate([0, 0, 1]) {
                cylinder(1, 2.5, 3, true);
                translate([0, 0, 1]) {
                    cylinder(1, 3, 2.5, true);
                    translate([0, 0, 1]) {
                        cylinder(1, 2.5, 2.5, true);
                    }
                }
            }
        }
    }
}
if (lett == "z") {
    translate([0, 0, 0.5]) {
        cylinder(1, 2.5, 2.5, true);
        translate([0, 0, 1]) {
            cylinder(1, 2.5, 2, true);
            translate([0, 0, 1]) {
                cylinder(1, 2, 2, true);
                translate([0, 0, 1]) {
                    cylinder(1, 2, 2.5, true);
                    translate([0, 0, 1]) {
                        cylinder(1, 2.5, 2.5, true);
                    }
                }
            }
        }
    }
}
}
}




/*letter("a", 0);
letter("b", 1);
letter("c", 2);
letter("d", 3);
letter("e", 4);
letter("f", 5);
letter("g", 6);
letter("h", 7);
letter("i", 8);
letter("j", 9);
letter("k", 10);
letter("l", 11);
letter("m", 12);
letter("n", 13);
letter("o", 14);
letter("p", 15);
letter("q", 16);
letter("r", 17);
letter("s", 18);
letter("t", 19);
letter("u", 20);
letter("v", 21);
letter("w", 22);
letter("x", 23);
letter("y", 24);
letter("z", 25);

letter("k", 27);
letter("e", 28);
letter("v", 29);
letter("i", 30);
letter("n", 31);*/




////////// Parameters



/////////// Renders

letter(l1, 0);
letter(l2, 1);
letter(l3, 2);
letter(l4, 3);
letter(l5, 4);
letter(l6, 5);
letter(l7, 6);
letter(l8, 7);
letter(l9, 8);
letter(l10, 9);
letter(l11, 10);
