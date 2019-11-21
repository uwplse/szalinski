larghezza=100; //[50:300]
lunghezza =150; //[50:300]
altezza=20; //[10:50]
spessore=20;//[10:50]
numero_tagli=7;//[1:15]
spessore_tagli=5; //[1:10]
inclinazione=60; //[45:90]
distanza_tagli=20;//[12:50]

difference(){
	difference(){
		cube([larghezza,lunghezza,altezza],true);
		cube([(larghezza-spessore),(lunghezza-spessore),(altezza+1)],true);
	}

	for(i = [-((numero_tagli/2)-1):(numero_tagli/2)])
			translate([(-(larghezza/2)-1),((i*(-distanza_tagli))+(distanza_tagli/2)),(0)])
			rotate([inclinazione,0,0])
			cube([larghezza+2,(lunghezza/2),spessore_tagli]);
}