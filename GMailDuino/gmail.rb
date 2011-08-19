require 'serialport'
require 'open-uri'
require 'nokogiri'

# Settings
# make these your own
USERNAME = "your_username@gmail.com"
PASSWORD = "your_password"

# You can find this in the arduino
# or antipasto IDE under Tools > Serial Port
SERIALPORT = "/dev/tty.usbmodem3d11"

# Setup a new serial port in hopes
# of talking to our arduino
ser = SerialPort.new SERIALPORT

# We're checking for mail here.
# This is the main method.
# It calls mail_count
# to see if the <fullcount> node
# in the feed is greather than 0
# and writes to the arduino using
# the serial port created earlier.
def get_mail
  req = Net::HTTP::Get.new '/mail/feed/atom'
  req.basic_auth USERNAME, PASSWORD

  http = Net::HTTP.new('mail.google.com', 443)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  res = http.request req

  feed = Nokogiri::XML res.body

  count = mail_count feed #any new mails?

  if count > 0
    ser.write 'Y' # yes there is new mail
  else
    ser.write 'N' # no there isn't new mail
  end
end

# Take a feed and examine the xml for
# the <fullcount> node and return that
# integer. <fullcount> shows the number
# of new mails.
def mail_count(feed)
  feed.root.elements[2].text.to_i
end
