require 'selenium-webdriver'
require 'pry-debugger'
# Counts
$ruby = 0
$python = 0
$php = 0
$mobile = 0
$senior = 0
$junior = 0
$csharp = 0
$qa = 0
$java = 0
$javascript = 0
$clang = 0
$web = 0
$data = 0
$front = 0
$back = 0

def summary()
	puts '------------------------------ Search Complete ----------------------------------'
	puts '-- Languages Listed --'
	puts 'Ruby Positions Listed:  '+$ruby.to_s
	puts 'Python Positions Listed: '+$python.to_s
	puts 'PHP Positions Listed: '+$php.to_s
	puts 'C# and/or .Net Positions Listed: '+$csharp.to_s
	puts 'Java Positions Listed: '+$java.to_s
	puts 'C++ Positions Listed: '+$clang.to_s
	puts 'Javascript Positions Listed: '+$javascript.to_s
	puts '-- Addtl. Data --'
	puts 'QA Positions Listed: '+$qa.to_s
	puts 'Senior Positions Listed: '+$senior.to_s
	puts 'Junior Positions Listed: '+$junior.to_s
	puts 'Web Positions Listed: '+$web.to_s
	puts 'Mobile Positions Listed: '+$mobile.to_s
	puts 'Data Positions Listed: '+$data.to_s
	puts 'Front-end Positions Listed: '+$front.to_s
	puts 'Backend Positions Listed: '+$back.to_s
	$driver.quit
	exit(1)
end

# Will consider at most 50 pages or until a search times out
def findPositions(count)
	count += 1
	if count < 50
		elements = $driver.find_elements(:tag_name,'a')
		elements.each do |x|
			txt = x.text.downcase
			# Less than 13 tend to not be descriptive and or internal nav links
			if txt.length > 13
				if txt.include?("ruby")||txt.include?("rails")
					$ruby +=1
				end
				if txt.include?("python")
					$python +=1
				end
				if txt.include?("php")
					$php +=1
				end
				if txt.include?("mobile") || txt.include?("android") || txt.include?("ios")
					$mobile +=1
				end
				if txt.include?("c#") || txt.include?(".net")
					$csharp +=1
				end
				if txt.include?("java") && !txt.include?("javascript")
					$java += 1
				end
				if txt.include?("javascript") || txt.include?("front-end") || txt.include?("angular") || txt.include?("backbone") || txt.include?("node")
					$javascript +=1
				end
				if txt.include?("senior") || txt.include?("sr.")
					$senior += 1
				end
				if txt.include?("junior") || txt.include?("jr.")
					$junior += 1
				end
				if txt.include?("qa") || txt.include?("sdet")
					$qa += 1
				end	
				if txt.include?("c++")
					$clang +=1
				end		
				if txt.include?("web")
					$web +=1
				end		
				if txt.include?("data")
					$data +=1
				end	
				if txt.include?("front-end") || txt.include?("frontend")
					$front +=1
				end	
				if txt.include?("back-end") || txt.include?("backend")
					$back +=1
				end	
			end
			end
		end
		begin
			wait = Selenium::WebDriver::Wait.new(:timeout => 3)
			# date loads with entries -- wait for date
			wait.until {$driver.find_element(:class, "date")}
		rescue Selenium::WebDriver::Error::TimeOutError
			summary()
		end
		# Search the next page
		begin
			element = $driver.find_element(:link_text, "next >")
		rescue Selenium::WebDriver::Error::NoSuchElementError
			summary()
		end

		if element.enabled?
			element.click
			findPositions(count)
		end
end

puts "Enter city you would like to analyze open tech positions for (ie. Salt Lake City)"
city = gets.chomp.gsub(/\s+/, "")

begin
	$driver = Selenium::WebDriver.for :firefox
	$driver.navigate.to "http://"+city+".craigslist.org/sof/"
	findPositions(1)
	$driver.quit
rescue Selenium::WebDriver::Error::UnknownError
	puts "The City Entered was not Found"
	$driver.quit
	exit(1)
end






