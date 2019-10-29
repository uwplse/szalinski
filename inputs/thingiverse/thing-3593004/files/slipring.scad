// a slipring for the transfer of electrical power to a turning axis
// it may consist of 2 half shells which can be mounted to an unremovable axis and afterwards filled with the copper wire.

/* [display] */
// the complete slipring 
showSlipring = "on";         // [on, off]
// a slipring half. has to be printed twice
showSlipringHalf = "off";    // [on, off]
// the holder for the brushes
showSlip = "on";             // [on, off]
// the axis where the slipring is mounted
showAxis = "off";            // [on, off]

/* [global settings] */
// how many contacts
sl_cnt = 2;             
// the distance of the sliprings in z
sl_delta = 10;
// thickness of the housing
w_housing = 2;

/* [slipring] */
// the diameter of the axis
d_inner=92;
// the slipring at the sides
sr_hAll=10;
// the slipring in the middle where the copper is located
sr_h=7.5;
// thickness of the sides  
tz=2;
// diameter of the wire
wireD=1.4;

/* [brushes] */
// the complete brush, the spring is relaxed in x direction
sl = [24,8.2,7.2];
// the length of the cole, without spring
slBlack = 12.5;

// berechnetes
sr_d = d_inner+sr_hAll; // der maximale Aussendurchmesser des Schleifrings
sr_z = sr_h+2*tz;       // die Hoehe eines Schleifrings mit Seiten
h_y = sl[1] + 2*w_housing;      // die Breite des Halters
h_z = sl[2] + 2*w_housing;      // die Hoehe des Halters

module slipring(){
   for(lauf=[0:sl_cnt-1]){
        translate([0,0,lauf*sl_delta]) difference(){
            cylinder(d=sr_d, h=sr_z);
            translate([0,0,-.1]) cylinder(d=d_inner, h=sr_z+.2);    // cut off the axis
            
            // die Vertiefung fuer den Draht
            difference(){
                translate([0,0,tz]) cylinder(d=sr_d+.1, h=sr_z-2*tz);
                translate([0,0,tz]) cylinder(d=sr_d-wireD*2, h=sr_z-2*tz, $fn=50);  // hier liegt der Draht
            }
            // fuer jeden Ring braucht die jeweilige Windung 2 Loecher 
            for(i=[0:sl_cnt-1]){
                // die Durchfuehrung des Drahts auf die andere Seite
                rotate([0,0,i*20])translate([0,sr_d/2-1-wireD,-.1])cylinder(d=wireD+.2, h=sr_z+.2, $fn=50);
                // der Ausgang des Drahts aus der Wicklung, etwas verdreht um mehr Platz zu haben
                rotate([0,0,i*20+10])translate([0,sr_d/2-wireD,-.1])cylinder(d=wireD+.2, h=sr_z+.2, $fn=50);
            }
        }
    }
}

module slipringHalf(){
    rZentrierer=1.5;
    xZentrierer = d_inner/2+rZentrierer+.5;
    difference(){
        slipring();
        // so abschneiden, dass alle Loecher noch da sind
        translate([-sr_d/2,-sr_d,-.1]) cube([sr_d,sr_d,sr_d]);
        for(lauf=[0:sl_cnt-1]){
            translate([-xZentrierer,+.1,sr_z/2+lauf*sl_delta]) sphere(r=rZentrierer, $fn=50);
        }
    }
    for(lauf=[0:sl_cnt-1]){
        translate([xZentrierer,0,sr_z/2+lauf*sl_delta]) sphere(r=rZentrierer, $fn=50);
    }
}

module holder(){
    for(lauf=[0:sl_cnt-1]) translate([0,0,lauf*sl_delta]){
        difference(){
            union(){
                // die Fuehrung fuer die Kohlen
                translate([0,-h_y/2,.5]) difference(){
                    cube([sl[0]-.2,h_y,h_z]);
                    translate([-.1,w_housing,w_housing]){
                        cube(sl);
                        // an einer Seite ein Loch um die Kohle einzusetzen
                        translate([0,3,0])cube([slBlack+w_housing,sl[1],sl[2]]);
                    }
                }
                // die Platte an der Kontaktseite
                translate([-w_housing,-h_y/2,+.5])difference(){
                    cube([w_housing,h_y,h_z]);
                    rad=sl[1]-1;
                    translate([-.1,h_y/2,h_z/2])rotate([90,0,90])cylinder(h=w_housing+.2, d=rad);
                }
            }
            // die Luecke fuer die Metallplatte
            radH = sl[1]+3;
            translate([-.1,0,h_z/2])rotate([90,0,90])cylinder(h=2, d=radH);
        }
    }
    bFuss =40;
    translate([-w_housing,-bFuss/2,0]) cube([sl[0]+w_housing,bFuss,2]);
}

if(showSlipring=="on") slipring();
if(showAxis=="on") color("grey") translate([0,0,-50]) cylinder(d=d_inner, h=100);
if(showSlipringHalf=="on") slipringHalf();
if(showSlip=="on") translate([sr_d/2+3,0,0]) holder();
