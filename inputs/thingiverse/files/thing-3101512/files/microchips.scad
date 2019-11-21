
// Микросхемы в корпусе DIP и SMD

// L293D - DIP
//chip_dip(legs=8);

// L393D - SMD
//chip_smd(dim_x=3, dim_y=4.6, pins_x=0, pins_y=8, shift_y=0.2);

// PIC32 с ChipKIT Uno32
//chip_smd(dim_x=10, dim_y=10, pins_x=15, pins_y=15);

// AVR с китайской ардуины
//chip_smd(dim_x=6, dim_y=6, pins_x=8, pins_y=8);

all_microchips();

/**
 * Все компоненты из модуля microchips
 */
module all_microchips() {
    // L293D - DIP
    chip_dip(legs=8);
    
    // L393D - SMD
    translate([10, 0, 0]) chip_smd(dim_x=3, dim_y=4.6, pins_x=0, pins_y=8, shift_y=0.2);

    // PIC32 с ChipKIT Uno32
    translate([20, 0, 0]) chip_smd(dim_x=10, dim_y=10, pins_x=15, pins_y=15);

    // AVR с китайской ардуины
    translate([40, 0, 0]) chip_smd(dim_x=6, dim_y=6, pins_x=8, pins_y=8);
}

/** 
 * Микросхема в корпусе DIP
 * 
 * @param legs количество ножек (с одной стороны) 
 */
module chip_dip(legs=4) {
    // размеры корпуса DIP из спецификаций, например отсюда
    // http://www.chipdip.ru/info/dip-package-import-integrated-circuits/

    leg_base_width = 1.52;
    leg_base_height = 4.65/2;
    leg_pin_width = 0.81;
    leg_pin_height = 3.4;
    leg_step = 2.54;

    box_width=6.3;
    box_length=leg_step*(legs-1)+leg_base_width;
    box_height=3;
    box_brow=.3;

    // нога
    module leg() {
        translate([0, -leg_base_width/2, -0.2]) cube([3, leg_base_width, 0.2]);
        rotate([0, 10, 0]) {
            translate([-.1, -leg_base_width/2, -leg_base_height]) 
                cube([0.2, leg_base_width, leg_base_height]);
            translate([-.1, -leg_pin_width/2, -leg_base_height-leg_pin_height]) 
                cube([0.2, leg_pin_width, leg_pin_height]);
        }
    }


    // корпус
    difference() {
        //translate([-box_width/2, -leg_base_width/2, -box_height]) 
        //  cube([box_width, box_length, box_height]);

        // корпус - "гробик"
        translate([-box_width/2, 0, -box_height])
            polyhedron(
                points = [
                    // основание
                    [0, 0, 0], [box_width, 0, 0], [box_width, box_length, 0], [0, box_length, 0], 
                    // середина
                    [-box_brow, 0, box_height/2], 
                    [box_width+box_brow, 0, box_height/2], 
                    [box_width+box_brow, box_length, box_height/2], 
                    [-box_brow, box_length, box_height/2], 
                    // верх
                    [0, 0, box_height], [box_width, 0, box_height], 
                    [box_width, box_length, box_height], [0, box_length, box_height]
                ], 
                faces = [
                    // основание
                    [0,1,2,3],
                    // нижний ряд
                    [0,4,5,1], [1,5,6,2], [2,6,7,3], [3,7,4,0],
                    // верхний ряд
                    [4,8,9,5], [5,9,10,6], [6,10,11,7], [7,11,8,4],
                    // верх
                    [11,10,9,8]
                ]
            );

        // полукруглая выемка
        translate([0, 0, -.5]) cylinder(h=4, r=1, $fn=100);

        // в общем, незачем (визуально важен полукруг, чтобы определить,
        // где верх, а полная аутентичность со всеми выемками и надписями 
        // не нужна)

        // круглая ямка
        //translate([1.6, 1.6, -.1]) cylinder(h=0.1+0.1, r=0.5, $fn=100);

        // еще одна круглая ямка
        //translate([0, box_length-2, -.1]) cylinder(h=0.1+0.1, r=1, $fn=100);
    }

    // ноги
    for(i = [0 : legs-1]) {
        translate([-box_width/2-box_brow-0.2, leg_base_width/2 + leg_step*i, -box_height/2]) leg();
        mirror([1,0,0])
            translate([-box_width/2-box_brow-0.2,, leg_base_width/2 + leg_step*i, -box_height/2]) leg();
    }
}

/**
 * Чип в корпусе SMD
 * 
 * @param dim_x ширина по x
 * @param dim_y ширина по y
 * @param pins_x количество ножек по x
 * @param pins_y количество ножек по y
 * @param shift_x отступ первой ножки по x
 * @param shift_y отступ первой ножки по y
 */
module chip_smd(dim_x=10, dim_y=10, pins_x=15, pins_y=15, shift_x=1, shift_y=1) {
    module pin() {
        translate([0, -0.5, 0]) cube([0.3, 0.5, 1]);
        translate([0, -2, 0]) cube([0.3, 2, 0.1]);
    }

    // чип  
    cube([dim_x, dim_y, 2]);

    // ножки по X
    if(pins_x > 0) for(i = [0:pins_x-1]) {
        translate([shift_x+(0.3+0.25)*i, 0, 0]) pin();
        translate([shift_x+(0.3+0.25)*i, dim_y, 0]) mirror([0, -1, 0]) pin();  
    }

    // ножки по Y
    if(pins_y > 0) for(i = [0:pins_y-1]) {
        translate([0, shift_y+(0.3+0.25)*i, 0]) 
            translate([0, 0.3, 0]) rotate([0, 0, -90]) pin();
        translate([dim_x, shift_y+(0.3+0.25)*i, 0]) mirror([-1, 0, 0]) 
            translate([0, 0.3, 0]) rotate([0, 0, -90]) pin();
    }
}
