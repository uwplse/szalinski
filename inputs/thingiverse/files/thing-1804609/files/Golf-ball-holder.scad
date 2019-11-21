$fn=100;

numberOfGolfBalls = 6;
sizeOfScrews = 4;

module backside(){
    translate([-25.5,-25.0,-27.5])cube([1,48.0,48.0]);
}

module holder() {
    cube_size = 550;
    rotate([0,45,0])difference() {
      sphere(r = 46.5/2);
      sphere(r = 44/2);
      translate([-cube_size/2, -cube_size/2, 0])cube(cube_size);
    }
}

module backsideRow() {
    for (a =[0:50:(numberOfGolfBalls - 1) * 50]){ 
        translate([0,a,0])backside();
    }
}

module holderRow() {
    for (a =[0:50:(numberOfGolfBalls - 1) * 50]){ 
        translate([0,a,0])holder();
    }
}

module hulim(){
    hull(){
        backsideRow();
        holderRow();
    }
}

module holes(){
    difference(){    
        hulim();
            for (a =[0:50:(numberOfGolfBalls - 1) * 50]){
                translate([0,a,0])sphere(43.5/2);
            }

            for (a =[0:(numberOfGolfBalls - 1) * 50:(numberOfGolfBalls - 1) * 50]){
                translate([-50,a,0])rotate([0,90,0])cylinder(h = 100, r = (sizeOfScrews / 2));
            }
    }
}

holes();

