// js imports
import "bootstrap"
import Rails from "rails-ujs";
import * as ActiveStorage from "activestorage";
import "./home"

// css imports
import "../stylesheets/application.scss"

Rails.start();
ActiveStorage.start();
console.log("Hello World from Webpacker");
