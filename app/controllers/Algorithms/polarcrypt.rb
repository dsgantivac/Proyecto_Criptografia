
def caesar_cipher(string)
  shiftyArray = []
  charLine = string.chars.map(&:ord)

  shift = 1
  4.times do |shift|
    shiftyArray = charLine.map do |c|
      ((c + shift) <= 255 ? (c + shift) : (c + shift) - 255).chr
    end.join
  end

	shiftyArray
end


def caesar_decipher(string)
  shiftyArray = []
  charLine = string.chars.map(&:ord)
  
  shift = 1
  4.times do |shift|
    shiftyArray = charLine.map do |c|
      ((c - shift) >= 0 ? (c - shift) : (c - shift) + 255).chr
    end.join
  end

  shiftyArray
end

def toASCII(string)
	asciiArray = []
	string.each_byte do |c|
			asciiArray << c
	end
	asciiArray
end

def sumar(string,key)
	sumaArray = []
	(string.length).times do |i|
		sumaArray << string[i]+key[i%8]
	end
	sumaArray
end

def restar(string,key)
	sumaArray = []
	(string.length).times do |i|
		sumaArray << string[i].to_i-key[i%8]
	end
	sumaArray
end

def toASCII(string)
	asciiArray = []
	string.each_byte do |c|
		asciiArray << c
	end
	asciiArray
end

def toText(string)
	txtArray = []
	string.each_entry do |c|
			txtArray << c.chr
	end
	txtArray
end

def toString(array)
	text = ""
	array.each_entry do |i|
		text = text + i.to_s + " "
	end
	text[0...-1]
end

def decriptar(cypherText,key)
    cypherText = cypherText.split(" ")
	asciiKey = toASCII(key)
	restado = cypherText
	3.times do
		restado = restar(restado, asciiKey)
	end
	ascii = toText(restado)

	corrido = caesar_decipher(ascii.join(""))
	corrido
end

def encriptar(plainText, key)
	corrido = caesar_cipher(plainText)
	ascii = toASCII(corrido)
	asciiKey = toASCII(key)
	sumado = ascii
	3.times do
		sumado = sumar(sumado, asciiKey)
	end
	cipherText = toString(sumado)
	cipherText
end
