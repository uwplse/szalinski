/*
 <-----   A  ------>
         
     E |-----|             
 |-----|  F  |------|      ^
D|                  |      B
  \________________/       v
          C

W - Width (thickness)

*/

/*

Reference Dimensions

Extrusion
        A       B       C       D       E       F       W
2020    10.5    3.5     6.2     1       1       5       6
3030    15.6    5       8.2     2       1       6       6                                      
4040    19.4    6       8       3       3       8       8

Hex Nut
        Hole    Size    Height
M3      3.4     5.6     2.5
M4      4.6     7.1     3

Square Nut (DIN562)
        Hole    Size    Height
M3      3.4     5.6     1.8
M4      4.6     7.1     2.2

*/

// TNut(A, B, C, D, E, F, W, NutHole, NutSize, NutHeight, SquareNut);
// Example 4040 + M4 Hex
TNut(19.4, 6, 8, 3, 3, 8, 8, 4.6, 7.1, 2.2, false);

module TNut(A, B, C, D, E, F, W, NH, NS, NH, SquareNut=false){
    difference(){
        tee(A, B, C, D, E, F, W);
        nutAndHole(B+E, NH, NS, NH, SquareNut);
    }
}

module tee(A, B, C, D, E, F, W){
    translate([-W/2, -A/2, 0]){
        difference(){
            union(){
                translate([0, A/2-F/2, B]){
                    linear_extrude(height=E)
                        teeBodyShape(W, F);
                }            
                translate([0,0,0]){
                    linear_extrude(height=B)
                        teeBodyShape(W, A);
                }
            }
       
            translate([-0.5,0,B-D-0.05])
                rotate([0, 90, 0])
                    bottomCut(A, B, C, D, W);
        }
    }
}

module nutAndHole(t_height, t_holeDia, size, height, squarenut=false){
    union(){
        translate([0,0,height]){
            hole(t_holeDia, t_height);
        }
        #translate([0,0,0]){
            if (squarenut){
                square_nut(size, height);
            }else{
                hex_nut(size, height);
            }
        }
    }
}

module bottomCut(A, B, C, D, W){
    linear_extrude(height=W+1)
    polygon([
        [0,0],
        [B-D, (A-C)/2],
        [B-D, 0]
    ]);
    linear_extrude(height=W+1)
    polygon([
        [0,A],
        [B-D, A-(A-C)/2],
        [B-D, A]
    ]);
}

module teeBodyShape(width, length){
    filet = width/2.5;
    translate([filet, filet, 0]){
        circle(filet, $fn=20);
    }
    translate([width-filet, length-filet,0]){
        circle(filet, $fn=20);
    }
    polygon([
        [0, filet],
        [filet, filet],
        [filet, 0],
        [width, 0],
        [width, filet],
        [width, length-filet],
        [width-filet, length-filet],
        [width-filet, length],
        [0, length]
    ]);
}

module hole(dia, height){
    linear_extrude(height=height)
        circle(dia/2, $fn=20);
}

module square_nut(size, height){
    //rotate([0,0,45])
    linear_extrude(height=height)
        square([size, size], center=true);
}

module hex_nut(size, height){
    l = (size/2) / cos(30);
    rotate([0,0,90])
        linear_extrude(height=height)
            circle(l, $fn=6);
}