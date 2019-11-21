// How thick should the shaft be to fit your vaccuum?
shaft_diameter = 32; // [10:60]

// How wide should the tip of the nozzle open?
nozzle_opening = 8; // [1:20]

// How long should the crevice be in total?
crevice_length = 100; // [100:500]

// How thick should the walls of the nozzle be? (Thinner = less filament usage but more likely to break)
wall_thickness = 3; // [1:10]

module shape(rohrdurchmesser, duesenstaerke, laenge){
		
	difference(){		
		union(){
			cylinder(laenge/2, r=rohrdurchmesser/2);
			intersection(){
					translate([-rohrdurchmesser/2,-duesenstaerke/2,laenge/2]) 
						cube([rohrdurchmesser,duesenstaerke,laenge/2]);
					translate([0,0,laenge/2]) 
						cylinder(laenge/2, r=rohrdurchmesser/2);
			}
		}
		for(i = [[-rohrdurchmesser/2,-laenge/2-duesenstaerke/2,laenge/2],[-rohrdurchmesser/2,laenge/2+duesenstaerke/2,laenge/2]])			
			translate(i)
			rotate([0,90,0]) 
			cylinder(rohrdurchmesser, r=laenge/2);
	}
}

module fugenduese(rohrdurchmesser, duesenstaerke, laenge, wandstaerke){
$fn = 200;
blocklaenge = sqrt(pow((rohrdurchmesser+2*wandstaerke)*3/4,2)*2);
	difference(){
		shape(rohrdurchmesser+wandstaerke*2,duesenstaerke+wandstaerke*2,laenge); // duese erstellen

		translate([0,0,0]) shape(rohrdurchmesser,duesenstaerke,laenge); //duese aushoehlen

		translate ([(rohrdurchmesser+2*wandstaerke)/4,0,laenge])
	   rotate([0,-45,0]) translate([-blocklaenge,-(duesenstaerke+wandstaerke*2)/2-0.005,0]) cube([blocklaenge,duesenstaerke+wandstaerke*2+0.01,blocklaenge]); //im 45Grad Winkel abschneiden

		difference(){ 

			translate([(rohrdurchmesser+2*wandstaerke)/8+(rohrdurchmesser+2*wandstaerke)/16,-(duesenstaerke+2*wandstaerke)/2-0.005,laenge-(rohrdurchmesser+2*wandstaerke)/8/4+0.005]) cube([(rohrdurchmesser)/8, duesenstaerke+2*wandstaerke+0.01 ,(rohrdurchmesser+2*wandstaerke)/8/4+0.005]);

			translate([
(rohrdurchmesser+2*wandstaerke)/4+(((rohrdurchmesser)/8)-sqrt(pow((rohrdurchmesser+2*wandstaerke)/8,2))/2),
duesenstaerke/2+wandstaerke+0.01,
laenge-(rohrdurchmesser+2*wandstaerke)/8]) 
rotate([90,0,0]) cylinder(duesenstaerke+wandstaerke*2+0.02, r = (rohrdurchmesser+2*wandstaerke)/8);

		} // die Ecke der Schnittkante abrunden
	}


}

fugenduese(shaft_diameter,nozzle_opening,crevice_length,wall_thickness);




