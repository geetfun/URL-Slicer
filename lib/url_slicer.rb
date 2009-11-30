class UrlSlicer

  attr_reader :url
  
  def initialize(url)
    @url = url
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
    
  end
  
  
  def valid?
    regex = /\A(https?|ftp|file):\/\/.+\Z/
    @valid ||= url.scan(regex).length > 0 ? true : false
  end
  
end