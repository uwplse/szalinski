button_symbol = "Strange sentence";
button_author = "gugod" ;
fn_c = 30;

//characters = "【摩訶般若波羅密多心經】觀自在菩薩，行深般若波羅蜜多時。照見五蘊皆空，渡一切苦厄。舍利子，色不異空，空不異色，色即是空，空即是色，受想行識，亦復如是。舍利子，是諸法空相，不生不滅，不垢不淨，不增不減。是故空中無色，無受想行識，無眼耳鼻舌身意，無色聲香味觸法，無眼界，乃至無意識界。無無明，亦無無明盡，乃至無老死，亦無老死盡。無苦集滅道，無智亦無得。以無所得故，菩提薩埵，依般若波羅蜜多故，心無罣礙，無罣礙故，無有恐怖，遠離顛倒夢想，究竟涅槃。三世諸佛，依般若波羅蜜多故，得阿耨多羅三藐三菩提。故知般若波羅蜜多，是大神咒，是大明咒，是無上咒，是無等等咒，能除一切苦，真實不虛。故說般若波羅蜜多咒，即說咒曰：揭諦揭諦，波羅揭諦，波羅僧揭諦，菩提薩婆訶。";
characters = "話說我又忘了收衣服了 衣服好可憐,孤怜怜地晾了好幾天 主人渡假時，答錄機的紅燈 很少人經過的路上，的閃光紅燈 三十天沒被attach的screen 四十年沒被想過的老人 幾百年沉在河底的戒指 在第10集結束時,主角的飛踢還沒落下,可是一直都沒有出現的第11集 被上升氣流排擠而到角落的氧氣 被早上六點客人叫醒的吉野家店員 趟在收銀機裡三個星期無法找開的二百元紙鈔 很久沒被karma的keyword生鏽機關槍,斷電的插頭 ";
thickness = 3 ;

inner_wall = "YES";
google_font = "AdobeFanHeitiStd-Bold";//"Noto Sans CJK TC:style=Black"; 

function PI() = 3.14159;

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 90.
// Parameters: 
//     radius - the radius of arc
//     angle - the angle of arc
//     width - the width of arc
module a_quarter_arc(radius, angle, width = 1) {
    outer = radius + width;
    intersection() {
        difference() {
            offset(r = width) circle(radius, $fn=fn_c); 
            circle(radius, $fn=fn_c);
        }
        polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
    }
}

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 360.
// Parameters: 
//     radius - the radius of arc
//     angle - the angle of arc
//     width - the width of arc
module arc(radius, angles, width = 1) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;
    outer = radius + width;
    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_arc(radius, angle_difference, width);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            arc(radius, [0, 90], width);
            rotate(90) a_quarter_arc(radius, angle_difference - 90, width);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            arc(radius, [0, 180], width);
            rotate(180) a_quarter_arc(radius, angle_difference - 180, width);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            arc(radius, [0, 270], width);
            rotate(270) a_quarter_arc(radius, angle_difference - 270, width);
       }
}

// It has the same visual effect as `cylinder_character`, but each character is created by the `text` module. Use this module if your `arc_angle` is small enough and you want to render a model quickly. 
// Parameters: 
//     character - 3D character you want to create
//     arc_angle - angle which the character go across
//     radius - the cylinder radius
//     font - the character font
//     thickness - the character thickness
//     font_factor - use this parameter to scale the calculated font if necessary
module fake_cylinder_character(character, arc_angle, radius, font = "Courier New:style=Bold", thickness = 1, font_factor = 1) {

    half_arc_angle = arc_angle / 2;
    font_size = 2 * radius * sin(half_arc_angle) * font_factor;

    translate([radius - 0.2, -0.5, 0])
    rotate([90, 0, 90]) 
    linear_extrude(thickness) 
    text(character, font = font, size = font_size, halign = "center");
} 

// Create a character tower for chinese. It uses the font "微軟正黑體:style=Bold". If you want to print it easily, set the `inner_wall` parameter to `"YES"`. It will add an inner wall with the thickness of the half `thickness` value.
// Parameters: 
//     symbol - the bottom symbol
//     characters - the characters around the tower
//     thickness - the character thickness
//     inner_wall - `"YES"` will add an inner wall with the thickness of the half `thickness` value.
// Create a character tower for chinese. It uses the font "微軟正黑體:style=Bold". If you want to print it easily, set the `inner_wall` parameter to `"YES"`. It will add an inner wall with the thickness of the half `thickness` value.
// Parameters: 
//     symbol - the bottom symbol
//     characters - the characters around the tower
//     thickness - the character thickness
//     inner_wall - `"YES"` will add an inner wall with the thickness of the half `thickness` value.
module penbox_with_chinese_characters(symbol, characters, thickness = 1, inner_wall = "NO") {
    radius = 50;
    
    characters_of_a_circle = 30;
	arc_angle = 360 / characters_of_a_circle;
    
    half_arc_angle = arc_angle / 2;
    font_size = 2.2 * radius * sin(half_arc_angle);
    z_desc = font_size / characters_of_a_circle;

    max_height  =   z_desc * len(characters) + font_size * 1.5 ;
    
   union(){
        //  圓桶
        difference() {
            rotate([0,0,6])translate([0, 0, 0]) 
            linear_extrude(max_height) 
            circle(radius, $fn=fn_c);
        
            translate([0, 0, thickness]) 
            linear_extrude(max_height - thickness + 0.1) 
            circle(radius - thickness, $fn=fn_c);

            /* 簽名 */
            translate([0, -font_size / 2 - 1, thickness - 0.5]) 
                linear_extrude(thickness)
                    text(symbol,
                        font = "Verdana",
                        size = font_size / 2,
                        halign = "center",
                        valign = "center");

            translate([0, font_size / 2 + 1, thickness - 0.5]) 
                linear_extrude(thickness) 
                    text(button_author,
                        font = "Verdana",
                        size = font_size / 2 ,
                        halign = "center",
                        valign = "center");

            //  外部倒角
            difference() {
                rotate_extrude(convexity=10,$fn=fn_c)
                    translate([radius,0,0])
                        square(thickness*4,true);

                translate([0,0,thickness*2])
                    rotate_extrude(convexity=10,$fn=fn_c)
                        translate([radius-thickness*2,0,0])
                            circle(thickness*2,$fn=fn_c) ;
            }

            //  分隔線
            for(i = [0 : len(characters) + characters_of_a_circle - 2]) {
                translate([0, 0, max_height - z_desc * i - 0.7])
                    rotate([-2, 0, i * arc_angle])
                        linear_extrude(0.6) 
                            arc(radius - thickness * 0.2,
                                [0, arc_angle + half_arc_angle],
                                thickness);
            }

            //  文字
            for(i = [0 : len(characters) - 1]) {
                translate([0, 0, max_height - font_size - z_desc * i + 3])
                    rotate([0, 0.6, i * arc_angle]) 
                        fake_cylinder_character(characters[i],
                            arc_angle,
                            radius - thickness * 0.25 ,
                            font = google_font,
                            thickness = thickness / 2,
                            font_factor = 0.65);
            }
        }
        //  內部倒角
        difference() {
            translate([0,0,thickness*1.5])
                rotate_extrude(convexity=10,$fn=fn_c)
                    translate([radius-thickness*1.5,0,0])
                        square(thickness,true);

            translate([0,0,thickness*2])
                rotate_extrude(convexity=10,$fn=fn_c)
                    translate([radius-thickness*2,0,0])
                        circle(thickness,$fn=fn_c) ;
        }
    }
}

penbox_with_chinese_characters(button_symbol, characters, thickness, inner_wall = inner_wall);
