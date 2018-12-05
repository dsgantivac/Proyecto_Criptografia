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
  
  def prime_numbers(n)
    
    i = 2
    while @primes.size < n do
      @primes << i if is_prime?(i)
      i += 1
    end
    @primes
  end
  
  def is_prime?(n)
    @primes.each { |prime| return false if n % prime == 0 }
    true
  end
  
  def e_finder(a)
      i=2
      while a.gcd(i) != 1
          i +=1
      end
      i
  end
  
  def egcd(a,b)
      if a==0
          return b, 0, 1
      else
          g, y, x = egcd(b % a, a)
          return g, x - (b / a).to_i * y, y
      end
  end
  
  def inv_mod(a, m)
    g, x, y = egcd(a, m)
      if g != 1
          return -1
      else
          return x % m
      end
      
  end
  
 
  
  def decryptRsa(array,d,n)
    m = ""
    print("power:",d, "\n")
    array.each do |group|
        group = group.to_i

      tmp = mod_pow( group, d, n )
      m = m+n_to_s(tmp)
    end
    m
  end