require "Algorithms/rsa.rb"
class WelcomeController < ApplicationController

  def index
    p = 47
    q = 71
    @n = p*q
    @phi = (p-1)*(q-1)
    @e = e_finder(@phi) 
    @key1 = @e
    @key2 = @n
  end

end
