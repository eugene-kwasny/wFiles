( function _FileProvider_Hub_Extract_test_s_( ) {

// !!! disabled because Provider.Hub is in implementation phase

'use strict';

if( typeof module !== 'undefined' )
{

  require( './aFileProvider.test.s' );

}

//

var _ = wTools;
var Parent = wTests[ 'FileProvider' ];

_.assert( Parent );

//

var filesTree =
{
  'folder.abc' :
  {
    'test1.js' : "test\n.gitignore\n.travis.yml\nMakefile\nexample.js\n",
    'test2' : "var concatMap = require('concat-map');\nvar balanced = require('balanced-match');",
    'folder2.x' :
    {
      'test1.txt' : "var concatMap = require('concat-map');\nvar balanced = require('balanced-match');",
    }
  },
  'test_dir' :
  {
    'test3.js' : 'test\n.gitignore\n.travis.yml\nMakefile\nexample.js\n',
  },
  'file1' : 'Excepteur sint occaecat cupidatat non proident',
  'file' : 'abc',
  'linkToFile' : [{ hardLink : './file' }],
  'linkToUnknown' : [{ hardLink : './unknown' }],
  'linkToDir' : [{ hardLink : './test_dir' }],
  'softLinkToFile' : [{ softLink : './file' }],
  'softLinkToUnknown' : [{ softLink : './unknown' }],
  'softLinkToDir' : [{ softLink : './test_dir' }],
}

//

function makePath( filePath )
{
  return this.providerEffective.originPath +  '/' + filePath;
}

function onSuitBegin()
{
  var self = this;
  self.providerEffective = _.FileProvider.Extract
  ({
    filesTree : filesTree,
    protocols : [ 'extract' ]
  });
  self.provider.providerRegister( self.providerEffective );
  self.provider.defaultProvider = self.providerEffective;
  self.provider.defaultOrigin = self.providerEffective.originPath;
  self.provider.defaultProtocol = thselfis.providerEffective.protocol;
}

// --
// proto
// --

var Proto =
{

  name : 'FileProvider.Hub.Extract',
  abstract : 0,
  silencing : 1,
  enabled : 0,

  onSuitBegin : onSuitBegin,

  context :
  {
    provider : _.FileProvider.Hub({ empty : 1 }),
    providerEffective : null,
    filesTree : filesTree,
    makePath : makePath,
    // testFile : 'file1'
  },

  tests :
  {
  },

}

//

var Self = new wTestSuit( Proto ).inherit( Parent );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

} )( );
