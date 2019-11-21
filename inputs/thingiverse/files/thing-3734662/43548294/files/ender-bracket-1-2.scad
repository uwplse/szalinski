//v1.2
length = 25;
width = 2;
// fine adjustment
A = 10;
B = 6;
C = 1.3;
D = 4;
E = 6;
module bracket(){
            translate([-width, A/2-E/2, 0]) cube([width, E, length]);
            linear_extrude(length){
                polygon([[0,0], [0,A], [C,A], [D,(A-B)/2+B], [D,(A-B)/2], [C,0]]);
            }
        }
bracket();