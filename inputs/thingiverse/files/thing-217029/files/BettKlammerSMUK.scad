//DIe Laenge der Klammer
laenge=30;

//Weite der Basis
wbase=8;
//Weite des Arms oben (der Druckpunkt liegt etwas zurueck)
warmtop=14;
//Weite des Arms unten
warmbottom=14;

// Betthoehe (der Druck muss selbst eingerechnet werden zB 0.6 abziehen)
hbed=4.3;   
//Hoehe Arm oben (mehr als 4 geht beim Mendel90 nicht)
harmtop=3.6; 
//Hoehe Arm unten
harmbottom=5;

hall=hbed+harmtop+harmbottom;

	      	linear_extrude(height=laenge)
		      polygon(
		         points=[[0,1],
                       [0,hall-1],
                       [1,hall],
                       [wbase,hall],
                       [wbase+warmtop-1,hall],
                       [wbase+warmtop,hall-1],
                       [wbase+warmtop,hall-harmtop+1],
                       [wbase+warmtop-1,hall-harmtop],
                       [wbase+warmtop-3,hall-harmtop+0.05],
                       [wbase+warmtop-8,hall-harmtop+0.5],
                       [wbase,hall-harmtop+0.5],
                       
                       [wbase,harmbottom-0.5],
                       [wbase+warmbottom-8,harmbottom-0.5],
                       [wbase+warmbottom-3,harmbottom-0.05],
                       [wbase+warmbottom-1,harmbottom],
                       [wbase+warmbottom,harmbottom-1],
                       [wbase+warmbottom,1],
                       [wbase+warmbottom-1,0],
                       [wbase,0],
                       [1,0]
                       
                       ] 
                   );
