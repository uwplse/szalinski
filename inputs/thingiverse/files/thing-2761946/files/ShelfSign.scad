// Customizable shelf sign
// by Andreas Oberreiter (https://www.thingiverse.com/AndreasO73/)
// license  CC BY-NC-SA 3.0

// Sign Genaral Dimensions
//Shelf Board Thickness on which you want to slide the sign on
_boardThickness=18; 
// Reach of the sign to slide on
_signTotalDepth=6;  
//minimum 3 times _printerLayerHeight if you print with _textHeight=1 and _textWithBase=true; 
_signThickness=.8; 

//Printer Settings / Dimensions
//Printer layer height
_printerLayerHeight=.2;
//Printer nozzle width
_printerNozzle=.4;
//Font settings
_textFont="Helvetica:style=Negreta obliqua"; //Font to use
//Move the startingpoint of the text
_fontLeftCorr=-1.2; 
//Height of the text
_textSize=10; 
//Times _printerLayerHeight: Thickness of the Imprinted Text only on Layer nessasary
_textHeight=2; 
//Times _printerLayerHeight: Elevation of the Imprinted Text abov the actual Sign
_textElevation=0; 

//Generating Modi
//Generation mode: create sign or text for MultiMaterial print
//0: generate Text part 1: generate sign part 2: generate 2 transparent layers (MultiMaterial components)
_printMode=1;
//1: generate with one underlaying layer 0: generate without 
_printWithTextBase=1;
//1: generate with two transparent layerers 0: generate without 
_printWithBase=0;
//1: generate up side down (prints without support) 0: text Visible in Onlinegenerator
_generateUpSideDown=0;

//Sign to Print
//choose Predefined 0 to 36 or -1 to Enter printText and printTextWidth
_printSignNumber =-1; 
//Text to print if printSignNumber is -1 (You can use Unicodes like \uf0e9 but be aware they have to be in the aktual font there is no fontreplacement in OpenSCAD)
_printText="Thingiverse"; 
//Textwith to print if printerSignNumber is -1
_printTextWidth=72.5; 

//Possible Signs: There is no way to calculate a TextWidth so you have to gess and optimce yourselve
_possibleSigns = [ [0, "Thingiverse", 72.5],
[1, "Science fiction", 90],
[2, "Physik", 43],
[3, "Psychologie", 75],
[4, "IT-Security", 68.25],
[5, "Populärwissenschaft", 127.75],
[6, "Religion", 51.5],
[7, "Romane", 53.25],
[8, "Krimi", 34],
[9, "Lexikon", 50],
[10, "Klassiker", 59],
[11, "Soziologie", 64.5],
[12, "Pädagogik", 67],
[13, "Video", 38],
[14, "Games", 46.5],
[15, "Mathematik", 73.5],
[16, "IT", 15.25],
[17, "DIY", 25.75],
[18, "Soziales",54],
[19, "Garten",44],
[20, "Musik",39],
[21, "Biographien",75],
[22, "Geschichte",70],
[23, "Philosophie", 72.5],
[24, "Fremdsprachen", 97.5],
[25, "Soziales", 53.75],
[26, "Reisen", 44.75],
[27, "Politik", 39.5],
[28, "Sachbücher", 76],
[29, "Wirtschaft", 64],
[30, "Kochen", 49.],
[31, "Neu...", 38],
[32, "\uf0e9", 12.5], // ArrowUP change Font to Wingdings
[33, "\uf0ea", 12.5],
[34, "Kurzgeschichten", 103],
[35, "Medizin", 49],
[36, "create your own with OpenSCAD", 202]];


module o_Text (_Text,_Width)
{
    
    difference () {
    
        union () {            
            translate([_Width/2+_fontLeftCorr,0,-_textHeight*_printerLayerHeight-shiftZ]) linear_extrude(height =_textHeight*_printerLayerHeight+_textElevation*_printerLayerHeight) {
                text(_Text, font = _font, size=_textSize, valign="center", halign="center");}
            if (_textWithBase) { 
                widthIntern=_Width-(_printerNozzle*6);
                translate([_printerNozzle*3,-(_boardThickness+2-(_printerNozzle*6))/2,-_textHeight*_printerLayerHeight-_printerLayerHeight-shiftZ]) cube(size = [widthIntern,_boardThickness+2-(_printerNozzle*6),_printerLayerHeight], center = false); 
                }
            else {
                widthIntern=_Width;
            }
        }
        union () {
        }
    }
}

module o_Schild(_Text,_Width)
{
    
    difference () {
    
        union () {
            translate([0,-(_boardThickness+2)/2,-(_signTotalDepth+_signThickness+shiftZ)]) cube(size = [_Width,_boardThickness+2,_signTotalDepth+_signThickness], center = false);
            
        }
        union () {
            o_Text(_Text,_Width);
             translate([0,-(_boardThickness)/2,-(_signTotalDepth+_signThickness+shiftZ)]) cube(size = [_Width+2,_boardThickness,_signTotalDepth], center = false);
        }
    }
}

module o_Transparent (_Width)
{
    difference () {
    
        union () {
            translate([0,-(_boardThickness+2)/2,-_textHeight*_printerLayerHeight]) cube(size = [_Width,_boardThickness+2,_printerLayerHeight*2], center = false); 
        }
        union () {
        }
    }
}

//Calculated Prameters b<5&&a>8

_font = ((_printSignNumber>32)&&(_printSignNumber<33)) ? "Wingdings" : _textFont;
_textWithBase = (_printWithTextBase > 0) ? true : false;
_withBase = (_printWithBase > 0) ? true : false;
_upSideDown= (_generateUpSideDown > 0) ? true : false;
_Angle = _upSideDown ? 180 : 0 ;
_Shift = _upSideDown ? 1 : -1 ;
echo(_possibleSigns[_printSignNumber]);
text= (_printSignNumber > 0) ? _possibleSigns[_printSignNumber][1] : _printText;
width= (_printSignNumber > 0) ? _possibleSigns[_printSignNumber][2] : _printTextWidth;
shiftZ= _withBase ? 2*_printerLayerHeight : 0;

//Single Center translate([_possibleSigns[_printSigns[sign]][2]/2*_Shift,0,0])
    if (_printMode==0) {    
        translate([width/2*_Shift,0,0])  rotate([0,_Angle,0]) o_Text(text,width);
        }
    if (_printMode==1) {      
        translate([width/2*_Shift,0,0]) rotate([0,_Angle,0]) o_Schild(text,width);
    } 
    if (_printMode==2) {      
        translate([width/2*_Shift,0,0]) rotate([0,_Angle,0]) o_Transparent(width);
    } 
