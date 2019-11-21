//---------- <CONFIG> ----------

//	FRAME
		ft=1.8;		//frame thickness
		fh=4;		//frame height

//	FLIGHT CONTROLLER
		fc_ss=26;	//flight controller screw spacing

//	PROPS
		ps=45;		//prop size
		pc=15;		//prop clearance

//	MOTOR
		md=6;		//motor diameter
		mt=1.2;		//motor holder thickness
		mh=5;		//motor holder height

//	ADVANCED
		$fa=4;
		$fs=0.5;

//---------- </CONFIG> ----------

for(i=[0:4-1]){
	rotate([0,0,90*i]){
		difference(){
			st();
			mpt(md,5);
		}

		difference(){
			mpt(md+(mt*2),mh);
			mpt(md,mh+1);
		}

		difference(){
			fcst(3,fh+1);
			fcst(1.2,fh+2);
		}
		fcst(4.5,fh);
	}
}



//---------- <MATH> ----------

	fc_ss_x=sqrt((fc_ss*fc_ss)+(fc_ss*fc_ss));

//---------- </MATH> ----------

//---------- <MODULES> ----------

//	flight controller screw template
	module fcst(d,h){
		translate([fc_ss_x/2,0,0])
			cylinder(d=d,h=h);
	}
	
//	motor/prop template
	module mpt(d,h){
		translate([(pc+ps)/2,(pc+ps)/2,0])
			cylinder(d=d,h=h);
	}

//	strut template
	module st(){
		hull(){
			mpt(ft,fh);
			fcst(ft,fh);
		}

		hull(){
			mpt(ft,fh);
			rotate([0,0,90])
				fcst(ft,fh);
		}
	}
	
//---------- </MODULES> ----------