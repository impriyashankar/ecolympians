// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

require("jquery")
require('select2')


//$(document).ready(function(){});
  // Turn on js-selectable class so that it becomes SELCT 2 tag

  import $ from 'jquery'
  import 'select2'
  import 'select2/dist/css/select2.css'

  window.addEventListener('DOMContentLoaded', () => {
    $('.js-states').select2({
      allowClear: true,
      width:'100%'
    });
  });

  $( document ).on('turbolinks:load', function() {//Added to avoid select2 tag display issues on page reload
    $( ".js-states" ).select2({
      allowClear: true,
      width:'100%'
    });
  });
