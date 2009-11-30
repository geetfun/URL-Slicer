class UrlSlicer
  
  class InvalidUrlError < StandardError; end;

  attr_reader :url  
  def initialize(url)
    @url = url
  end
  
  def valid?
    regex = /\A(https?|ftp|file):\/\/.+\Z/
    @valid ||= url.scan(regex).length > 0 ? true : false
  end
  
  def host
    raise InvalidUrlError unless valid?
    regex = /\A[a-z][a-z0-9+\-.]*:\/\/([a-z0-9\-._~%!$&'()*+,;=]+@)?([a-z0-9\-._~%]+|\[[a-z0-9\-._~%!$&'()*+,;=:]+\])/
    @host ||= url.scan(regex).flatten.compact.to_s
  end
  
  def domain
    raise InvalidUrlError unless valid?
    regex = /^(?:(?>[a-z0-9-]*\.)+?|)([a-z0-9-]+\.(?>[a-z]*(?>\.[a-z]{2})?))$/i
    @domain ||= host.scan(regex).to_s
  end
  
  def subdomain
    raise InvalidUrlError unless valid?
    @subdomain ||= host.gsub(domain, '').gsub('.', '')
  end
  
  def port
    raise InvalidUrlError unless valid?
    regex = /^[a-z][a-z0-9+\-.]*:\/\/([a-z0-9\-._~%!$&'()*+,;=]+@)?([a-z0-9\-._~%]+|\[[a-z0-9\-._~%!$&'()*+,;=:]+\]):([0-9]+)/
    @port ||= url.scan(regex).flatten.compact[1].to_i
    
    @port == 0 ? default_port : @port
  end
  
  def default_port
    case protocol
    when "http"
      80
    when "https"
      443
    when "ftp"  
      21
    else
      nil
    end
  end
  
  def protocol
    raise InvalidUrlError unless valid?
    regex = /^(https|http|ftp|file)/
    @protocol ||= url.scan(regex).flatten[0]
  end
  
  def ssl?
    raise InvalidUrlError unless valid?
    protocol == "https" ? true : false
  end
  
end