# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#postal_code1").jpostal({
    postcode : [ "#postal_code1",
    			 "#postal_code2"
    			],
    address  : {
                  "#prefecture_code" : "%3",
                  "#city"            : "%4",
                  "#building"        : "%5%6%7"
                }
  });