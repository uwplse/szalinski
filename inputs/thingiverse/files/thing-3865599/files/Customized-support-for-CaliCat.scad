// Author: Dima 'DiAleksi' Tsvetkov
// Date: 2019-09-15

//Horizontal amount of the cats
cats_x = 4; //[2 : 100]

//Vetical amount of the cats
cats_y = 4; //[2 : 100]


multiply();

module multiply() {
    shapes = [];

    for(a = [0 : cats_x - 1]) {
        x = 20*a;
        y = 30*cats_y;
        one(x, y);
    }
}

module one(x, y) {
    vertical_addition = [[x,30],[x+5,30],[x+5,y],[x,y]];
    bottom = [[x,0],[x+2.5,0],[x+5,2.5],[x+5,5],[x+7.5,5],[x+7.5,10],[x+5,10],[x+5,30],[x,30],[x,10],[x-12.5,10],[x-12.5,5],[x-10,5],[x-10,2.5],[x-7.5,0],[x-5,0],[x-5,5],[x,5]];
    vertical_close = [[x,y],[x-12.5,y],[x-12.5,y-5],[x+7.5,y-5],[x+7.5,y]];
    
    linear_extrude(2.5){ 
        union() {
            polygon(bottom);
            polygon(vertical_addition);
            polygon(vertical_close);
        }
    }
}
