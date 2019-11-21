// preview[view:north west, tilt:top diagonal]

//the width of the new stone
stone_w = 35;//[10:60]

//height of the new stone
stone_h = 23;//[5:60]

//new stone length
stone_l = 98;//[40:148]

//original (old) stone length
original_stone_l = 158;//[120:170]

//Cutout
cut = 1; //[1:On,2:Off]


dist = (original_stone_l - stone_l)/2 - 3 - 2;

translate ([-25 / 2, 0, 0]) {cube ([25, dist, 4], 0);

rotate ([0, 270, 180]){ 
    linear_extrude(height = 25, center = 0, convexity = 10, twist = 0) polygon(points=[[0,0],[4,0],[0,3]],center = 0);
    }
}

translate ([-25/2, -3, 0]) cube ([1, 3, 4],0);
translate ([-25/2+24, -3, 0]) cube ([1, 3, 4],0);

difference (){
    
    translate ([- ((stone_w + 3.5) / 2), dist, 0]) {
        cube ([stone_w + 3.5, 10, stone_h + 3.5],0);
    }
    
    translate ([- (stone_w + 0.5 ) / 2, dist + 2, 1.5]) {
        cube ([stone_w + 0.5, 10, stone_h + 0.5 ],0);
    }
    
    if (cut == 1){
        translate ([0, dist + 10, -1]) resize([stone_w - 1, 13, 0]) {
            cylinder(stone_h + 5, d = stone_w / 2 );
        }
    }
}

rotate ([0, 270, 180]) translate([4, - dist, - 3]){ 
    linear_extrude(height = 6, center = 0, convexity = 10, twist = 0) polygon(points=[[0,0],[stone_h - 6, 0],[0, dist]], center=0);
}
