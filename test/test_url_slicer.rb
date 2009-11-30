require 'helper'

class TestUrlSlicer < Test::Unit::TestCase
  context "validating URL" do
    should "be valid if url is http://www.test.com" do
      url = UrlSlicer.new("http://www.test.com")
      assert url.valid?
    end
    
    should "be valid if url is ftp://ftp.test.com" do
      url = UrlSlicer.new("ftp://ftp.test.com")
      assert url.valid?
    end
    
    should "not be valid if url is www" do
      url = UrlSlicer.new("www")
      assert !url.valid?
    end
    
    should "not be valid if url is http://" do
      url = UrlSlicer.new("http://")
      assert !url.valid?
    end
  end
  
  context "returning host" do
    should "return www.test.com if url is http://www.test.com" do
      url = UrlSlicer.new("http://www.test.com")
      assert_equal "www.test.com", url.host
    end
    
    should "return www.test.com if url is http://www.test.com:80" do
      url = UrlSlicer.new("http://www.test.com")
      assert_equal "www.test.com", url.host
    end
  end
  
  context "returning tld domain" do
    should "return test.com if url is http://www.test.com" do
      url = UrlSlicer.new("http://www.test.com")
      assert_equal "test.com", url.domain
    end
    
    should "return bbc.co.uk if url is http://www.bbc.co.uk" do
      url = UrlSlicer.new("http://www.bbc.co.uk")
      assert_equal "bbc.co.uk", url.domain
    end
    
    should "return test.com if url is http://www.test.com:80" do
      url = UrlSlicer.new("http://www.test.com")
      assert_equal "test.com", url.domain
    end
  end
  
  context "returning subdomain" do
    should "return www if url is http://www.test.com" do
      url = UrlSlicer.new("http://www.test.com")
      assert_equal "www", url.subdomain
    end
    
    should "return blog if url is http://blog.somewhere.co.uk" do
      url = UrlSlicer.new("http://blog.somewhere.co.uk")
      assert_equal "blog", url.subdomain
    end
  end
  
  context "returning port" do
    should "return port 80 if url is http://www.test.com:80" do
      url = UrlSlicer.new("http://www.test.com:80")
      assert_equal 80, url.port
    end
    
    should "return port 8080 if url is http://www.bbc.co.uk:8080" do
      url = UrlSlicer.new("http://www.bbc.co.uk:8080")
      assert_equal 8080, url.port
    end
    
    should "return port 80 if url is http://www.test.com" do
      url = UrlSlicer.new("http://www.test.com")
      assert_equal 80, url.port
    end
  end
  
  # context 
end
