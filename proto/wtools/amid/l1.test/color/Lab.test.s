( function _lab_test_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../Tools.s' );
  require( '../../l1/color/entry/ColorBasic.s' );
  _.include( 'wTesting' );
  _.include( 'wMathVector' );
}

let _ = _global_.wTools;

// --
// tests
// --

function _strToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = 'lab(0,0,0)';
  var expected = [ 0, 0, 0 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = 'lab(100, 0, -0)';
  var expected = [ 1, 1, 1 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = 'lab(53.241, 80.092, 67.203)';
  var expected = [ 1, 0, 0 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = 'lab(87.735, -86.183, 83.179)';
  var expected = [ 0, 1, 0 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = 'lab(32.297,79.188,-107.860)';
  var expected = [ 0, 0, 1 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = 'lab(97.139,-21.554,94.478)';
  var expected = [ 1, 1, 0 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = 'lab(91.113,-48.088,-14.131)';
  var expected = [ 0, 1, 1 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = 'lab(60.324,98.234,-60.825)';
  var expected = [ 1, 0, 1 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'lab(54.385, 7.912, 59.883)';
  var src = 'lab(54.385, 7.912, 59.883)';
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'lab(84.594, -64.473, 24.743)';
  var src = 'lab(84.594, -64.473, 24.743)';
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'lab(81.504, -11.785, 69.259)';
  var src = 'lab(81.504, -11.785, 69.259)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'lab(81.504, -11.785, 69.259, 100) with alpha = 100';
  var src = 'lab(81.504, -11.785, 69.259, 100)';
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.lab._strToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 100';
  var src = 'lab(811.504, -11.785, 69.259)';
  var expected = null;
  var got = _.color.lab._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 127';
  var src = 'lab(81.504, 1111.785, 69.259)';
  var expected = null;
  var got = _.color.lab._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 127';
  var src = 'lab(81.504, -11.785, 699.259)';
  var expected = null;
  var got = _.color.lab._strToRgb( null, src );
  test.identical( got, expected );

  test.case = 'alpha !== 100';
  var src = 'lab(81.504, -11.785, 69.259, 120)';
  test.shouldThrowErrorSync( () => _.color.lab._strToRgb( null, src ) )

}

_strToRgb.accuracy = 1e-2;

//

function _strToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = 'lab(0, 0%, 0%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.lab._strToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = 'lab(120, 100%, 50%)';
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.lab._strToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = 'lab(0, 100%, 50%)';
  var dst = new I8x([ 1, 5, 15 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.lab._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = 'lab(0, 0%, 100%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.lab._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = 'lab(45, 98%, 33%), dst = Array';
  var src = 'lab(45, 98%, 33%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'lab(45, 98%, 33%), dst = Long';
  var src = 'lab(45, 98%, 33%)';
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'lab(45, 98%, 33%), dst = TypedArray';
  var src = 'lab(45, 98%, 33%)';
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'lab(45, 98%, 33%), dst = VectorAdapter';
  var src = 'lab(45, 98%, 33%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = 'lab(45, 98%, 33%, 100%) with alpha = 100, dst = Array';
  var src = 'lab(45, 98%, 33%, 100%)';
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._strToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = 'lab(45, 98%, 33%, 100%) with alpha = 100, dst = VectorAdapter';
  var src = 'lab(45, 98%, 33%, 100%)';
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._strToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = 'lab(55, 68%, 55%)';
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.lab._strToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = 'lab(55, 68%, 55%)';
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.lab._strToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = 'lab(55, 68%, 55%)';
  var dst = new Float32Array([ 1, 2, 3, 4 ]);
  test.shouldThrowErrorSync( () => _.color.lab._strToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = 'lab(55, 68%, 55%)';
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.lab._strToRgb( dst, src ) )

}

_strToRgbWithDst.accuracy = 1e-2;

//

function _longToRgb( test )
{

  test.open( 'basic colors' );

  test.case = 'Black';
  var src = [ 0, 0, 0 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'White';
  var src = [ 0, 0, 1 ];
  var expected = [ 1, 1, 1 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Red';
  var src = [ 0, 1, 0.5 ];
  var expected = [ 1, 0, 0 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Green';
  var src = [ 0.3333333333333333, 1, 0.5 ];
  var expected = [ 0, 1, 0 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Blue';
  var src = [ 0.6666666666666666, 1, 0.5 ];
  var expected = [ 0, 0, 1 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Yellow';
  var src = [ 0.1666666666666666, 1, 0.5 ];
  var expected = [ 1, 1, 0 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Cyan';
  var src = [ 0.5, 1, 0.5 ];
  var expected = [ 0, 1, 1 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = 'Magenta';
  var src = [ 0.8333333333333333, 1, 0.5 ];
  var expected = [ 1, 0, 1 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.125, 0.98, 0.33 ]';
  var src = [ 0.125, 0.98, 0.33 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.4361111111111111, 0.87, 0.53 ]';
  var src = [ 0.4361111111111111, 0.87, 0.53 ];
  var expected = [ 0.12156862745098039, 0.9411764705882353, 0.6352941176470588 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.1527777777777778, 0.68, 0.55 ]';
  var src = [ 0.1527777777777778, 0.68, 0.55 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.case = '[ 0.1527777777777778, 0.68, 0.55, 1 ] with alpha = 1';
  var src = [ 0.1527777777777778, 0.68, 0.55, 1 ];
  var expected = [ 0.8549019607843137, 0.807843137254902, 0.23921568627450981 ];
  var got = _.color.lab._longToRgb( null, src );
  test.equivalent( got, expected );

  test.close( 'non basic colors' );

  test.case = 'first arg > 1';
  var src = [ 2, 0.5, 0.5 ];
  var expected = null;
  var got = _.color.lab._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'second arg > 1';
  var src = [ 0.2, 5, 0.5 ];
  var expected = null;
  var got = _.color.lab._longToRgb( null, src );
  test.identical( got, expected );

  test.case = 'third arg > 1';
  var src = [ 0.2, 0.5, 1.1 ];
  var expected = null;
  var got = _.color.lab._longToRgb( null, src );
  test.identical( got, expected );

}

_longToRgb.accuracy = 1e-2;

//

function _longToRgbWithDst( test )
{

  test.open( 'basic colors' );

  test.case = 'Black, dst = Array';
  var src = [ 0, 0, 0 ]
  var dst = [ 1, 2, 3 ];
  var expected = [ 0, 0, 0 ];
  var got = _.color.lab._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Green, dst = Long';
  var src = [ 0.3333333333333333, 1, 0.5 ];
  var dst = _.longFrom([ 1, 4, 13 ]);
  var expected = [ 0, 1, 0 ];
  var got = _.color.lab._longToRgb( dst, src );
  test.identical( got, expected );
  test.true( got === dst );

  test.case = 'Red, dst = TypedArray';
  var src = [ 0, 1, 0.5 ];
  var dst = new I8x([ 1, 5, 15 ]); /* 1 and 0 -> Integer Typed Array can be used */
  var expected = [ 1, 0, 0 ];
  var got = _.color.lab._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = 'White, dst = VectorAdapter';
  var src = [ 0, 0, 1 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 1, 1, 1 ];
  var got = _.color.lab._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.identical( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'basic colors' );

  /* */

  test.open( 'non basic colors' );

  test.case = '[ 0.125, 0.98, 0.33 ], dst = Array';
  var src = [ 0.125, 0.98, 0.33 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33 ], dst = Long';
  var src = [ 0.125, 0.98, 0.33 ];
  var dst = _.longFrom([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33 ], dst = TypedArray';
  var src = [ 0.125, 0.98, 0.33 ];
  var dst = new Float32Array([ 1, 2, 3 ]); /* ( 0, 1 ) -> Integer Typed Array can NOT be used */
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got[ i ], expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33 ], dst = VectorAdapter';
  var src = [ 0.125, 0.98, 0.33 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33, 1 ] with alpha = 100, dst = Array';
  var src = [ 0.125, 0.98, 0.33, 1 ];
  var dst = [ 1, 2, 3 ];
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._longToRgb( dst, src );
  test.equivalent( got, expected );
  test.true( got === dst );

  test.case = '[ 0.125, 0.98, 0.33, 1 ] with alpha = 100, dst = VectorAdapter';
  var src = [ 0.125, 0.98, 0.33, 1 ];
  var dst = _.vad.fromLong([ 1, 2, 3 ]);
  var expected = [ 0.6531372549019608, 0.4823529411764706, 0.00784313725490196 ];
  var got = _.color.lab._longToRgb( dst, src );
  for( let i = 0; i < expected.length; i++ )
  test.equivalent( got.eGet( i ), expected[ i ] );
  test.true( got === dst );

  test.close( 'non basic colors' );

  test.case = 'first arg > 360';
  var src = [ 4.5, 0.9, 0.36 ]
  var expected = null;
  var got = _.color.lab._longToRgb( [ 1, 2, 3, 4 ], src );
  test.identical( got, expected );

  test.case = 'second arg > 100%';
  var src = [ 0.45, 9, 0.36 ]
  var expected = null;
  var got = _.color.lab._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  test.case = 'third arg > 100%';
  var src = [ 0.45, 0.9, 1.2 ]
  var expected = null;
  var got = _.color.lab._longToRgb( [ 1, 2, 3 ], src );
  test.identical( got, expected );

  /* - */

  test.case = 'dst : Array; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = [ 1, 2, 3, 5, 6 ];
  test.shouldThrowErrorSync( () => _.color.lab._longToRgb( dst, src ) )

  test.case = 'dst : Long; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = _.longFrom([ 1, 2 ]);
  test.shouldThrowErrorSync( () => _.color.lab._longToRgb( dst, src ) )

  test.case = 'dst : TypedArray; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = new Float32Array([ 1, 2, 3, 4 ]);
  test.shouldThrowErrorSync( () => _.color.lab._longToRgb( dst, src ) )

  test.case = 'dst : VectorAdapter; dst.length !== 3';
  var src = [ 0.45, 0.45, 0.45 ];
  var dst = _.vad.fromLong([ 1 ]);
  test.shouldThrowErrorSync( () => _.color.lab._longToRgb( dst, src ) )

}

_longToRgbWithDst.accuracy = 1e-2;

//

function _validate( test )
{

  test.case = 'normal 3 elements';
  var src = [ 11, 16, 75 ];
  var expected = true;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

  test.case = 'normal 4 elements';
  var src = [ 11, 16, 75, 40 ];
  var expected = true;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

  test.case = 'first arg > 360';
  var src = [ 1111, 16, 75 ];
  var expected = false;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

  test.case = 'first arg < 0';
  var src = [ -111, 16, 75 ];
  var expected = false;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

  test.case = 'second arg > 100';
  var src = [ 11, 160, 75 ];
  var expected = false;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

  test.case = 'second arg < 0';
  var src = [ 11, -160, 75 ];
  var expected = false;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

  test.case = 'third arg > 100';
  var src = [ 11, 16, 750 ];
  var expected = false;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

  test.case = 'third arg < 0';
  var src = [ 11, 16, -750 ];
  var expected = false;
  var got = _.color.lab._validate( src );
  test.identical( got, expected );

}

//

function _formatStringParse( test )
{
  test.case = 'normal 3';
  var src = 'lab(0,0%,100%)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.lab._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 3';
  var src = 'lab(0, 0%, 100%)';
  var expected = [ 0, 0, 100 ];
  var got = _.color.lab._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal 4';
  var src = 'lab(0,0%,0%,100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.lab._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'normal spaces 4';
  var src = 'lab(0, 0%, 0%, 100%)';
  var expected = [ 0, 0, 0, 100 ];
  var got = _.color.lab._formatStringParse( src );
  test.identical( got, expected );

  test.case = 'wrong format';
  var src = 'hwba(0,0%,0%)';
  test.shouldThrowErrorSync( () => _.color.lab._formatStringParse( src ) );

  test.case = 'redundant channel';
  var src = 'lab(0,0%,0%,0%,100%)';
  test.shouldThrowErrorSync( () => _.color.lab._formatStringParse( src ) );

  test.case = 'without \'%\'';
  var src = 'lab(0,0,0%)';
  test.shouldThrowErrorSync( () => _.color.lab._formatStringParse( src ) );

  test.case = 'more than 3 digits \'%\'';
  var src = 'lab(0,0%,1000%)';
  test.shouldThrowErrorSync( () => _.color.lab._formatStringParse( src ) );
}


// --
// declare
// --

let Self =
{

  name : 'Tools/mid/lab',
  silencing : 1,

  tests :
  {
    // to rgb/a

    _strToRgb,
    // _strToRgbWithDst,
    // _longToRgb,
    // _longToRgbWithDst,
    // _validate,
    // _formatStringParse

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
