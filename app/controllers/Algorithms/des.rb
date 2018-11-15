require_relative 'src/encoder'
require_relative 'src/decoder'
require_relative 'src/algorithm_parameters'

s=""
def several_iterations(input)  #pille esta mierda lo que le hace es que pueda ejecutar el encode y decode n veces siendo n el numero decadenas de 8 bytes que tenga la entrada
  string_p=input

  if (string_p.length % 8 ) !=0    #aqui hago los machetes para complementar con 0 si hace falta
    a = string_p.length
    b = 8 -(a % 8 )
    string_p = string_p.ljust((a+b),' ')
  end

  aux = string_p.length / 8
  #print aux
  array_aux=[]
  string_aux =""

  for i in 0..(aux -1) do
    array_aux[i] =  string_p[(8*(i))..(8*(i+1)-1)]  #aqui divido la  string en bloques de 8 caracteres y los meto a un array
  end

  return array_aux
end

def set_block_to_decode(s)
  DES::AlgorithmParameters.set_block_to_decode(s)
end


def get_block_to_decode
  DES::AlgorithmParameters.get_block_to_decode
end

def get_block_to_encode(s)
  DES::AlgorithmParameters.get_block_to_encode(s)
end

def set_key(s)
  DES::AlgorithmParameters.set_key(s)
end


def encrypt(input,key)
  set_key(key)
  DES::AlgorithmHelper.create_round_keys
  array_aux=several_iterations(input)
  arr = []
  text = ""
  for i in 0..(array_aux.length-1)
     block = get_block_to_encode(array_aux[i]) #ahi le paso cada pos del array para que forme bloques y con eso encripte y desencripte
     DES::Encoder.encode(block) #encripta
     tmp = DES::Encoder.cipherText
     arr.push(get_block_to_decode)
     text+=get_block_to_decode
     text+='!/^'
	end
  text.force_encoding('UTF-8')
  return text
end


def decrypt(text,key)
  text.force_encoding('ASCII-8BIT')
  arr = text.split('!/^')
  set_key(key)
  DES::AlgorithmHelper.create_round_keys
  result = ""
  for i in 0..(arr.length-1)
     block = set_block_to_decode(arr[i]) #ahi le paso cada pos del array para que forme bloques y con eso encripte y desencripte
     DES::Decoder.decode(block) #desencripta
     tmp = DES::Decoder.cipherText
     tmp[0]=""
     tmp[8]=""
     result+= tmp
	end
  result.force_encoding('UTF-8')
  return result
end


=begin
msj = "hola mundo de monda"
k ="12345678"
puts msj
a = encrypt(msj,k)
puts a
puts decrypt(a,k)
=end



#
