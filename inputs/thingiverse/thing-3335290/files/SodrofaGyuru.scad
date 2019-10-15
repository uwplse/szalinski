//Rolling pin rings for uniform thickness of dough
//2019.01.05. by MicroWizard
//This software is in the Public Domain

//You must set parameters...
//... typically for sweet christmas cookies with honey
//I used to cut them with Oogime brand cookie cutters.
rolling_pin_diameter	= 32.5;	//in millimeters
dough_thickness			=  5.0; //in millimeters
ring_width				= 10.0; //in millimeters

/*
//... typically for small cheese scones
//I used to cut them with 25mm dia round cutter.
rolling_pin_diameter	= 32.5;	//in millimeters
dough_thickness			= 10.0; //in millimeters
ring_width				= 15.0; //in millimeters
*/

//Originally...
//2017.04.15. Mamanak fondant, marcipan nyujtashoz sodrofa gyuru
$fn=36;

//belso atmero, (teszta)vastagsag, gyuru szelesseg
module gyuru(db,vas,szel){
    difference(){
        cylinder(d1=db+2*vas,d2=db+2*vas,h=szel, center=true);
        cylinder(d1=db,d2=db,h=szel+1, center=true);
    }
}

//belso atmero, (teszta)vastagsag, gyuru szelesseg
gyuru(rolling_pin_diameter, dough_thickness, ring_width);

