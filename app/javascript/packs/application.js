// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
var Rails = require("@rails/ujs")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

function render(res, req) {
  if (/text\/html/.test(req.getResponseHeader('content-type'))) {
    const snapshot = Turbolinks.Snapshot.wrap(res);

    if (snapshot.bodyElement.nodeName === 'BODY') {
      document.body = snapshot.bodyElement;
    }
  }
}

function refresh() {
  window.setTimeout(function() {
    Rails.ajax({
      type: "GET",
      url: "/",
      success: function(res, status, req){
        render(res, req);
        refresh();
     },

      error: function(response){
        render(res, req);
        refresh();
      }
    })
  }, 1000);
}

refresh();