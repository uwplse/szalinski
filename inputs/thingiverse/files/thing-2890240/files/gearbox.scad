
use <pd-gears/pd-gears.scad>

// Редуктор:
// - 3 ступени
// - количество зубцов:
//     ступень 1: 9-47
//     ступень 2: 12-47
//     ступень 3: 12-47
// - circular pitch для всех ступеней 1.5
// - pressure angle для всех ступеней 20
// 
// Положение шестеренок задается относительными углами поворота
// 
gb_gearbox(base=true, cover=true, gears=true,
    mirror_x=true, mirror_y=false,
    printed_rods=false,
    exit_base=true, exit_cover=false,
    tnum1=[9, 12, 12], tnum2=[47, 47, 47],
    cp=[1.5, 1.5, 1.5], pa=[20, 20, 20],
    holed1=[2, 2, 2], holed2=[2, 2, 2],
    h1=[9, 5, 5], h2=[3, 3, 3],
    a=[-25, 15, -15], stage1_c1=[0,0],
    rot2=[0, 0, 0],
    h2_gap=1, bottom_gap=0, top_gap=1,
    base_points=[[-54, -20], [-54, 10], [54, 10], [54, -20]],
    cover_points=[[-54, -20], [-54, 10], [54, 10], [54, -20]],
    base_h=3, cover_h=3,
    columns=[
        [0, -15],
        [49.5, -15], [49.5, 5],
        [-49.5, -15], [-49.5, 5]],
    base_color=[0.8, 0.5, 0.9], cover_color=[0.5, 0.7, 0.9], gears_color=[1, 1, 0.4],
    print_error=0.1, $fn=100);

// все шестеренки отдельно
for(i=[0:3]) {
    translate([i*30-40, 40, 0])
        gb_gear(tnum1=[9, 12, 12], tnum2=[47, 47, 47],
            cp=[1.5, 1.5, 1.5], pa=[20, 20, 20],
            holed1=[2, 2, 2], holed2=[2, 2, 2],
            h1=[9, 5, 5], h2=[3, 3, 3],
            rot2=[0, 0, 0],
            print_error=0.1, $fn=100,
            index=i);
}

/**
 * Найти координаты центра второй шестеренки на ступени редуктора.
 * 
 * @param tnum1 количество зубцов на шестеренке 1
 * @param tnum2 количество зубцов на шестеренке 2
 * @param cp circular pitch
 *     (по умолчанию: 1.5)
 * @param a угол поворота центра шестеренки 2 вокруг центра шестеренки 1
 *     (по умолчанию: 0)
 * @param c1 координаты центра шестеренки 1
 *     (по умолчанию: [0,0])
 * 
 * @return координаты [x, y] центра шестеренки 2
 */
function gb_find_center2(tnum1, tnum2, cp=1.5, a=0, c1=[0,0]) =
    [c1.x +
        (pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum1)+
        pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum2))*cos(a),
    c1.y +
        (pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum1)+
        pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum2))*sin(a)];

/**
 * Найти координаты центра второй шестеренки на
 * указанной ступени редуктора.
 * 
 * @param stage_n индекс ступени редкутора (отсчет с 0)
 * @param tnum1 количество зубцов на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param tnum2 количество зубцов на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param cp circular pitch
 *     (массив значений для каждой ступени)
 * @param a угол поворота центра шестеренки 2 вокруг центра шестеренки 1
 *     (массив значений для каждой ступени)
 * @param stage1_c1 координаты центра шестеренки 1 на ступени 1
 *     (по умолчанию: [0,0])
 * 
 * @return координаты [x, y] центра шестеренки 2 на ступени stage_n
 */
function gb_find_stage_center2(stage_n, tnum1, tnum2, cp, a, stage1_c1=[0,0]) =
    stage_n == 0 ?
        gb_find_center2(tnum1=tnum1[0], tnum2=tnum2[0],
            cp=cp[0], a=a[0], stage1_c1=stage1_c1) :
        gb_find_center2(tnum1=tnum1[stage_n], tnum2= tnum2[stage_n],
            cp=cp[stage_n],
            a=a[stage_n],
            c1=gb_find_stage_center2(stage_n=stage_n-1,
                tnum1=tnum1, tnum2=tnum2,
                cp=cp, a=a, stage1_c1=stage1_c1));

/**
 * Координаты центров шестеренок на всех ступенях
 * редуктора.
 * Результат - список координат, начиная с 1й ступени:
 * [
 *     [[stage-1.c1.x, stage-1.c1.y], [stage-1.c2.x, stage-1.c2.y]],
 *     [[stage-2.c1.x, stage-2.c1.y], [stage-2.c2.x, stage-2.c2.y]], 
 *     ...
 *     [[stage-n.c1.x, stage-n.c1.y], [stage-n.c2.x, stage-n.c2.y]]
 * ]
 * здесь
 *     stage-n.c1 - центр 1й шестеренки на ступени n,
 *     stage-n.c2 - центр 2й шестеренки на ступени n.
 * 
 * @param stage_n - индекс верхней ступени, до которой вычисляем центры.
 *     (нумерация с 0: для 1й ступени stage_n=0, для n-й - stage_n=n-1)
 * @param tnum1 количество зубцов на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param tnum2 количество зубцов на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param cp circular pitch
 *     (массив значений для каждой ступени)
 * @param a угол поворота центра шестеренки 2 вокруг центра шестеренки 1
 *     (массив значений для каждой ступени)
 * @param stage1_c1 координаты центра шестеренки 1 на ступени 1
 *     (по умолчанию: [0,0])
 * 
 * @return координаты центров шестеренок на всех ступенях редуктора до 
 *     ступени stage_n включительно.
 */
function gb_find_stage_centers(stage_n, tnum1, tnum2, cp, a, stage1_c1=[0,0]) =
    stage_n == 0 ?
        [
            // центр1 на ступени 1
            [stage1_c1,
            // центр2 на ступени 2
            gb_find_center2(tnum1=tnum1[0], tnum2=tnum2[0],
                cp=cp[0], c1=stage1_c1, a=a[0])]
        ] :
        concat(
            // все центры на предыдущих ступенях
            gb_find_stage_centers(stage_n=stage_n-1,
                tnum1=tnum1, tnum2=tnum2,
                cp=cp, a=a, stage1_c1=stage1_c1),
            [
                // центр 1 на текущей ступени == центр 2 на предыдущей ступени
                [gb_find_center2(tnum1=tnum1[stage_n-1], tnum2= tnum2[stage_n-1],
                    cp=cp[stage_n-1], a=a[stage_n-1],
                    c1=gb_find_stage_centers1(stage_n=stage_n-1,
                        tnum1=tnum1, tnum2=tnum2,
                        cp=cp, a=a, stage1_c1=stage1_c1)[stage_n-1]),
                // центр 2 на текущей ступени
                gb_find_center2(tnum1=tnum1[stage_n], tnum2= tnum2[stage_n],
                    cp=cp[stage_n], a=a[stage_n],
                    c1=gb_find_stage_center2(stage_n=stage_n-1,
                        tnum1=tnum1, tnum2=tnum2,
                        cp=cp, a=a, stage1_c1=stage1_c1))]
            ]
        );

/**
 * Координаты центров шестеренки 1 на всех ступенях редуктора.
 * Результат - список координат, начиная с 1й ступени
 * [[stage-1.c1.x, stage-1.c1.y], [stage-2.c1.x, stage-2.c1.y], ..., [stage-n.c1.x, stage-n.c1.y]]
 * здесь stage-n.c1 - центр 1й шестеренки на ступени n.
 * 
 * @param stage_n - индекс верхней ступени, до которой вычисляем центры.
 *     (нумерация с 0: для 1й ступени stage_n=0, для n-й - stage_n=n-1)
 * @param tnum1 количество зубцов на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param tnum2 количество зубцов на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param cp circular pitch
 *     (массив значений для каждой ступени)
 * @param a угол поворота центра шестеренки 2 вокруг центра шестеренки 1
 *     (массив значений для каждой ступени)
 * @param stage1_c1 координаты центра шестеренки 1 на ступени 1
 *     (по умолчанию: [0,0])
 * 
 * @return координаты центров шестеренки 1 на всех ступенях редуктора
 *     до ступени stage_n включительно.
 */
function gb_find_stage_centers1(stage_n, tnum1, tnum2, cp, a, stage1_c1=[0,0]) =
    stage_n == 0 ?
        [stage1_c1] :
        concat(
            gb_find_stage_centers1(stage_n=stage_n-1,
                tnum1=tnum1, tnum2=tnum2,
                cp=cp, a=a, stage1_c1=stage1_c1),
            [gb_find_center2(tnum1=tnum1[stage_n-1], tnum2= tnum2[stage_n-1],
                cp=cp[stage_n-1], a=a[stage_n-1],
                c1=gb_find_stage_centers1(stage_n=stage_n-1,
                    tnum1=tnum1, tnum2=tnum2,
                    cp=cp, a=a, stage1_c1=stage1_c1)[stage_n-1])]
        );

/**
 * Координаты центров шестеренки 2 на всех ступенях редуктора.
 * Результат - список координат, начиная с 1й ступени
 * [[stage-1.c2.x, stage-1.c2.y], [stage-2.c2.x, stage-2.c2.y], ..., [stage-n.c2.x, stage-n.c2.y]]
 * здесь stage-n.c1 - центр 1й шестеренки на ступени n.
 * 
 * @param stage_n - индекс верхней ступени, до которой вычисляем центры.
 *     (нумерация с 0: для 1й ступени stage_n=0, для n-й - stage_n=n-1)
 * @param tnum1 количество зубцов на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param tnum2 количество зубцов на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param cp circular pitch
 *     (массив значений для каждой ступени)
 * @param a угол поворота центра шестеренки 2 вокруг центра шестеренки 1
 *     (массив значений для каждой ступени)
 * @param stage1_c1 координаты центра шестеренки 1 на ступени 1
 *     (по умолчанию: [0,0])
 *
 * @return координаты центров шестеренки 2 на всех ступенях редуктора
 *     до ступени stage_n включительно.
 */
function gb_find_stage_centers2(stage_n, tnum1, tnum2, cp, a, stage1_c1=[0,0]) =
    stage_n == 0 ?
        [gb_find_center2(tnum1=tnum1[0], tnum2=tnum2[0],
            cp=cp[0], c1=stage1_c1, a=a[0])] :
        concat(
            gb_find_stage_centers2(stage_n=stage_n-1,
                tnum1=tnum1, tnum2=tnum2,
                cp=cp, a=a, stage1_c1=stage1_c1),
            [gb_find_center2(tnum1=tnum1[stage_n], tnum2= tnum2[stage_n],
                cp=cp[stage_n], a=a[stage_n],
                c1=gb_find_stage_center2(stage_n=stage_n-1,
                    tnum1=tnum1, tnum2=tnum2,
                    cp=cp, a=a, stage1_c1=stage1_c1))]
        );


/**
 * Координата основания (по оси Z) указанной ступени редуктора.
 * Высота ступени берется как высота шестеренки 2 h2
 * плюс вертикальный отступ h2_gap.
 *
 * Основание 1й ступени (stage_n=0) - ноль.
 *
 * @param stage_n - индекс ступени, для которой вычисляем координату Z основания.
 *     (нумерация с 0: для 1й ступени stage_n=0, для n-й - stage_n=n-1)
 * @param h2 высота шестеренки 2
 *     (массив значений для каждой ступени)
 * @param h2_gap отступ по оси Z под шестеренкой 2 относительно шестеренки 1
 *     (по умолчанию: 0)
 * @return
 */
function gb_stage_bottom(stage_n, h2, h2_gap=0) =
    stage_n == 0 ? 0 :
        gb_stage_bottom(stage_n=stage_n-1, h2=h2, h2_gap=h2_gap) +
            h2[stage_n-1] + h2_gap;


/**
 * Нарисовать ступень редуктора:
 * 2 сцепленные шестеренки, центр шестеренки 2 повернут
 * вокруг центра шестеренки 1 на a градусов.
 * 
 * @param tnum1 количество зубцов на шестеренке 1
 * @param tnum2 количество зубцов на шестеренке 2
 * @param cp circular pitch (default=1.5)
 * @param pa pressure angle (default=20)
 * @param holed1 диаметр отверстия на шестеренке 1
 * @param holed2 диаметр отверстия на шестеренке 2
 * @param h1 высота шестеренки 1
 * @param h2 высота шестеренки 2
 * @param a угол поворота шестеренки 2 вокруг цента шестеренки 1
 * @param c1 координаты центра шестеренки 1
 * @param rot2 угол поворота шестеренки 2 вокруг центра
 *     (может быть полезно при подгонке стыковки зубцов)
 * @param h2_gap отступ по оси Z под шестеренкой 2 относительно шестеренки 1
 * @param mirror_x отразить все шестеренки, кроме начальной, по оси X
 * @param mirror_y шестренки, отраженные по X, рисовать отраженными по Y
 * @param print_error компенсация погрешности 3д-печати для отверстий
 *     внутри шестеренок
 * @param $fn детализация отверстий внутри шестеренок
 */
module gb_stage(tnum1, tnum2,
        cp=1.5, pa=20,
        holed1=2, holed2=2, h1=3, h2=3,
        a=0, c1=[0,0], rot2=0, h2_gap=0,
        mirror_x=true, mirror_y=false,
        print_error=0,
        $fn=90) {
    module _stage() {
        gear(mm_per_tooth=cp, pressure_angle=pa,
            number_of_teeth=tnum1, thickness=h1, hole_diameter=holed1+print_error,
            center=false, $fn=$fn);
        rotate([0, 0, a]) translate([
                pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum1)+
                pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum2),
                0, h2_gap])
            rotate([0,0,rot2]) gear(mm_per_tooth=cp, pressure_angle=pa,
                number_of_teeth=tnum2, thickness=h2, hole_diameter=holed2+print_error,
                center=false, $fn=$fn);
        if(mirror_x && c1.x == 0) {
            // шестеренка 1 находится на оси X - отражаем только 
            // шестеренку 2
            rotate([0, 0, (mirror_y?180+a:180-a)]) translate([
                    pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum1)+
                    pitch_radius(mm_per_tooth=cp, number_of_teeth=tnum2),
                    0, h2_gap])
                rotate([0,0,-rot2]) gear(mm_per_tooth=cp, pressure_angle=pa,
                    number_of_teeth=tnum2, thickness=h2, hole_diameter=holed2+print_error,
                    center=false, $fn=$fn);
        }
    }
    translate([c1.x, c1.y, 0]) _stage();
    if(mirror_x && c1.x != 0) {
        // шестеренка 1 не на оси X - отражаем обе
        mirror([0, (mirror_y?1:0), 0]) mirror([1, 0, 0]) translate([c1.x, c1.y, 0]) _stage();
    }
}

/**
 * Многоступенчатый плоский редуктор.
 * 
 * @param tnum1 количество зубцов на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param tnum2 количество зубцов на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param cp circular pitch
 *     (массив значений для каждой ступени)
 * @param pa pressure angle
 *     (массив значений для каждой ступени)
 * @param holed1 диаметр отверстия на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param holed2 диаметр отверстия на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param h1 высота шестеренки 1
 *     (массив значений для каждой ступени)
 * @param h2 высота шестеренки 2
 *     (массив значений для каждой ступени)
 * @param a угол поворота центра шестеренки 2 вокруг центра шестеренки 1
 *     (массив значений для каждой ступени)
 * @param stage1_c1 координаты центра шестеренки 1 на ступени 1
 * @param rot2 угол поворота шестеренки 2 вокруг своей оси
 *     (может быть полезно при подгонке стыковки зубцов)
 *     (массив значений для каждой ступени)
 *     (по умолчанию: пустой массив [])
 * @param h2_gap отступ по оси Z под шестеренкой 2 относительно шестеренки 1 (по умолчанию: 1)
 * @param bottom_gap отступ снизу от основания ректора
 *      (по умолчанию: 0)
 * @param top_gap отступ сверху от крышки ректора
 *      (по умолчанию: 1)
 * @param base_points точки многоугольника для основания
 * @param base_points точки многоугольника для крышки
 * @param base_h толщина основания
 * @param cover_h толщина крышки
 * @param columns стойки с отверстиями под винты
 *     (3мм отверстие+2мм стенка). Массив: каждый элемент
 *     массива - пара [x,y] - координаты центра каждой стойки.
 * @param mirror_x отразить все шестеренки, кроме начальной, по оси X
 * @param mirror_y шестренеки, отраженные по X, рисовать отраженными по Y
 * @param printed_rods рисовать стержни для шестеренок для печати вместе
 *     с основанием вместо отверстий для отдельных (металлических) осей.
 *     (по умолчанию: false)
 * @param exit_base в основании сквозное отверстие на оси
 *     2й шестеренки последней ступени
 *     (по умолчанию: false)
 * @param exit_cover в крышке сквозное отверстие на оси
 *     2й шестеренки последней ступени
 *     (по умолчанию: false)
 * @param base рисовать основание (true/false)
 * @param cover рисовать крышку (true/false)
 * @param gears  рисовать шестеренки (true/false)
 * @param base_color цвет основания (предпросмотр)
 * @param cover_color цвет основания (предпросмотр)
 * @param gears_color цвет шестеренок (предпросмотр)
 * @param print_error компенсация погрешности 3д-печати
 *     для стыкующихся элементов
 * @param $fn детализация цилиндрических стоек и отверстий
 */
module gb_gearbox(tnum1, tnum2, cp, pa,
        holed1, holed2, h1, h2,
        a, stage1_c1=[0,0], rot2=[],
        h2_gap=1, bottom_gap=0, top_gap=1,
        base_points=[[-20, -20], [20, -20], [20, 20], [-20, 20]],
        cover_points=[[-20, -20], [20, -20], [20, 20], [-20, 20]],
        base_h=3, cover_h=3,
        columns=[],
        mirror_x=true, mirror_y=false,
        printed_rods=false,
        exit_base=false, exit_cover=false,
        base=true, cover=true, gears=true,
        base_color=[0.8, 0.5, 0.9], cover_color=[0.5, 0.7, 0.9], gears_color=[1, 1, 0.4],
        print_error=0, $fn=100) {
    
    // центры шестеренки 1 на всех ступенях
    c1 = gb_find_stage_centers1(stage_n=len(tnum1),
                tnum1=tnum1, tnum2=tnum2,
                cp=cp, a=a, stage1_c1=stage1_c1);
    // центры шестеренки 2 на всех ступенях
    c2 = gb_find_stage_centers2(stage_n=2,
                tnum1=tnum1, tnum2=tnum2,
                cp=cp, a=a, stage1_c1=stage1_c1);
            
    // высота блока с шестеренками - без зазоров сверху и снизу,
    // для последней ступеньки берем высоту более высокой шестеренки
    stages_h = gb_stage_bottom(stage_n=len(tnum1)-1, h2=h2, h2_gap=h2_gap) +
        (h1[len(tnum1)-1] > h2[len(tnum1)-1]+h2_gap ?
            h1[len(tnum1)-1] : h2[len(tnum1)-1]+h2_gap);
            
    // подставки под шестеренки - под каждой 2й шестеренкой
    // на ступеньке: цилиндр радиусом=радиус отверстия шестеренки+2мм
    module _gear_stands() {
        for(i = [0 : len(tnum1)-1]) {
            difference() {
                translate([c2[i].x, c2[i].y, 0]) union() {
                    cylinder(
                        r=holed2[i]/2+2,
                        h=gb_stage_bottom(
                            stage_n=i, h2=h2, h2_gap=h2_gap)+h2_gap+bottom_gap, $fn=$fn);
                    
                    if(printed_rods) {
                        // ось шестеренки - добавляем к подставке на высоту шестеренки
                        translate([0, 0, gb_stage_bottom(
                                stage_n=i, h2=h2, h2_gap=h2_gap)+h2_gap+bottom_gap])
                            cylinder(
                                r=holed2[i]/2-print_error,
                                h=h2[i]+(i<len(tnum1)-1 ? h1[i+1] : 0));
                    }
                }
                
                if(!printed_rods) {
                    // отверстие внутри подставки под ось шестеренки: высота подставки + 2мм
                    // (дополнительное вычитание из самого дна)
                    translate([c2[i].x, c2[i].y, -0.1])
                        cylinder(
                            r=holed2[i]/2+print_error,
                            h=gb_stage_bottom(
                                stage_n=i, h2=h2, h2_gap=h2_gap)+h2_gap+bottom_gap+0.2, $fn=$fn);
                }
                
                // вычитаем внешний диаметр шестеренки 2 с предыдущей ступени
                if(i >0) translate([c2[i-1].x, c2[i-1].y, -0.1])
                    cylinder(
                        r=outer_radius(mm_per_tooth=cp[i-1], number_of_teeth=tnum2[i-1], clearance=0)+0.2+print_error,
                        h=gb_stage_bottom(
                            stage_n=i, h2=h2, h2_gap=h2_gap)+h2_gap+bottom_gap+0.2, $fn=$fn);
            }
        }
    }
    
    // отверстия в основании (колонны не учитываем)
    module _base_holes1() {
        if(!printed_rods) {
            // несквозные отверстия в основании под оси шестеренок:
            // высота подставки + 2мм;
            // на шестеренке 2 последней ступени сквозное отверстие,
            // если exit_base=true
            for(i = [0 : len(tnum1)-1]) {
                translate([c2[i].x, c2[i].y, (i<len(tnum1)-1 || !exit_base ? -2 : -base_h-0.1)])
                    cylinder(r=holed2[i]/2+print_error,
                        h=(i<len(tnum1)-1 || !exit_base ? 2 : base_h+0.1)+0.1, $fn=$fn);
            }
        }
    }
    
    // отверстия в крышке (колонны не учитываем)
    module _cover_holes1() {
        if(!printed_rods) {
            // несквозные отверстия в крышке под оси шестеренок;
            // на шестеренке 2 последней ступени сквозное отверстие,
            // если exit_cover=true
            for(i = [0 : len(tnum1)-1]) {
                    translate([c2[i].x, c2[i].y, stages_h+bottom_gap+top_gap-0.1])
                        cylinder(r=holed2[i]/2+print_error,
                            h=(i<len(tnum1)-1 || !exit_cover ? 2 : cover_h+0.1)+0.1, $fn=$fn);
            }
        }
    }
    
    // срезы с колонн: вычитаем из колонн цилиндры
    // диаметром с шестеренки по центрам шестеренок
    // по всей высоте
    module _column_cutoffs() {
        for(i = [0 : len(tnum1)-1]) {
            translate([c1[i].x, c1[i].y, -0.1]) cylinder(
                r=outer_radius(
                    mm_per_tooth=cp[i], number_of_teeth=tnum1[i], clearance=0)+0.2,
                h=stages_h+bottom_gap+top_gap+2+0.2+print_error,
                $fn=$fn);
            translate([c2[i].x, c2[i].y, -0.1]) cylinder(
                r=outer_radius(
                    mm_per_tooth=cp[i], number_of_teeth=tnum2[i], clearance=0)+0.2,
                h=stages_h+bottom_gap+top_gap+2+0.2+print_error,
                $fn=$fn);
        }
    }

    // основание
    color(base_color) if(base) {
        // дно
        difference() {
            translate([0, 0, -base_h])
                linear_extrude(height=base_h) polygon(base_points);
            
            // отверстия под подставками под шестеренки
            _base_holes1();
            if(mirror_x) mirror([0, (mirror_y?1:0), 0]) mirror([1,0,0]) _base_holes1();
            
            // отверстия под "колоннами"
            for(col = columns) {
                translate([col.x, col.y, -base_h-0.1]) cylinder(r=1.5+print_error, h=base_h+0.2);
            }
        }
        
        // подставки под шестеренки
        _gear_stands();
        if(mirror_x) mirror([0, (mirror_y?1:0), 0]) mirror([1,0,0]) _gear_stands();
        
        // "колонны": высота внутри редуктора + 2мм
        // внутри отверстие 3мм (для винтов)
        difference() {
            for(col = columns) {
                translate([col.x, col.y, 0]) difference() {
                    cylinder(r=3.5-print_error, h=stages_h+bottom_gap+top_gap+2);
                    translate([0,0,-0.1])
                        cylinder(r=1.5+print_error, h=stages_h+bottom_gap+top_gap+2+0.2);
                }
            }
            
            // вычитаем из колонн цилиндры диаметром с шестеренки
            // по центрам шестеренок по всей высоте
            _column_cutoffs();
            if(mirror_x) mirror([0, (mirror_y?1:0), 0]) mirror([1,0,0]) _column_cutoffs();
        }
    }
    
    // крышка
    color(cover_color) if(cover) {
        // крышка
        difference() {
            translate([0, 0, stages_h+bottom_gap+top_gap])
                linear_extrude(height=cover_h) polygon(cover_points);
            
            // отверстия для осей шестеренок
            _cover_holes1();
            if(mirror_x) mirror([0, (mirror_y?1:0), 0]) mirror([1,0,0]) _cover_holes1();
            
            // выемки для "колонн"
            for(col = columns) {
                translate([col.x, col.y, stages_h+bottom_gap+top_gap-0.1])
                    cylinder(r=3.5+print_error, h=2+0.1);
            }
            
            // сквозные отверстия под "колоннами" (для винтов)
            for(col = columns) {
                translate([col.x, col.y, stages_h+bottom_gap+top_gap-0.1])
                    cylinder(r=1.5+print_error, h=cover_h+0.2);
            }
        }
    }
    
    // шестеренки
    color(gears_color) if(gears) {
        for(i = [0 : len(tnum1)-1]) {
            translate([0,0, gb_stage_bottom(stage_n=i, h2=h2, h2_gap=h2_gap)+bottom_gap])
                gb_stage(tnum1=tnum1[i], tnum2=tnum2[i],
                    cp=cp[i], pa=pa[i],
                    holed1=holed1[i], holed2=holed2[i], h1=h1[i], h2=h2[i],
                    a=a[i], c1=c1[i],
                    rot2=(i < len(rot2) ? rot2[i]:0),
                    h2_gap=h2_gap,
                    mirror_x=mirror_x, mirror_y=mirror_y,
                    print_error=print_error, $fn=$fn);
        }
    }
}

/**
 * Нарисовать отдельную шестеренку редуктора.
 * Первая и последняя шестеренки - одинарные,
 * все остальные промежуточные - сдвоенные.
 *
 *   stage-n.gear-1 - 1я шестеренка ступени n
 *   stage-n.gear-2 - 2я шестеренка ступени n
 * 
 * Шестеренки нумеруем следующим образом:
 *   0: stage-1.gear-1 (одинарная)
 *   1: stage-1.gear-2+stage-2.gear-1 (сдвоенная)
 *   2: stage-2.gear-2+stage-3.gear-1 (сдвоенная)
 *   3: stage-3.gear-2+stage-4.gear-1 (сдвоенная)
 * ...
 *   n-1: stage-(n-1).gear-2+stage-n.gear-1 (сдвоенная)
 *   n: stage-n.gear-2 (одинарная)
 * 
 * @param index номер шестеренки
 *     (0 - шестеренка 1 1й ступени, n - шестеренка 2 ступений n).
 * @param tnum1 количество зубцов на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param tnum2 количество зубцов на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param cp circular pitch
 *     (массив значений для каждой ступени)
 * @param pa pressure angle
 *     (массив значений для каждой ступени)
 * @param holed1 диаметр отверстия на шестеренке 1
 *     (массив значений для каждой ступени)
 * @param holed2 диаметр отверстия на шестеренке 2
 *     (массив значений для каждой ступени)
 * @param h1 высота шестеренки 1
 *     (массив значений для каждой ступени)
 * @param h2 высота шестеренки 2
 *     (массив значений для каждой ступени)
 * @param rot2 угол поворота шестеренки 2 вокруг своей оси
 *     (может быть полезно при подгонке стыковки зубцов)
 *     (массив значений для каждой ступени)
 *     (по умолчанию: пустой массив [])
 * @param print_error компенсация погрешности 3д-печати для отверстий
 *     внутри шестеренок
 * @param $fn детализация отверстий внутри шестеренок
 */
module gb_gear(index,
        tnum1, tnum2, cp, pa,
        holed1, holed2, h1, h2,
        rot2=[],
        print_error=0,
        $fn=90) {
    if(index == 0) {
        // шестеренка 1 на ступени 1
        // tnum1[0]
        gear(mm_per_tooth=cp[0], pressure_angle=pa[0],
            number_of_teeth=tnum1[0], thickness=h1[0],
            hole_diameter=holed1[0]+print_error,
            center=false, $fn=$fn);
    } else if(index < len(tnum1)) {
        // tnum2[0] + tnum1[1]
        // tnum2[index-1] + tnum1[index]
        // шестеренка 2 на ступени index-1
        rotate([0, 0, index-1 < len(rot2) ? rot2[index-1]:0])
            gear(mm_per_tooth=cp[index-1], pressure_angle=pa[index-1],
                number_of_teeth=tnum2[index-1], thickness=h2[index-1],
                hole_diameter=holed2[index-1]+print_error,
                center=false, $fn=$fn);
        // шестеренка 1 на ступени index
        translate([0, 0, h2[index-1]])
            gear(mm_per_tooth=cp[index], pressure_angle=pa[index],
                number_of_teeth=tnum1[index], thickness=h1[index],
                hole_diameter=holed1[index]+print_error,
                center=false, $fn=$fn);
    } else if(index == len(tnum1)) {
        // шестеренка 2 на ступени n
        // tnum2[index-1]
        gear(mm_per_tooth=cp[index-1], pressure_angle=pa[index-1],
            number_of_teeth=tnum2[index-1], thickness=h2[index-1],
            hole_diameter=holed2[index-1]+print_error,
            center=false, $fn=$fn);
    }
}
