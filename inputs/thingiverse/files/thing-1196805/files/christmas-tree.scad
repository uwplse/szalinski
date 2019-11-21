//CUSTOMIZER VARIABLES
character = "C";	//	[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]
char_pos = 7.5; // Character Position [6:9]
//CUSTOMIZER VARIABLES END

difference(){

linear_extrude(height = 5)
polygon(points = [ [10, 0], [10, 6],[0, 6],[4, 14],[1, 14],[5, 21],[2.65, 21],[12.4, 38.1],[12.4, 38.1],[22, 21],[19.7, 21],[24, 14],[21, 14],[25, 6],[15, 6],[15, 0]]);
    
    
    



translate([char_pos,13,0])    
linear_extrude(height = 5)
   text(character,font="Arial:style=Bold");
}
translate([12.5,40.5,0])
difference(){
cylinder(r=4,h=5,$fn=50);
cylinder(r=2,h=5,$fn=50);
}

