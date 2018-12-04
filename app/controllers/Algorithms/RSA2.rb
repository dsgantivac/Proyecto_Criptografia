# generate keys


















#............................................................

#convert number to string
def n_to_s( n )
  s = ""
  while( n > 0 )
    s = ( n & 0xFF ).chr + s
    n >>= 8
  end
  s
end

# Convert string to number
def s_to_n( s )
  n = 0
  s.each_byte do |b|
    n = n * 256 + b
  end
  n
end

def mod_pow( base, power, mod )
  res = 1
  while power > 0
    res = (res * base) % mod if power & 1 == 1
    base = base ** 2 % mod
    power >>= 1
  end
  res
end

def inv_mod(a, m)
  g, x, y = egcd(a, m)
	if g != 1
		return -1
	else
		return x % m
	end
end

def rsa_encrypt(m,e,n)
  array = [m]
  array = array.first.chars.each_slice(2).to_a.map(&:join)
  m = []
  array.each do |group|
    tmp = s_to_n(group)
    m.push(mod_pow( tmp, e, n ))
  end
  m
end

def rsa_decrypt(array,d,n)
  m = []
  array.each do |group|
    tmp = mod_pow( group, d, n )
    m.push(n_to_s(tmp))
  end
end





