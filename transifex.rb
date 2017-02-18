=begin
This script fetches the translation files from the transifex service and puts them 
into the locales directory.

You will need maintainer access on our transifex project to run this script.

Get your api token from here: https://www.transifex.com/user/settings/api/
and set it in your ENV as TRANSIFEX_API_KEY
e.g.
`export TRANSIFEX_API_KEY=<api key>`
in your shell.
=end

require 'net/http'
require 'json'
require 'tempfile'
require 'fileutils'
 
HTTP_USER = 'api'
HTTP_PASSWORD = ENV.fetch('TRANSIFEX_API_KEY')

def http(url)
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth HTTP_USER, HTTP_PASSWORD
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")    
    http.request(request)
end

def list_languages()
    url = 'https://www.transifex.com/api/2/project/security-without-borders-website/languages/'
    response = http(url)
    JSON.parse(response.body)
end

def list_resources() 
    url = 'https://www.transifex.com/api/2/project/security-without-borders-website/resources/'
    response = http(url)
    JSON.parse(response.body)
end

def get_language_info(language_code)
    url = 'https://www.transifex.com/api/2/project/security-without-borders-website/language/%s/' % language_code
    response = http(url)
    JSON.parse(response.body)    
end

def download_translation_file(language_code)
    tmpfile = Tempfile.new(language_code + '.yml')
    url = 'https://www.transifex.com/api/2/project/security-without-borders-website/resource/enyml/translation/%s/?file'% language_code
    response = http(url)    
    tmpfile.write(response.body)
    tmpfile.rewind
    tmpfile
end

# debug stuff
# puts list_resources

# main
languages = list_languages()
changes = 0
for language in languages
    # puts language
    # info = get_language_info(language["language_code"])
    # if info.reviewed_segments != info.total_segments
    #     # require that everything is reviewed.
    #     break
    # end
    tmpfile = download_translation_file language["language_code"]
    # puts tmpfile.path
    shorter_code = language["language_code"][0, 2] # hoping here that transifex does not inject a naughty 2 character long string
    original_file = 'locales/%s.yml' % shorter_code

    if not (File::exists? original_file and FileUtils.compare_file tmpfile, original_file)
        changes += 1
        puts "+ Translation for %s has been changed." % language["language_code"]
        FileUtils.mv tmpfile.path, original_file        
    end

    tmpfile.close
    tmpfile.unlink
end

puts "%i locales updated." % changes
