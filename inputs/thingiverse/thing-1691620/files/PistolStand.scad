base_length = 211;
pillar_length = 29;
pillar_width = 22;
pillar_height = 100;
slot_length = 140;
slot_width = 22;

module plate () {difference () {
        translate ([0, -47.5, 0]){cube ([base_length, 95, 25]);}
        translate ([73, -11, 15])cube ([slot_length, slot_width, 11]);
        rotate(a=45, v=[1, 0, 0])translate ([-2, 40, -30])cube ([215, 40, 40]);
rotate(a=45, v=[1, 0, 0])translate ([-2, -40, 40])cube ([215, 40, 40]);
translate ([170, -50, 50])rotate(a=45, v=[0, 1, 0])cube ([100,100,50]);
}}
module base() {union(){plate();rotate(a=15, v=[0, 1, 0])translate ([10, -10, 15])cube ([pillar_length, pillar_width, pillar_height]);}}
base();