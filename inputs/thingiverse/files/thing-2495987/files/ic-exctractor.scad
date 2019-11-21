
//connection circle diameter (диаметр внешнего круга)
cd=25;

//width of handles (толщина стенок)
w=4;

//length on handles (длина ручек)
l=80;

//tip length (длина губок)
tip=4;


//tip width (ширина губок)
tipw=3;


//twizers thick (толщина пинцета)
h=6;


//main size between ends (расстояние между концами без учета выступов)
max_w=28; 

ang=asin(((max_w-cd)/2)/l);
echo (ang);
//ang=10;//угол разведения ручек


$fn=64;
module tip(){
    polygon([[l*cos(ang)+tipw,endp+tipw*sin(ang)],[l*cos(ang),endp-tip-w],[l*cos(ang),endp]]);
}

endp=(cd+l*sin(ang)*2)*0.5;//точка луча конечная
linear_extrude(h){
    difference(){
        hull(){
            circle(d=cd);
            translate([l*cos(ang)-0.01,-(cd+l*sin(ang)*2)*0.5])square([0.01,cd+l*sin(ang)*2]);
        }
        hull(){
            circle(d=cd-w*2);
            translate([l*cos(ang)-0.01,-(cd+l*sin(ang)*2)*0.5+w])square([0.01,cd+l*sin(ang)*2-w*2]);
        }
        
    }
    tip();
    mirror([0,1,0])tip();
}
    