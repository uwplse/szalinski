//Uni-Button by LoGan McCarthy 03/08/2013 LM

//CUSTOMIZER VARIABLES

//	Choose Uni-Button Scale
Button_Scale = 1;

//	Choose Uni-Button Outer Radius
Button_Radius = 6.5;

//CUSTOMIZER VARIABLES END

		scale(v = [Button_Scale,Button_Scale,Button_Scale]) {

difference() {

//BUTTON

				union() {
difference() {
			translate(v = [0,0,.475]) {  cylinder ($fn=160,.9,Button_Radius,4.25);
}
			translate(v = [0,0,20.98]) { sphere ($fn=160,r=20);
	}
		}
mirror([ 0, 0, 1 ]) { difference() {
			translate(v = [0,0,.475]) {	cylinder ($fn=160,.9,Button_Radius,4.25);
}
			translate(v = [0,0,20.98]) { sphere ($fn=160,r=20);
	}
		}
			}
cylinder ($fn=160,.95,Button_Radius,Button_Radius, center = true);
	}


//BUTTON HOLES

			translate(v = [1.6,0,0]) { cylinder ($fn=160,5,.5,.5, center = true);
}
			translate(v = [-1.6,0,0]) { cylinder ($fn=160,5,.5,.5, center = true);
}

			translate(v = [0,1.6,0]) { cylinder ($fn=160,5,.5,.5, center = true);
}

			translate(v = [0,-1.6,0]) { cylinder ($fn=160,5,.5,.5, center = true);
}

//HOLE BALLS



translate(v = [1.6,0,3.85]) { sphere ($fn=90,r=3, center = true);
}

translate(v = [-1.6,0,3.85]) { sphere ($fn=90,r=3, center = true);
}

translate(v = [0,1.6,3.85]) { sphere ($fn=90,r=3, center = true);
}

translate(v = [0,-1.6,3.85]) { sphere ($fn=90,r=3, center = true);
}

			mirror([ 0, 0, 1 ]) {
translate(v = [1.6,0,3.85]) { sphere ($fn=90,r=3, center = true);
}

translate(v = [-1.6,0,3.85]) { sphere ($fn=90,r=3, center = true);
}

translate(v = [0,1.6,3.85]) { sphere ($fn=90,r=3, center = true);
}

translate(v = [0,-1.6,3.85]) { sphere ($fn=90,r=3, center = true);
}
	}
		}
			}


		