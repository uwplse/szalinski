// Attention!
// please use version 2019.05 or newer to render this!
// there was a bug in "rotate_extrude" the versions before that which led to 
// ununsable prints
//
//Глобальный параметр - размера минимального фрагмента на поверхности. Зависит от 3Д принтера, обычно 0.3-1. Сильно влияет на скорость рендера модели.
//Global parameter - the minimum size of the fragment on the surface. Depends on the 3D printer, typically 0.3-1. Greatly affect the speed rendering model.
$fs = 1;
$fn=100;

//Глобальный параметр - размер минимального угла для фрагмента. От этого зависит "гладкость" окружностей. Обычно 3-7. Сильно влияет на скорость рендера модели.
//Global parameter - the size of the minimum angle for the fragment. On this depends the "smoothness" of the circles. Usually 3-7. Greatly affect the speed rendering model.
$fa = 7;

// all size in mm
// все значения размеров в мм

//Общая высота модели
//Total model height 
total_height = 12;

//Диаметр центральной сферы. Желательно делать немного больше чем total_height
//The diameter of the central sphere. It is advisable to do a little more than the total_height
diam_central_sphere = 16;

//Зазор между кольцами. Зависит от возможностей 3D принтера
//The gap between the rings. It depends on the capabilities of 3D printer
gap = 0.5;

//Толщина колец
//The thickness of the rings
ring_thickness = 2;

//Толщина последнего (внешнего) кольца
//The thickness of the latter (outer) ring
last_ring_thickness = 2;

//Отступ проушины от внешней стороны кольца
//Indentation lugs on the external side of the ring
lug_ident = 1;

//Диаметр внутреннего отверстия в центральной сфере
//The diameter of the inner hole in the central sphere
diam_central_cylinder = 5;

//Текст для вывода на внешний обод последнего кольца. Длина никак не контролируется, что может приводить в проблемам. Для генерации кольца без текста, переменная должна содержать символ "пробел". Можно "управлять" размещением символов с помощью пробелов в начале и конце текста.
//Text for printing on the outer rim of the last ring. The length is not controlled, it can lead to problems. To generate ring without text, should contain a "space" character. It is possible to "manage" the placement of symbols with the spaces at the beginning and end of the text.
lettering_text = "section77.de";

//Толщина букв на внешем ободе последнего кольца
//The thickness of the letters on the outer rim of the last ring
letter_thickness = 1;

//Фонт по умолчанию. Желательно использовать моноширинные шрифты
//Default Font. Better use monospaced fonts. 
def_font = "Courier New:style=Bold";

//Количество внутренних колец, т.е. между центральной сферой и последним кольцом.
//The number of inner rings, ie, between the central sphere and the last ring.
number_of_rings = 5;


// Main geometry
CentralSphere();

for (i = [1 : number_of_rings]){
	SphereN(i);
}
	
SphereFinal(number_of_rings);

module CentralSphere() {
	difference(){
		intersection() {
			sphere(d = diam_central_sphere, center = true);
			cube([diam_central_sphere, diam_central_sphere, total_height], center = true);
		}
		cylinder(h = total_height+1, d = diam_central_cylinder, center = true);
	}
}

module SphereN(N) {
	cur_sphere_d = diam_central_sphere + gap*2*N + ring_thickness*2*N;
	cur_inner_sphere_d = cur_sphere_d - ring_thickness*2;

	echo("Ring:", N, ", sphere out d=", cur_sphere_d, ", in d=", cur_inner_sphere_d);

	intersection(){
		difference() {
			sphere(d = cur_sphere_d, center = true);
			sphere(d = cur_inner_sphere_d, center = true);
		}
		cube([cur_sphere_d, cur_sphere_d, total_height], center = true);
	}
}

module SphereFinal(N){
	cur_sphere_d = diam_central_sphere+ring_thickness*2*N+gap*2*N+last_ring_thickness*2+gap*2;
	cur_inner_sphere_d = cur_sphere_d-last_ring_thickness*2; 
	lug_angle = (total_height/3+6)/(cur_sphere_d/2)*(180/PI);

	echo("Last ring:", cur_sphere_d, "/", cur_inner_sphere_d, "N:", N, lug_angle);
	union(){
	
		intersection(){
			difference(){
				sphere(d = cur_sphere_d, center=true);
				sphere(d = cur_inner_sphere_d, center=true);
			}
			cube([cur_sphere_d, cur_sphere_d, total_height], center = true);
		}
		
		WriteOnRing(lettering_text, cur_sphere_d/2, total_height-2, lug_angle);
		
		sym_seg = (360-lug_angle)/len(lettering_text);
		rotate([0,0,-(90+sym_seg/2+lug_angle/2)]){
			union(){
				translate([-total_height/3, cur_sphere_d/2+lug_ident, 0]){
					rotate([0, 90, 0])
					rotate_extrude(angle=180, convexity=10)
					translate([total_height/3, total_height/3, 0])
					scale([1, 2, 1])
					circle(d = total_height/3, center=true);
				}
				difference(){
					translate([0, 0, total_height/2-total_height/3/2]){
						rotate([-90, 90, 0])
						linear_extrude(height = cur_sphere_d/2+lug_ident)
						scale([1, 2, 1])
						circle(d = total_height/3, center = true);
					}
					sphere(d=cur_inner_sphere_d + last_ring_thickness*2);	
				}
				difference(){
					translate([0, 0, -total_height/2+total_height/3/2]){
						rotate([-90, 90, 0])
						linear_extrude(height = cur_sphere_d/2+lug_ident)
						scale([1, 2, 1])
						circle(d = total_height/3, center = true);
					}
					sphere(d=cur_inner_sphere_d + last_ring_thickness*2);	
				}
			}
		}
	}
}



module WriteOnRing(text, radius, h, lug_angle){

	text_len = len(text);
	sym_seg = (360-lug_angle)/(text_len);
	
	intersection(){
		for (i=[0:text_len-1]){
			curangle = sym_seg*i;
			echo(i, curangle, cos(curangle)*radius, sin(curangle)*radius);
			translate([cos(curangle)*radius, sin(curangle)*radius, -total_height/2+1])
				rotate([0,0,curangle])
				PrepareSymbol(text[i], h);
		}
		intersection(){
			difference(){
				sphere(d = radius*2+letter_thickness*2, center=true);
				sphere(d = radius*2-last_ring_thickness, center=true);
			}
				cube([radius*2+letter_thickness+5, radius*2+letter_thickness+5, total_height], center = true);
		}
	}
}

module PrepareSymbol(sym, sym_size){
	rotate(90,[0,0,1])
		rotate(90,[1,0,0])
//		resize([sym_size, sym_size, 10])
		linear_extrude(height = 10, center=true)
		text(str(sym), size=sym_size, spacing=1, halign="center", valign="bottom", font=def_font);
}
