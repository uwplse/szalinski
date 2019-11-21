hoehe_mitte = 30;
hoehe_rand = 20;
breite_mitte = 100;
breite_rand = 15;
dicke_platte = 1;


position_buchse = 35;
laenge_buchse = 12;

position_randstueck_cube = ((breite_mitte/2)+(breite_rand/2));
durchmesser_buchse = 10;
durchmesser_ansatz_buchse = 14;
hoehe_ansatz_buchse = 2;
durchmesser_bohrung = 3.5;
durchmesser_kleberloecher = 2;
abstand_kleberloecher_x = 5;
abstand_kleberloecher_y = 5;
anzahl_klebeloecher_y = ceil((breite_mitte + 2*breite_rand) / abstand_kleberloecher_y);
anzahl_klebeloecher_x = ceil(hoehe_mitte / abstand_kleberloecher_x);
position_beule_x = -10;
position_beule_y = 45;
durchmesser_beule = 7;

ecke_winkel = atan(((hoehe_mitte-hoehe_rand)/2)/(breite_rand));
hoehe_ecke = ((hoehe_mitte - hoehe_rand)/2)/cos(ecke_winkel);
breite_ecke = sqrt(pow(hoehe_ecke,2)+pow(breite_rand,2));
//ecke_position_x = (hoehe_mitte/2)-hoehe_ecke;//-(cos(ecke_winkel)*hoehe_ecke);
ecke_position_x = (hoehe_mitte/2) - ((hoehe_ecke/2)*cos(ecke_winkel)) - ((breite_ecke/2)*sin(ecke_winkel));
ecke_position_y = (breite_mitte/2) + ((breite_ecke/2)*cos(ecke_winkel)) - ((hoehe_ecke/2)*sin(ecke_winkel)) ;
//ecke_position_y = (breite_mitte/2)+((cos(ecke_winkel)*breite_ecke)/2);
rundheit = 128;

klebe_bohrungen_rundheit = 4;

hoehe_M5 = (4.0 + 0.2);
durchmesser_M5 = (8.79 +0.2);
hoehe_M4 = (3.2 +0.2);
durchmesser_M4 = (8.1 + 0.2);
// Nach DIN 934 + 2 Zehntel

H_Mutter = hoehe_M4;
D_Mutter = durchmesser_M4;
Mutter_einlassen = 1;


difference()
{
	union()
	{
		difference()
		{
			union()
			{


				translate ([0,0,0]) cube ([hoehe_mitte,breite_mitte,dicke_platte],center=true);		// Mittelteil der Grundplatte
				for (i = [-position_randstueck_cube:2*position_randstueck_cube:position_randstueck_cube])	// Endstuecke rechtwinklig
				{
					translate ([0,i,0]) cube ([hoehe_rand,breite_rand,dicke_platte],center=true);		// Randstuecke der Grundplatte		
				}
				for (i = [-1:2:1])
				{
					for (j = [-1:2:1])
					{
						translate ([i*ecke_position_x,j*ecke_position_y,0]) rotate([0,0,i*j*ecke_winkel]) cube ([hoehe_ecke,breite_ecke,1],center=true);
					}
				}
			}
			union()
			{
				for (i = [-(anzahl_klebeloecher_y/2):1:anzahl_klebeloecher_y/2])
				{
					for (j = [-(anzahl_klebeloecher_x/2):1:anzahl_klebeloecher_x/2])
					{
						if (i < 0)
						{
							if ((i*abstand_kleberloecher_y) > (-position_buchse + (durchmesser_buchse/2 + durchmesser_kleberloecher/2)))
							{
								translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);

							}
							else if ((i*abstand_kleberloecher_y) < (-position_buchse - (durchmesser_buchse/2 + durchmesser_kleberloecher/2)))
							{
								translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);
							}
							else 
							{
								if ((j*abstand_kleberloecher_x) > (durchmesser_buchse/2 + durchmesser_kleberloecher/2))
								{
									translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);
								}
								else if ((j*abstand_kleberloecher_x) < (-(durchmesser_buchse/2 + durchmesser_kleberloecher/2)))
								{
									translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);
								
								}
							}
						}
						else
						{
							if ((i*abstand_kleberloecher_y) > (position_buchse + (durchmesser_buchse/2 + durchmesser_kleberloecher/2)))
							{
								translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);

							}
							else if ((i*abstand_kleberloecher_y) < (position_buchse - (durchmesser_buchse/2 + durchmesser_kleberloecher/2)))
							{
								translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);
							}
							else 
							{
								if ((j*abstand_kleberloecher_x) > (durchmesser_buchse/2 + durchmesser_kleberloecher/2))
								{
									translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);
								}
								else if ((j*abstand_kleberloecher_x) < (-(durchmesser_buchse/2 + durchmesser_kleberloecher/2)))
								{
									translate ([j*abstand_kleberloecher_x,i*abstand_kleberloecher_y,0]) cylinder (d= durchmesser_kleberloecher,h=2*dicke_platte, center= true, $fn = klebe_bohrungen_rundheit);
								
								}
							}
						}
					}
				}
				for (i = [-1:2:1])
				{
					translate ([position_beule_x,i*position_beule_y,0]) cylinder (d= durchmesser_beule,h=2*dicke_platte, center= true, $fn = rundheit);
				}
			}
		}
		for (i = [-1:2:1])		// Buchsen
		{
			translate ([0,i*position_buchse,(laenge_buchse/2+dicke_platte/2)]) cylinder(h=laenge_buchse,d=durchmesser_buchse,center=true,$fn = rundheit);
			translate ([0,i*position_buchse,(hoehe_ansatz_buchse/2+dicke_platte/2)]) cylinder(h=hoehe_ansatz_buchse,d1=durchmesser_ansatz_buchse,d2=durchmesser_buchse,center=true, $fn = rundheit);
		}
	}
	for (i = [-1:2:1])
	{
		translate ([0,i*position_buchse,(laenge_buchse/2+dicke_platte/2)+1]) cylinder(h=laenge_buchse+10*dicke_platte,d=durchmesser_bohrung,center=true,$fn = rundheit);
	}	
	if (Mutter_einlassen)
	{
		for (i = [-1:2:1])
		{
			translate ([0,i*position_buchse,H_Mutter/2-(dicke_platte/2)]) cylinder(h=(H_Mutter+0.01),d=D_Mutter,center=true,$fn = 6);
		}	
	}
}