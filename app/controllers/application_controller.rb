require "src/isValid.rb"
require "Algorithms/des.rb"
require "Algorithms/polarcrypt.rb"
require "Algorithms/RSA2.rb"

class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception



  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  # generate keys

  def generate_keys()
    primes = prime_numbers((rand(503)))
    p = primes[-1]
    q = primes[-2]
    puts p
    puts q
    n = p*q
    phi = (p-1)*(q-1)
    e = e_finder(phi)
    d = inv_mod(e, phi)
    
    return [e,d,n,phi]
  end

  def prime_numbers(n)
    i = 2
    @primes = []
    while @primes.size < n do
      @primes << i if is_prime?(i)
      i += 1
    end
    @primes
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

  def is_prime?(n)
    @primes.each { |prime| return false if n % prime == 0 }
    true
  end
 
#............................................................ 

  helper_method :current_user
  helper_method :isValid

end
