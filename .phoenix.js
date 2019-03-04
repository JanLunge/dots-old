// swapping space contents
Phoenix.set({
  openAtLogin: true
});
//const PHOENIX_PATH = '~/.config/phoenix/'
const DEFAULT_PATH='/usr/bin:/bin:/usr/sbin:/sbin';
//require ( PHOENIX_PATH + 'phoenix.js' );
//move mouse to screen
//Screen.main().mouseTo()
// https://github.com/kasper/phoenix/blob/master/docs/API.md#18-screen
const HYPER = ['ctrl', 'cmd', 'alt', 'shift'];
const META = ['ctrl', 'shift', 'alt'];
const NOMOD = [];
const OSASCRIPT_PATH = '~/playground/automate/';
const SHELL_PATH = '~/playground/automate/';
const HANDLERS = [];

// BASE
/* SET EVENT HANDLER */
function setEventHandler ( event, handler ) {
  HANDLERS.push ( Event.on ( event, handler ) );
}
/* SET HANDLER */
function setHandler ( key, modifier, handler, handlerArgs = [], skipRepetitions = true ) {
  HANDLERS.push ( Key.on ( key, modifier, ( identifier, repeated ) => {
    if ( repeated && skipRepetitions ) return;
    handler ( ...handlerArgs );
  }));
}
/* SHELL */
function shell ( command ) {
  Task.run('/bin/sh', ['-c', `PATH=/usr/local/bin:${DEFAULT_PATH} ${command} > /Users/jan/Desktop/1.txt`], () => {});
}
/* OSASCRIPT */
function osascript ( script, callback = _.noop ) {
  Task.run ( OSASCRIPT_PATH, [ '-e', script ], callback );
}
//protos
Screen.prototype.mouseTo = function() {
  const f = this.flippedFrame();
  return Mouse.move({
    x: f.x + (f.width / 2),
    y: f.y + (f.height / 2)
  });
};
//functions

/* CENTER WINDOW */
function center_window ( window ) {
  var screen = window.screen(),
        sFrame = window.screen().flippedFrame(),
        wFrame = window.frame ();

  window.setFrame ({
    x: sFrame.x + ( sFrame.width / 2 ) - ( wFrame.width / 2 ),
    y: ( sFrame.height / 2 ) - ( wFrame.height / 2 ),
    width: wFrame.width,
    height: wFrame.height
  });
}
function matchesFrame(frame1,frame2){
    if(frame1.x == frame2.x &&
       frame1.y == frame2.y &&
       frame1.width == frame2.width &&
       frame1.height == frame2.height){
        alert('match');
        return false;
    }
    alert(JSON.stringify(frame1));
    alert(JSON.stringify(frame2));
    return true;
}
function alert(message) {
    var modal = new Modal();
    modal.message = message;
    modal.duration = 2;
    modal.show();
}
function halves(window, side = 'left'){
    var screen = window.screen(),//Screen.main(),
        sFrame = screen.flippedVisibleFrame(),
        left = side == 'left';
    var destinationFrame = {
        x: sFrame.x + ( left ? 0 : sFrame.width / 2 ),
        y: sFrame.y,
        width: sFrame.width/2,
        height: sFrame.height
    };
  window.setFrame(destinationFrame);
}
function moveToScreen(window, screen) {
    if (!window) return;
    if (!screen) return;

    var frame = window.frame();
    var oldScreenRect = window.screen().visibleFrameInRectangle();
    var newScreenRect = screen.visibleFrameInRectangle();
    var xRatio = newScreenRect.width / oldScreenRect.width;
    var yRatio = newScreenRect.height / oldScreenRect.height;

    var mid_pos_x = frame.x + Math.round(0.5 * frame.width);
    var mid_pos_y = frame.y + Math.round(0.5 * frame.height);

    window.setFrame({
        x: (mid_pos_x - oldScreenRect.x) * xRatio + newScreenRect.x - 0.5 * frame.width,
        y: (mid_pos_y - oldScreenRect.y) * yRatio + newScreenRect.y - 0.5 * frame.height,
        width: frame.width,
        height: frame.height
    });
};
function switchScreen(alt){
    var window = Window.focused();
    var screen = alt ? window.screen().previous() : window.screen().next();
    moveToScreen(window,screen);
}

//
/* assignments */
//

//center comfort
setHandler ( 'f8', NOMOD, () => {
  center_window(Window.focused());
});

//left half
setHandler ( 'f7', NOMOD, () => {
  halves(Window.focused(), 'left');
});

//right half
setHandler ( 'f8', NOMOD, () => {
  halves(Window.focused(), 'right');
});
// //right half
// setHandler ( 'right', ['ctrl', 'cmd'], () => {
//     halves(Window.focused(), 'right');
// });
// //right half
// setHandler ( 'left', ['ctrl', 'cmd'], () => {
//     halves(Window.focused(), 'left');
// });
//right half
setHandler ( 'up', ['ctrl', 'cmd'], () => {
    switchScreen();
});
//right half
setHandler ( 'down', ['ctrl', 'cmd'], () => {
    switchScreen(true);
});
//move window
setHandler ( 'f5', NOMOD, () => {

  window = Window.focused();
  window.setFrame({
    x: Screen.all()[1].flippedFrame().x,
    y: 0,
    width: Screen.all()[1].flippedFrame().width,
    height: Screen.all()[1].flippedFrame().height
  })
});
//move window
setHandler ( 'f6', NOMOD, () => {
  window = Window.focused();
  var screenNr = window.screen() == Screen.all()[0]?2:0;
  var sFrame = Screen.all()[screenNr].flippedFrame();
  window.setFrame({
    x: sFrame.x+sFrame.width*0.1,
    y: sFrame.height*0.1,
    width: sFrame.width*0.8,
    height: sFrame.height*0.8
  })
});

// youtube media button
setHandler ( 'f4', NOMOD, () => {
  shell('osascript /Users/jan/playground/automate/youtube-play.scpt');
});

// Finder
setHandler ( 'f3', NOMOD, () => {
  App.launch ( "Finder", { focus: true } );
});
// Chrome
setHandler ( 'f2', NOMOD, () => {
  App.launch ( "Google Chrome", { focus: true } );
});
// PhpStorm
setHandler ( 'f1', NOMOD, () => {
  var phpstorm = App.get("PhpStorm");
  if( phpstorm.isActive ){
    phpstorm.windows()[phpstorm.windows().length - 1].focus();
  }else{
    App.launch ( "PhpStorm", { focus: true } );
  }
});

// // Chrome
// setHandler ( 'a', HYPER, () => {
//   App.launch ( "Google Chrome", { focus: true } );
// });
// // pause app
// setHandler ( 's', HYPER, () => {
//   osascript ( 'tell application "System Events" to return name of first process whose frontmost is true', ({ output }) => {
//     const app = _.trim ( output ),
//           isStopped = !Window.focused (); // If the app is stopped this will return undefined
//     shell ( `killall -${isStopped ? 'CONT' : 'STOP'} -c '${app}'` );
//   });

// });
