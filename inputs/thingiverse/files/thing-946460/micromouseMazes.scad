// micromouseMazes - Uses buildMaze to construct multiple historic micromouse robotics competition mazes
// Created by James Trimbe
// @jamestrimble https://keybase.io/jamestrimble

// Maze
mazeChoice = 1; // [1:1st World,2:US 1982,3:US 1983,4:US 1986,5:US 1988,6:Chicago 1986,7:Japan 1983,8:Japan 1988,9:London 1988]

initMaze();
if (mazeChoice == 1) {
    1stworld();
}
else if (mazeChoice == 2) {
    us82();
}
else if (mazeChoice == 3) {
	 us83();
}
else if (mazeChoice == 4) {
    us86();
}
else if (mazeChoice == 5) {
	 us88();
}
else if (mazeChoice == 6) {
    chicago86();
}
else if (mazeChoice == 7) {
    japan83();
}
else if (mazeChoice == 8) {
    japan88();
}
else if (mazeChoice == 9) {
	 london88();
}


// Constants for direction
N = 0;
S = 1;
E = 2;
W = 3;

module initMaze() { // Creates floor, outside wall, and lattice points
    floor();
    for (r = [1:1:16]) {
        for (c = [1:1:16]) {
             if (r==1) {
                 wall(r,c,S);           
             }
             else if (r==16) {
                 wall(r,c,N);
             }
             if (c == 1) {
                 wall(r,c,W);
             }
             else if (c == 16) {
                 wall(r,c,E);
             }
            lattice(r,c);
        }
    }
    
}



module wall(r, c, side) { // Places a wall at cell r,c on the side (N,S,E,W) given
    //echo(N=N,S=S,E=E,W=W); 
    rot = (side == S || side == N) ? 0 : 90;
    y = (side == N) ? r : r-1;
    x = (side == E) ? c : c-1;
    
    offset_x = (side == N) ? 12 : 
                (side == S) ? 12 : 
                 (side == E) ? 12 : 12;
    
    offset_y = (side == N) ? 0 : 
                (side == S) ? 0 : 
                 (side == E) ? 12 : 12;
    //echo(x=x,y=y,rot=rot,side=side);
    translate([x*180+offset_x,y*180+offset_y,10]) {
        rotate([0,0,rot]) {
            union() {
                color("White") {
                    cube([168,12,49],false);
                }
                translate([0,0,49]) {
                    color ("Red") {
                        cube([168,12,1],false);
                    }
                }
            }
        }
    }
}

module lattice(r,c) {  // Creates 4 lattice points around the cell at r,c
    bl_height = (r == 9 && c == 9) ? 100 : 50;
    br_height = (r == 9 && c == 8) ? 100 : 50;
    tr_height = (r == 8 && c == 8) ? 100 : 50;
    tl_height = (r == 8 && c == 9) ? 100 : 50;
    translate([(c-1)*180,(r-1)*180,10]) {
        color("White") {
            cube([12,12,bl_height],false);
            translate([0,180,0]) { 
                cube([12,12,tl_height],false); }
            translate([180,0,0]) { 
                cube([12,12,br_height],false); }
            translate([180,180,0]) { 
                cube([12,12,tr_height],false); }
        }
    }
}

module floor() {  // Creates a black floor for the maze
    translate([0,0,0]) {
        color("Black") {
            cube([180*16+12,180*16+12,10]);
        }
    }
}

module us86() {    
wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
											wall(16,12,E);				wall(16,16,E);
	wall(15,2,N);	wall(15,3,N);	wall(15,4,N);	wall(15,5,N);	wall(15,6,N);	wall(15,7,N);		wall(15,9,N);							
wall(15,1,E);					wall(15,6,E);	wall(15,7,E);	wall(15,8,E);		wall(15,10,E);	wall(15,11,E);	wall(15,12,E);	wall(15,13,E);	wall(15,14,E);	wall(15,15,E);	wall(15,16,E);
	wall(14,2,N);							wall(14,9,N);				wall(14,13,N);			
wall(14,1,E);	wall(14,2,E);	wall(14,3,E);	wall(14,4,E);	wall(14,5,E);	wall(14,6,E);	wall(14,7,E);	wall(14,8,E);		wall(14,10,E);	wall(14,11,E);			wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
								wall(13,9,N);	wall(13,10,N);	wall(13,11,N);		wall(13,13,N);	wall(13,14,N);	wall(13,15,N);	
wall(13,1,E);	wall(13,2,E);	wall(13,3,E);	wall(13,4,E);	wall(13,5,E);	wall(13,6,E);	wall(13,7,E);								wall(13,15,E);	wall(13,16,E);
								wall(12,9,N);	wall(12,10,N);	wall(12,11,N);		wall(12,13,N);	wall(12,14,N);		
wall(12,1,E);		wall(12,3,E);	wall(12,4,E);	wall(12,5,E);	wall(12,6,E);	wall(12,7,E);	wall(12,8,E);							wall(12,15,E);	wall(12,16,E);
								wall(11,9,N);	wall(11,10,N);	wall(11,11,N);		wall(11,13,N);	wall(11,14,N);		
wall(11,1,E);	wall(11,2,E);	wall(11,3,E);				wall(11,7,E);	wall(11,8,E);							wall(11,15,E);	wall(11,16,E);
									wall(10,10,N);	wall(10,11,N);		wall(10,13,N);	wall(10,14,N);		
wall(10,1,E);	wall(10,2,E);	wall(10,3,E);	wall(10,4,E);	wall(10,5,E);	wall(10,6,E);	wall(10,7,E);	wall(10,8,E);							wall(10,15,E);	wall(10,16,E);
	wall(9,2,N);						wall(9,8,N);	wall(9,9,N);	wall(9,10,N);	wall(9,11,N);	wall(9,12,N);	wall(9,13,N);	wall(9,14,N);	wall(9,15,N);	
			wall(9,4,E);	wall(9,5,E);	wall(9,6,E);	wall(9,7,E);		wall(9,9,E);						wall(9,15,E);	wall(9,16,E);
	wall(8,2,N);								wall(8,10,N);	wall(8,11,N);	wall(8,12,N);	wall(8,13,N);	wall(8,14,N);		
wall(8,1,E);	wall(8,2,E);	wall(8,3,E);	wall(8,4,E);	wall(8,5,E);	wall(8,6,E);	wall(8,7,E);		wall(8,9,E);							wall(8,16,E);
								wall(7,9,N);	wall(7,10,N);	wall(7,11,N);	wall(7,12,N);	wall(7,13,N);	wall(7,14,N);	wall(7,15,N);	
wall(7,1,E);	wall(7,2,E);	wall(7,3,E);	wall(7,4,E);	wall(7,5,E);	wall(7,6,E);	wall(7,7,E);								wall(7,15,E);	wall(7,16,E);
								wall(6,9,N);	wall(6,10,N);	wall(6,11,N);		wall(6,13,N);	wall(6,14,N);		
wall(6,1,E);	wall(6,2,E);	wall(6,3,E);				wall(6,7,E);	wall(6,8,E);							wall(6,15,E);	wall(6,16,E);
								wall(5,9,N);	wall(5,10,N);	wall(5,11,N);		wall(5,13,N);	wall(5,14,N);		
wall(5,1,E);		wall(5,3,E);	wall(5,4,E);	wall(5,5,E);	wall(5,6,E);	wall(5,7,E);	wall(5,8,E);								wall(5,16,E);
								wall(4,9,N);	wall(4,10,N);	wall(4,11,N);		wall(4,13,N);	wall(4,14,N);		
wall(4,1,E);	wall(4,2,E);	wall(4,3,E);	wall(4,4,E);	wall(4,5,E);	wall(4,6,E);		wall(4,8,E);							wall(4,15,E);	wall(4,16,E);
									wall(3,10,N);	wall(3,11,N);		wall(3,13,N);	wall(3,14,N);	wall(3,15,N);	
wall(3,1,E);	wall(3,2,E);	wall(3,3,E);	wall(3,4,E);	wall(3,5,E);	wall(3,6,E);	wall(3,7,E);			wall(3,10,E);	wall(3,11,E);			wall(3,14,E);	wall(3,15,E);	wall(3,16,E);
	wall(2,2,N);								wall(2,10,N);			wall(2,13,N);			
wall(2,1,E);						wall(2,7,E);	wall(2,8,E);		wall(2,10,E);	wall(2,11,E);	wall(2,12,E);	wall(2,13,E);	wall(2,14,E);	wall(2,15,E);	wall(2,16,E);
		wall(1,3,N);	wall(1,4,N);	wall(1,5,N);	wall(1,6,N);	wall(1,7,N);	wall(1,8,N);	wall(1,9,N);	wall(1,10,N);		wall(1,12,N);				
wall(1,1,E);															wall(1,16,E);


    
}

module 1stworld() {
 wall(16,1,N);
wall(16,2,N);
wall(16,3,N);
wall(16,4,N);
wall(16,5,N);
wall(16,6,N);
wall(16,7,N);
wall(16,8,N);
wall(16,9,N);
wall(16,10,N);
wall(16,11,N);
wall(16,12,N);
wall(16,13,N);
wall(16,14,N);
wall(16,15,N);
wall(16,16,N);
wall(16,16,E);
wall(15,2,N);
wall(15,3,N);
wall(15,4,N);
wall(15,5,N);
wall(15,6,N);
wall(15,7,N);
wall(15,8,N);
wall(15,9,N);
wall(15,10,N);
wall(15,11,N);
wall(15,12,N);
wall(15,14,N);
wall(15,16,N);
wall(15,2,E);
wall(15,11,E);
wall(15,16,E);
wall(14,4,N);
wall(14,5,N);
wall(14,6,N);
wall(14,7,N);
wall(14,8,N);
wall(14,9,N);
wall(14,10,N);
wall(14,12,N);
wall(14,13,N);
wall(14,14,N);
wall(14,1,E);
wall(14,2,E);
wall(14,14,E);
wall(14,15,E);
wall(14,16,E);
wall(13,4,N);
wall(13,5,N);
wall(13,6,N);
wall(13,7,N);
wall(13,8,N);
wall(13,9,N);
wall(13,10,N);
wall(13,11,N);
wall(13,12,N);
wall(13,13,N);
wall(13,1,E);
wall(13,2,E);
wall(13,4,E);
wall(13,5,E);
wall(13,13,E);
wall(13,14,E);
wall(13,15,E);
wall(13,16,E);
wall(12,7,N);
wall(12,8,N);
wall(12,9,N);
wall(12,10,N);
wall(12,11,N);
wall(12,1,E);
wall(12,2,E);
wall(12,3,E);
wall(12,4,E);
wall(12,5,E);
wall(12,6,E);
wall(12,11,E);
wall(12,12,E);
wall(12,13,E);
wall(12,14,E);
wall(12,16,E);
wall(11,9,N);
wall(11,10,N);
wall(11,2,E);
wall(11,5,E);
wall(11,6,E);
wall(11,7,E);
wall(11,13,E);
wall(11,15,E);
wall(11,16,E);
wall(10,2,N);
wall(10,9,N);
wall(10,10,N);
wall(10,12,N);
wall(10,13,N);
wall(10,15,N);
wall(10,1,E);
wall(10,2,E);
wall(10,3,E);
wall(10,4,E);
wall(10,5,E);
wall(10,6,E);
wall(10,7,E);
wall(10,11,E);
wall(10,14,E);
wall(10,15,E);
wall(10,16,E);
wall(9,8,N);
wall(9,9,N);
wall(9,13,N);
wall(9,14,N);
wall(9,1,E);
wall(9,2,E);
wall(9,3,E);
wall(9,4,E);
wall(9,5,E);
wall(9,6,E);
wall(9,7,E);
wall(9,9,E);
wall(9,10,E);
wall(9,11,E);
wall(9,13,E);
wall(9,14,E);
wall(9,15,E);
wall(9,16,E);
wall(8,1,E);
wall(8,2,E);
wall(8,6,E);
wall(8,7,E);
wall(8,9,E);
wall(8,11,E);
wall(8,12,E);
wall(8,14,E);
wall(8,15,E);
wall(8,16,E);
wall(7,4,N);
wall(7,5,N);
wall(7,6,N);
wall(7,8,N);
wall(7,10,N);
wall(7,11,N);
wall(7,16,N);
wall(7,1,E);
wall(7,2,E);
wall(7,3,E);
wall(7,6,E);
wall(7,11,E);
wall(7,12,E);
wall(7,13,E);
wall(7,15,E);
wall(7,16,E);
wall(6,3,N);
wall(6,5,N);
wall(6,8,N);
wall(6,9,N);
wall(6,10,N);
wall(6,14,N);
wall(6,1,E);
wall(6,2,E);
wall(6,3,E);
wall(6,4,E);
wall(6,6,E);
wall(6,11,E);
wall(6,14,E);
wall(6,16,E);
wall(5,7,N);
wall(5,9,N);
wall(5,11,N);
wall(5,12,N);
wall(5,13,N);
wall(5,1,E);
wall(5,3,E);
wall(5,5,E);
wall(5,6,E);
wall(5,10,E);
wall(5,15,E);
wall(5,16,E);
wall(4,5,N);
wall(4,7,N);
wall(4,8,N);
wall(4,10,N);
wall(4,12,N);
wall(4,13,N);
wall(4,14,N);
wall(4,15,N);
wall(4,2,E);
wall(4,4,E);
wall(4,6,E);
wall(4,9,E);
wall(4,15,E);
wall(4,16,E);
wall(3,1,N);
wall(3,2,N);
wall(3,3,N);
wall(3,4,N);
wall(3,6,N);
wall(3,7,N);
wall(3,9,N);
wall(3,10,N);
wall(3,11,N);
wall(3,12,N);
wall(3,13,N);
wall(3,15,N);
wall(3,6,E);
wall(3,12,E);
wall(3,16,E);
wall(2,2,N);
wall(2,3,N);
wall(2,5,N);
wall(2,7,N);
wall(2,8,N);
wall(2,10,N);
wall(2,11,N);
wall(2,13,N);
wall(2,14,N);
wall(2,1,E);
wall(2,8,E);
wall(2,15,E);
wall(2,16,E);
wall(1,3,N);
wall(1,4,N);
wall(1,5,N);
wall(1,6,N);
wall(1,7,N);
wall(1,10,N);
wall(1,11,N);
wall(1,12,N);
wall(1,13,N);
wall(1,14,N);
wall(1,15,N);
wall(1,1,E);
wall(1,8,E);
wall(1,16,E);
}

module us88() {
    wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
			wall(16,4,E);		wall(16,6,E);	wall(16,7,E);		wall(16,9,E);			wall(16,12,E);				wall(16,16,E);
wall(15,1,N);	wall(15,2,N);												wall(15,14,N);	wall(15,15,N);	
		wall(15,3,E);		wall(15,5,E);		wall(15,7,E);	wall(15,8,E);	wall(15,9,E);	wall(15,10,E);	wall(15,11,E);			wall(15,14,E);		wall(15,16,E);
	wall(14,2,N);			wall(14,5,N);	wall(14,6,N);										
	wall(14,2,E);	wall(14,3,E);			wall(14,6,E);	wall(14,7,E);	wall(14,8,E);	wall(14,9,E);	wall(14,10,E);	wall(14,11,E);	wall(14,12,E);	wall(14,13,E);	wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
															
wall(13,1,E);	wall(13,2,E);	wall(13,3,E);	wall(13,4,E);	wall(13,5,E);			wall(13,8,E);			wall(13,11,E);	wall(13,12,E);	wall(13,13,E);		wall(13,15,E);	wall(13,16,E);
	wall(12,2,N);		wall(12,4,N);	wall(12,5,N);	wall(12,6,N);		wall(12,8,N);	wall(12,9,N);	wall(12,10,N);	wall(12,11,N);			wall(12,14,N);		
	wall(12,2,E);		wall(12,4,E);	wall(12,5,E);		wall(12,7,E);					wall(12,12,E);		wall(12,14,E);		wall(12,16,E);
		wall(11,3,N);				wall(11,7,N);					wall(11,12,N);	wall(11,13,N);		wall(11,15,N);	wall(11,16,N);
wall(11,1,E);	wall(11,2,E);		wall(11,4,E);		wall(11,6,E);	wall(11,7,E);	wall(11,8,E);	wall(11,9,E);	wall(11,10,E);			wall(11,13,E);			wall(11,16,E);
wall(10,1,N);			wall(10,4,N);		wall(10,6,N);						wall(10,12,N);	wall(10,13,N);	wall(10,14,N);	wall(10,15,N);	
	wall(10,2,E);					wall(10,7,E);		wall(10,9,E);	wall(10,10,E);			wall(10,13,E);			wall(10,16,E);
	wall(9,2,N);	wall(9,3,N);	wall(9,4,N);	wall(9,5,N);	wall(9,6,N);	wall(9,7,N);	wall(9,8,N);	wall(9,9,N);	wall(9,10,N);	wall(9,11,N);	wall(9,12,N);			wall(9,15,N);	
					wall(9,6,E);			wall(9,9,E);				wall(9,13,E);		wall(9,15,E);	wall(9,16,E);
	wall(8,2,N);	wall(8,3,N);	wall(8,4,N);	wall(8,5,N);	wall(8,6,N);					wall(8,11,N);	wall(8,12,N);		wall(8,14,N);		wall(8,16,N);
wall(8,1,E);					wall(8,6,E);	wall(8,7,E);		wall(8,9,E);					wall(8,14,E);		wall(8,16,E);
		wall(7,3,N);	wall(7,4,N);	wall(7,5,N);			wall(7,8,N);	wall(7,9,N);	wall(7,10,N);	wall(7,11,N);					wall(7,16,N);
wall(7,1,E);	wall(7,2,E);				wall(7,6,E);	wall(7,7,E);	wall(7,8,E);		wall(7,10,E);	wall(7,11,E);	wall(7,12,E);	wall(7,13,E);	wall(7,14,E);	wall(7,15,E);	wall(7,16,E);
		wall(6,3,N);	wall(6,4,N);	wall(6,5,N);								wall(6,13,N);	wall(6,14,N);		
wall(6,1,E);				wall(6,5,E);		wall(6,7,E);		wall(6,9,E);		wall(6,11,E);			wall(6,14,E);	wall(6,15,E);	wall(6,16,E);
		wall(5,3,N);		wall(5,5,N);	wall(5,6,N);	wall(5,7,N);		wall(5,9,N);				wall(5,13,N);			
wall(5,1,E);	wall(5,2,E);								wall(5,10,E);		wall(5,12,E);		wall(5,14,E);	wall(5,15,E);	wall(5,16,E);
	wall(4,2,N);	wall(4,3,N);	wall(4,4,N);	wall(4,5,N);	wall(4,6,N);	wall(4,7,N);	wall(4,8,N);	wall(4,9,N);	wall(4,10,N);	wall(4,11,N);	wall(4,12,N);	wall(4,13,N);			
wall(4,1,E);				wall(4,5,E);			wall(4,8,E);	wall(4,9,E);				wall(4,13,E);	wall(4,14,E);		wall(4,16,E);
	wall(3,2,N);	wall(3,3,N);				wall(3,7,N);				wall(3,11,N);	wall(3,12,N);		wall(3,14,N);	wall(3,15,N);	
		wall(3,3,E);	wall(3,4,E);		wall(3,6,E);	wall(3,7,E);		wall(3,9,E);					wall(3,14,E);	wall(3,15,E);	wall(3,16,E);
	wall(2,2,N);			wall(2,5,N);	wall(2,6,N);			wall(2,9,N);	wall(2,10,N);	wall(2,11,N);	wall(2,12,N);	wall(2,13,N);			
wall(2,1,E);	wall(2,2,E);	wall(2,3,E);		wall(2,5,E);				wall(2,9,E);					wall(2,14,E);		wall(2,16,E);
						wall(1,7,N);	wall(1,8,N);		wall(1,10,N);	wall(1,11,N);			wall(1,14,N);	wall(1,15,N);	
wall(1,1,E);			wall(1,4,E);				wall(1,8,E);				wall(1,12,E);				wall(1,16,E);
															
                                                        }
                                                        
module japan88 () {
                                                            wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
								wall(16,9,E);	wall(16,10,E);	wall(16,11,E);	wall(16,12,E);				wall(16,16,E);
	wall(15,2,N);		wall(15,4,N);		wall(15,6,N);		wall(15,8,N);						wall(15,14,N);	wall(15,15,N);	
wall(15,1,E);						wall(15,7,E);		wall(15,9,E);		wall(15,11,E);	wall(15,12,E);	wall(15,13,E);		wall(15,15,E);	wall(15,16,E);
	wall(14,2,N);	wall(14,3,N);	wall(14,4,N);	wall(14,5,N);	wall(14,6,N);										
wall(14,1,E);						wall(14,7,E);	wall(14,8,E);	wall(14,9,E);	wall(14,10,E);	wall(14,11,E);	wall(14,12,E);	wall(14,13,E);	wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
		wall(13,3,N);	wall(13,4,N);		wall(13,6,N);								wall(13,14,N);		
wall(13,1,E);			wall(13,4,E);			wall(13,7,E);	wall(13,8,E);		wall(13,10,E);		wall(13,12,E);			wall(13,15,E);	wall(13,16,E);
	wall(12,2,N);		wall(12,4,N);	wall(12,5,N);	wall(12,6,N);	wall(12,7,N);	wall(12,8,N);	wall(12,9,N);	wall(12,10,N);			wall(12,13,N);	wall(12,14,N);	wall(12,15,N);	
	wall(12,2,E);								wall(12,10,E);	wall(12,11,E);					wall(12,16,E);
wall(11,1,N);		wall(11,3,N);	wall(11,4,N);	wall(11,5,N);	wall(11,6,N);	wall(11,7,N);	wall(11,8,N);	wall(11,9,N);		wall(11,11,N);	wall(11,12,N);		wall(11,14,N);	wall(11,15,N);	wall(11,16,N);
			wall(11,4,E);							wall(11,11,E);					wall(11,16,E);
wall(10,1,N);	wall(10,2,N);		wall(10,4,N);		wall(10,6,N);	wall(10,7,N);	wall(10,8,N);	wall(10,9,N);	wall(10,10,N);		wall(10,12,N);	wall(10,13,N);	wall(10,14,N);		wall(10,16,N);
			wall(10,4,E);	wall(10,5,E);	wall(10,6,E);				wall(10,10,E);		wall(10,12,E);				wall(10,16,E);
	wall(9,2,N);	wall(9,3,N);	wall(9,4,N);				wall(9,8,N);						wall(9,14,N);	wall(9,15,N);	wall(9,16,N);
			wall(9,4,E);	wall(9,5,E);	wall(9,6,E);	wall(9,7,E);		wall(9,9,E);	wall(9,10,E);	wall(9,11,E);	wall(9,12,E);				wall(9,16,E);
wall(8,1,N);	wall(8,2,N);	wall(8,3,N);										wall(8,13,N);	wall(8,14,N);		
			wall(8,4,E);		wall(8,6,E);	wall(8,7,E);		wall(8,9,E);	wall(8,10,E);	wall(8,11,E);	wall(8,12,E);			wall(8,15,E);	wall(8,16,E);
	wall(7,2,N);	wall(7,3,N);	wall(7,4,N);	wall(7,5,N);			wall(7,8,N);	wall(7,9,N);					wall(7,14,N);	wall(7,15,N);	
				wall(7,5,E);					wall(7,10,E);	wall(7,11,E);	wall(7,12,E);				wall(7,16,E);
wall(6,1,N);	wall(6,2,N);	wall(6,3,N);		wall(6,5,N);	wall(6,6,N);		wall(6,8,N);	wall(6,9,N);	wall(6,10,N);						
					wall(6,6,E);				wall(6,10,E);	wall(6,11,E);	wall(6,12,E);	wall(6,13,E);	wall(6,14,E);	wall(6,15,E);	wall(6,16,E);
	wall(5,2,N);	wall(5,3,N);		wall(5,5,N);		wall(5,7,N);		wall(5,9,N);	wall(5,10,N);						wall(5,16,N);
		wall(5,3,E);	wall(5,4,E);	wall(5,5,E);	wall(5,6,E);	wall(5,7,E);				wall(5,11,E);	wall(5,12,E);		wall(5,14,E);		wall(5,16,E);
	wall(4,2,N);						wall(4,8,N);	wall(4,9,N);	wall(4,10,N);	wall(4,11,N);		wall(4,13,N);			
	wall(4,2,E);	wall(4,3,E);	wall(4,4,E);	wall(4,5,E);		wall(4,7,E);		wall(4,9,E);	wall(4,10,E);	wall(4,11,E);	wall(4,12,E);	wall(4,13,E);	wall(4,14,E);	wall(4,15,E);	wall(4,16,E);
wall(3,1,N);	wall(3,2,N);		wall(3,4,N);												
				wall(3,5,E);	wall(3,6,E);	wall(3,7,E);	wall(3,8,E);	wall(3,9,E);		wall(3,11,E);		wall(3,13,E);	wall(3,14,E);		wall(3,16,E);
	wall(2,2,N);	wall(2,3,N);		wall(2,5,N);							wall(2,12,N);				
wall(2,1,E);		wall(2,3,E);	wall(2,4,E);		wall(2,6,E);	wall(2,7,E);	wall(2,8,E);	wall(2,9,E);	wall(2,10,E);		wall(2,12,E);		wall(2,14,E);	wall(2,15,E);	wall(2,16,E);
		wall(1,3,N);		wall(1,5,N);								wall(1,13,N);	wall(1,14,N);	wall(1,15,N);	
wall(1,1,E);					wall(1,6,E);		wall(1,8,E);		wall(1,10,E);	wall(1,11,E);					wall(1,16,E);
															

                                                        }
module us82() {
    wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
wall(16,1,E);							wall(16,8,E);				wall(16,12,E);				wall(16,16,E);
		wall(15,3,N);	wall(15,4,N);	wall(15,5,N);	wall(15,6,N);	wall(15,7,N);		wall(15,9,N);							
wall(15,1,E);					wall(15,6,E);	wall(15,7,E);			wall(15,10,E);	wall(15,11,E);	wall(15,12,E);	wall(15,13,E);	wall(15,14,E);	wall(15,15,E);	wall(15,16,E);
	wall(14,2,N);							wall(14,9,N);				wall(14,13,N);			
wall(14,1,E);	wall(14,2,E);	wall(14,3,E);	wall(14,4,E);	wall(14,5,E);	wall(14,6,E);	wall(14,7,E);			wall(14,10,E);	wall(14,11,E);			wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
								wall(13,9,N);	wall(13,10,N);	wall(13,11,N);		wall(13,13,N);	wall(13,14,N);	wall(13,15,N);	
wall(13,1,E);	wall(13,2,E);	wall(13,3,E);	wall(13,4,E);	wall(13,5,E);	wall(13,6,E);	wall(13,7,E);								wall(13,15,E);	wall(13,16,E);
								wall(12,9,N);	wall(12,10,N);	wall(12,11,N);		wall(12,13,N);	wall(12,14,N);		
wall(12,1,E);		wall(12,3,E);	wall(12,4,E);	wall(12,5,E);	wall(12,6,E);	wall(12,7,E);								wall(12,15,E);	wall(12,16,E);
								wall(11,9,N);	wall(11,10,N);	wall(11,11,N);		wall(11,13,N);	wall(11,14,N);		
wall(11,1,E);	wall(11,2,E);	wall(11,3,E);				wall(11,7,E);								wall(11,15,E);	wall(11,16,E);
								wall(10,9,N);	wall(10,10,N);	wall(10,11,N);		wall(10,13,N);	wall(10,14,N);		
wall(10,1,E);	wall(10,2,E);	wall(10,3,E);	wall(10,4,E);	wall(10,5,E);	wall(10,6,E);	wall(10,7,E);								wall(10,15,E);	wall(10,16,E);
	wall(9,2,N);						wall(9,8,N);	wall(9,9,N);	wall(9,10,N);	wall(9,11,N);	wall(9,12,N);	wall(9,13,N);	wall(9,14,N);	wall(9,15,N);	
			wall(9,4,E);	wall(9,5,E);	wall(9,6,E);	wall(9,7,E);								wall(9,15,E);	wall(9,16,E);
	wall(8,2,N);								wall(8,10,N);	wall(8,11,N);	wall(8,12,N);	wall(8,13,N);	wall(8,14,N);		
wall(8,1,E);	wall(8,2,E);	wall(8,3,E);	wall(8,4,E);	wall(8,5,E);	wall(8,6,E);	wall(8,7,E);		wall(8,9,E);							wall(8,16,E);
							wall(7,8,N);	wall(7,9,N);	wall(7,10,N);	wall(7,11,N);	wall(7,12,N);	wall(7,13,N);	wall(7,14,N);	wall(7,15,N);	
wall(7,1,E);	wall(7,2,E);	wall(7,3,E);	wall(7,4,E);	wall(7,5,E);	wall(7,6,E);	wall(7,7,E);								wall(7,15,E);	wall(7,16,E);
								wall(6,9,N);	wall(6,10,N);	wall(6,11,N);		wall(6,13,N);	wall(6,14,N);		
wall(6,1,E);	wall(6,2,E);	wall(6,3,E);				wall(6,7,E);								wall(6,15,E);	wall(6,16,E);
								wall(5,9,N);	wall(5,10,N);	wall(5,11,N);		wall(5,13,N);	wall(5,14,N);		
wall(5,1,E);		wall(5,3,E);	wall(5,4,E);	wall(5,5,E);	wall(5,6,E);	wall(5,7,E);								wall(5,15,E);	wall(5,16,E);
								wall(4,9,N);	wall(4,10,N);	wall(4,11,N);		wall(4,13,N);	wall(4,14,N);		
wall(4,1,E);	wall(4,2,E);	wall(4,3,E);	wall(4,4,E);	wall(4,5,E);	wall(4,6,E);	wall(4,7,E);								wall(4,15,E);	wall(4,16,E);
								wall(3,9,N);	wall(3,10,N);	wall(3,11,N);		wall(3,13,N);	wall(3,14,N);	wall(3,15,N);	
wall(3,1,E);	wall(3,2,E);	wall(3,3,E);	wall(3,4,E);	wall(3,5,E);	wall(3,6,E);	wall(3,7,E);			wall(3,10,E);	wall(3,11,E);			wall(3,14,E);	wall(3,15,E);	wall(3,16,E);
	wall(2,2,N);							wall(2,9,N);				wall(2,13,N);			
wall(2,1,E);					wall(2,6,E);	wall(2,7,E);			wall(2,10,E);	wall(2,11,E);	wall(2,12,E);	wall(2,13,E);	wall(2,14,E);	wall(2,15,E);	wall(2,16,E);
		wall(1,3,N);	wall(1,4,N);	wall(1,5,N);	wall(1,6,N);	wall(1,7,N);		wall(1,9,N);							
wall(1,1,E);							wall(1,8,E);				wall(1,12,E);				wall(1,16,E);
															

}
module chicago86() {
    wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
			wall(16,4,E);		wall(16,6,E);	wall(16,7,E);		wall(16,9,E);			wall(16,12,E);				wall(16,16,E);
wall(15,1,N);	wall(15,2,N);												wall(15,14,N);	wall(15,15,N);	
		wall(15,3,E);		wall(15,5,E);		wall(15,7,E);	wall(15,8,E);	wall(15,9,E);	wall(15,10,E);	wall(15,11,E);			wall(15,14,E);		wall(15,16,E);
	wall(14,2,N);			wall(14,5,N);	wall(14,6,N);										
	wall(14,2,E);	wall(14,3,E);			wall(14,6,E);	wall(14,7,E);	wall(14,8,E);	wall(14,9,E);	wall(14,10,E);	wall(14,11,E);	wall(14,12,E);	wall(14,13,E);	wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
															
wall(13,1,E);	wall(13,2,E);	wall(13,3,E);	wall(13,4,E);	wall(13,5,E);			wall(13,8,E);			wall(13,11,E);	wall(13,12,E);	wall(13,13,E);		wall(13,15,E);	wall(13,16,E);
	wall(12,2,N);		wall(12,4,N);	wall(12,5,N);	wall(12,6,N);		wall(12,8,N);	wall(12,9,N);	wall(12,10,N);	wall(12,11,N);			wall(12,14,N);		
	wall(12,2,E);		wall(12,4,E);		wall(12,6,E);	wall(12,7,E);					wall(12,12,E);		wall(12,14,E);		wall(12,16,E);
		wall(11,3,N);	wall(11,4,N);	wall(11,5,N);		wall(11,7,N);					wall(11,12,N);	wall(11,13,N);		wall(11,15,N);	wall(11,16,N);
wall(11,1,E);	wall(11,2,E);				wall(11,6,E);	wall(11,7,E);	wall(11,8,E);	wall(11,9,E);	wall(11,10,E);			wall(11,13,E);			wall(11,16,E);
wall(10,1,N);			wall(10,4,N);		wall(10,6,N);						wall(10,12,N);	wall(10,13,N);	wall(10,14,N);	wall(10,15,N);	
	wall(10,2,E);					wall(10,7,E);		wall(10,9,E);	wall(10,10,E);			wall(10,13,E);			wall(10,16,E);
	wall(9,2,N);	wall(9,3,N);	wall(9,4,N);	wall(9,5,N);	wall(9,6,N);	wall(9,7,N);	wall(9,8,N);	wall(9,9,N);	wall(9,10,N);	wall(9,11,N);	wall(9,12,N);			wall(9,15,N);	
					wall(9,6,E);			wall(9,9,E);				wall(9,13,E);		wall(9,15,E);	wall(9,16,E);
	wall(8,2,N);	wall(8,3,N);	wall(8,4,N);	wall(8,5,N);	wall(8,6,N);					wall(8,11,N);	wall(8,12,N);		wall(8,14,N);		wall(8,16,N);
wall(8,1,E);					wall(8,6,E);	wall(8,7,E);		wall(8,9,E);					wall(8,14,E);		wall(8,16,E);
		wall(7,3,N);	wall(7,4,N);	wall(7,5,N);			wall(7,8,N);	wall(7,9,N);	wall(7,10,N);	wall(7,11,N);					
wall(7,1,E);	wall(7,2,E);				wall(7,6,E);	wall(7,7,E);	wall(7,8,E);		wall(7,10,E);	wall(7,11,E);	wall(7,12,E);	wall(7,13,E);		wall(7,15,E);	wall(7,16,E);
		wall(6,3,N);	wall(6,4,N);	wall(6,5,N);								wall(6,13,N);	wall(6,14,N);		
wall(6,1,E);				wall(6,5,E);		wall(6,7,E);		wall(6,9,E);		wall(6,11,E);			wall(6,14,E);		wall(6,16,E);
		wall(5,3,N);		wall(5,5,N);	wall(5,6,N);	wall(5,7,N);		wall(5,9,N);				wall(5,13,N);			
wall(5,1,E);	wall(5,2,E);								wall(5,10,E);		wall(5,12,E);		wall(5,14,E);	wall(5,15,E);	wall(5,16,E);
	wall(4,2,N);	wall(4,3,N);	wall(4,4,N);	wall(4,5,N);	wall(4,6,N);	wall(4,7,N);	wall(4,8,N);	wall(4,9,N);	wall(4,10,N);	wall(4,11,N);	wall(4,12,N);	wall(4,13,N);			
wall(4,1,E);				wall(4,5,E);			wall(4,8,E);	wall(4,9,E);				wall(4,13,E);	wall(4,14,E);		wall(4,16,E);
	wall(3,2,N);	wall(3,3,N);				wall(3,7,N);				wall(3,11,N);	wall(3,12,N);		wall(3,14,N);	wall(3,15,N);	
		wall(3,3,E);	wall(3,4,E);		wall(3,6,E);	wall(3,7,E);		wall(3,9,E);					wall(3,14,E);	wall(3,15,E);	wall(3,16,E);
	wall(2,2,N);			wall(2,5,N);	wall(2,6,N);			wall(2,9,N);	wall(2,10,N);	wall(2,11,N);	wall(2,12,N);	wall(2,13,N);			
wall(2,1,E);	wall(2,2,E);	wall(2,3,E);		wall(2,5,E);				wall(2,9,E);					wall(2,14,E);		wall(2,16,E);
						wall(1,7,N);	wall(1,8,N);		wall(1,10,N);	wall(1,11,N);			wall(1,14,N);	wall(1,15,N);	
wall(1,1,E);			wall(1,4,E);				wall(1,8,E);				wall(1,12,E);				wall(1,16,E);

}

module japan83() {
wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
wall(16,1,E);															wall(16,16,E);
		wall(15,3,N);	wall(15,4,N);	wall(15,5,N);	wall(15,6,N);	wall(15,7,N);	wall(15,8,N);	wall(15,9,N);		wall(15,11,N);	wall(15,12,N);		wall(15,14,N);	wall(15,15,N);	
wall(15,1,E);	wall(15,2,E);													wall(15,15,E);	wall(15,16,E);
		wall(14,3,N);	wall(14,4,N);	wall(14,5,N);	wall(14,6,N);	wall(14,7,N);		wall(14,9,N);	wall(14,10,N);	wall(14,11,N);		wall(14,13,N);	wall(14,14,N);		
	wall(14,2,E);									wall(14,11,E);			wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
	wall(13,2,N);		wall(13,4,N);	wall(13,5,N);	wall(13,6,N);	wall(13,7,N);	wall(13,8,N);	wall(13,9,N);	wall(13,10,N);		wall(13,12,N);	wall(13,13,N);			
	wall(13,2,E);	wall(13,3,E);										wall(13,13,E);	wall(13,14,E);	wall(13,15,E);	wall(13,16,E);
				wall(12,5,N);	wall(12,6,N);	wall(12,7,N);	wall(12,8,N);	wall(12,9,N);	wall(12,10,N);	wall(12,11,N);	wall(12,12,N);	wall(12,13,N);			
wall(12,1,E);	wall(12,2,E);	wall(12,3,E);	wall(12,4,E);				wall(12,8,E);				wall(12,12,E);	wall(12,13,E);	wall(12,14,E);	wall(12,15,E);	wall(12,16,E);
					wall(11,6,N);	wall(11,7,N);	wall(11,8,N);	wall(11,9,N);	wall(11,10,N);	wall(11,11,N);					
wall(11,1,E);	wall(11,2,E);	wall(11,3,E);	wall(11,4,E);	wall(11,5,E);			wall(11,8,E);			wall(11,11,E);	wall(11,12,E);	wall(11,13,E);	wall(11,14,E);	wall(11,15,E);	wall(11,16,E);
						wall(10,7,N);	wall(10,8,N);	wall(10,9,N);	wall(10,10,N);						
wall(10,1,E);	wall(10,2,E);	wall(10,3,E);	wall(10,4,E);	wall(10,5,E);	wall(10,6,E);				wall(10,10,E);	wall(10,11,E);		wall(10,13,E);	wall(10,14,E);	wall(10,15,E);	wall(10,16,E);
							wall(9,8,N);	wall(9,9,N);							
wall(9,1,E);	wall(9,2,E);	wall(9,3,E);	wall(9,4,E);	wall(9,5,E);	wall(9,6,E);	wall(9,7,E);		wall(9,9,E);	wall(9,10,E);	wall(9,11,E);	wall(9,12,E);	wall(9,13,E);	wall(9,14,E);	wall(9,15,E);	wall(9,16,E);
															
wall(8,1,E);	wall(8,2,E);							wall(8,9,E);	wall(8,10,E);		wall(8,12,E);	wall(8,13,E);	wall(8,14,E);	wall(8,15,E);	wall(8,16,E);
							wall(7,8,N);	wall(7,9,N);							
wall(7,1,E);	wall(7,2,E);	wall(7,3,E);	wall(7,4,E);	wall(7,5,E);	wall(7,6,E);				wall(7,10,E);	wall(7,11,E);	wall(7,12,E);	wall(7,13,E);		wall(7,15,E);	wall(7,16,E);
						wall(6,7,N);	wall(6,8,N);		wall(6,10,N);						
wall(6,1,E);	wall(6,2,E);	wall(6,3,E);	wall(6,4,E);	wall(6,5,E);	wall(6,6,E);					wall(6,11,E);	wall(6,12,E);	wall(6,13,E);	wall(6,14,E);	wall(6,15,E);	wall(6,16,E);
				wall(5,5,N);	wall(5,6,N);	wall(5,7,N);	wall(5,8,N);	wall(5,9,N);	wall(5,10,N);	wall(5,11,N);					
wall(5,1,E);	wall(5,2,E);	wall(5,3,E);	wall(5,4,E);								wall(5,12,E);	wall(5,13,E);	wall(5,14,E);		wall(5,16,E);
				wall(4,5,N);	wall(4,6,N);	wall(4,7,N);	wall(4,8,N);		wall(4,10,N);	wall(4,11,N);	wall(4,12,N);				
	wall(4,2,E);	wall(4,3,E);										wall(4,13,E);	wall(4,14,E);	wall(4,15,E);	wall(4,16,E);
	wall(3,2,N);		wall(3,4,N);	wall(3,5,N);	wall(3,6,N);	wall(3,7,N);	wall(3,8,N);	wall(3,9,N);	wall(3,10,N);	wall(3,11,N);	wall(3,12,N);	wall(3,13,N);			
	wall(3,2,E);											wall(3,13,E);	wall(3,14,E);	wall(3,15,E);	wall(3,16,E);
		wall(2,3,N);	wall(2,4,N);	wall(2,5,N);	wall(2,6,N);	wall(2,7,N);	wall(2,8,N);		wall(2,10,N);	wall(2,11,N);	wall(2,12,N);	wall(2,13,N);	wall(2,14,N);	wall(2,15,N);	
wall(2,1,E);	wall(2,2,E);						wall(2,8,E);								wall(2,16,E);
		wall(1,3,N);	wall(1,4,N);		wall(1,6,N);	wall(1,7,N);	wall(1,8,N);	wall(1,9,N);	wall(1,10,N);	wall(1,11,N);	wall(1,12,N);	wall(1,13,N);	wall(1,14,N);	wall(1,15,N);	
wall(1,1,E);															wall(1,16,E);
}

module us83(){
wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
wall(16,1,E);															wall(16,16,E);
		wall(15,3,N);	wall(15,4,N);	wall(15,5,N);	wall(15,6,N);	wall(15,7,N);	wall(15,8,N);	wall(15,9,N);		wall(15,11,N);	wall(15,12,N);		wall(15,14,N);	wall(15,15,N);	
wall(15,1,E);	wall(15,2,E);													wall(15,15,E);	wall(15,16,E);
		wall(14,3,N);	wall(14,4,N);	wall(14,5,N);	wall(14,6,N);	wall(14,7,N);		wall(14,9,N);	wall(14,10,N);	wall(14,11,N);		wall(14,13,N);	wall(14,14,N);		
	wall(14,2,E);									wall(14,11,E);			wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
	wall(13,2,N);		wall(13,4,N);	wall(13,5,N);	wall(13,6,N);	wall(13,7,N);	wall(13,8,N);	wall(13,9,N);	wall(13,10,N);		wall(13,12,N);	wall(13,13,N);			
	wall(13,2,E);	wall(13,3,E);			wall(13,6,E);							wall(13,13,E);	wall(13,14,E);	wall(13,15,E);	wall(13,16,E);
				wall(12,5,N);	wall(12,6,N);	wall(12,7,N);	wall(12,8,N);	wall(12,9,N);	wall(12,10,N);	wall(12,11,N);	wall(12,12,N);	wall(12,13,N);			
wall(12,1,E);	wall(12,2,E);	wall(12,3,E);	wall(12,4,E);				wall(12,8,E);				wall(12,12,E);	wall(12,13,E);	wall(12,14,E);	wall(12,15,E);	wall(12,16,E);
					wall(11,6,N);	wall(11,7,N);	wall(11,8,N);	wall(11,9,N);	wall(11,10,N);	wall(11,11,N);					
wall(11,1,E);	wall(11,2,E);	wall(11,3,E);	wall(11,4,E);	wall(11,5,E);			wall(11,8,E);			wall(11,11,E);	wall(11,12,E);	wall(11,13,E);	wall(11,14,E);		wall(11,16,E);
						wall(10,7,N);	wall(10,8,N);	wall(10,9,N);	wall(10,10,N);						
wall(10,1,E);	wall(10,2,E);	wall(10,3,E);	wall(10,4,E);	wall(10,5,E);	wall(10,6,E);				wall(10,10,E);	wall(10,11,E);		wall(10,13,E);	wall(10,14,E);	wall(10,15,E);	wall(10,16,E);
							wall(9,8,N);	wall(9,9,N);							
wall(9,1,E);	wall(9,2,E);	wall(9,3,E);	wall(9,4,E);	wall(9,5,E);	wall(9,6,E);	wall(9,7,E);		wall(9,9,E);	wall(9,10,E);	wall(9,11,E);	wall(9,12,E);	wall(9,13,E);	wall(9,14,E);	wall(9,15,E);	wall(9,16,E);
															
wall(8,1,E);	wall(8,2,E);				wall(8,6,E);			wall(8,9,E);	wall(8,10,E);		wall(8,12,E);	wall(8,13,E);	wall(8,14,E);	wall(8,15,E);	wall(8,16,E);
						wall(7,7,N);	wall(7,8,N);	wall(7,9,N);							
wall(7,1,E);	wall(7,2,E);	wall(7,3,E);	wall(7,4,E);	wall(7,5,E);	wall(7,6,E);				wall(7,10,E);	wall(7,11,E);	wall(7,12,E);	wall(7,13,E);		wall(7,15,E);	wall(7,16,E);
						wall(6,7,N);	wall(6,8,N);		wall(6,10,N);						
wall(6,1,E);	wall(6,2,E);	wall(6,3,E);	wall(6,4,E);	wall(6,5,E);	wall(6,6,E);					wall(6,11,E);	wall(6,12,E);	wall(6,13,E);	wall(6,14,E);	wall(6,15,E);	wall(6,16,E);
				wall(5,5,N);	wall(5,6,N);	wall(5,7,N);	wall(5,8,N);	wall(5,9,N);	wall(5,10,N);	wall(5,11,N);					
wall(5,1,E);	wall(5,2,E);	wall(5,3,E);	wall(5,4,E);								wall(5,12,E);	wall(5,13,E);	wall(5,14,E);		wall(5,16,E);
				wall(4,5,N);	wall(4,6,N);	wall(4,7,N);	wall(4,8,N);		wall(4,10,N);	wall(4,11,N);	wall(4,12,N);				
	wall(4,2,E);	wall(4,3,E);										wall(4,13,E);	wall(4,14,E);	wall(4,15,E);	wall(4,16,E);
	wall(3,2,N);		wall(3,4,N);	wall(3,5,N);	wall(3,6,N);	wall(3,7,N);	wall(3,8,N);	wall(3,9,N);	wall(3,10,N);	wall(3,11,N);	wall(3,12,N);	wall(3,13,N);			
	wall(3,2,E);											wall(3,13,E);	wall(3,14,E);	wall(3,15,E);	wall(3,16,E);
		wall(2,3,N);	wall(2,4,N);	wall(2,5,N);	wall(2,6,N);	wall(2,7,N);	wall(2,8,N);		wall(2,10,N);	wall(2,11,N);	wall(2,12,N);	wall(2,13,N);	wall(2,14,N);	wall(2,15,N);	
wall(2,1,E);	wall(2,2,E);						wall(2,8,E);								wall(2,16,E);
		wall(1,3,N);	wall(1,4,N);		wall(1,6,N);	wall(1,7,N);	wall(1,8,N);	wall(1,9,N);	wall(1,10,N);	wall(1,11,N);	wall(1,12,N);	wall(1,13,N);	wall(1,14,N);	wall(1,15,N);	
wall(1,1,E);															wall(1,16,E);
}

module london88() {
wall(16,1,N);	wall(16,2,N);	wall(16,3,N);	wall(16,4,N);	wall(16,5,N);	wall(16,6,N);	wall(16,7,N);	wall(16,8,N);	wall(16,9,N);	wall(16,10,N);	wall(16,11,N);	wall(16,12,N);	wall(16,13,N);	wall(16,14,N);	wall(16,15,N);	wall(16,16,N);
															wall(16,16,E);
	wall(15,2,N);	wall(15,3,N);	wall(15,4,N);	wall(15,5,N);	wall(15,6,N);	wall(15,7,N);	wall(15,8,N);	wall(15,9,N);	wall(15,10,N);	wall(15,11,N);	wall(15,12,N);	wall(15,13,N);	wall(15,14,N);		
wall(15,1,E);													wall(15,14,E);	wall(15,15,E);	wall(15,16,E);
		wall(14,3,N);	wall(14,4,N);	wall(14,5,N);	wall(14,6,N);	wall(14,7,N);	wall(14,8,N);	wall(14,9,N);	wall(14,10,N);		wall(14,12,N);	wall(14,13,N);			
wall(14,1,E);	wall(14,2,E);								wall(14,10,E);	wall(14,11,E);		wall(14,13,E);	wall(14,14,E);	wall(14,15,E);	wall(14,16,E);
			wall(13,4,N);	wall(13,5,N);	wall(13,6,N);	wall(13,7,N);	wall(13,8,N);	wall(13,9,N);							
wall(13,1,E);		wall(13,3,E);							wall(13,10,E);	wall(13,11,E);	wall(13,12,E);	wall(13,13,E);	wall(13,14,E);	wall(13,15,E);	wall(13,16,E);
	wall(12,2,N);	wall(12,3,N);		wall(12,5,N);	wall(12,6,N);	wall(12,7,N);	wall(12,8,N);	wall(12,9,N);	wall(12,10,N);						
wall(12,1,E);	wall(12,2,E);		wall(12,4,E);		wall(12,6,E);				wall(12,10,E);	wall(12,11,E);	wall(12,12,E);	wall(12,13,E);	wall(12,14,E);	wall(12,15,E);	wall(12,16,E);
			wall(11,4,N);				wall(11,8,N);	wall(11,9,N);							
wall(11,1,E);		wall(11,3,E);		wall(11,5,E);	wall(11,6,E);	wall(11,7,E);			wall(11,10,E);	wall(11,11,E);	wall(11,12,E);	wall(11,13,E);	wall(11,14,E);	wall(11,15,E);	wall(11,16,E);
		wall(10,3,N);		wall(10,5,N);				wall(10,9,N);							
wall(10,1,E);			wall(10,4,E);		wall(10,6,E);	wall(10,7,E);		wall(10,9,E);		wall(10,11,E);	wall(10,12,E);	wall(10,13,E);	wall(10,14,E);	wall(10,15,E);	wall(10,16,E);
	wall(9,2,N);	wall(9,3,N);	wall(9,4,N);		wall(9,6,N);		wall(9,8,N);	wall(9,9,N);		wall(9,11,N);					
			wall(9,4,E);		wall(9,6,E);			wall(9,9,E);	wall(9,10,E);	wall(9,11,E);	wall(9,12,E);	wall(9,13,E);	wall(9,14,E);	wall(9,15,E);	wall(9,16,E);
	wall(8,2,N);	wall(8,3,N);		wall(8,5,N);											
wall(8,1,E);		wall(8,3,E);			wall(8,6,E);	wall(8,7,E);		wall(8,9,E);	wall(8,10,E);		wall(8,12,E);	wall(8,13,E);	wall(8,14,E);	wall(8,15,E);	wall(8,16,E);
			wall(7,4,N);	wall(7,5,N);	wall(7,6,N);		wall(7,8,N);	wall(7,9,N);			wall(7,12,N);				
wall(7,1,E);	wall(7,2,E);				wall(7,6,E);		wall(7,8,E);		wall(7,10,E);		wall(7,12,E);	wall(7,13,E);	wall(7,14,E);	wall(7,15,E);	wall(7,16,E);
		wall(6,3,N);	wall(6,4,N);		wall(6,6,N);	wall(6,7,N);			wall(6,10,N);	wall(6,11,N);					
wall(6,1,E);			wall(6,4,E);		wall(6,6,E);					wall(6,11,E);	wall(6,12,E);	wall(6,13,E);	wall(6,14,E);	wall(6,15,E);	wall(6,16,E);
	wall(5,2,N);	wall(5,3,N);		wall(5,5,N);			wall(5,8,N);	wall(5,9,N);	wall(5,10,N);						
wall(5,1,E);		wall(5,3,E);		wall(5,5,E);	wall(5,6,E);				wall(5,10,E);	wall(5,11,E);	wall(5,12,E);	wall(5,13,E);	wall(5,14,E);	wall(5,15,E);	wall(5,16,E);
			wall(4,4,N);			wall(4,7,N);	wall(4,8,N);								
	wall(4,2,E);	wall(4,3,E);		wall(4,5,E);				wall(4,9,E);		wall(4,11,E);	wall(4,12,E);	wall(4,13,E);	wall(4,14,E);	wall(4,15,E);	wall(4,16,E);
wall(3,1,N);				wall(3,5,N);	wall(3,6,N);	wall(3,7,N);	wall(3,8,N);	wall(3,9,N);	wall(3,10,N);	wall(3,11,N);				wall(3,15,N);	
	wall(3,2,E);	wall(3,3,E);									wall(3,12,E);	wall(3,13,E);			wall(3,16,E);
			wall(2,4,N);	wall(2,5,N);	wall(2,6,N);	wall(2,7,N);	wall(2,8,N);	wall(2,9,N);	wall(2,10,N);	wall(2,11,N);	wall(2,12,N);		wall(2,14,N);	wall(2,15,N);	wall(2,16,N);
wall(2,1,E);	wall(2,2,E);														wall(2,16,E);
		wall(1,3,N);	wall(1,4,N);	wall(1,5,N);	wall(1,6,N);	wall(1,7,N);	wall(1,8,N);	wall(1,9,N);	wall(1,10,N);	wall(1,11,N);	wall(1,12,N);	wall(1,13,N);	wall(1,14,N);	wall(1,15,N);	
wall(1,1,E);															wall(1,16,E);
}