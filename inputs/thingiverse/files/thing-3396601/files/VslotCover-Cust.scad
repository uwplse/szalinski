
length = 50; // [3:0.1:500]

// conver extension on one side
// leave it 0 (zero) if you don't need it
side_extension_width = 0; // [0:0.1:20]

/* HIDDEN */
side_add_w = side_extension_width;

$fn=1*60;

top2_w = 1*9.6;
top_w = 1*10; // 9.2 -v2> 9.6 -v3> 10
w1 = 1*8.4;
w2 = 1*6;
w3 = 1*7.4; // 8 -v2> 7.4
bottom_w = 1*5.8;

h1 = 1*4; // 3.8 -v4> 4.0
h2 = 1*2;
h3 = 1*1.2;
h_top_cover = 1*0.4;

wall_thick = 1*0.8; // 
tb_thick = 1*0; // top-bottom thickness 0.8 -v3> 0.4 -v4> 0

// MAIN

rotate([-90,0,0])
linear_extrude(height = length) {
	difference() {
		polygon(points=[[-bottom_w/2, 0],
						[-w3/2, h3],
						[-w2/2, h2],
						[-w1/2, h1],
						[-top_w/2, h1],
						[-top2_w/2, h1 + h_top_cover],
						[top2_w/2 + side_add_w, h1 + h_top_cover],
						[top_w/2 + side_add_w, h1],
						[w1/2, h1],
						[w2/2, h2],
						[w3/2, h3],
						[bottom_w/2, 0]]);

		polygon(points=[[-bottom_w/2 + wall_thick, tb_thick],
						[-w3/2 + wall_thick, h3],
						[-w2/2 + wall_thick, h2],
						[-w1/2 + wall_thick, h1],
						[w1/2 - wall_thick, h1],
						[w2/2 - wall_thick, h2],
						[w3/2 - wall_thick, h3],
						[bottom_w/2 - wall_thick, tb_thick]]);
	}			
		
}
