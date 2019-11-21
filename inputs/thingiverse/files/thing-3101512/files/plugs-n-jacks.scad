
// разъемы и штекеры

use <2d_points/2d_points.scad>

//head_pin();
//u_shape_terminal();
//socket_bls(count=3);
//power_plug_jack();
//usb_a_plug();
//usb_b_plug();

all_plugs_n_jacks();

/**
 * Все компоненты из модуля plugs_n_jacks
 */
module all_plugs_n_jacks() {
    head_pin();
    translate([20, 0, 0]) u_shape_terminal();
    translate([40, 0, 0]) socket_bls(count=3);
    translate([60, 0, 0]) power_plug_jack();
    translate([80, 0, 0]) usb_a_plug();
    translate([100, 0, 0]) usb_b_plug();
}

/**
 * Металлический штырь внутри резиновой головки
 */
module head_pin() {
    // силиконовая головка
    cylinder(r=1.5, h=10, $fn=100);
    sphere(r=1.5, $fn=100);
    translate([0,0,10]) sphere(r=1.5, $fn=100);

    // штырь
    cylinder(r=0.5, h=19, $fn=100);
}

/**
 * Гнездо BLS - ряд.
 * 
 * @param count количество гнезд в ряду
 */
module socket_bls(count=1) {
    module single_bls() {
        difference() {
            cube([2, 2, 13]);

            // отверстие внутри
            translate([0.5, 0.5, -0.1]) cube([1, 1, 13+0.2]);

            // небольшой паз сбоку
            translate([-0.1, -0.1, 5]) cube([2+0.2, .2+0.1, 5]);

            // окошко сбоку
            translate([0.2, -0.1, 5+3+0.2]) cube([1.6,1.5+0.1,1.6]);
        }

        // защелка в боковом пазу
        translate([0.4, 0, 5]) cube([1.2, .2, 3]);
    }

    bls_width = 2;
    for(i = [0 : count-1]) {
        translate([(bls_width+1)*i, 0, 0]) single_bls();
        if(i != count-1) {
            translate([(bls_width+1)*(i+1) - 1, 0, 0]) cube([1, 2, 13]);
        }
    }
}

/**
 * Обжимная U-образная клемма.
 */
module u_shape_terminal() {
    // термоусадка
    translate([-1.5,0,0]) cylinder(r=1, h=8, $fn=100);
    translate([-1.5,0,0]) sphere(r=1, $fn=100);

    translate([1.5,0,0]) cylinder(r=1, h=8, $fn=100);
    translate([1.5,0,0]) sphere(r=1, $fn=100);

    translate([-1.5,-1,0]) cube([3, 2, 8]);
    translate([-1.5,0,0]) rotate([0,90,0]) cylinder(h=3, r=1, $fn=100);

    // клемма
    segments = [
        // право,  против часовой стрелки
        [[1.5, 0], [1.67, 0], [2, 0.21], [2, 0.5]], // право низ
        [[2, 0.5], [2, 9]], // вверх
        [[2, 9], [2.15, 9.11], [3, 9.5], [3, 10]],
        [[3, 10], [3, 15.5]], // вверх
        [[3, 15.5], [3, 15.75], [2.75, 16], [2.5, 16]],
        [[2.5, 16], [2, 16]], // правая макушка
        [[2, 16], [1.75, 16], [1.5, 15.75], [1.5, 15.5]],
        [[1.5, 15.5], [1.5, 11.5]], // вниз
        [[1.5, 11.5], [1.5, 10.66], [0.84, 10], [0, 10]],
        // лево
        [[0, 10], [-0.84, 10], [-1.5, 10.66], [-1.5, 11.5]],
        [[-1.5, 11.5], [-1.5, 15.5]], // вверх
        [[-1.5, 15.5], [-1.5, 15.75], [-1.75, 16], [-2, 16]],
        [[-2, 16], [-2.5, 16]], // левая макушка
        [[-2.5, 16], [-2.75, 16], [-3, 15.75], [-3, 15.5]],
        [[-3, 15.5], [-3, 10]], // вниз
        [[-3, 10], [-3, 9.5], [-2.15, 9.11], [-2, 9]],
        [[-2, 9], [-2, 0.5]], // вниз
        [[-2, 0.5], [-2, 0.21], [-1.67, 0], [-1.5, 0]], // лево низ
        [[-1.5, 0], [1.5, 0]] // низ
    ];
    //color([0.4,0.4,0.9]) linear_extrude(height=1) polygon(segments[0]);
    
    rotate([90,0,0]) linear_extrude(height=1, center=true)
        polygon(polybezier_points(segments));
}

/**
 * Штекер питания (вариант для Arduino)
 */
module power_plug_jack() {
    // "жгутик"
    difference() {
        cylinder(r=3, h=13, $fn=100);
        translate([0,0,-0.1]) cylinder(r=2.5, h=13+0.2, $fn=100);
    }

    // корпус
    translate([0,0,13]) cylinder(r=5, h=20, $fn=8);
    translate([0,0,11]) cylinder(r=4.5, h=2, $fn=100);

    // штекер
    translate([0,0,13+20]) difference() {
        union() {
            cylinder(r=2.5, h=12, $fn=100);
            translate([0, 0, 12]) sphere(r=2.5, $fn=100);
        }

        // срезать макушку
        translate([0, 0, 12+1.5]) cylinder(r=3, h=3);

        // отверстие внутри
        cylinder(r=1, h=15, $fn=100);
    }
}

/**
 * Штекер USB-A
 */
module usb_a_plug() {
    // "жгутик"
    difference() {
        cylinder(r=7/2, h=11, $fn=100);
        translate([0, 0, -0.1]) cylinder(r=2.5, h=13+0.2, $fn=100);
    }

    // корпус
    translate([0, 0, 11+20/2]) cube([17, 7, 20], center=true);

    // штекер
    translate([0, 0, 11+20]) {
        difference() {
            translate([0, 0, 15/2]) cube([12, 4, 15], center=true);

            // всё внутри
            translate([0, 0, 15/2]) cube([12-0.4, 4-0.4, 15+0.2], center=true);

            // еще две пары квадратных дырок сверхи и снизу для антуражу
            translate([3, 0, 7+2/2]) cube([2.5, 14+0.2, 2], center=true);
            translate([-3, 0, 7+2/2]) cube([2.5, 14+0.2, 2], center=true);
        }
        // пластмасска внутри
        translate([0, -4/2+0.2+1.5/2, 15/2-0.2]) cube([12-0.4, 1.5, 15-0.2], center=true);
    }
}

/**
 * Штекер USB-B
 */
module usb_b_plug() {
    // "жгутик"
    difference() {
        cylinder(r=7/2, h=11, $fn=100);
        translate([0, 0, -0.1]) cylinder(r=2.5, h=13+0.2, $fn=100);
    }

    // корпус
    translate([0, 0, 11+20/2]) cube([11, 10, 20], center=true);

    // штекер
    translate([0, 0, 11+20]) difference() {
        linear_extrude(height=15) 
            polygon([ 
                [-8/2,-7/2], [-8/2, -7/2+5], [-8/2+2, -7/2+5+2],
                [8/2-2, -7/2+5+2], [8/2, -7/2+5], [8/2,-7/2]
            ]);

        // всё внутри
        translate([0, 0, 15/2]) cube([6, 3, 15+0.2], center=true);
    }
}
