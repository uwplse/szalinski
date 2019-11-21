centralSquare = 11;
longeure=4*centralSquare;
epaisseur=10;
difference ()
{
	union ()
		{  
		translate([-longeure/2,0,0])
		cube([2*longeure,2*centralSquare,epaisseur]);
		translate([longeure/4,-centralSquare/2,0])
		cube([2*centralSquare,3*centralSquare,epaisseur]);	

		linear_extrude (height=epaisseur) polygon (points=[[centralSquare,0],[-centralSquare/2,0],[centralSquare,-centralSquare/2]]);
		linear_extrude (height=epaisseur) polygon (points=[[3*centralSquare,0],[3*centralSquare,-centralSquare/2],[4.5*centralSquare,0 ]]);	
		linear_extrude (height=epaisseur) polygon (points=[[centralSquare,2*centralSquare],[-centralSquare/2,2*centralSquare],[centralSquare,2*centralSquare+centralSquare/2]]);
		linear_extrude (height=epaisseur) polygon (points=[[3*centralSquare,2*centralSquare],[3*centralSquare,2*centralSquare+centralSquare/2],[4.5*centralSquare,2*centralSquare ]]);	
		}
		translate([longeure/2-centralSquare/2,centralSquare/2,-10])
		cube([centralSquare,centralSquare,2*epaisseur+20]);
	}
 