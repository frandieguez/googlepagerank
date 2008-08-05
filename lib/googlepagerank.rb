## Pagerank calculation based on http://www.math.kobe-u.ac.jp/~kodama/gprank.rb

require "net/http"

class GooglePageRank
  
  M=0x100000000 # modulo for unsigned int 32bit(4byte)


  # Calculates the PageRank for the given _url_ 
  # ATENTION: Old version, use the GooglePageRak.get() instead 
  #
  # :call-seq: 
  # GooglePageRank.get0("url",[port],[proxy_url],[proxy_port]) -> Fixnum
  # 
  # If an error ocurrs with the connection 
  # or the domain isn't indexed returns  -1
  # ==== Parameters
  # url<String>::
  # port<Fixnum>::
  # proxy<String>::
  # proxy_port<Fixnum>::
  # ==== Returns
  # Fixnum:: The PageRank for the given url.
  # ==== Examples
  #   GooglePageRank.get0("www.mabishu.com") # => 4
  #   GooglePageRank.get0("www.mabishu.com", 80) # => 4
  #   GooglePageRank.get0("www.mabishu.com", 80, "http://proxy.example.com", 8080) # => 4
	def self.get0(url="http://sample/index.html",port=80,proxy=nil,proxy_port=nil)
		# get Google PageRank
		# old version
		ch = checkSum(url);
		# printf("CheckSUM: 6%u\n", ch);
		g_path=sprintf("/search?client=navclient-auto&failedip=216.239.51.102;821&ch=6%u&q=info:%s", ch, url);
		p="" # rank
		##
		printf("%s\n",g_path)
		# http://www.google.co.jp/search?client=navclient-auto&ch=63055969557&features=Rank&q=info:http://www.hyperposition.com/se3blog/
		# http://www.google.co.jp/search?client=navclient-auto&features=Rank&q=info:http://www.hyperposition.com/&ch=6768349016
		g_server="toolbarqueries.google.com"
		# toolbarqueries.google.co.jp
		#g_server="www.google.co.jp"
		Net::HTTP::new(g_server, port, proxy, proxy_port).get(g_path){|line|
			printf("%s\n", line)
			pos=line.index("<RK>") # format: <RK>(rank)</RK>
			if( pos != nil) then p=(line[pos+4,2]).to_i; break; end;
		}
		if (p.size>0) then return p.to_i; else return -1; end
	end



  # Calculates the PageRank for the given _url_ 
  # New algorithm version  (16 july 2007)
  #
  # :call-seq: 
  # GooglePageRank.get("url",[port],[proxy_url],[proxy_port]) -> Fixnum
  # 
  # If an error ocurrs with the connection 
  # or the domain isn't indexed returns  -1
  # ==== Parameters
  # url<String>::
  # port<Fixnum>::
  # proxy<String>::
  # proxy_port<Fixnum>::
  # ==== Returns
  # Fixnum:: The PageRank for the given url.
  # ==== Examples
  #   GooglePageRank.get("www.mabishu.com") # => 4
  #   GooglePageRank.get("www.mabishu.com", 80) # => 4
  #   GooglePageRank.get("www.mabishu.com", 80, "http://proxy.example.com", 8080) # => 4
	def self.get(url="http://sample/index.html",port=80,proxy=nil,proxy_port=nil)
		# get Google PageRank
		# 2007.07.10
		ch = checkSum(url);
		# printf("CheckSUM: 6%u\n", ch);
		###### format changed
		#g_path=sprintf("/search?client=navclient-auto&failedip=216.239.51.102;821&ch=6%u&q=info:%s", ch, url);
		g_path=sprintf("/search?client=navclient-auto&features=Rank&failedip=216.239.51.102;821&q=info:%s&ch=6%u", url, ch);
		p="" # rank
		# printf("%s\n",g_path)
		# http://www.google.co.jp/search?client=navclient-auto&ch=63055969557&features=Rank&q=info:http://www.hyperposition.com/se3blog/
		# http://www.google.co.jp/search?client=navclient-auto&features=Rank&q=info:http://www.hyperposition.com/&ch=6768349016
		g_server="toolbarqueries.google.com"  # toolbarqueries.google.co.jp
		Net::HTTP::new(g_server, port, proxy, proxy_port).get(g_path){|line|
			# printf("%s\n", line)
			###### format changed
			pos=line.index("Rank_1:1:") # format: Rank_1:1:4
			if( pos != nil) then p=(line[pos+9,2]).to_i; break; end;
		}
		if (p.size>0) then return p.to_i; else return -1; end
	end

	private
	
	def self.m1(a,b,c,d)
		return (((a+(M-b)+(M-c))%M)^(d%M))%M # mix/power mod
	end

	def self.c2i(s="",k=0)
		# char codes to int. Little Endian
		return ((s[k+3].to_i*0x100+s[k+2].to_i)*0x100+s[k+1].to_i)*0x100+s[k].to_i
	end

	def self.mix(a,b,c)
		a=a%M; b=b%M; c=c%M
		a = m1(a,b,c, c >> 13); b = m1(b,c,a, a <<  8); c = m1(c,a,b, b >> 13);
		a = m1(a,b,c, c >> 12); b = m1(b,c,a, a << 16); c = m1(c,a,b, b >>  5);
		a = m1(a,b,c, c >>  3); b = m1(b,c,a, a << 10); c = m1(c,a,b, b >> 15);
		return [a,b,c];
	end
	
	def self.checkSum(url="http://sample/index.html")
		a= 0x9E3779B9; b= 0x9E3779B9; c= 0xE6359A60;
		iurl="info:"+url; len = iurl.size; k=0;
		while (len>=k+12) do
			a += c2i(iurl,k) ; b += c2i(iurl,k+4); c += c2i(iurl,k+8); a,b,c = mix(a,b,c);
			k=k+12
		end
		a += c2i(iurl,k); b += c2i(iurl,k+4); c += (c2i(iurl,k+8)<<8)+len; a,b,c = mix(a,b,c);
		return c;
	end
	
end