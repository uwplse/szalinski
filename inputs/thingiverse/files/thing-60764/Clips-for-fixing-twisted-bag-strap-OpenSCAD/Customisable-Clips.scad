x = 15; // [10:50]
y = 43.5; // [25:75]
z = 9; // [5:15]


union() { 

intersection() { translate(v = [-(x-3)/2, 0, -(z/6)]) cube(size = [3,(y+20),(z/3)], center = true);
union() { translate(v = [-(x-3)/2, -1, 0]) rotate(a=[70,0,0]) cube(size = [10,(y+20),(z/1.5)], center = true);
translate(v = [-(x-3)/2, 1, 0]) rotate(a=[-70,0,0]) cube(size = [10,(y+20),(z/1.5)], center = true); } }

intersection() { translate(v = [(x-3)/2, 0, -(z/6)]) cube(size = [3,(y+20),(z/3)], center = true);
union() { translate(v = [(x-3)/2, -1, 0]) rotate(a=[70,0,0]) cube(size = [10,(y+20),(z/1.5)], center = true);
translate(v = [(x-3)/2, 1, 0]) rotate(a=[-70,0,0]) cube(size = [10,(y+20),(z/1.5)], center = true); } }


difference() { union() { cube(size = [x,y,z], center = true);
translate(v = [0, -(y/2), 0]) rotate(a=[90,90,90]) cylinder(h = x, r=(z/2), center = true);
translate(v = [0, (y/2), 0]) rotate(a=[90,90,90]) cylinder(h = x, r=(z/2), center = true); }

union() { translate(v = [0, -(y/2), 0]) rotate(a=[90,90,90]) cylinder(h = (x+10), r=(z/3.6), center = true);
translate(v = [0, (y/2), 0]) rotate(a=[90,90,90]) cylinder(h = (x+10), r=(z/3.6), center = true); 

translate(v = [0, 0, -(z/4)-1]) cube(size = [(x+40),(y+40),(z/2)+2], center = true); } } }



difference() { 

union() { translate(v = [x+(x/2), 0, 0]) cube(size = [x,y,z], center = true);

translate(v = [x+(x/2), -(y/2), 0]) rotate(a=[90,90,90]) cylinder(h = x, r=(z/2), center = true);

translate(v = [x+(x/2), (y/2), 0]) rotate(a=[90,90,90]) cylinder(h = x, r=(z/2), center = true); }

union() { translate(v = [x+(x/2), -(y/2), 0]) rotate(a=[90,90,90]) cylinder(h = (x+5), r=(z/3.6), center = true);

translate(v = [x+(x/2), (y/2), 0]) rotate(a=[90,90,90]) cylinder(h = (x+5), r=(z/3.6), center = true); 

translate(v = [x+(x/2), 0, -(z/4)-1]) cube(size = [(x+40),(y+40),(z/2)+2], center = true);

intersection() { translate(v = [x+(x/2), 0, z/6]) cube(size = [(x+5),(y+11),(z/3)+0.2], center = true);

union() { translate(v = [x+(x/2), 1.2, 0]) rotate(a=[70,0,0]) cube(size = [(x+5),(y+11),(z/1.5)], center = true);

translate(v = [x+(x/2), -1.2, 0]) rotate(a=[-70,0,0]) cube(size = [(x+5),(y+11),(z/1.5)], center = true);

translate(v = [x+(x/2), 0, 1]) cube(size = [(x-6),(z+1),(z/3)+0.2], center = true); } }

}

}







