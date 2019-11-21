
// разные датчики

use <descrete.scad>

//sonar();
//ir_line_sensor();

all_sensors();

/**
 * Все компоненты из модуля sensors
 */
module all_sensors() {
    sonar();
    translate([40, 0, 0]) ir_line_sensor();
}


/**
 * Сонар
 */
module sonar() {
    // "глаз" сонара - цилиндр
    module sonar_eye() {
        difference() {
            cylinder(r=8, h=12, $fn=100);
            translate([0, 0, 11]) cylinder(r=6, h=1+0.1, $fn=100);
        }
    }

    // плата
    translate([0, 0, 1]) cube([45, 20, 2], center=true);

    // глаза сонара
    translate([-13, 0, 2]) sonar_eye();
    translate([13, 0, 2]) sonar_eye();

    // штыри
    translate([0, -7.5, 0]) mirror([0, 0, -1]) pin_row_bended(count=4, center=true);
}

/**
 * Инфракрасный датчик линии
 */
module ir_line_sensor() {    
    // плата
    difference() {
        translate([-7, 0, 0]) cube([14, 31, 2]);

        translate([0, 7, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
    }

    // подстроечный резистор
    translate([0, 12, 2]) trimming_resistor();

    // штыри
    translate([0, 2.5/2, 2]) pin_row_bended(count=3, center=true);

    // лампочки
    translate([3.5, 31.5, 2.5]) rotate([-90, 0, 0]) led_head();
    translate([-3.5, 31.5, 2.5]) rotate([-90, 0, 0]) led_head();
}
