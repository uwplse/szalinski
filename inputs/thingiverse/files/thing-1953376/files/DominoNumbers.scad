// Number Declaration
Which_number_do_you_need = 11; //[1:12]
// Font Declaration
What_font = "Standard"; //	[Standard, Fjalla One, Roboto, Ubuntu, Lobster, Anton, Exo Bold, Patua One]


// Declare what size to use for each number
numSize =       (What_font == "Standard") ? 12.9 : 
                (What_font == "Fjalla One") ? 13.4 :
                (What_font == "Roboto") ? 12.9 :
                (What_font == "Ubuntu") ? 12.9 :
                (What_font == "Lobster") ? 13.9 :
                (What_font == "Anton") ? 13.9 :
                (What_font == "Exo Bold" ? 13.9 : 13.9);

//    text(Which_number_do_you_need, size = numSize, font = What_font);
    
    echo(Which_number_do_you_need);
    echo(What_font);
    echo(numSize);
    
if(Which_number_do_you_need==1) linear_extrude(height = 3){text("1", size = numSize, font = What_font);}
if(Which_number_do_you_need==2) linear_extrude(height = 3){text("2", size = numSize, font = What_font);}
if(Which_number_do_you_need==3) linear_extrude(height = 3){text("3", size = numSize, font = What_font);}
if(Which_number_do_you_need==4) linear_extrude(height = 3){text("4", size = numSize, font = What_font);}
if(Which_number_do_you_need==5) linear_extrude(height = 3){text("5", size = numSize, font = What_font);}
if(Which_number_do_you_need==6) linear_extrude(height = 3){text("6", size = numSize, font = What_font);}
if(Which_number_do_you_need==7) linear_extrude(height = 3){text("7", size = numSize, font = What_font);}
if(Which_number_do_you_need==8) linear_extrude(height = 3){text("8", size = numSize, font = What_font);}
if(Which_number_do_you_need==9) linear_extrude(height = 3){text("9", size = numSize, font = What_font);}
if(Which_number_do_you_need==10) linear_extrude(height = 3){text("10", size = numSize, font = What_font);}
if(Which_number_do_you_need==11) linear_extrude(height = 3){text("11", size = numSize, font = What_font);}
if(Which_number_do_you_need==12) linear_extrude(height = 3){text("12", size = numSize, font = What_font);}
