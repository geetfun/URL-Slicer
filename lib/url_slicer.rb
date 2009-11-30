class UrlSlicer

  attr_reader :url
  
  def initialize(url)
    @url = url
  end
  
  def valid?
    regex = /\A(https?|ftp|file):\/\/.+\Z/
    @valid ||= url.scan(regex).length > 0 ? true : false
  end
  
  def host
    regex = /\A[a-z][a-z0-9+\-.]*:\/\/([a-z0-9\-._~%!$&'()*+,;=]+@)?([a-z0-9\-._~%]+|\[[a-z0-9\-._~%!$&'()*+,;=:]+\])/
    @host ||= url.scan(regex).flatten.compact.to_s
  end
  
  def domain
    regex = /^(?:(?>[a-z0-9-]*\.)+?|)([a-z0-9-]+\.(?>[a-z]*(?>\.[a-z]{2})?))$/i
    @domain ||= host.scan(regex).to_s
  end
  
  def subdomain
    @subdomain ||= host.gsub(domain, '').gsub('.', '')
  end
  
  def port
    regex = /^[a-z][a-z0-9+\-.]*:\/\/([a-z0-9\-._~%!$&'()*+,;=]+@)?([a-z0-9\-._~%]+|\[[a-z0-9\-._~%!$&'()*+,;=:]+\]):([0-9]+)/
    @port ||= url.scan(regex).flatten.compact[1].to_i
    
    @port == 0 ? default_port : @port
  end
  
  def default_port
    80
  end
  
  
  
end