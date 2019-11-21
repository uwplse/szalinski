radius = 12;
latticeWidth = 4;
latticeLength = 3;
spacing = 10;
height = 1;

difference() {   
    linear_extrude(height) {
        for(j = [0:latticeWidth-1]) {
            translate([(((sqrt(3)*radius)+spacing)/2)*(j%2),sqrt(pow((((((sqrt(3)))*radius)+spacing)),2)-(pow(((((sqrt(3)*radius)+spacing))/2),2)))*j,0]) {
                for(i = [0:latticeLength-1]) {
                    translate([((sqrt(3)*radius*i)+spacing*i),0,0]) {
                        rotate([0,0,30]) {
                            circle(((sqrt(3)*radius)+(spacing*2))/sqrt(3), $fn = 6);
                        }
                    }
                }
            }
        }
    }
    linear_extrude(height) {
        for(j = [0:latticeWidth-1]) {
            translate([((sqrt(3)*radius)+spacing)/2*(j%2),sqrt((pow(((sqrt(3)*radius)+spacing),2))-(pow((((sqrt(3)*radius)+spacing))/2,2)))*j,0]) {
                for(i = [0:latticeLength-1]) {
                    translate([(sqrt(3)*radius*i)+spacing*i,0,0]) {
                        rotate([0,0,30]) {
                            circle(radius, $fn = 6);
                        }
                    }
                }
            }
        }
    }
}