tile_width = 5;
wall = 1;
wall_height = 5;
plate_height = 2;

mazestring="03,06,02,06,00,02,02,02,02,06,br,05,02,12,04,04,06,02,10,10,12,br,01,09,04,08,08,12,08,08,08,04,br,01,12,04,00,04,00,04,00,08,12,br,01,03,12,12,04,04,08,08,01,04,br,01,09,08,04,04,08,08,08,12,04,br,09,00,12,08,04,08,00,12,00,04,br,01,08,01,08,12,00,00,01,12,12,br,01,08,08,09,00,12,00,09,08,04,br,09,08,08,08,08,09,08,01,08,12,br";


width=search("b",mazestring,1)[0]/3;
height=len(search("b",mazestring,99999)[0]);

maze(mazestring,width,height,tile_width,wall,wall_height,plate_height);



module maze(ms,w,h,t,wall,wallh,plateh){

	cube([h*t,w*t,plateh],false);
	union()
	for (j=[0:h-1]){
		for (i=[0:w-1]){
			translate([j*t,i*t,0]){
				translate([0,0,plateh]){
					wallcalc(str(ms[i*3+j*(w+1)*3], ms[i*3+j*(w+1)*3+1]), t, wall, wallh);
				}
			}
		}
	}
}


module wallcalc(i, t, wt,wh){
echo(i);
		if(i == "15"){
			wall(1,1,1,1, i, t, wt,wh);
		}else if(i == "14"){
			wall(0,1,1,1, i, t, wt,wh);
		}else if(i == "13"){
			wall(1,0,1,1, i, t, wt,wh);
		}else if(i == "12"){
			wall(0,0,1,1, i, t, wt,wh);
		}else if(i == "11"){
			wall(1,1,0,1, i, t, wt,wh);
		}else if(i == "10"){
			wall(0,1,0,1, i, t, wt,wh);
		}else if(i == "09"){
			wall(1,0,0,1, i, t, wt,wh);
		}else if(i == "08"){
			wall(0,0,0,1, i, t, wt,wh);
		}else if(i == "07"){
			wall(1,1,1,0, i, t, wt,wh);
		}else if(i == "06"){
			wall(0,1,1,0, i, t, wt,wh);
		}else if(i == "05"){
			wall(1,0,1,0, i, t, wt,wh);
		}else if(i == "04"){
			wall(0,0,1,0, i, t, wt,wh);
		}else if(i == "03"){
			wall(1,1,0,0, i, t, wt,wh);
		}else if(i == "02"){
			wall(0,1,0,0, i, t, wt,wh);
		}else if(i == "01"){
			wall(1,0,0,0, i, t, wt,wh);
		}else{
			//nothing
		}
}

module wall(a,b,c,d, i, t, wt,wh){
		if(a == 1)
			translate([0,-0.001,0])
				cube([t,wt,wh],false);
		if(b == 1)
			translate([-0.001,0,0])
				cube([wt,t,wh],false);
		if(c == 1)
			translate([0,(t-wt)+0.001,0])
				cube([t,wt,wh],false);
		if(d == 1)
			translate([(t-wt)+0.001,0,0])
				cube([wt,t,wh],false);
}