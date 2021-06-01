/* app/javascript/packs/application.js */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "controllers"
import "bootstrap"
import "jquery"
import "@fortawesome/fontawesome-free/css/all"
global.toastr = require("toastr")
import "spark"; // vendor/assets/javascripts

import "../stylesheets/application"
import "../js/common";
import "../js/proposal_form";

window.Turbo = Turbo
Rails.start();
ActiveStorage.start();


