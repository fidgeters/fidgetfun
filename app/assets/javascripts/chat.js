//= require ./cable

var buttonPresses = 0;

var messages = {
  one: 'Hey, nice to meet you!',
  five: "Watch out for the sore thumb!",
  ten: 'Wow, you are really fidgiting!',
  sevenish: 'Ooh, just the way I like it',
  thirteenish: 'Yes yes yes, do it again',
  // dial
  arm_twister: "Don't twist my arm",
  zen: 'Totally Zen 🙏🏻',
  round_the_world: 'Round round the world it goes',
  // switch
  turn_on: 'You really turn me on!',
  turn_off: 'It was nice while it lasted...'
}

var hitZero;
App.cable.subscriptions.create({ channel: "EventsChannel" }, {
  received: function(data) {
    if (data.event_type == 'button') {
      buttonPresses++;
    }

    if (data.event_type == 'switch') {
      if (data.value == 1) {
        triggerOnce('turn_on');
      } else {
        triggerOnce('turn_off');
      }
    }

    if (data.event_type == 'meter') {
      if (data.value == 10) {
        triggerOnce('arm_twister');
      }

      if (data.value == 0) {
        hitZero = true;
        triggerOnce('zen');
      }
      if (data.value == 10 && hitZero) {
        trigger('round_the_world');
        hitZero = false;
      }
    }

    calculateMessages()
  }
})

var shown = {};

function calculateMessages() {
  if (buttonPresses > 0) { triggerOnce('one'); }
  if (buttonPresses > 5) { triggerOnce('five'); }
  if (buttonPresses > 10) { triggerOnce('ten'); }
  if (buttonPresses % 7 == 0 && buttonPresses > 0) { trigger('sevenish'); }
  if (buttonPresses % 13 == 0 && buttonPresses > 0) { trigger('thirteenish'); }
}

var $masterWrapper;

$(function() {
  $masterWrapper = $('.speech-wrapper .bubble').remove()
});

function addMessage(message) {
  var c = $masterWrapper.clone().hide()
  c.find('.message').text(message)

  var d = new Date();
  var hour = "" + d.getHours();
  if (hour.length == 1) hour = "0" + hour;
  var mins = "" + d.getMinutes();
  if (mins.length == 1) mins = "0" + mins;
  c.find('.timestamp').text(hour + ':' + mins)
  $('.speech-wrapper').prepend(c);
  c.slideDown()

  $('.zero-state').hide()
}

var seen = {};
function triggerOnce(message) {
  if (seen[message]) return;
  seen[message] = true;
  trigger(message)
}

function trigger(message) {
  addMessage(messages[message]);
}
