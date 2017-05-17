//= require ./cable
var beerControl = function(percent) {
  $('#liquid') // I Said Fill 'Er Up!
    .animate({
      height: (170 * (percent / 100)) + 'px'
    }, 250);

  $('.beer-foam') // Keep that Foam Rollin' Toward the Top! Yahooo!
    .animate({
      bottom: (200 * (percent / 100)) + 'px'
      }, 250);
}

var percentage = 100;
var int;

$(document).ready(function() {
  $('.pour').hide()

  beerControl(100)

  int = setInterval(function() {
    percentage--;
    beerControl(percentage);

    if (percentage <= 0) {
      clearInterval(int);
    }
  }, 1000);
});


App.cable.subscriptions.create({ channel: "BeerChannel" }, {
  received: function(data) {
    percentage += data.percentage;
    if (percentage >= 100) { percentage = 100; }
    beerControl(percentage)
  }
})
