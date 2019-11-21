//external width the box
width=74.6;
//external length the box
length=55;
//external height the box
height=10;
//diameter of support board 
support_board=6;
//heigth of support board 
height_support_board=6.9;
//hole of screw diameter
hole_screw=2.1;
//text of bottom in the box
text_bottom="Circuit test 1";
//Font size of text
font_size=6;
//height text in the bottom box
height_text=.5;
//thickness for the box
thickness=2.1;
module caixa(){
    difference(){
        union(){
            difference(){
                cube([width,length,height],center=true);
                translate([0,0,thickness]){
                    cube([width-thickness*2,length-thickness*2,height],center=true);
                }
            }
            translate([-width/2+support_board/2+thickness,-length/2+support_board/2+thickness,-height/2+height_support_board/2+thickness]){
                quina(support_board,hole_screw,height);
            }
            translate([-width/2+support_board/2+thickness,+length/2-support_board/2-thickness,-height/2+height_support_board/2+thickness]){
                rotate(-90){
                    quina(support_board,hole_screw,height);
                }
            }
            translate([width/2-support_board/2-thickness,+length/2-support_board/2-thickness,-height/2+height_support_board/2+thickness]){
                rotate(180){
                    quina(support_board,hole_screw,height);
                }
            }   
            translate([width/2-support_board/2-thickness,-length/2+support_board/2+thickness,-height/2+height_support_board/2+thickness]){
                rotate(90){
                    quina(support_board,hole_screw,height);
                }   
            }
        }
        translate([0,0,-height/2]){
            if ( width<length ) { 
                rotate(90){
                    texto(text_bottom);
                }
            }else{
                texto(text_bottom);
            }
        }
    }
}
module quina(support_board,hole_screw,height){
    difference(){
    union(){
    cylinder($fn=20, height_support_board,support_board/2,support_board/2,center=true);
    translate([-support_board/2,-support_board/2,-height_support_board/2]){
        cube([support_board/2,support_board/2,height_support_board],center=false);
    }
}
cylinder($fn=10,height*2,hole_screw/2,hole_screw/2,center=true);
}
}
module texto(text_bottom){
    mirror([1,0,0]){
        linear_extrude(height_text){
            text(text_bottom,size=font_size ,font="Courier New:stlengthle=bold",halign="center",valign="center");
        }
    }
}
caixa();
translate([0,0,-height/2]){
  //  texto(text_bottom);
}
