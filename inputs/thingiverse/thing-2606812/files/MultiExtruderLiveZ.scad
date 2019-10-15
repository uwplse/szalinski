// The current extruder you want to work with from 1 to the number of extruders
CurrentExtruder = 1;
// How many extruders you have.
ExtruderCount = 4;
// ExtruderCount * SpiralMultiplier = total number of spirals.
SpiralMultiplier = 4;
// The X dimension of your bed
BedSizeX = 250;
// The Y dimension of your bed
BedSizeY = 210;
// How much space on the left and right side of the x axis to leave
MarginX = 25;
// How much space on the front and back of the y axis to leave
MarginY = 25;
// How wide to draw each track.  If this value is too small you will have problems slicing.  If you are using Slic3r make sure you select 'detect thin walls'.
TrackWidth = 0.5;
// How tall to make this print.  You probably only want 1 layer.
LayerHeight = .2;


// Use at your own risk!  This has not been extensively debugged and does NOT prevent you from using unreasonable values!
module MultiExtruderTestSpiral(
CurrentExtruder = 1, // The extruder track to render (1 to ExtruderCount).  You will need to run this command once per extruder
ExtruderCount = 4, // How many extruders you have total.
SpiralMultiplier = 4, // Spirals total = ExtruderCount + SpiralMultiplier.  This does NOT mean that each extruder will have exactly 4 spirals, but things work out better if we have a multiple of the extruder count.
BedSizeX = 250, // The X width of the bed
BedSizeY = 210, // The Y width of the bed
MarginX = 25,// The amount of margin to leave on the left and right of the X axis
MarginY = 25,// The amount of margin to leave on the front and back of the Y axis
TrackWidth = 0.5,
LayerHeight = .2,
OutputDebugMessages = false
)
{
    //Calculations
    _spirals = SpiralMultiplier * ExtruderCount;
    _printSizeX = BedSizeX - MarginX*2;
    _printSizeY = BedSizeY - MarginY*2;
    _trackSpacingX = ((_printSizeX-TrackWidth*2)/(_spirals+1));
    _trackSpacingY = ((_printSizeY-TrackWidth*2)/(_spirals+1));

    translate([MarginX,MarginY])    // Center the object in the bed
    union()
    {
        // Calculate the length of the entire spiral.
        _spiralLengthTotal = _spiralLength(_spirals, 1,_printSizeX, _printSizeY, _trackSpacingX,_trackSpacingY, TrackWidth);
        // Calculate how much track would be drawn if things are 100% fair
        _lengthToPrintPerFilament = _spiralLengthTotal/ExtruderCount;
        // Calculate the start and end position of the current extruder in an ideal world
        _endLength = _lengthToPrintPerFilament * CurrentExtruder;
        _startLength = _endLength - _lengthToPrintPerFilament;
        
        if(OutputDebugMessages)
        {
            // Show some critical variables to help with debugging
            echo(SpiralLength=_spiralLengthTotal
                ,SpiralLengthPerFilament=_lengthToPrintPerFilament
                ,StartLength =_startLength
                ,EndLength = _endLength
                ,Difference = _endLength-_startLength
                );
        }
        for(_currentSpiral = [0:_spirals])
        {

            // Find each track length for the current spiral
            // First track, in X direction from left to right
            _trackLength1 = _printSizeX-(_trackSpacingX*_currentSpiral);
            // Second track, in Y direction, from front to back
            _trackLength2 = _printSizeY-_trackSpacingY*(_currentSpiral)+TrackWidth;
            // Third track, in the X direction from right to left.
            _trackLength3 = _printSizeX-(_trackSpacingX*(_currentSpiral+.5));
            // Fourth track, in the Y direction, from back to front
            _trackLength4 = _printSizeY-_trackSpacingY*(_currentSpiral+.5);
            _lengthPrinted = _spiralLength(_currentSpiral, 1,_printSizeX, _printSizeY, _trackSpacingX,_trackSpacingY, TrackWidth);
            
            if(_lengthPrinted >= _startLength && _lengthPrinted < _endLength)
            {
                if(OutputDebugMessages)
                {
                    echo(Extruder=CurrentExtruder
                        ,LengthPrinted = _lengthPrinted
                        ,Distance = _trackLength1+_trackLength2+_trackLength3+_trackLength4
                        ,Track1Length=_trackLength1
                        ,Track2Length = _trackLength2
                        , Track3Length=_trackLength3
                        , Track4Length = _trackLength4);
                }
                // First track, in X direction from left to right
                translate([_trackSpacingX*_currentSpiral/2,_trackSpacingY*_currentSpiral/2])cube([_trackLength1,TrackWidth,LayerHeight]);
                // Second track, in Y direction, from front to back
                translate([_printSizeX-_trackSpacingX*(_currentSpiral)/2,_trackSpacingY*(_currentSpiral)/2])cube([TrackWidth,_trackLength2,LayerHeight]);
                // Third track, in the X direction from right to left.
                translate([_trackSpacingX*(_currentSpiral+1)/2,_printSizeY-_trackSpacingY*_currentSpiral/2])cube([_trackLength3,TrackWidth,LayerHeight]);
                // Fourth track, in the Y direction, from back to front
                translate([_trackSpacingX*(_currentSpiral+1)/2,_trackSpacingY*(_currentSpiral+1)/2])cube([TrackWidth,_trackLength4,LayerHeight]);
            }
        }
        
        
    }
}
// Calculate the length of a series of spirals, starting with SpiralNum and ending at EndSpiral
function _spiralLength(SpiralNum,EndSpiral, PrintSizeX , PrintSizeY, TrackSpackingX, TrackSpackingY, TrackWidth) = 
(
    SpiralNum < EndSpiral ? 0 
        : PrintSizeX-(TrackSpackingX*SpiralNum) +
          PrintSizeY-TrackSpackingY*(SpiralNum)+TrackWidth +
          PrintSizeY-TrackSpackingY*(SpiralNum+.5) +
          PrintSizeX-(TrackSpackingX*(SpiralNum+.5)) +
          _spiralLength(SpiralNum- 1, EndSpiral,PrintSizeX , PrintSizeY, TrackSpackingX, TrackSpackingY, TrackWidth)
);

// Sample using defaults (Prusa Mk2 with MMU) , one command per extruder.
/*
MultiExtruderTestSpiral(CurrentExtruder=1);
MultiExtruderTestSpiral(CurrentExtruder=2);
MultiExtruderTestSpiral(CurrentExtruder=3);
MultiExtruderTestSpiral(CurrentExtruder=4);
*/

// Sample dual extruder setup
/*
MultiExtruderTestSpiral(CurrentExtruder=1,ExtruderCount=2);
MultiExtruderTestSpiral(CurrentExtruder=2,ExtruderCount=2);
*/




MultiExtruderTestSpiral(
    CurrentExtruder = CurrentExtruder,
    ExtruderCount = ExtruderCount,
    SpiralMultiplier = SpiralMultiplier,
    BedSizeX = BedSizeX,
    BedSizeY = BedSizeY,
    MarginX = MarginX,
    MarginY = MarginY,
    TrackWidth = TrackWidth,
    LayerHeight = LayerHeight

);

