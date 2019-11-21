
// гнезда и разъемы - размещение на панели (panel mount)

use <2d_points/2d_points.scad>
use <descrete.scad>

//on_off_btn_pm(shadow=false);
//power_socket_pm(shadow=false);
//power_socket_with_button_pm(on=true, skirt=false, shadow=false);
// power_socket_with_button_pm(on=true, skirt=true, shadow=false);
//usb_b_socket_pm(shadow=false);

all_panel_mount();

/**
 * Все компоненты из модуля panel-mount
 */
module all_panel_mount() {
    on_off_btn_pm(shadow=false);
    translate([40, 0, 0]) power_socket_pm(shadow=false);
    translate([90, 0, 0]) power_socket_with_button_pm(on=true, skirt=false, shadow=false);
    translate([150, 0, 0]) power_socket_with_button_pm(on=true, skirt=true, shadow=false);
    translate([210, 0, 0]) usb_b_socket_pm(shadow=false);
}

/** 
 * Штырь в гнезде для штекера питания.
 * 
 * @param h высота
 */
module _plug_pin(h=20) {
    translate([0, 0, (h-3)/2]) cube([2, 4, h-3], center=true);
    // кончик
    // 2*4^2=x^2; x^2=32; x=sqrt(32)
    translate([0, 0, h-3]) scale([0.5, 1, 1]) rotate([0, 0, 45]) cylinder(d1=sqrt(32), d2=2, h=3, $fn=4);
    //подставка
    linear_extrude(height=2) polygon(rect_points([5, 7], r=1, center=true));
}

/**
 * Контактная площадка на обратной стороне гнезда питания.
 * 
 * @param h высота
 */
module _contact_plate(h=10) {
    translate([0, 0, -h/2]) difference() {
        cube([5, 1, 10], center=true);
        translate([0, 1/2+0.1, -1]) rotate([90, 0, 0]) cylinder(r=1, h=1.2, $fn=100);
    }
}

/**
 * Кнопка включить-выключить.
 * 
 * @param on true - включено, false - выключено
 * @param shadow
 *     true: рисовать только "тень" компонента - контур отверстия в панели
 *     false: рисовать сам компонент
 *     (по умолчанию: false)
 * @param shadow_h высота "тени"
 *     (по умолчанию: 3+0.2)
 */
module on_off_btn_pm(on=true, shadow=false, shadow_h=3+0.2) {
    // кнопка-переключатель
    module _btn() {
        difference() {
            cube([14.4, 9, 5], center=true);
            translate([0, 9/2+0.1, 30+1.5]) rotate([90, 0, 0]) cylinder(h=9+0.2, r=30, $fn=300);
        }
    }
    
    if(!shadow) {
        // корпус
        difference() {
            union() {
                // ободок сверху
                translate([0, 0, 1]) cube([20, 14, 2], center=true);
                // основной блок
                translate([0, 0, -13/2]) cube([17, 12, 13], center=true);
            }
            
            // колодец для кнопки
            translate([0, 0, -(12+2+0.1)/2+2+0.1]) cube([15.5, 9+0.2, 12+2+0.1], center=true);
        }
        
        // контактные площадки
        translate([0, 0, -12]) rotate([0, 0, 90]) _contact_plate();
        translate([6.5, 0, -12]) rotate([0, 0, 90]) _contact_plate();
        translate([-6.5, 0, -12]) rotate([0, 0, 90]) _contact_plate();
        
        // переключатель 
        rotate([0, (on ? 10 : -10), 0]) translate([0, 0, 1]) _btn();
    } else {
        // "тень" - контур отверстия в панели
        translate([0, 0, -shadow_h+0.1]) {
            translate([0, 0, shadow_h/2]) cube([16, 12, shadow_h], center=true);
        }
    }
}

/**
 * Гнездо для штекера питания (размещение на панели).
 * 
 * @param shadow
 *     true: рисовать только "тень" компонента - контур отверстия в панели
 *     false: рисовать сам компонент
 *     (по умолчанию: false)
 * @param shadow_h высота "тени"
 *     (по умолчанию: 3+0.2)
 */
module power_socket_pm(shadow=false, shadow_h=3+0.2) {
    if(!shadow) {
        // внешний вид гнезда
        translate([0, 0, -20+3]) difference() {
            union() {
                linear_extrude(height=20) polygon([
                    // лево
                    [-13.5+6, 9.5], [-13.5, 9.5-6], [-13.5, -9.5],  
                    // право
                    [13.5, -9.5], [13.5, 9.5-6], [13.5-6, 9.5]
                ]);
                // лицевая сторона на панель
                translate([0, 0, 20-3]) linear_extrude(height=3) polygon(
                    rect_points([30, 24], r=1.5, center=true)
                );
            }
            // гнездо для штекера
            translate([0, 0, 1.5]) linear_extrude(height=20-1.5+0.1) polygon([
                // лево
                [-12+5, 8], [-12, 8-5], [-12, -8],  
                // право
                [12, -8], [12, 8-5], [12-5, 8]
            ]);
        }
        
        // штыри вилки
        translate([0, 3, -20+1.5+2]) _plug_pin(20-2);
        translate([8, -2, -20+1.5+2]) _plug_pin(20-5);
        translate([-8, -2, -20+1.5+2]) _plug_pin(20-5);
        
        // контактные площадки
        translate([0, 3, -20+3]) rotate([0, 0, 90]) _contact_plate();
        translate([8, -2, -20+3]) rotate([0, 0, 90]) _contact_plate();
        translate([-8, -2, -20+3]) rotate([0, 0, 90]) _contact_plate();
        
    } else {
        // "тень" - контур отверстия в панели
        translate([0, 0, -shadow_h+0.1]) linear_extrude(height=shadow_h) polygon([
            // лево
            [-13.5+6, 9.5], [-13.5, 9.5-6], [-13.5, -9.5],  
            // право
            [13.5, -9.5], [13.5, 9.5-6], [13.5-6, 9.5]
        ]);
    }
}

/**
 * Гнездо для штекера питания с выключателем (размещение на панели).
 * 
 * @param on true - включено, false - выключено
 * @param skirt рисовать шестиугольную "юбку" с отверстиями для винтов
 *     true: рисовать, false: не рисовать (по умолчанию: true)
 * @param shadow
 *     true: рисовать только "тень" компонента - контур отверстия в панели
 *     false: рисовать сам компонент
 *     (по умолчанию: false)
 * @param shadow_h высота "тени"
 *     (по умолчанию: 3+0.2)
 */
module power_socket_with_button_pm(on=true, skirt=true, shadow=false, shadow_h=3+0.2) {
    if(!shadow) {
        // внешний вид гнезда
        translate([0, 0, -20+2.5]) difference() {
            union() {
                // основной блок
                linear_extrude(height=20) polygon([
                    // лево
                    [-13.5+6, 9.5], [-13.5, 9.5-6], [-13.5, -37.5],  
                    // право
                    [13.5, -37.5], [13.5, 9.5-6], [13.5-6, 9.5]
                ]);
                
                // лицевая сторона на панель
                translate([0, -14.5, 18-0.5]) {
                    if(skirt) {
                        // шестиугольник со скругленными углами
                        linear_extrude(height=2) polygon(polybezier_points([
                            // левый верхний скругленный угол
                            [[-10, 29], [-13, 29], [-14.4, 28], [-15.5, 25]],
                            [[-15.5, 25], [-23.5, 4]],
                            // лево
                            [[-23.5, 4], [-24.6, 1], [-24.6, -1], [-23.5, -4]],
                            [[-23.5, -4], [-15.5, -25]],
                            // левый нижний скругленный угол
                            [[-15.5, -25], [-14.4, -28], [-13, -29], [-10, -29]],
                            [[-10, -29], [10, -29]],
                            // правый нижний скругленный угол
                            [[10, -29], [13, -29], [14.4, -28], [15.5, -25]],
                            [[15.5, -25], [23.5, -4]],
                            // право
                            [[23.5, -4], [24.6, -1], [24.6, 1], [23.5, 4]],
                            [[23.5, 4], [15.5, 25]],
                            // правый верхний скругленный угол
                            [[15.5, 25], [14.4, 28], [13, 29], [10, 29]],
                            [[10, 29], [-10, 29]]
                        ]));
                    }
                    
                    // оконтовка - выступающий прямоугольник со скругленными углами
                    linear_extrude(height=2.5) polygon(
                        rect_points([28, 54], r=2, center=true)
                    );
                }
            }
            // гнездо для штекера
            translate([0, 0, 1.5]) linear_extrude(height=20-1.5+0.1) polygon([
                // лево
                [-12+5, 8], [-12, 8-5], [-12, -8],  
                // право
                [12, -8], [12, 8-5], [12-5, 8]
            ]);
            
            // гнездо для кнопки
            translate([0, -30, (2+0.1)/2 + 20-2]) cube([20.4, 14.4, 2+0.1], center=true);
            translate([0, -30, (1+0.2)/2 + 20-3-0.1]) cube([16, 12, 1+0.2], center=true);
            translate([0, -30, (17+0.1)/2 - 0.1]) cube([25, 13, 17+0.1], center=true);
            
            if(skirt) {
                // отверстия для винтов на "юбке"
                translate([-20, -14.5, 20-2.5-0.1]) cylinder(h=2+0.2, r=2, $fn=100);
                translate([-20, -14.5, 20-1.5]) cylinder(h=1+0.1, r1=2, r2=3, $fn=100);
                translate([20, -14.5, 20-2.5-0.1]) cylinder(h=2+0.2, r=2, $fn=100);
                translate([20, -14.5, 20-1.5]) cylinder(h=1+0.1, r1=2, r2=3, $fn=100);
            }
        }
        
        // штыри вилки
        translate([0, 3, -20+1.5+2.5]) _plug_pin(20-2);
        translate([8, -2, -20+1.5+2.5]) _plug_pin(20-5);
        translate([-8, -2, -20+1.5+2.5]) _plug_pin(20-5);
        
        // контактные площадки
        translate([0, 5, -20+2.5]) _contact_plate();
        translate([8, -6, -20+2.5]) _contact_plate();
        translate([8, -17, -20+2.5]) _contact_plate();
        
        // кнопка
        translate([0, -30, 0.5]) on_off_btn_pm(on=on);
        
    } else {
        // "тень" - контур отверстия в панели
        // основной блок
        translate([0, 0, -shadow_h+0.1]) {
            linear_extrude(height=shadow_h) polygon([
                // лево
                [-13.5+6, 9.5], [-13.5, 9.5-6], [-13.5, -37.5],  
                // право
                [13.5, -37.5], [13.5, 9.5-6], [13.5-6, 9.5]
            ]);
                
            // винты
            translate([-20, -14.5, 0]) cylinder(h=shadow_h, r=2, $fn=100);
            translate([20, -14.5, 0]) cylinder(h=shadow_h, r=2, $fn=100);
        }
    }
}

/**
 * Гнездо USB-B (размещение на панели).
 * (компонент располагается с внутренней стороны)
 * 
 * @param panel_h высота панели (для позиции по умочанию)
 * @param shadow
 *     true: рисовать только "тень" компонента - контур отверстия в панели
 *     false: рисовать сам компонент
 *     (по умолчанию: false)
 * @param shadow_h высота "тени"
 *     (по умолчанию: 3+0.2)
 */
module usb_b_socket_pm(panel_h=2, shadow=false, shadow_h=3+0.2) {
    // гнездо USB
    module _usb_b_socket() {
        translate([0, 0, -16]) difference() {
            // главный блок
            translate([0, 0, 8]) cube([12, 10, 16], center=true);
            
            // колодец
            translate([0, -4, 6]) linear_extrude(height=10+0.1) polygon([
                // лево
                [-5, 0], [-5, 6], [-5+2, 8],
                // право
                [5-2, 8], [5, 6], [5, 0]
            ]);
        }
        // язычок внутри
        translate([0, 0.5, -16 + 7.5]) cube([6, 3, 15], center=true);
    }
    if(!shadow) {
        translate([0, 0, -panel_h]) {
            difference() {
                union() {
                    // большой блок
                    translate([0, -13/2, -25/2]) rotate([-90, 0, 0]) linear_extrude(height=13)
                        polygon(rect_points([21, 25], r1=3, r2=3, center=true));
                    
                    // круглые ушки
                    translate([0, 0, -5]) linear_extrude(height=5)
                        polygon(rect_points([38, 11], r=5.5, center=true));
                    
                    // цилиндр снизу
                    translate([0, 0, -25-5]) cylinder(h=5, r=5, $fn=100);
                }
                
                // под гнездо USB
                translate([0, 0, 0.1]) cube([12, 10, 16+0.1], center=true);
                
                // дополнительная выемка наверху
                translate([0, 0, -(4+0.1)/2+0.1]) cube([16, 13+0.2, 4+0.1], center=true);
                
                // отверстия крепежа
                translate([15, 0, -5-0.1]) cylinder(r=1.5, h=5+0.2, $fn=100);
                translate([-15, 0, -5-0.1]) cylinder(r=1.5, h=5+0.2, $fn=100);
            }
            _usb_b_socket();
        }
    } else {
        translate([0, 0, -shadow_h+0.1]) {
            translate([0, 0, shadow_h/2]) cube([16, 13, shadow_h], center=true);
        
            // отверстия крепежа
            translate([15, 0, 0]) cylinder(r=1.5, h=shadow_h, $fn=100);
            translate([-15, 0, 0]) cylinder(r=1.5, h=shadow_h, $fn=100);
        }
    }
}

