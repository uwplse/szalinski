//Ceiling blind hole cover
//LGI v1.0, Dec 2016

$fn=100;

//Constants:
blindhole=75; //Diameter of the blind hole to cover
holedepth=12; //Depth of the hole, equals the length of the stands without the hook
thwall=1.5; //Wall thickness for the stands
hbottofhook=thwall; //Height of the widening section of the hook
overlap=6; //mm overlap over the hole
coverh=3; //Height (thickness) of the coverplate

//The actual coverplate (the easy part;-):
cover=blindhole+(2*overlap); //defines the diameter of the coverplate
translate(v=[0,0,(coverh/-1)]) {
cylinder (coverh,d1=cover-coverh,d2=cover);
}

//The four stands:
difference() {
cylinder (holedepth,d1=blindhole,d2=blindhole);
    
cylinder (holedepth,d1=blindhole-(2*thwall),d2=blindhole-(2*thwall));

translate (v=[(blindhole/-2),(blindhole*-0.3),0]) {
cube ([blindhole,(blindhole*0.6),holedepth]);
    }
translate (v=[(blindhole*-0.3),(blindhole/-2),0]) {
cube ([(blindhole*0.6),blindhole,holedepth]);
    }
}


//Clamping hooks lower section:
difference () {
translate(v=[0,0,holedepth]) {
cylinder (hbottofhook,d1=blindhole,d2=blindhole+(1*thwall));
    }
translate (v=[cover/-2,(blindhole*-0.3),holedepth]) {
cube ([cover,(blindhole*0.6),holedepth]);
    }
translate (v=[(blindhole*-0.3),cover/-2,holedepth]) {
cube ([(blindhole*0.6),cover,holedepth]);
    }
translate (v=[0,0,holedepth]) {
cylinder (holedepth,d1=blindhole-(2*thwall),d2=blindhole-(2*thwall));
    }
}

//Clamping hooks upper section:
htopofhook=holedepth+hbottofhook; //Do not modify
difference () {
translate(v=[0,0,htopofhook]) {
cylinder (holedepth*2/3,d1=blindhole+(1*thwall),d2=blindhole-thwall);
    }
translate (v=[cover/-2,(blindhole*-0.3),htopofhook]) {
cube ([cover,(blindhole*0.6),holedepth]);
    }
translate (v=[(blindhole*-0.3),cover/-2,htopofhook]) {
cube ([(blindhole*0.6),cover,holedepth]);
    }
translate (v=[0,0,htopofhook]) {
cylinder (holedepth*2/3,d1=blindhole-(2*thwall),d2=blindhole-(2*thwall));
    }
}