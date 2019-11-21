use <microchips.scad>
use <descrete.scad>

//chipkit_uno32();
//arduino_uno();
//arduino_uno_china();
//cnc_shield(drivers=true, drivers_radiator=false);

all_arduino();

/**
 * Все компоненты из модуля arduino
 */
module all_arduino() {
    chipkit_uno32();
    translate([100, 0, 0]) arduino_uno();
    translate([200, 0, 0]) arduino_uno_china();
    translate([300, 0, 0])  cnc_shield(drivers=true, drivers_radiator=false);
}

/**
 * Плата Arduino Uno, классическая 
 * с чипом AVR в корпусе DIP
 * https://store.arduino.cc/usa/arduino-uno-rev3
 */
module arduino_uno() {
    size_x = 53;
    size_y = 68;

    // плата
    difference() {
        cube([size_x, size_y, 2]);

        // отверстия для винтов
        translate([7.5, 2.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([35.5, 2.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([2.5, 54.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([size_x-2.5, 53, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
    }

    // Analog In
    translate([1, 3, 2]) GPIO_socket(count_x=1, count_y=6); 

    // Power
    translate([1, 3+2.54*6+2, 2]) GPIO_socket(count_x=1, count_y=8); 

    // GPIO
    translate([size_x-2.54-1, 3, 2]) GPIO_socket(count_x=1, count_y=8);
    // GPIO
    translate([size_x-2.54-1, 3+2.54*8+1.5, 2]) GPIO_socket(count_x=1, count_y=10);

    // чип AVR
    translate([17, 3, 8]) chip_dip(legs=14);
    // в кроватке
    difference() {
        translate([12.5, 2.5, 2-0.1]) cube([9, 35.5, 3]);
        translate([12.5+0.5, 2.5+0.5, 3]) cube([9-1, 35.5-1, 3]);
    }

    // питание
    translate([3, 57, 2]) power_jack_socket();

    // порт USB-B
    translate([30, 59, 2-0.1]) usb_b_socket();

    // кнопка Reset
    translate([45, 59, 2]) button();
}

/**
 * Плата Arduino Uno, безымянный китайский клон
 * с чипом AVR в корпусе SMD
 */
module arduino_uno_china() {
    size_x = 53;
    size_y = 68;

    // плата
    difference() {
        cube([size_x, size_y, 2]);

        // отверстия для винтов
        translate([7.5, 2.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([35.5, 2.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([2.5, 54.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([size_x-2.5, 53, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
    }

    // Analog In
    translate([1, 3, 2]) GPIO_socket(count_x=1, count_y=6); 

    // Power
    translate([1, 3+2.54*6+2, 2]) GPIO_socket(count_x=1, count_y=8); 

    // GPIO
    translate([size_x-2.54-1, 3, 2]) GPIO_socket(count_x=1, count_y=8);
    // GPIO
    translate([size_x-2.54-1, 3+2.54*8+1.5, 2]) GPIO_socket(count_x=1, count_y=10);

    // чип AVR
    translate([25, 25, 2]) chip_smd(dim_x=6, dim_y=6, pins_x=8, pins_y=8);

    // питание
    translate([3, 57, 2]) power_jack_socket();

    // порт USB-B
    translate([30, 59, 2-0.1]) usb_b_socket();

    // кнопка Reset
    translate([45, 59, 2]) button();
}

/**
 * Плата ChipKIT Uno32
 * https://chipkit.net/wiki/index.php?title=ChipKIT_Uno32
 */
module chipkit_uno32() {
    size_x = 53;
    size_y = 68;

    // плата
    difference() {
        cube([size_x, size_y, 2]);

        // отверстия для винтов
        translate([7.5, 2.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([35.5, 2.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([2.5, 54.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([size_x-2.5, 53, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
    }


    // J7 (Analog)
    translate([1, 3, 2]) GPIO_socket(count_x=2, count_y=6); 

    // J2 (питание)
    translate([1, 3+2.54*6+2, 2]) GPIO_socket(count_x=1, count_y=6); 

    // J6 (GPIO)
    translate([size_x-2.54*2-1, 3, 2]) GPIO_socket(count_x=2, count_y=8);
    // J5 (GPIO)
    translate([size_x-2.54*2-1, 3+2.54*8+1.5, 2]) GPIO_socket(count_x=2, count_y=8);
    
    // дополнительные гребенки с джамперами на чипките
    
    // JP8
    translate([13, 1, 2]) pin_row(count_x=3, count_y=1, pin_h=11, center=false);
    // JP6
    translate([13, 1+2.54, 2]) pin_row(count_x=3, count_y=1, pin_h=11, center=false);
    
    // J8
    translate([24, 1, 2]) pin_row(count_x=3, count_y=2, pin_h=11, center=false);
    
    // JP7
    translate([24, 13, 2]) pin_row(count_x=3, count_y=1, pin_h=11, center=false);
    // JP5
    translate([24, 13+2.54, 2]) pin_row(count_x=3, count_y=1, pin_h=11, center=false);
    
    // JP2
    translate([1, 42, 2]) pin_row(count_x=1, count_y=3, pin_h=11, center=false);
    
    // JP4
    translate([40, 27, 2]) pin_row(count_x=1, count_y=3, pin_h=11, center=false);
    

    // чип PIC32
    translate([22, 25, 2]) chip_smd(dim_x=10, dim_y=10, pins_x=15, pins_y=15);

    // питание
    translate([3, 57, 2]) power_jack_socket();

    // порт mini-USB
    translate([33, 59, 2-0.1]) mini_usb_socket();

    // кнопка Reset
    translate([45, 59, 2]) button();
}

/**
 * CNC Shield
 * https://www.reprap.me/arduino-cnc-shield.html
 *
 * @param drivers draw drivers
 *     true: draw drivers, false: don't draw drivers
 *     (default: true)
 * @param drivers_radiator draw radiators for drivers
 *     true: draw radiators, false: don't draw radiators
 *     (default: false)
 */
/**
 * Шилд CNC
 * https://www.reprap.me/arduino-cnc-shield.html
 *
 * @param drivers рисовать драйверы
 *     true: рисовать, false: не рисовать
 *     (по умолчанию: true)
 * @param drivers_radiator рисовать радиаторы на драйверах
 *     true: рисовать, false: не рисовать
 *     (по умолчанию: false)
 */
module cnc_shield(drivers=true, drivers_radiator=true) {
    module _step_dir_block() {
        translate([0, 0, 2]) GPIO_socket(count_x=8, count_y=1);
        translate([0, 12.5, 2]) GPIO_socket(count_x=8, count_y=1);
    }
    
    /**
     * Драйвер step-dir
     * @param radiator рисовать радиатор на чипе
     *     true: рисовать, false: не рисовать
     *     (по умолчанию: false)
     * @param radiator_angle угол поворота радиатора на чипе
     *     (по умолчанию: 0)
     */
    module _step_dir_driver(radiator=false, radiator_angle=0) {
        module _radiator() {
            translate([-9/2, -9/2, 0]) difference() {
                    cube([9, 9, 5]);
                    
                    translate([1, -0.1, 2]) cube([1, 9+0.2, 7+0.1]);
                    translate([3, -0.1, 2]) cube([1, 9+0.2, 7+0.1]);
                    translate([5, -0.1, 2]) cube([1, 9+0.2, 7+0.1]);
                    translate([7, -0.1, 2]) cube([1, 9+0.2, 7+0.1]);
                }
        }
        
        translate([0, 0, 2.5]) {
            cube([20.32, 15, 1.5]);
            
            // гребенки ножек
            mirror([0, 0, 1])
                pin_row(count_x=8, count_y=1, pin_h=11, center=false);
            translate([0, 15-2.54, 0]) mirror([0, 0, 1])
                pin_row(count_x=8, count_y=1, pin_h=11, center=false);
            
            // микрочип-драйвер
             translate([12, 3, 1.5])
                chip_smd(dim_x=4, dim_y=9, pins_x=0, pins_y=16, shift_y=0.2);
            
            // радиатор на чипе
            if(radiator) {
                translate([9.5+9/2, 3+9/2, 3.5]) rotate([0, 0, radiator_angle])
                    _radiator();
            }
        }
    }
    
    size_x = 53;
    size_y = 68;

    // плата
    difference() {
        //cube([size_x, size_y, 2]);
        linear_extrude(height=2) polygon([
            // нижняя граница с декоративными срезами
            [0, 2.5], [2.5, 2.5], [5, 0], [38, 0], [41, 2.5], [size_x, 2.5],
            [size_x, size_y], [0, size_y]
        ]);

        // отверстия для винтов
        translate([2.5, 54.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
        translate([size_x-2.5, 54.5, -0.1]) cylinder(r=1.5, h=2+0.2, $fn=100);
    }
    
    // ряд Analog In в шилд
    translate([1, 3, 0]) mirror([0, 0, 1])
        pin_row(count_x=1, pin_h=11, count_y=6); 

    // ряд Power в шилд
    translate([1, 3+2.54*6+2, 0]) mirror([0, 0, 1])
        pin_row(count_x=1, pin_h=11, count_y=6); 
    
    // ряд GPIO в шилд
    translate([size_x-2.54-1, 3, 0]) mirror([0, 0, 1])
        pin_row(count_x=1, count_y=8, pin_h=11, center=false);
    // ряд GPIO в шилд
    translate([size_x-2.54-1, 3+2.54*8+1.5, 0]) mirror([0, 0, 1])
        pin_row(count_x=1, count_y=8, pin_h=11, center=false);
    
    // A
    translate([4, 17, 0]) _step_dir_block();
    translate([4, 20.5, 2]) pin_row(count_x=2, count_y=3, pin_h=11, center=false);
    translate([9, 13.5, 2]) pin_row(count_x=4, count_y=1, pin_h=11, center=false);
    if(drivers) {
        translate([4, 17, 10.2]) _step_dir_driver(radiator=drivers_radiator);
    }
    
    // Z
    translate([4, 38, 0]) _step_dir_block();
    translate([4, 41.5, 2]) pin_row(count_x=2, count_y=3, pin_h=11, center=false);
    translate([9, 34.5, 2]) pin_row(count_x=4, count_y=1, pin_h=11, center=false);
    if(drivers) {
        translate([4, 38, 10.2]) _step_dir_driver(radiator=drivers_radiator);
    }
    
    // Y
    translate([28, 17, 0]) _step_dir_block();
    translate([28, 20.5, 2]) pin_row(count_x=2, count_y=3, pin_h=11, center=false);
    translate([34, 13.5, 2]) pin_row(count_x=4, count_y=1, pin_h=11, center=false);
    if(drivers) {
        translate([28, 17, 10.2]) _step_dir_driver(radiator=drivers_radiator);
    }
    
    // X
    translate([28, 38, 0]) _step_dir_block();
    translate([28, 41.5, 2]) pin_row(count_x=2, count_y=3, pin_h=11, center=false);
    translate([34, 34.5, 2]) pin_row(count_x=4, count_y=1, pin_h=11, center=false);
    if(drivers) {
        translate([28, 38, 10.2]) _step_dir_driver(radiator=drivers_radiator);
    }
    
    // 2 длинные гребенки сзади
    translate([5, 1, 2]) pin_row(count_x=13, count_y=1, pin_h=11, center=false);
    translate([5, 1+2.54, 2]) pin_row(count_x=13, count_y=1, pin_h=11, center=false);
    
    // 2 коротки гребенки сзади
    translate([38.2, 5, 2]) pin_row(count_x=4, count_y=1, pin_h=11, center=false);
    translate([38.2, 5+2.54, 2]) pin_row(count_x=4, count_y=1, pin_h=11, center=false);

    // питание
    translate([10, 58+5*2, 2]) rotate([0, 0, -90]) screw_terminal(count=2, center=false);
    
    // 2 двойные гребенки рядом с питанием
    translate([19, 56, 2]) pin_row(count_x=4, count_y=2, pin_h=11, center=false);
    translate([19, 56+2.54*2, 2]) pin_row(count_x=4, count_y=2, pin_h=11, center=false);
    
    // еще две средние гребенки рядом с кнопкой Reset
    translate([29, 53, 2]) pin_row(count_x=6, count_y=1, pin_h=11, center=false);
    translate([29, 53+2.54, 2]) pin_row(count_x=6, count_y=1, pin_h=11, center=false);
    

    // кнопка Reset
    translate([45, 59, 2]) button();
}

