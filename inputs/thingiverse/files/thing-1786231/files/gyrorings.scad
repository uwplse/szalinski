spherediam=10;
cylinderdiam=4;
cylinderdpth=40;
sides=250;
start=5;
end=12;
pi=3.141592653589793238;
translate([0,0,0])
difference(){
    for (i = [end:-1:start]) {
        difference(){
            sphere( d=((spherediam/pi)*i)+2.5,$fn=sides);
            sphere( d=((spherediam/pi)*i),$fn=sides);
        }
        sphere( d=((spherediam/pi)*4+2.5),$fn=sides);
    }
    translate([-20,-20,7]){cube(40);}
    translate([-20,-20,-47]){cube(40);}
    translate([0,0,-20]){cylinder( d=cylinderdiam,h=cylinderdpth,$fn=6);}
 text("G", font = "Arial Black", size = 15 * 1.2, valign = "center", halign="center");
}

