//Charles Zanon
//MTU 4777 Customizer Mini Project

//Facet Number
$fn=50;

//Variable for text for customizable texts
txt="Chuck";


//Length will vary per how many characters of text
length=56;

//Width will remain constant for this font size
width=25;

//Height will vary with user input
height=8;

border = 3;
inset = 3;
base = 3;



//Cube
module base(){
translate([ border, border, 0 ])
    
    difference(){  
        cube([
            length - 2*border,
            width - 2*border,
            height
        ]);
    ;
    
    translate([ border, border, base ])
    cube([
            length - 4*border,
            width - 4*border,
            height
        ]);
    
}
}



//Text 
module sub(){
translate([ border+inset+2, border + inset+2,0]){
    
    linear_extrude( height = height ){
        
text(text=txt,
    font="Iowan Old Style:style=Roman",
    size=10,
    spacing=1
    );
        
}
}
}

module nametag();
union(){base();sub();}

{nametag();}


