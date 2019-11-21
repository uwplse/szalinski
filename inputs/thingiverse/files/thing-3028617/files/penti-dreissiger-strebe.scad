// die penti strebe wird aus einer pyramide geschnitten
// d.h. von der pyrmide werden drei platten abgezogen
// die pyramide konstruiert sich aus den gegebenen winkeln
// die platten berechnen sich aus den dimensionen der streben

// Lenght of outer edge
leng = 22; // [1:100]
// Width of beam
widt = 6; // [1:10]
// Height of beam
heig = 6; // [1:10]

module strebe (leng, widt, heig) {
    // platten(widt, leng);
    difference() {
        pyra(leng);
        platten(widt, leng);
        deckel(heig, leng);
    }
}

module pyra(leng) { // leng ist f
    // https://www.matheretter.de/rechner/raute/
    // alpha ist 116.6
    // ergibt ein e von 161.91 bei einem f von 100
    otherleng = leng * 1.6191;
    // dreieck mit seitenwinkeln 69.1 gibt spitzwinkel von 41.8
    // grundlinie 100 --> hoehe von 130.9
    heiglen = leng * 1.309;
    points = [
        [ leng/2, 0, 0 ], // A 0
        [ leng, otherleng/2, 0 ], // B 1
        [ leng/2, otherleng, 0 ], // C 2
        [ 0, otherleng/2, 0 ], // D 3
        [ leng/2, otherleng/2, heiglen ] // E 4
    ];
    faces = [
        [1,2,3], // boden N
        [1,3,0], // boden S
        [2,4,3], // N
        [1,4,2], // O
        [0,4,1], // S
        [0,3,4] // W
    ];
    translate([-leng/2,-otherleng/2,0])
        polyhedron(points, faces, 1);
    
}

module platten(widt, leng) {
   translate([-leng/2, widt/2, -1])
       cube([leng, leng, leng]);
    rotate(180)
    translate([-leng/2, widt/2, -1])
       cube([leng, leng, leng]);
}

module deckel(heig, leng) {
    translate([-leng/2, -leng/2, heig])
       cube([leng, leng, leng*2]);
}

strebe(leng, widt, heig);