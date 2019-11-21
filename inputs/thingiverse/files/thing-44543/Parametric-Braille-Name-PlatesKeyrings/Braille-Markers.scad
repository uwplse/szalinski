//Enter Text
Text="Paul";
//Text height in mm
Size=20; //[10,20,30,40,50]
Show_Build="No"; //[Yes,No]
//Size of build platform (inches)
Build_Size=12; //[8,10,12,14]
//Is this a Key Ring?
Key_Ring="No"; //[Yes,No]

module Insert(Letter,TextSize){

	x=[-TextSize,TextSize,-TextSize,TextSize,-TextSize,TextSize];
	y=[2*TextSize,2*TextSize,0,0,-2*TextSize,-2*TextSize];
	difference(){
		cube([4*TextSize,6*TextSize,1],center=true);
		cube([3.8*TextSize,5.8*TextSize,2],center=true);
	}
	//echo (Letter);
	for (i=[0:5]){
		if ((Letter[i])==1) translate([x[i],y[i],0]) sphere(r=0.5*TextSize);
	}
}
module WORD(Word,TxtSize){

	a=[1,0,0,0,0,0];
	b=[1,0,1,0,0,0];
	c=[1,1,0,0,0,0];
	d=[1,1,0,1,0,0];
	e=[1,0,0,1,0,0];
	f=[1,1,1,0,0,0];
	g=[1,1,1,1,0,0];
	h=[1,0,1,1,0,0];
	i=[0,1,1,0,0,0];
	j=[0,1,1,1,0,0];
	k=[1,0,0,0,1,0];
	l=[1,0,1,0,1,0];
	m=[1,1,0,0,1,0];
	n=[1,1,0,1,1,0];
	o=[1,0,0,1,1,0]; 
	p=[1,1,1,0,1,0];
	q=[1,1,1,1,1,0];
	r=[1,0,1,1,1,0];
	s=[0,1,1,0,1,0];
	t=[0,1,1,1,1,0];
	u=[1,0,0,0,1,1];
	v=[1,0,1,0,1,1];
	w=[0,1,1,1,0,1];
	x=[1,1,0,0,1,1];
	y=[1,1,0,1,1,1];
	z=[1,0,0,1,1,1];
	
	translate([TxtSize*3,0,0])
	for (i=[0:len(Word)-1]){
		translate([TxtSize*i*6,0,0]) {
			if (Word[i]=="A" || Word[i]=="a") Insert(a,TxtSize);
			if (Word[i]=="B" || Word[i]=="b") Insert(b,TxtSize);
			if (Word[i]=="C" || Word[i]=="c") Insert(c,TxtSize);
			if (Word[i]=="D" || Word[i]=="d") Insert(d,TxtSize);
			if (Word[i]=="E" || Word[i]=="e") Insert(e,TxtSize);
			if (Word[i]=="F" || Word[i]=="f") Insert(f,TxtSize);
			if (Word[i]=="G" || Word[i]=="g") Insert(g,TxtSize);
			if (Word[i]=="H" || Word[i]=="h") Insert(h,TxtSize);
			if (Word[i]=="I" || Word[i]=="i") Insert(i,TxtSize);
			if (Word[i]=="J" || Word[i]=="j") Insert(j,TxtSize);
			if (Word[i]=="K" || Word[i]=="k") Insert(k,TxtSize);
			if (Word[i]=="L" || Word[i]=="l") Insert(l,TxtSize);
			if (Word[i]=="M" || Word[i]=="m") Insert(m,TxtSize);
			if (Word[i]=="N" || Word[i]=="n") Insert(n,TxtSize);
			if (Word[i]=="O" || Word[i]=="o") Insert(o,TxtSize);
			if (Word[i]=="P" || Word[i]=="p") Insert(p,TxtSize);
			if (Word[i]=="Q" || Word[i]=="q") Insert(q,TxtSize);
			if (Word[i]=="R" || Word[i]=="r") Insert(r,TxtSize);
			if (Word[i]=="S" || Word[i]=="s") Insert(s,TxtSize);
			if (Word[i]=="T" || Word[i]=="t") Insert(t,TxtSize);
			if (Word[i]=="U" || Word[i]=="u") Insert(u,TxtSize);
			if (Word[i]=="V" || Word[i]=="v") Insert(v,TxtSize);
			if (Word[i]=="W" || Word[i]=="w") Insert(w,TxtSize);
			if (Word[i]=="X" || Word[i]=="x") Insert(x,TxtSize);
			if (Word[i]=="Y" || Word[i]=="y") Insert(y,TxtSize);
			if (Word[i]=="Z" || Word[i]=="z") Insert(z,TxtSize);
		}
	}
}
if (Show_Build=="Yes") { color("blue") translate([-10,-10,-.9]) cube([Build_Size*25.4,Build_Size*25.4,1]);}
if (Key_Ring=="No"){
	translate([0,0,0]) cube([Size*(len(Text)),Size*1.5,Size/10]);
	translate([0,Size*.75,Size/10]) WORD(Text,Size/6);
} else {
	difference(){
		cube([Size*(len(Text))+10,Size*1.5,Size/10]);
		translate([5,Size*.75,-2]) cylinder(r=3,h=Size);
	}
	translate([10,Size*.75,Size/10]) WORD(Text,Size/6);
}