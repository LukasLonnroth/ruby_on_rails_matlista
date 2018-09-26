require 'rest-client'
require 'rubygems'
require 'json'

class WelcomeController < ApplicationController
  def index
    response = RestClient.get('https://www.amica.fi/modules/json/json/Index?costNumber=3003&language=sv-FI')
    json = JSON.parse(response)
    menusForDays = json['MenusForDays']
    today = menusForDays[0]
    setmenus = today['SetMenus']
    todayString = ""

    for value in setmenus
      components = value['Components']
      for value in components
        todayString = todayString + value + '<br>'
      end
    end
    @arcadaResponse = todayString

    response = RestClient.get('https://www.fazerfoodco.fi/modules/json/json/Index?costNumber=3104&language=sv-FI')
    json = JSON.parse(response)
    menusForDays = json['MenusForDays']
    today = menusForDays[0]
    setmenus = today['SetMenus']
    todayString = ""

    for value in setmenus
      components = value['Components']
      for value in components
        todayString = todayString + value + '<br>'
      end
    end
    @diakResponse = todayString
  end
end
