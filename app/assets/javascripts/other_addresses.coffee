# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#other_address_postcode").jpostal({
    postcode : [ "#other_address_postal_cadde1",
    			 "#other_address_postal_cadde2" ],
    address  : {
                  "#other_address_prefecture_code" : "%3",
                  "#other_address_city"            : "%4",
                  "#other_address_building"          : "%5%6%7"
                }
  })
