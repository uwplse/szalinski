

// The diameter of the rod
stangendurchmesser = 10;
// The diameter of the hole
lochdurchmesser = 16.5;
// Hight of the object
objekthoehe = 21;
// Hight of the lower base
sockelhoehe = 4.8;
// Diameter of the screw thread
gewindedurchmesser = 4;
// Height of the screw head
schraubkopfhoehe = 3;
// diameter of the screw head
schraubkopfdurchmesser = 7.6;

difference(){
clip(stangendurchmesser, lochdurchmesser, objekthoehe, sockelhoehe);

senkkopfbohrung(objekthoehe, gewindedurchmesser, schraubkopfhoehe, schraubkopfdurchmesser, sockelhoehe);
}




module clip(stangendurchmesser, lochdurchmesser, hoehe=23, sockelhoehe=4.8){
    $fn=200;
    radius = lochdurchmesser / 2;
    stangenradius = stangendurchmesser /2;
    difference(){
        
        
        //Grundkörper
        cylinder(h=hoehe, r1=radius, r2=radius);
        
        translate([lochdurchmesser*0.9,0,sockelhoehe]){
            cylinder(h=23, r1=radius, r2=radius);
        }
        
        translate([lochdurchmesser*-0.9,0,sockelhoehe]){
            cylinder(h=23, r1=radius, r2=radius);
        }
        kerbe(stangendurchmesser,sockelhoehe);
        
       // Einrastung
        translate([0,lochdurchmesser/2+1,stangenradius+sockelhoehe+2])
        rotate([90,0,0]){
            cylinder(lochdurchmesser+2, r1=stangenradius+0.5, r2=stangenradius+0.5);
        }        

    }
    
            
    
}

module senkkopfbohrung(objekthoehe, gewindedurchmesser, schraubkopfhoehe, schraubkopfdurchmesser, sockelhoehe){
    $fn=200;
    radius = gewindedurchmesser / 2;

    translate([0,0,-1]) cylinder(h=objekthoehe+2, r1=radius, r2=radius);

    translate([0,0, sockelhoehe-schraubkopfhoehe])
    cylinder(h=schraubkopfhoehe, r1=gewindedurchmesser/2, r2=schraubkopfdurchmesser/2);
    translate([0,0,sockelhoehe])
    cylinder(h=objekthoehe, r1=schraubkopfdurchmesser/2, r2=schraubkopfdurchmesser/2);
}


module kerbe(durchmesser, sockelhoehe){
    $fn=200;
    rotate([0,0,90]){
    kerbenbreite=30;
    kerbenhoehe=20;
    radius = durchmesser /2;
    translate([0,0,radius+sockelhoehe]){
    rotate([0,90,0]){
        cylinder(h=kerbenbreite, r1=radius, r2=radius, center=true);
        }
    }
    translate([kerbenbreite*-0.5, -radius,sockelhoehe+radius])
    cube([kerbenbreite,durchmesser,kerbenhoehe]);
}
}