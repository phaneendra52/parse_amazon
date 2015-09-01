// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree ./bootstrap

$(document).ready(function() {

  $(document).on("click", "button.add_fields", function() {
    add_fields(this, $(this).data('fieldType'), $(this).data('content'));
    return false;
  });

  $(document).on("click", "button.remove_fields", function() {
    remove_fields(this);
    return false;
  });

});

function remove_fields(button) {
  return $(button).closest('.fields').remove();
}

function add_fields(button, type, content) {
  var new_id, regexp;
  new_id = new Date().getTime();
  regexp = new RegExp('new_' + type, 'g');
  return $(button).before(content.replace(regexp, new_id));
}

function remove_nested_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_nested_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
}