head = 5;
neck = 5;
body = 10;

module pawn(head, neck, body){
    translate([0,0,10]){sphere(head);}
    cylinder(body, neck);
}

pawn(5, 5, 10);