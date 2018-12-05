require "Algorithms/rsa.rb"
class WelcomeController < ApplicationController

  def index
    #la posicion 0 es la llave publica
    #la posicion 1 es la llave privada
    #la posicion 2 es n
     # p = 47
      #q = 71
      #@n = p*q
      #@phi = (p-1)*(q-1)
      #@e = e_finder(@phi)
      #@key1 = @e
      #@key2 = @n
    array_aux ={}
    array_aux = generate_keys()
    $global_e = array_aux[0]
    $global_n = array_aux[1]
    $global_d = array_aux[2]

    end

end
