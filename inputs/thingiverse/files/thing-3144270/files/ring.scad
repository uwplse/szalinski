//Ring ID (mm)
ID = 20;

//Ring Height (mm)
height = 5;

//Thickness
t=2;

//Resolution
resolution = 200;


difference()
		{cylinder (h = height, r = t+ID/2, $fn = resolution, center = true);
            
        cylinder (h = height * 1.5, r = ID/2, $fn = resolution, center = true);}

