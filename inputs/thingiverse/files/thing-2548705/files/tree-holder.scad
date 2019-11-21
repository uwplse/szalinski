// Количество веток
count=15;

difference(){
	cylinder(h=31,r=12.5);
	cylinder(h=31,r=10);
}

for (i=[0:count]){
	rotate([0,0,360/count*i]){
		translate([0, -15, 0]){
			branch ();
		}
	}
}

// Держатель для ветки
module branch (){
	union(){
		difference(){
			cylinder(h=31,r=5);
			cylinder(h=31,r=2.5);
			translate([-2.5, -5, 31-6.5]){
				cube([5,5,6.5]);
			}
		}
		translate([5, -15, 31]){
			rotate([0,180,0]){
				
				difference(){
					union(){
		   			prism(2.5, 15, 10);
						translate([7.5, 0, 0]){
		   				prism(2.5, 15, 10);
						}					
					}
					translate([0, -5, 0]){
	   				cube([10, 10, 10]);
					}
				}
			}
		}
	}
}

// Создание призмы (для направляющих ветки)
module prism(l, w, h){
	polyhedron(
		points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
		faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
	);
}
   