slide_lenght = 15 ; //90

phone_hight = 12 ;
phone_widith = 79 ;

wall = 3 ;
tab_size = 5 ;

difference(){
	cube([phone_widith+wall*2,slide_lenght,phone_hight+wall],center=true);
	translate([0,0,wall/2+.1])cube([phone_widith,slide_lenght+.2,phone_hight],center=true);
}


tab();
mirror(0,1,0)tab();

mirror(1,0,0)tab();

module tab(){
	hull(){ //tabb
		translate([-phone_widith/2-wall,-slide_lenght/2,phone_hight/2+wall])cube([tab_size,slide_lenght,wall/2]); //Top
		translate([-phone_widith/2-wall,-slide_lenght/2,phone_hight/2+wall/2])cube([wall,slide_lenght,wall]); //Bottom
	}
}
/* 

hull(){	//tab
	mirror(0,1,0)translate([-phone_widith/2-wall,-slide_lenght/2,phone_hight/2+wall])cube([tab_size,slide_lenght,wall]);
	mirror(0,1,0)translate([-phone_widith/2-wall,-slide_lenght/2,phone_hight/2+wall/2])cube([wall,slide_lenght,wall]);
} */