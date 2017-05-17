//= require ./cable
window.beerControl = function(percent) {
  $('#liquid') // I Said Fill 'Er Up!
    .animate({
      height: (170 * (percent / 100)) + 'px'
    }, 250);

  $('.beer-foam') // Keep that Foam Rollin' Toward the Top! Yahooo!
    .animate({
      bottom: (200 * (percent / 100)) + 'px'
      }, 250);
}

$(document).ready(function() {
  $('.pour').hide()

  beerControl(0)
});


App.cable.subscriptions.create({ channel: "BeerChannel" }, {
  received: function(data) {
    console.log(data);
    beerControl(data.percentage)
  }
})
