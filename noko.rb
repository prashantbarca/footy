require 'nokogiri'
require 'libnotify'
require 'open-uri'
map = {}
puts "Press ^C to quit"
while true do
    begin
        puts "\nFetching. . . \n\n"
        @doc = Nokogiri::XML(open("http://www.scorespro.com/rss2/live-soccer.xml"))
        r = @doc.xpath("//title").reverse
        s = @doc.xpath("//description").reverse
        k = []
        v = []
        r.each do |key|
            k.push(key.inner_html)
        end
        s.each do |value|
            v.push(value.inner_html)
        end
        (0..k.length-2).each do |i|
            #puts "\n\n\n #{i} #{k[i]} #{v[i]}"
            if(map[k[i]]==v[i] )
                break
            else
                map[k[i]]=v[i]
                Libnotify.show :summary => "#{v[i]}" , :body => "\t#{k[i]}"
            end
        end
        sleep 30
    rescue
        puts "Net wont work boss"
                Libnotify.show :summary => "\tClient Quit" , :body => "It closed because your net won't work"
        break
    end
end
