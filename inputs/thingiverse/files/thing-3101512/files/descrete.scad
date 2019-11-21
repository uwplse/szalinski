
// дискрентые элементы (размещение на печатной плате)

use <2d_points/2d_points.scad>

//power_jack_socket();
//usb_b_socket();
//mini_usb_socket();
//button();
//trimming_resistor(val=15);
//screw_terminal(count=2, center=true);
//GPIO_socket(count_x=8, count_y=2, center=true);
//pin_row(count_x=8, count_y=2, center=true);
//pin_row_bended(count=4, center=true);
//led_head();

all_descrete();
//all_descrete2();

/**
 * Все компоненты из модуля descrete
 */
module all_descrete() {
    power_jack_socket();
    translate([30, 0,0]) usb_b_socket();
    translate([60, 0,0]) mini_usb_socket();
    translate([90, 0,0]) button();
    translate([120, 0,0]) trimming_resistor(val=15);
    translate([150, 0,0]) screw_terminal(count=2, center=true);
    translate([180, 0,0]) GPIO_socket(count_x=8, count_y=2);
    translate([230, 0,0]) pin_row(count_x=8, count_y=2, center=true);
    translate([270, 0,0]) pin_row_bended(count=8, center=true);
    translate([300, 0,0]) led_head();
}

/**
 * Все компоненты из модуля descrete
 */
module all_descrete2() {
    power_jack_socket();
    translate([30, 0,0]) usb_b_socket();
    translate([60, 0,0]) mini_usb_socket();
    translate([90, 0,0]) button();
    translate([120, 0,0]) trimming_resistor(val=15);
    translate([150, 0,0]) mirror([0, 1, 0]) screw_terminal(count=2, center=true);

    translate([0, 60,0]) GPIO_socket(count_x=8, count_y=2);
    translate([60, 60,0]) pin_row(count_x=8, count_y=2, center=true);
    translate([90, 60,0]) pin_row_bended(count=4, center=true);
    translate([120, 60,0]) rotate([-90, 0, 0]) led_head();
}

/**
 * Гнездо для штекера питания
 * 
 * @param draw_bottom_contacts рисовать контакты снизу
 *     true: рисовать, false: не рисовать
 *     (по умолчанию: true)
 */
module power_jack_socket(draw_bottom_contacts=true) {
    difference() { 
        union() {
            translate([0, 1, 0]) cube([8, 14, 7]);
            translate([4, 1, 4+3]) rotate([-90, 0, 0]) cylinder(r=4, h=14, $fn=100);
            translate([0, 1+14-3.5, 0]) cube([8, 3.5, 12]);

            // сзади пара хвостиков
            cube([2, 2, 3]);
            translate([6, 0, 0]) cube([2, 2, 3]);
        }

        // отверстие для штекера
        translate([4, 3+0.1, 4+3]) rotate([-90, 0, 0]) cylinder(r=3, h=13, $fn=100);
    }

    // штырь внутри гнезда
    translate([4, 0.5, 4+3]) rotate([-90, 0, 0]) cylinder(r=1, h=13.5, $fn=100);
    translate([4, 14, 4+3]) sphere(r=1, $fn=100);

    // контакты снизу
    if(draw_bottom_contacts) {
        // земля сбоку
        translate([-0.5, 3, -3]) cube([0.5, 2, 7]);
        translate([0, 4, -3]) rotate([0, -90, 0]) cylinder(r=1, h=0.5, $fn=100);

        // плюс сзади
        translate([3, 0.5, -3]) cube([2, 0.5, 10]);
        translate([4, 1, -3]) rotate([90, 0, 0]) cylinder(r=1, h=0.5, $fn=100);

        // и еще земля внизу посередине
        translate([3, 7.5, -3]) cube([2, 0.5, 4]);
        translate([4, 8, -3]) rotate([90, 0, 0]) cylinder(r=1, h=0.5, $fn=100);
    }
}

/**
 * Кнопка
 * 
 * @param draw_bottom_contacts рисовать контакты снизу
 *     true: рисовать, false: не рисовать
 *     (по умолчанию: true)
 */
module button(draw_bottom_contacts=true) {
    difference() {
        cube([6, 6, 4]);

        translate([3, 3, 2]) cylinder(r=2.2, h=2+0.1, $fn=100);
    }

    // кнопка
    translate([3, 3, 0]) cylinder(r=2, h=5, $fn=100);

    // выступающие крепления по углам
    translate([.8, .8, 0]) cylinder(r=.5, h=4.5, $fn=100);
    translate([6-.8, .8, 0]) cylinder(r=.5, h=4.5, $fn=100);
    translate([.8, 6-.8, 0]) cylinder(r=.5, h=4.5, $fn=100);
    translate([6-.8, 6-.8, 0]) cylinder(r=.5, h=4.5, $fn=100);

    // контакты снизу
    if(draw_bottom_contacts) {
        translate([0.5, -0.5, -3]) cube([1, .5, 4]);
        translate([6-1-0.5, -0.5, -3]) cube([1, .5, 4]);

        translate([0.5, 6, -3]) cube([1, .5, 4]);
        translate([6-1-0.5, 6, -3]) cube([1, .5, 4]);
    }
}

/**
 * Гнездо USB-B
 * 
 * @param draw_bottom_contacts рисовать контакты снизу
 *     true: рисовать, false: не рисовать
 *     (по умолчанию: true)
 */
module usb_b_socket(draw_bottom_contacts=true) {
    //cube([12, 16, 10]);
    rotate([-90, 0, 0]) mirror([0, -1, 0]) union() {
        difference() {
            cube([12, 10, 16]);

            translate([1, 1, 6]) linear_extrude(height=10+0.1)
                polygon([
                    [0, 0], [0, 6], [2, 8],
                    [10-2, 8], [10, 6], [10, 0]
                ]);
        }
        // язычок внутри
        translate([3, 4, 0]) cube([6, 3, 15]);

        // контакты снизу
        if(draw_bottom_contacts) {
            translate([-0.5, -3, 4]) cube([0.5, 4, 2]);
            translate([12, -3, 4]) cube([0.5, 4, 2]);
        }
    }
}

/**
 * Гнездо mini-USB
 */
module mini_usb_socket() {
    //cube([8, 10, 4]);
    translate([0, 0, 4]) rotate([-90,0,0]) union() {  
        difference() {
            linear_extrude(height=10)
                polygon([
                    [0, 0], [0, 3], [1, 4],
                    [10-1, 4], [10, 3], [10, 0]
                ]);
            translate([0, 0, 1]) linear_extrude(height=10)
                polygon([
                    [0.5, 0.5], [0.5, 3-0.5], [1+0.5, 4-0.5],
                    [10-1-0.5, 4-0.5], [10-0.5, 3-0.5], [10-0.5, 0.5]
                ]);
        }
        // язычок внутри
        translate([2, 1.5, 0]) cube([6, 1.5, 9]);

        // контактные уши
        cube([0.5, 4, 2]);
        translate([0, 0, 6]) cube([0.5, 4, 2]);

        translate([9.5, 0, 0]) cube([0.5, 4, 2]);
        translate([9.5, 0, 6]) cube([0.5, 4, 2]);
    }
}


/**
 * Головка светодиода с точащими снизу 2мя ножками
 * (она же может быть головкой инфракрасного излучателя,
 * приемника и любой другой лампочки такой же формы)
 */
module led_head() {
    cylinder(r=3, h=1, $fn=100);
    cylinder(r=2.5, h=7, $fn=100);
    translate([0, 0, 7]) sphere(r=2.5, $fn=100);
      
    // ножки
    // слева
    translate([-1.5, 0, -1.5]) cube([.5, .5, 3], center=true);
    translate([-1.5, 1.5, -3]) cube([.5, 3, .5], center=true);
    translate([-1.5, 0, -3]) 
        rotate([0, 90, 0]) cylinder(r=0.5/2, h=0.5, $fn=100, center=true);
      
    // справа
    translate([1.5, 0, -1.5]) cube([.5, .5, 3], center=true);
    translate([1.5, 1.5, -3]) cube([.5, 3, .5], center=true);
    translate([1.5, 0, -3]) 
        rotate([0, 90, 0]) cylinder(r=0.5/2, h=0.5, $fn=100, center=true);
}

/**
 * Подстроечный резистор.
 * 
 * @param val угол поворота подстроечной ручки
 */
module trimming_resistor(val=15) {
    difference() {
        cube([7, 7, 5]);
        translate([7/2, 7/2, 2]) cylinder(r=1.5+0.1, h=3+0.1, $fn=100);
    }

    // ручка настройки
    translate([7/2, 7/2, 2]) rotate([0, 0, val]) difference() {
        cylinder(r=1.5, h=3, $fn=100);

        // пазы
        translate([0, 0, 3-1/2]) cube([0.5, 3+0.1, 1+.1], center=true);
        translate([0, 0, 3-1/2]) cube([3+0.1, 0.5, 1+.1], center=true);
    }

    // ножки снизу
    translate([7/2-0.5/2, 7-1, -3]) cube([0.5, 0.5, 3]);
    translate([7/2-0.5/2, .5, -3]) cube([0.5, 0.5, 3]);
    translate([0.5, 7/2-0.5/2, -3]) cube([0.5, 0.5, 3]);
}

/**
 * Гнездо GPIO. Шаг 2.54 мм (0.1 дюйма).
 *
 * @param count_x количество элементов по оси x
 * @param count_y количество элементов по оси y
 * @param draw_bottom_contacts рисовать контакты снизу
 *     true: рисовать, false: не рисовать
 *     (по умолчанию: true)
 */
module GPIO_socket(count_x=8, count_y=1, draw_bottom_contacts=true) {
    module GPIO_single_socket() {
        difference() {
            cube([2.54, 2.54, 8]);

            // отверстие внутри
            translate([(2.54-1)/2, (2.54-1)/2, 1]) cube([1, 1, 7+0.1]);
        }

        if(draw_bottom_contacts) {
            // штырик снизу
            translate([(2.54-.5)/2, (2.54-.5)/2, -3]) cube([.5, .5, 3+.1]);
        }
    }

    socket_width = 2.54;
    for(i = [0 : count_x-1]) {
        for(j = [0 : count_y-1]) {
            translate([socket_width*i, socket_width*j, 0]) GPIO_single_socket();
        }
    }
}

/**
 * Гребенка пинов, шаг 2.54 мм (0.1 дюйма).
 * 
 * @param count_x количество элементов по оси x
 * @param count_y количество элементов по оси y
 * @param center центрировать по первому ряду ножек или по внешнему краю гребенки
 *     true: центрировать по первому ряду ножек
 *     false: ноль по внешнему краю гребенки
 */
module pin_row(count_x=8, count_y=1, pin_h=14, bottom_h=3, center=false) {
    // один пин
    module single_pin() {
        translate([0, 0, pin_h/2-3]) cube([0.7, 0.7, pin_h], center=true);

        // опора
        translate([0, 0, 2.5/2]) cube([2.54, 2, 2.5], center=true);
        translate([0, 0, 2.5/2]) cube([2, 2.54, 2.5], center=true);
    }

    // размножить нужное количество пинов с шагом 2.54 мм
    translate([
            center ? -2.54*count_x/2 +2.54/2 : 2.54/2, 
            center ? -2.54*count_y/2 +2.54/2 : 2.54/2,
            0])
        for(i = [0 : count_x-1]) {
            for(j = [0 : count_y-1]) {
                translate([2.54*i, 2.54*j, 0]) single_pin();
            }
        }
}

/**
 * Гребенка пинов, согнутых на 90 градусов, шаг 2.54 мм (0.1 дюйма).
 *
 * @param count количество элементов
 * @param center центрировать по ножкам или по внешнему краю гребенки
 *     true: центрировать по ножкам
 *     false: ноль по внешнему краю гребенки
 */
module pin_row_bended(count=8, center=false) {
    // один пин
    module single_pin() {
        translate([0, 0, 7/2-3]) cube([0.7, 0.7, 7], center=true);
        translate([0, -7/2, 7-3]) cube([0.7, 7, 0.7], center=true);
        translate([0, 0, 7-3]) rotate([0, 90, 0]) cylinder(r=0.7/2, h=0.7, $fn=100, center=true);

        // опора
        translate([0, 0, 2.5/2]) cube([2.54, 2, 2.5], center=true);
        translate([0, 0, 2.5/2]) cube([2, 2.54, 2.5], center=true);
    }

    // размножить нужное количество пинов с шагом 2.54 мм
    translate([center ? -2.54*count/2 +2.54/2 : 2.54/2, 0, 0])
        if(count > 0) for(i = [0 : count-1]) {
            translate([2.54*i, 0, 0]) single_pin();
        }
}

/**
 * Винтовой зажим (screw terminal).
 * (как на Arduino CNC Shield)
 * 
 * @param count количество элементов
 * @param center центрировать по ножкам или по внешнему краю блока
 *     true: центрировать по ножкам
 *     false: ноль по внешнему краю блока
 */
module screw_terminal(count=2, center=false) {
    module screw_head() {
        difference() {
            cylinder(r=2, h=3, $fn=100);

            // пазы
            translate([0, 0, 3-1/2]) cube([0.5, 4+0.1, 1+.1], center=true);
            translate([0, 0, 3-1/2]) cube([3, 0.5, 1+.1], center=true);
            translate([0, 0, 3-1]) cylinder(r1=.6, r2=1, h=1+0.1, $fn=100);
        }
    }
    
    // один зажим
    module single_terminal() {
        difference() {
            union() {
                cube([5, 8, 6]);
                translate([5, 0, 6]) rotate([0, -90, 0])
                    linear_extrude(height=5) polygon([[0,0], [0, 8], [3, 8-1.5], [3, 1.5]]);
            }
            
            // вход клеммы
            translate([0.5, -0.1, 0.5]) cube([4, 7+0.1, 5]);
            // винт сверху
            translate([2.5, 4, 6-0.5-0.1]) cylinder(r=2, h=3+0.5+0.2, $fn=100);
            // прорезь снизу
            translate([2, -0.1, -0.1]) cube([1, 4+0.1, 0.5+0.2]);
        }
        
        // винт
        translate([2.5, 4, 5]) rotate([0, 0, 20]) screw_head();
        
        // металлические клеммы внутри
        difference() {
            translate([0.5, 1, 0.5]) cube([4, 6, 5]);
            
            translate([1, 1.5, 1]) cube([3, 5, 4]);
            translate([2.5, 1-0.1, 3]) rotate([-90, 0, 0]) cylinder(r=1.5, h=0.5+0.2, $fn=100);
        }
        translate([1, 1, 6]) rotate([-100, 0, 0]) linear_extrude(height=4)
            polygon([[0, 0], [3, 0], [2.5, 2], [0.5, 2]]);

        // ножка снизу
        translate([2.5-0.5/2, 3.5, -3]) cube([0.5, 0.5, 4]);
    }

    difference() {
        // размножить нужное количество зажимов с шагом 5мм
        translate([center ? -5*count/2 : 0, 0, 0])
            if(count > 0) for(i = [0 : count-1]) {
                translate([5*i, 0, 0]) single_terminal();
            }
        
        // вырезать пазы между зажимами
        translate([center ? -5*count/2 : 0, 0, 0])
            if(count > 0) for(i = [0 : count-2]) {
                translate([5*i+4.75, 1.7, 6]) cube([0.5, 4.6, 3+0.1]);
            }
    }
}
