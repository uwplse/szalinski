head = 3;
body = 10;
neck = 5;

module pawn (head,body,neck) {
    translate([0,0,0]){cylinder(body,neck, $fn=600);}
    translate([0,0,13]){sphere(head, $fn=600);}
}

pawn(3,10,5);
