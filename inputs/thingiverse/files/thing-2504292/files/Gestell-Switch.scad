// Parameter
//
X_DISTANCE=150;
Y_DISTANCE=100;
Z_HOEHE=80;
FUSS_LAENGE=11;
DICKE=3;
DIST=FUSS_LAENGE-3;

$fn=400;

module fuss(x,y)
{
	
	translate([x,y,0])
	linear_extrude(height = Z_HOEHE)
	{
			circle((FUSS_LAENGE+DICKE)/2);
	}
	
}

module tfuss(x,y)
{
	
	translate([x,y,-5])
	linear_extrude(height = 5)
	{
			circle((FUSS_LAENGE+DICKE)/2);
	}
	
}

module mtfuss(x,y)
{
	
	translate([x,y,-7])
	linear_extrude(height = 30)
	{
			circle((FUSS_LAENGE+DICKE)/2);
	}
	
}

module innenfuss(x,y)
{
	translate([x,y,-60])
	linear_extrude(height = Z_HOEHE+300)
	{
			circle((FUSS_LAENGE+3)/2-DICKE/2);
	}
}

module tplatte()
{
	hull()
	{
		tfuss(X_DISTANCE/2,-Y_DISTANCE/2);
		tfuss(-X_DISTANCE/2,Y_DISTANCE/2);
		tfuss(-X_DISTANCE/2,-Y_DISTANCE/2);
		tfuss(X_DISTANCE/2,Y_DISTANCE/2);
	}
}

module tinnenplatte()
{
	hull()
	{
		mtfuss(X_DISTANCE/2-10,-Y_DISTANCE/2+10);
		mtfuss(-X_DISTANCE/2+10,Y_DISTANCE/2-10);
		mtfuss(-X_DISTANCE/2+10,-Y_DISTANCE/2+10);
		mtfuss(X_DISTANCE/2-10,Y_DISTANCE/2-10);
	}
}

module fuesse()
{
	fuss(X_DISTANCE/2,-Y_DISTANCE/2);
	fuss(-X_DISTANCE/2,Y_DISTANCE/2);
	fuss(-X_DISTANCE/2,-Y_DISTANCE/2);
	fuss(X_DISTANCE/2,Y_DISTANCE/2);
}

difference()
{ 
	fuesse();
	innenfuss(X_DISTANCE/2,-Y_DISTANCE/2);
	innenfuss(-X_DISTANCE/2,Y_DISTANCE/2);
	innenfuss(-X_DISTANCE/2,-Y_DISTANCE/2);
	innenfuss(X_DISTANCE/2,Y_DISTANCE/2);
}

difference()
{
	tplatte();
	tinnenplatte();

}

