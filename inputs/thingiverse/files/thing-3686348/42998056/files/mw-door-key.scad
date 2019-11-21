$fn=100;
difference(){
    //зададим подложку из которой будем вырезать всё "лишнее"
minkowski()
{ cube([43,18,4],true);
  cylinder(r=4,h=1); }
  //получился кубик со стороной Z мм (x+2r: y+2r) и скругленными (на r)гранями
  //теперь то что вырезаем склеим в одну фигуру
 union () { 
 // кубоцилиндр смещаем на радиус цилиндра (r), чтобы расположить по центру первого
translate ([0,0,3]) #minkowski()
{ cube([43,18,5],true);
  cylinder(r=2,h=1); }
} 
}
// добавляем толкатели
difference(){
 union () {
rotate ([0,0,0]) translate ([11,0,0]) cylinder(r=4.75,h=37.6);
rotate ([0,0,0]) translate ([-11,0,0]) cylinder(r=4.75,h=37.6);}
// делаем скос для беспроблемного возврата опорной пластины замка дверцы
  #rotate ([0,-105,90]) translate ([38.5,0,0]) cube([5,60,40],true); }

// добавляем фиксаторы
difference(){
 union () {
    rotate ([0,0,0]) translate ([23,0,13]) cube([5,6,26],true);
    rotate ([0,0,0]) translate ([-23,0,13]) cube([5,6,26],true); } 
  // отрезаем лишнее    
  #rotate ([0,0,0]) translate ([25,0,12]) cube([4,6,18],true);
  #rotate ([0,0,0]) translate ([-25,0,12]) cube([4,6,18],true);  
  #rotate ([0,30,0]) translate ([-35,0,12]) cube([4,6,18],true);   
  #rotate ([0,-30,0]) translate ([35,0,12]) cube([4,6,18],true);     
 
}