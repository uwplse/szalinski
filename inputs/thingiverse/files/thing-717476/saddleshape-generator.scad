Resolution = .5; 
Size = 10;
Thickness = 2;
Scaler1 = 3;
Scaler2 = 2;







mirror ([1,0,0]){
	saddle (Resolution, Size, Thickness, Scaler1, Scaler2);
}

saddle (Resolution, Size, Thickness, Scaler1, Scaler2);

mirror ([0,1,0]){
	saddle (Resolution, Size, Thickness, Scaler1, Scaler2);
}

mirror ([0,1,0]){
	mirror ([1,0,0]){
		saddle (Resolution, Size, Thickness, Scaler1, Scaler2);
	}
}








module saddle (res, siz, thi, sc1, sc2){
	for (d = [0: res: siz]){
		assign (y=d){
			for (i = [0 : res: siz]){
		    	assign (x = i){
					assign (
					z1 = ((y*y)/(sc2* sc2)) - ((x*x)/(sc1* sc1)),
					z2 = (((y+res)*(y+res))/(sc2* sc2)) - ((x*x)/(sc1* sc1)),
					z3 = (((y+res)*(y+res))/(sc2* sc2)) - (((x+res)*(x+res))/(sc1*sc1)),
					z4 =((y*y)/(sc2* sc2)) -  (((x+res)*(x+res))/(sc1*sc1))	){
			
						polyhedron(
  points=[[x, y, z1], [x,y+res,z2],[x+res,y+res,z3],[x+res,y,z4], // the four points on top
         [x, y, z1-thi], [x,y+res,z2-thi],[x+res,y+res,z3-thi],[x+res,y,z4-thi]], // the four points at the bottom 
  faces=[ [0,1,2],[0,2,3],			//Top
		   [0,3,4],[4,3,7],       //Side 1 
		   [4,5,0],[0,5,1],       //Side 2
		   [6,2,1],[1,5,6],       //Side 3
		   [7,3,2],[2,6,7],       //Side 4
		   [7,6,4],[6,5,4] ]       //Bottom    
 		);
					}
				}
			}
		}
	}
}