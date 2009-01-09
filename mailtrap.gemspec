Gem::Specification.new do |s|
  s.name     = "mailtrap"
  s.version  = "0.2.2"
  s.date     = "2009-01-09"
  s.summary  = "A mock SMTP server for use in Rails development, also included web interface to browse received mail"
  s.email    = "hasan@somewherein.net"
  s.homepage = "http://github.com/we4tech/mailtrap/"
  s.description = %{Create a new Mailtrap on the specified host:port. If once it true it
    will listen for one message then exit. Specify the msgdir where messages
    are written. http_host:http_port is used for initiating web server to
    display currently received mails}
  s.has_rdoc = true
  s.authors  = ["Matt Mower <self@mattmower.com>", "nhm tanveer hossain khan"]
  s.files    = [
      "History.txt",
		  "README.txt",
		  "Rakefile",
		  "mailtrap.gemspec",
		  "lib/mailtrap.rb",
		  "lib/mailbox_service.rb",
		  "bin/mailtrap"]
  s.test_files = [
      "test/test_mailtrap.rb"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.add_dependency("daemons", [">= 1.0.8"])
  s.add_dependency("trollop", [">= 1.7"])
  s.add_dependency("rack", [">= 0.3.0"])
end
